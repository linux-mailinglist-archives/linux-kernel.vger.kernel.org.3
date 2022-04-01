Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5B4EE803
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbiDAGD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiDAGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5E25EC9C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1F961B86
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425D8C2BBE4;
        Fri,  1 Apr 2022 06:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648792896;
        bh=usiQ5/kmWskool16uoQNuX3zH9fqlkLk8OXUJrapyVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgDBvIU4HK7sNSbq7Es2681HocJZvVfc0diInnEolZ0o577aEhp56QPwNvlmJKHEO
         0uXwiEaG1aIFcpFH/FnZM2z6CUYsNxMR8OirdyOoidTg/bIL3PA6wvUrobP+xQWci3
         4vTuXwDt8myng+TKtmwZxbmwo0U8Rm/ffsOwCDqA=
Date:   Fri, 1 Apr 2022 08:01:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: unisys: Remove "struct dentry
 *eth_debugfs_dir"
Message-ID: <YkaVPtpgLk7zc1e/@kroah.com>
References: <20220331064751.29634-1-fmdefrancesco@gmail.com>
 <20220331082202.GZ12805@kadam>
 <5558288.DvuYhMxLoT@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5558288.DvuYhMxLoT@leap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:58:58PM +0200, Fabio M. De Francesco wrote:
> On gioved? 31 marzo 2022 10:22:02 CEST Dan Carpenter wrote:
> > On Thu, Mar 31, 2022 at 08:47:51AM +0200, Fabio M. De Francesco wrote:
> > > There is no need for "struct dentry *eth_debugfs_dir" which is used for
> > > debug / sysfs directories. Therefore, remove this "struct dentry" and
> > > everything related (i.e., creation and removal).
> > > 
> > > As a side effect of this change, the code has no more need of the
> > > "cleanup_register_netdev" label, which can also be removed.
> > > 
> > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v1 - v2: Add a couple of "Suggested-by" tags which were forgotten. 
> > > Thanks to Dan Carpenter and Greg Kroah-Hartman.
> > > 
> > 
> > Thanks!
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > regards,
> > dan carpenter
> > 
> I've just noticed that visornic and visorhba do other calls to 
> debugfs_create_dir() and debugfs_create_file() functions.
> 
> I'm not sure whether or not this driver still needs those other calls.

It looks like those drivers create actual files in debugfs with
information in them, so I would leave them alone.

thanks,

greg k-h
