Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7964D2D63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiCIKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiCIKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:49:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B3289AC;
        Wed,  9 Mar 2022 02:48:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 034EF617B1;
        Wed,  9 Mar 2022 10:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECB5C340EE;
        Wed,  9 Mar 2022 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646822907;
        bh=nszSjITz7rc7Q6JPajiseDT3RQeb+PqXIqoDG287umc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAy5RrXMWqdY/7u9anICI2tCq8ALHSmRv4LahQG9SqlzIf0xs5/HYTP0qiW8jA2WC
         NtQwdYdzfUFXT2Yty8EEg6nrH20qkmE00mPfQ9b4Z5iUwxBA0y30wlXZBf7eehYKt8
         tjaeRYkiDUjZFrw43J07xlWBTGwWPJi1VPuUAdC0=
Date:   Wed, 9 Mar 2022 11:48:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Dmitrii Okunev <xaionaro@fb.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Xiaoyan Zhang <xiaoyan.zhang@intel.com>,
        Pavel Machek <pavel@denx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Message-ID: <YiiF9wfx3V+K1J33@kroah.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com>
 <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
 <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:40:03AM +0000, Jonathan McDowell wrote:
> (This is an RFC to see if the approach is generally acceptable; unlike
> the previous driver this exposes the information purely as read-only
> status information, so userspace can make an informed decision about the
> system state without having to poke about in /dev/mem. There are still a
> few extra registers I'm trying to dig up information for before a proper
> submission.)
> 
> This module provides read-only access to the Intel TXT (Trusted
> Execution Technology) status registers, allowing userspace to determine
> the status of measured boot and whether the dynamic root of trust for
> measurement (DRTM) has been fully enabled.
> 
> Tools such as txt-stat from tboot
> <https://sourceforge.net/projects/tboot/> can make use of this driver to
> display state rather than relying on access to /dev/mem.
> 
> See Documentation/x86/intel_txt.rst for more information about Intel
> TXT.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
>  arch/x86/include/asm/txt.h             |  34 +++++
>  drivers/platform/x86/intel/Kconfig     |  14 ++
>  drivers/platform/x86/intel/Makefile    |   2 +
>  drivers/platform/x86/intel/txt_sysfs.c | 185 +++++++++++++++++++++++++

No Documentation/ABI/ entry for your new sysfs entry?  How can we
evaluate if this is a good api then?

Wait, I don't see any sysfs code in here, are you sure you sent a viable
patch?

confused,

greg k-h
