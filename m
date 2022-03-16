Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C44DAC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiCPIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354392AbiCPIDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1C60DAD;
        Wed, 16 Mar 2022 01:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05283613EA;
        Wed, 16 Mar 2022 08:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7CC340E9;
        Wed, 16 Mar 2022 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647417716;
        bh=iU61jj44HSCKXoyq/igNQoibZ+t/Lt8YMfNC/5DL6T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aA+aq++LOmveFW2VrKrCqVYitvDxX0WWx/fi4berY482hYJoNqX5S5xtTc3tXeaHR
         BZvlr42Khb9uHGO3oD8t7f7l2mE6dFgbPjKfCi7N13cfimUErhkTdfdLMSo6usPTHR
         ZqD0JkYPUmYntbrA6p8uiLW7P8b07kI9xkMKpV0g=
Date:   Wed, 16 Mar 2022 09:01:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/usb: harden xen_hcd against malicious backends
Message-ID: <YjGZb9jihryp//RJ@kroah.com>
References: <20220311103509.12908-1-jgross@suse.com>
 <YjDPtRhdrtY6tpvc@kroah.com>
 <78b16b06-9cfe-5bfd-5d23-b7e8010024fd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b16b06-9cfe-5bfd-5d23-b7e8010024fd@suse.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:29:00AM +0100, Juergen Gross wrote:
> On 15.03.22 18:41, Greg Kroah-Hartman wrote:
> > On Fri, Mar 11, 2022 at 11:35:09AM +0100, Juergen Gross wrote:
> > > Make sure a malicious backend can't cause any harm other than wrong
> > > I/O data.
> > > 
> > > Missing are verification of the request id in a response, sanitizing
> > > the reported actual I/O length, and protection against interrupt storms
> > > from the backend.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   drivers/usb/host/xen-hcd.c | 57 ++++++++++++++++++++++++++++----------
> > >   1 file changed, 43 insertions(+), 14 deletions(-)
> > 
> > Fails to apply to my tree:
> > 
> > checking file drivers/usb/host/xen-hcd.c
> > Hunk #2 succeeded at 720 (offset -1 lines).
> > Hunk #3 succeeded at 807 (offset -3 lines).
> > Hunk #4 succeeded at 934 (offset -5 lines).
> > Hunk #5 FAILED at 986.
> > Hunk #6 succeeded at 1003 with fuzz 1 (offset -10 lines).
> > Hunk #7 succeeded at 1048 (offset -10 lines).
> > Hunk #8 succeeded at 1072 (offset -10 lines).
> > Hunk #9 succeeded at 1161 (offset -10 lines).
> > Hunk #10 succeeded at 1516 (offset -10 lines).
> > 1 out of 10 hunks FAILED
> > 
> > Any hints?
> 
> Rebase your tree to v5.17-rc8? It is missing the recent security
> patches which modified drivers/usb/host/xen-hcd.c.

I can't rebase, but I can merge.  I'll do that, thanks.

greg k-h
