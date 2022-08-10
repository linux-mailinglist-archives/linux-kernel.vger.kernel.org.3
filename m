Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DF58F466
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiHJW1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:27:48 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874A8D3E2;
        Wed, 10 Aug 2022 15:27:47 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l8so7366074qvr.5;
        Wed, 10 Aug 2022 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=1kroZZlbx2mb+lZ5zbOLxVzJk8/IGmcscYwlNeEJr90=;
        b=I6zcHS1SoFrUtXXgV0bCF5RpE7FkCxGeTZ3HJLX6/AHAeDkeolokYdxbHX41LnVXmD
         ajXM/I9QuIzBrrbRgaLA7GwQsPahcxar2Ijoz+FgUZWB74MFanJRGAfcMG4/8maygj9m
         BFkxaqyVWb4FUOnMsCgcqF+EkMGmURptkfEHxjNvWXo5pRZRUZ70+pGML+t4Qm0KYP9q
         4TWclY88l5A4/aTfng7dPwA8sGWHXTxyV/obLe+bBCC8M22s199iqC3PPm99Tqnpb30k
         0Y237mJ4k/ZxKabyyie0tjOAVQ4kHYFa5wDzSAM15r5MFku558/n6xfBL4qSsnbBW4Fs
         pSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1kroZZlbx2mb+lZ5zbOLxVzJk8/IGmcscYwlNeEJr90=;
        b=KJAX53WXj9RF+ndiOp6lGjBiKgOD9TAZHXh3QVkiYE0LbAN6oGqWcws8IqyS5nM4Tw
         vCml23GWpGX4GHCMtcmqngpbyMsnUdUMwib9wPfxSK8wCTIVswrazOdTt/E/fhmP7Kk1
         2tJ2o6DqYoogSenv5nME4xJLctBeDOYs/Jxxgr9zK+eUemzb0tmtfdVrbVnh+/+RdnMr
         7h5/8X5WqzEhdSKPiPhH+92c0NbAcijF3YlAFuRfVqJjLq3ovfF+c1Iy1Nrf7yc4/cNX
         lp/TBOL5BoycfjDgNxMmReAUk6TCS5U73nE+L76197xrgk/Zwq7PyT6oCb1buLRERbn2
         joQw==
X-Gm-Message-State: ACgBeo37fDIOAOWlYbwTHb/YvxkNV3ylhNs/ZP0VOzg8BpkyXI+peITm
        fx1FYVeAz/XWKCObqDKropCSYMPdkgQ=
X-Google-Smtp-Source: AA6agR7aUXEdccWAXLss1IP/vMeIrZWTc1bQPXR3VFUBbsJnIAdnUFeILdnkbR1cSC7IvA9WtQm+0w==
X-Received: by 2002:a05:6214:242b:b0:479:4bb0:529c with SMTP id gy11-20020a056214242b00b004794bb0529cmr22486761qvb.109.1660170466453;
        Wed, 10 Aug 2022 15:27:46 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006b8e8c657ccsm711341qkj.117.2022.08.10.15.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:27:45 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 0/2] usb: host: xhci-plat: Introduce XHCI_SUSPEND_RESUME_CLKS quirk
Date:   Wed, 10 Aug 2022 15:27:33 -0700
Message-Id: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Introduce XHCI_SUSPEND_RESUME_CLKS quirk for turning off clocks during suspend and
turning on clocks on resume. Certain hardware, in our case xhci_plat_brcm, can have
power savings by turning off clocks before hitting suspend states.

Justin Chen (2):
  usb: host: xhci-plat: suspend and resume clocks
  usb: host: xhci-plat: suspend/resume clks for brcm

 drivers/usb/host/xhci-plat.c | 18 ++++++++++++++++--
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.7.4

