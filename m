Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944A55A874
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiFYJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiFYJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92D2C132
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F6CCB818FE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACFFC3411C;
        Sat, 25 Jun 2022 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656149417;
        bh=tcU5XmpCJeuUxNJXmTWn3A1u75vW01b3kSYZ+naAcsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOmHi7oQJ6OFaFx7aKCd8NgDtKCV6VLOAIL9AWuEu/u7hYKvPYWjQmFj3WqjV5FWq
         A49KIWkAbfaPKwK2XUu5b753elpYaaeCgaN5cyY4JWaIBE0XXwo7qBVFIC/NuzkJlP
         X8ROhvLSCNaQFKXFNig7yjQrs+byKda8pUet+79A=
Date:   Sat, 25 Jun 2022 11:30:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     duoming@zju.edu.cn
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        alexander.deucher@amd.com, kuba@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Fix sleep in atomic context bug in
 dm_fsync_timer_callback
Message-ID: <YrbVpbKvqdYuY84C@kroah.com>
References: <20220623055912.84138-1-duoming@zju.edu.cn>
 <YrQ2gXtX2FOkyNgu@kroah.com>
 <1ddff589.e0f1.181944e6c1a.Coremail.duoming@zju.edu.cn>
 <482a0dc6.10f76.1819a2a3546.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <482a0dc6.10f76.1819a2a3546.Coremail.duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 05:21:06PM +0800, duoming@zju.edu.cn wrote:
> Hello,
> 
> > > On Thu, Jun 23, 2022 at 01:59:12PM +0800, Duoming Zhou wrote:
> > > > There are sleep in atomic context bugs when dm_fsync_timer_callback is
> > > > executing. The root cause is that the memory allocation functions with
> > > > GFP_KERNEL or GFP_NOIO parameters are called in dm_fsync_timer_callback
> > > > which is a timer handler. The call paths that could trigger bugs are
> > > > shown below:
> > > > 
> > > >     (interrupt context)
> > > > dm_fsync_timer_callback
> > > >   write_nic_byte
> > > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > > >     usb_control_msg
> > > >       kmalloc(.., GFP_NOIO); //may sleep
> > > >   write_nic_dword
> > > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > > >     usb_control_msg
> > > >       kmalloc(.., GFP_NOIO); //may sleep
> > > > 
> > > > This patch uses delayed work to replace timer and moves the operations
> > > > that may sleep into the delayed work in order to mitigate bugs.
> > > > 
> > > > Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> > > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > > ---
> > > > Changes in v2:
> > > >   - Use delayed work to replace timer.
> > > 
> > > Did you test this with real hardware to verify it still works?
> > 
> > I am testing this and I will give you feedback within one or two days.
> 
> Do you know what vendor id and device id use the r8192u_usb driver?

The vendor/device ids are in the driver itself.  Also in the output of
modinfo:
	❯ modinfo drivers/staging/rtl8192u/r8192u_usb.ko | grep alias
	alias:          usb:v043Ep7A01d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v5A57p0290d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v2001p3301d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v1740p9201d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v0DF6p0031d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v050Dp805Ed*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v07AAp0043d*dc*dsc*dp*ic*isc*ip*in*
	alias:          usb:v0BDAp8709d*dc*dsc*dp*ic*isc*ip*in*

see the "v" and "p" portions of the alias string.

thanks,

greg k-h
