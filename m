Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA04D8AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiCNRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCNRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:32:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E891DEB6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BA82CE137D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6B9C340E9;
        Mon, 14 Mar 2022 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647279081;
        bh=hX9Tqyy6vxbu6BVOcnzI3a9SafOh9xeUfxbU1OKEzW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvCr6fPJpW2TN8UmjlWrLR/7KrPpDjyCFKfVCoFxaMZcipnssEs/dzZML+gzbX/NW
         T+nQ77peJ6ElKCXxQz3MyYqN3zLeJU+goeXfETaPFVGG86Nv9npx3RLOaprd7XKnuo
         UgrMydSklX+rv1pBjgxdZm0xVvB/p+EhmydGduAI=
Date:   Mon, 14 Mar 2022 18:30:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: r8188eu: some rx cleanups
Message-ID: <Yi97s4Eu20CVE/Ds@kroah.com>
References: <20220305185351.1409232-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305185351.1409232-1-martin@kaiser.cx>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 07:53:45PM +0100, Martin Kaiser wrote:
> Here's another set with simple cleanups in the code for receiving frames.
> 
> Martin Kaiser (6):
>   staging: r8188eu: remove unnecessary initializations
>   staging: r8188eu: remove three unused receive defines
>   staging: r8188eu: remove unused function prototype
>   staging: r8188eu: make rtl8188e_process_phy_info static
>   staging: r8188eu: remove some unused local ieee80211 macros
>   staging: r8188eu: remove local BIT macro
> 
>  drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  6 +---
>  .../staging/r8188eu/include/rtl8188e_recv.h   |  6 ----
>  drivers/staging/r8188eu/include/wifi.h        | 34 +------------------
>  3 files changed, 2 insertions(+), 44 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

This series breaks the build:

drivers/staging/r8188eu/core/rtw_wlan_util.c: In function ‘update_IOT_info’:
drivers/staging/r8188eu/core/rtw_wlan_util.c:1279:42: error: conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551611’ to ‘4294967291’ [-Werror=overflow]
 1279 |                 Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/core/rtw_wlan_util.c:1285:42: error: conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’} changes value from ‘18446744073709551611’ to ‘4294967291’ [-Werror=overflow]
 1285 |                 Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

I'm going to drop it from my queue now.

thanks,

greg k-h
