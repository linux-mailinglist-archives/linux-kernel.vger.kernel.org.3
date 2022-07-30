Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A0585BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiG3TUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiG3TUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:20:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D564F8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f5so941346eje.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=EFbRg/nqcrMXwmvwVJAfLTwGOIkIy+h69qc0adusVBI=;
        b=c5nZCcAX3Mffi02JWCfgocLDuB/aJlOqDTWln6qMPcZ+Gxip48Z5JA9aMYBwkQ6clz
         EVn960uPpgSJUFRQY1ZW+uHQt580Z3zBVVBFvdt6T8+oHnoG3VZPuaQxNBX2M5NHNpEB
         ht1ZqAlOvQJmCkPyPDaXxSda6urPElHI8PpxTckJIkA168kHbcTlHuOJVlszTvmfR2o2
         k+zeequNl88Av7Wqjnz0Jv45SNN+e+15DSY3Ah5SC/pvua9beC3HM9zeubguFSyH28Iz
         AVD9VQtFccQ7/qY++62/wjV9q7RKK5jw+Lw1UKy6cWhjUG+GD249O8jNET1e2MMH8EZ/
         xM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=EFbRg/nqcrMXwmvwVJAfLTwGOIkIy+h69qc0adusVBI=;
        b=Bp2T8du5gMEL6ppzP79R6VTlpGuoV5s77cmL7Vm6ud+LK+KF3Bh7D3uzjhCD/uKjq/
         P1v18B0rFjc5SBP/085DITD2smgORy0h6+FfEHJMoUtEDAkDayBX9IhZzlHzP56anWPy
         DWo+EfjIJmYvuFn7Kcqro0R8G5y6JcQgHIWlMVr9lATUH/ievJ2UN5YTAsaUdsH07pr+
         tohZLkOWGuRXlEPMQ0oEcQ9OISi8TXWTTFDZaYX/L0NXa1JE9HOQr599J+EME43Ey969
         vyt6y/VUjT1QF9DmX4mholIhWBtIylvcUsJN0Yf2iVdj0j1+6evid5vfMpkFKvfT7t33
         WERw==
X-Gm-Message-State: AJIora8FolVQzFamZlHNgALNymzb2LyEzvkJYwhKIjcMgLHSQaRZftD7
        xyhp/bNFzpk39tvGjsHzaiIdPeajDFI=
X-Google-Smtp-Source: AGRyM1tZapWpVJ/5Ytntxbfj3ZmPbpUqzirX59zV/WvbivUG4tdg9QJBYCgaNTcacf8Et/W8wvzt1w==
X-Received: by 2002:a17:907:7638:b0:72d:f11b:5ebb with SMTP id jy24-20020a170907763800b0072df11b5ebbmr7216032ejc.647.1659208813009;
        Sat, 30 Jul 2022 12:20:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906a08800b006fe0abb00f0sm3231656ejy.209.2022.07.30.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:20:12 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:20:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: vt6655: Create one base function for four macros
Message-ID: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create one base function vt6655_mac_en_dis_bits_u32_reg with parameters for four multiline macros. Multiline macros are not liked by kernel community.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (6):
  staging: vt6655: Convert macro MACvEnableProtectMD to function
  staging: vt6655: Create one function for four macros
  staging: vt6655: Rename function MACvEnableProtectMD
  staging: vt6655: Convert macro MACvDisableProtectMD
  staging: vt6655: Convert macro MACvEnableBarkerPreambleMd
  staging: vt6655: Convert macro MACvDisableBarkerPreambleMd

 drivers/staging/vt6655/device_main.c | 40 +++++++++++++++++++++++++---
 drivers/staging/vt6655/mac.h         | 37 +++----------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.37.1

