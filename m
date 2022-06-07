Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5743F53FD13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiFGLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbiFGLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD4B1FCEC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C600B81F0D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F3C34114;
        Tue,  7 Jun 2022 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654600077;
        bh=hxoefO8ek43ItzGRofz5rRQ5aC3GlUmtAAZnQJJjjwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXVU1aU0wezKSSm9Y12+6GLH4j2cgjcjeg2g5oBQbwvl7sFUjfZAg30wzTmCdwuak
         vqUj8CBmZe4QHTxM1P3OUAzpnmzax0Q89MM4Rh/Bs3SVYbV7Pb3i/5NXZF0yB2eNoS
         mwGtCB1wuyvfzUsVeaUBZr+cLFfeaQub4C5v000Q=
Date:   Tue, 7 Jun 2022 13:07:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 0/4] staging: r8188eu: add error handling of usb read
 errors
Message-ID: <Yp8xezHITGrxv47H@kroah.com>
References: <cover.1654543286.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1654543286.git.paskripkin@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:36:46PM +0300, Pavel Skripkin wrote:
> Hi,
> 
> it's reincarnation of my old series for adding sane error handling in
> r8818eu.
> 
> *Problem*
> 
> Old code was returning just stack variable in case of read error. It's
> not the best approach, since passing around stack data might cause
> device misconfiguration or even kernel data leakage
> 
> To solve this I've changed rtw_read{8,16,32} prototypes to return an error via
> return value and data via passed pointer. Some work should be done to
> propogate an error down to calltrace, but it's good way to at least
> start doing sane I/O error handling
> 
> Tested locally on qemu with TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS]
> device. More testing is welcomed, of course :)
> 
> _NOTE_
> Series is based on top of staging-testing branch.
> 
> Changes since v2:
>     get rid of `(void)res` and return an error from function instead of
>     hiding it
> 
> Changes since v1:
>     addresses issues found by Dan and self review. Mostly related to returning
>     _FAIL instead of -errno, since callers expect _FAIL/_SUCCESS
> 
> v1: https://lore.kernel.org/linux-staging/cover.1652911343.git.paskripkin@gmail.com/
> v2: https://lore.kernel.org/linux-staging/cover.1652994483.git.paskripkin@gmail.com/
> 
> Pavel Skripkin (4):
>   staging: r8188eu: add error handling of rtw_read8
>   staging: r8188eu: add error handling of rtw_read16
>   staging: r8188eu: add error handling of rtw_read32
>   MAINTAINERS: add myself as r8188eu reviewer
> 
>  MAINTAINERS                                   |   1 +
>  drivers/staging/r8188eu/core/rtw_cmd.c        |  15 +-
>  drivers/staging/r8188eu/core/rtw_efuse.c      |  33 ++-
>  drivers/staging/r8188eu/core/rtw_fw.c         |  72 +++--
>  drivers/staging/r8188eu/core/rtw_led.c        |  16 +-
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  62 ++++-
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   9 +-
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  |  20 +-
>  .../r8188eu/hal/Hal8188ERateAdaptive.c        |  21 +-
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  21 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>  drivers/staging/r8188eu/hal/hal_com.c         |  27 +-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 ++-
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 136 +++++++---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  30 ++-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 251 +++++++++++++++---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  33 ++-
>  drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  47 +++-
>  drivers/staging/r8188eu/os_dep/os_intfs.c     |  19 +-
>  21 files changed, 693 insertions(+), 178 deletions(-)

After applying, I get the following build warning which breaks the
build:

drivers/staging/r8188eu/core/rtw_mlme_ext.c:6826:13: error: unused variable ‘res’ [-Werror=unused-variable]
 6826 |         int res;
      |             ^~~

Please test-build your patches before sending them out :(

greg k-h
