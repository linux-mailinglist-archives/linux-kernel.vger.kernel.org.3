Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FA4F7974
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiDGIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiDGIYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A463FE;
        Thu,  7 Apr 2022 01:22:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso8234760pju.1;
        Thu, 07 Apr 2022 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFrIrtsQKJqbLPQjNpD6vU6LHMWV1LB2ZOEwvrNBHME=;
        b=KPiSW8LpcJ6t0UL64bRLu/9z1LUsnBgNurE/ke3Le9+wfmbVAnBIvjoiFK4gvbHVgp
         sPBfWVCnccOPUWF12cfGWz21BbuW8GUCPyeuGNcuNgHqFD/UaZp/LwJgInWpLI6icq/a
         wwM+2cvuCRErwy91/3r/Vo4jothmJBEDSGvUFgcfwrEPTknC4kIP5Dof14ZX+dFJnAeL
         NL0ZjS0UykPIIbfiwFWCS2SYGXirYA1fho1UjNPkU3Nrna5ezSzgGKrpVmovmentrWY5
         riRg+k0HlslMV3uUXtABIfeXDzyfzNIT70QDyaPI423YKI5e0oEeEoMdgG13DD8/9OXb
         76tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFrIrtsQKJqbLPQjNpD6vU6LHMWV1LB2ZOEwvrNBHME=;
        b=g0khBpyn5OBJfXhPh5qoiocWI+36C8Nd9aC+ggDYci7M2As6SRpF62fOdMOqz0XxzR
         DbVKMrVGzxcoCSlqEJzxDroiP1nkczjiYyXp0jgTMbmQoUam4qDI89qrM7fONdg4cAJS
         dFx68QPKQTGhR44p/pMAgXYWw4H66wBA69bBii7+/0CuBroNz5nFXfr/vR8WEF2VWUr0
         ECA/S+iY1dVLEPZjDPuEyqZjeDYl8h9AVxxu4fdIMfuI7wuC/L6PHvF/nE47ywHpi8O0
         txm5vVRf1fAUp7ESObRRyUgZKh+Du+WQx6vqGphrv5c8YztHEqF31ZzAdGqmtr89r+Lw
         RX/w==
X-Gm-Message-State: AOAM531kWP8eRJsESt6TbjLG1fQfOW8AcRXVlWKp1lStMUpXB8PNWnGw
        3/klbkKQLbqbNyQnTrqARPuN4rY/8b4fkNyu
X-Google-Smtp-Source: ABdhPJwl+4jS25HkUfJ1nHHSohvoh5MZd46me0EcXxw+ubdbRge2AuoYkai3a8ZWAkmm+R6jKwCfGA==
X-Received: by 2002:a17:902:aa8b:b0:156:c639:7283 with SMTP id d11-20020a170902aa8b00b00156c6397283mr12709951plr.13.1649319728450;
        Thu, 07 Apr 2022 01:22:08 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:08 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/7] iio: adc: sc27xx: adjust structure and add PMIC's support
Date:   Thu,  7 Apr 2022 16:21:41 +0800
Message-Id: <20220407082148.571442-1-gengcixi@gmail.com>
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

Cixi Geng (7):
  dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
  iio: adc: sc27xx: fix read big scale voltage not right
  iio: adc: sc27xx: structure adjuststment and optimization
  iio: adc: refactor some functions for support more PMiCs
  iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
  iio: adc: sc27xx: add support for PMIC sc2730
  iio: adc: sc27xx: add support for PMIC ump9620

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
  

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  57 +-
 drivers/iio/adc/sc27xx_adc.c                  | 717 ++++++++++++++++--
 2 files changed, 710 insertions(+), 64 deletions(-)

-- 
2.25.1

