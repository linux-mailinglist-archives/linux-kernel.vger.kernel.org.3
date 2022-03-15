Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0A4DA446
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbiCOU4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbiCOU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:56:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA644839E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:55:32 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nUECW-00088x-NG; Tue, 15 Mar 2022 21:55:28 +0100
Date:   Tue, 15 Mar 2022 21:55:28 +0100
From:   Martin Kaiser <lists@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: r8188eu: some rx cleanups
Message-ID: <20220315205528.vfby3delkhyidbv5@viti.kaiser.cx>
References: <20220305185351.1409232-1-martin@kaiser.cx>
 <Yi97s4Eu20CVE/Ds@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yi97s4Eu20CVE/Ds@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> On Sat, Mar 05, 2022 at 07:53:45PM +0100, Martin Kaiser wrote:
> > Here's another set with simple cleanups in the code for receiving frames.

> > Martin Kaiser (6):
> >   staging: r8188eu: remove unnecessary initializations
> >   staging: r8188eu: remove three unused receive defines
> >   staging: r8188eu: remove unused function prototype
> >   staging: r8188eu: make rtl8188e_process_phy_info static
> >   staging: r8188eu: remove some unused local ieee80211 macros
> >   staging: r8188eu: remove local BIT macro

> >  drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  6 +---
> >  .../staging/r8188eu/include/rtl8188e_recv.h   |  6 ----
> >  drivers/staging/r8188eu/include/wifi.h        | 34 +------------------
> >  3 files changed, 2 insertions(+), 44 deletions(-)

> > -- 
> > 2.30.2



> This series breaks the build:

on x86_64 - and I tested only on arm32 :-(

> drivers/staging/r8188eu/core/rtw_wlan_util.c: In function ‘update_IOT_info’:
> drivers/staging/r8188eu/core/rtw_wlan_util.c:1279:42: error: conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551611’ to ‘4294967291’ [-Werror=overflow]
>  1279 |                 Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
>       |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/r8188eu/core/rtw_wlan_util.c:1285:42: error: conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551611’ to ‘4294967291’ [-Werror=overflow]
>  1285 |                 Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
>       |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

> I'm going to drop it from my queue now.

The driver's BIT(x) macro was 1 << (x), the "global" one uses 1UL << (x).
DYNAMIC_BB_DYNAMIC_TXPWR needs a cast to u32. I've just sent v2.

Thanks,
Martin
