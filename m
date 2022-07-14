Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B9575286
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiGNQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiGNQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:14:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C25183B8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:08 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w1so1338954qkj.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0zBfnxSR+XSC3TWRrXeBSbIPtooMElqlO0E5qJfqHY=;
        b=AicyMAMtAJ/Z0UOW+5U7FPyH3YduEHw66mxNzKFt83q0UgYAuUktYuRnKY19VdiPow
         4zfsat974n37jCNFKnsLH9/F4qaV+PE1XPU9u0SIwjfBQTysVePz8O+XxnErKvNaDgiu
         B6UXUzyoUci5m5SWoI7T8vrnf7LVgnHKkhSIP1jw7bO/0tDqO8N8Oi4VAgjs25g+rcE2
         odBX+nEFF0Xbxb+m8zVMh527QH0F0m5j7i9tZFDD0Ig16MMX4/MvAnXOIv5T8zfTlLMy
         ySDyz1mZ4Hp1aPxQhKxow7eFeA5Vr+P4b2Evt5h50OiqKtfSZj7aczQ7eu45G70ATrZ7
         TGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0zBfnxSR+XSC3TWRrXeBSbIPtooMElqlO0E5qJfqHY=;
        b=subEEe3Q2WMOV44FzM+sA1NX/Rv6Y3ZrW0ivzD+IsrD5u+ueoPsfJfQbjubRB4eQRx
         a5xnAnXtOymyvZ/qcIf6Ky4BM4PPbLUiJg0Q/0FYpaPiVIXLJJFY6q16TiTcvTiudUQd
         63ni9cYiYYlfm3eHNNpfE11ZWPovblQBQDkqqahg/O2Lqb/eCjCXxlh9vt5+uDuT55zh
         2IDQb5oodOsHq9YxyfKZYDBRIwfpgorSCMvGfcecEUyKAfpuUxLfuma+OUni+jPsTFmF
         qHOogOzXUqrtlTwX8fkbzneHmYbM2N/eEGFgt6E9pDohbio09CRmNpsFWsGcV1VE1xwQ
         8ksg==
X-Gm-Message-State: AJIora+ux/tYH+fZXZuLh5G8WRqp2gKEc9C7pAY+g8y9fPTsLa/Kjagf
        svjdqnAzSITCeHF675K84NdyVA==
X-Google-Smtp-Source: AGRyM1s87BgBAU1CqOQNE5w2MmJYKyfCjer37D9d4I2vq4RoVsg++iiHKfpOrCrnZDIDFNUm7HsPkw==
X-Received: by 2002:a05:620a:22ef:b0:6b5:9a48:fa67 with SMTP id p15-20020a05620a22ef00b006b59a48fa67mr6604165qki.567.1657815247782;
        Thu, 14 Jul 2022 09:14:07 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0031eb393aa45sm1690067qtb.40.2022.07.14.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:14:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/4] Counter updates and cleanups for 5.20
Date:   Thu, 14 Jul 2022 12:07:11 -0400
Message-Id: <cover.1657813472.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First set of Counter updates and cleanups for 5.20

Only a couple changes this cycle, all involving the 104-QUAD-8 driver.

The 104-QUAD-8 driver is refactored to utilize iomap() and respective
ioread8()/iowrite8() I/O memory accessor calls. This allows some
significant cleanup of magic numbers, replacing them with a more
straight-forward approach of accessing named register structures.

The Counter git repository has moved to a new host
<https://git.linaro.org/people/william.gray/counter.git/> and the
MAINTAINTERS file updated accordingly along with my latest contact
information. Syed Nayyar Waris is no longer available to maintain the
104-QUAD-8 driver so the 104-QUAD-8 drivers maintainers list is updated
as well to reflect the departure.

William Breathitt Gray (4):
  MAINTAINERS: Update info for William Breathitt Gray
  counter: 104-quad-8: Utilize iomap interface
  counter: 104-quad-8: Implement and utilize register structures
  MAINTAINERS: Update 104-QUAD-8 driver maintainers list

 MAINTAINERS                  |  29 +++--
 drivers/counter/104-quad-8.c | 203 ++++++++++++++++++++---------------
 2 files changed, 130 insertions(+), 102 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

