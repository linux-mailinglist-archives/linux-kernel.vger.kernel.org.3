Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8850706C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiDSO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353446AbiDSO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA374615B;
        Tue, 19 Apr 2022 07:25:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s17so5073913plg.9;
        Tue, 19 Apr 2022 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5wz0mPibPZZTEoFjOQeeIvFKSEaATByfDSSqqkPSZc=;
        b=qZ89eNbxg2HFY5/pSU8PkiJ47WYAC6qi0bgAeU3XRv/XtpPO4QiZiH2skn00r3zjDE
         yg9HcAv5ME7n3G9EtBv7ovw8QPlaDvURhcY9OSf/z0R2WAGmmrFM5Pd+dC49gKQ3uqFA
         L1vbfBnwG6bBo+uh9g9McooycDTMUkmrr4jCzm6+WxUt1cvM5K00eeBezeK462uxJExU
         lhnDR2d583ujVey/+axSJ1fCyQ0qq3rJ/GWRdCx7Ebp7+oAab5j8DkR0pzBmATJ7kuEo
         kkaTkLAI0fp5xA0pX4OWk5wFOnrIPh8GbwowTT1Xig1fHIOR5JyMvSptk8Vn28CA1XGn
         xqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5wz0mPibPZZTEoFjOQeeIvFKSEaATByfDSSqqkPSZc=;
        b=3zbD+gpJpoAs4ts5LyBjdPDDX7GlQ/w/Us12VzixPDgjrNMH2HEspv8bILrW8KeaG2
         gKjvYKoc9ysSqRrBbGyTNR9wA+uqVmdnA225BxzM1QCI7GJ2ymDI14t9J6EANSPy8PNt
         nw+nQgBkEYRwvqGRKWWJcvW/8sEcgb657UjyTwR29cNcf+0WlaX5vQQf3IINdKsBYYeT
         Of7ChBKevP2i4LJv6vo8ZVRu+UBQsTP0C4CW3eXQWcV++dH4khTRcqGZupI1xh186jgu
         x3/1NPDQXuYhbq9Sf27Yc5V5F6PqRGaQAfpeLtHspvbet4VYg8UwATVUaA+zBNK8i4d2
         pKNg==
X-Gm-Message-State: AOAM531AOi7ld18lvrFMXiVW7TvJ7OP1Ow91u8KFr7gJrfZQzS3WGhGf
        2ETu1cxOAMgW5tt2bLDHBnh3oNgqfpQ=
X-Google-Smtp-Source: ABdhPJyhuD7hHHUs7YtB/6bFzuIb7pegX+hR+fLQm6tWhmjLrhKAn7yUCjkk/pl2ZzmcO8pkk4HdAg==
X-Received: by 2002:a17:903:2441:b0:159:208:755c with SMTP id l1-20020a170903244100b001590208755cmr9439064pls.160.1650378315569;
        Tue, 19 Apr 2022 07:25:15 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:15 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/7] iio: adc: sc27xx: adjust structure and add PMIC's support
Date:   Tue, 19 Apr 2022 22:24:51 +0800
Message-Id: <20220419142458.884933-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

this patchset add a sc27xx_adc_variant_data structure
and add sc272*,sc273* and ump9620 PMIC support.

v2 changes:
  fix dt_binding_check error
  adjust some code-style issue
  optimize the copy-paste functions
  the smatch warnings found by lkp
  and  ohter comments by v1 patches.

v3 changes:
  fix nvmem-cells Items value and add ump9620 dt sample
  add the correct signature for each patch
  fix the unused warning in 3/7, add explain for set the scales
  remove duplicate code,add goto label in sc27xx_adc_read
  pull out the refactor code into a single patch
  delete the suspend and resume pm for ump9620

v4 changes:
  Add fix tag in the 2/7 patch.
  Separate modification and refactoring 3/7(v3) to 2 pathes.
  remove the pmic_type struct instead of a boot set_volref
  to define the specific feathure.
  use switch statement in all scale_init functions.
  remove ump9620 pmic support in this patchset, submit separately
  in the next patches.

Cixi Geng (7):
  dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
  iio: adc: sc27xx: fix read big scale voltage not right
  iio: adc: Fine tune the scale calibration values
  iio: adc: sc27xx: structure adjustment and optimization
  iio: adc: refactor some functions for support more PMiCs
  iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
  iio: adc: sc27xx: add support for PMIC sc2730

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  59 ++-
 drivers/iio/adc/sc27xx_adc.c                  | 473 ++++++++++++++++--
 2 files changed, 491 insertions(+), 41 deletions(-)

-- 
2.25.1

