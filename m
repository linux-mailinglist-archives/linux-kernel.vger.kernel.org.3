Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6786B4E356F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiCVAT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiCVATZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:19:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9779C126FB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B37DB819F9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA3AC340EE;
        Tue, 22 Mar 2022 00:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908080;
        bh=ptq/x+NmLEN93pVa3brLVtmIuD2jc5p162570UhOGQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmGegkS2ilwEKTVAUxejCavZAzG3ZrQ+HgomCHaYhL/c0BdCu8AdIN+Te3GCUGPEl
         gnUHJEhnMqtWIr8bIP/z55kCLyBYkGiXsDLO4TKC6mgpgvcYP60ZHXe1lXSowrjQTH
         df0W02qQ1wiAEjBYF7NlnCyFnC1YFqJJ2KzN8Qd2R2pU0Ur9cRRoKiX7SRWa6EBGE9
         F8/3vMBGbbTKEdagT4TANbEz/KSeQOzOHx4K0g9atyX+m8QlK5rcS7Aej89TnqYAJc
         20CSPIMvwnEeROONYUgO5fwkvbJ9slOQ0mgAlBqVjiDCgLphKSLwIugQZ/YM86eHQo
         QesHDFlCDJ6pw==
Date:   Mon, 21 Mar 2022 17:14:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce data read/write showing path
 info
Message-ID: <YjkU7tP+Rjs90X38@google.com>
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <Yjj/L5/kwc5Oo74E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjj/L5/kwc5Oo74E@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21, Eric Biggers wrote:
> On Mon, Mar 21, 2022 at 03:33:15PM -0700, Jaegeuk Kim wrote:
> > This was used in Android for a long time. Let's upstream it.
> > 
> 
> You still need to explain why this is useful.
> 
> > +static inline char *f2fs_get_pathname(char *buf, int len, struct inode *inode)
> > +{
> > +	char *path;
> > +	struct dentry *d;
> > +
> > +	/*
> > +	 * d_obtain_alias() will either iput() if it locates an existing
> > +	 * dentry or transfer the reference to the new dentry created.
> > +	 * So get an extra reference here.
> > +	 */
> > +	ihold(inode);
> > +	d = d_obtain_alias(inode);
> 
> Why does this use d_obtain_alias() to get a dentry instead of just using the
> dentry of the open file?

:( I shouldn't copy the code from aosp simply.

> 
> - Eric
