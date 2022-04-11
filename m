Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504004FB78C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiDKJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDKJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9A2529A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C10B8118C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF45C385A3;
        Mon, 11 Apr 2022 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649669561;
        bh=jRnyWqH9TwszaP2Qx1WH6PeeWSd9y+g9piA8kiDuNDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmDoFyt0F82MYSmB3JQ+MLArA0Fs/TTqgQEy5pPSdowH59QJcZXP5nbmWIKLt7z9x
         +OXuBm+2o70yQOZOr6WY133qcgEjjzR5xc2+k7E/5NCu5aO5W4l4kWPflB4Jd9R45U
         PfOMnvjFBvIMg+fgT8vTOdXyycBSC/jTQz2V/3ws=
Date:   Mon, 11 Apr 2022 11:32:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Do not set llc_sibling if llc_id is
 invalid
Message-ID: <YlP1tqFm7ixu8gEl@kroah.com>
References: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
 <20220411083736.hrpgndcwuvtsgnhc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411083736.hrpgndcwuvtsgnhc@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:37:36AM +0100, Sudeep Holla wrote:
> Hi Qing,
> 
> On Sun, Apr 10, 2022 at 07:36:19PM -0700, Qing Wang wrote:
> > From: Wang Qing <wangqing@vivo.com>
> > 
> > When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
> > will set llc_sibling 0xff(...), this is misleading.
> > 
> > Don't set llc_sibling(default 0) if we don't know the cache topology.
> >
> 
> Makes sense to me and thanks for splitting the patch and pointing this out
> clearly. Your earlier patches mixed other things and made it hard to highlight
> this one.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Greg,
> 
> Can you pick this up ? IMO It can go as fix in -rc as it is kind of
> misleading though I am not sure if it is breaking any platform.

Will do, thanks.

greg k-h
