Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8194D66C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbiCKQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350560AbiCKQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:47:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144351D21DC;
        Fri, 11 Mar 2022 08:46:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q13so8095600plk.12;
        Fri, 11 Mar 2022 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l33vmNjYbm+zidxlsmi9Obib1twP7+y4EKc9l3Fxd4A=;
        b=ejlp0BwZ6mUH7mXQpCNnZM+qUysTSGxcSlz/shr+J6oHya1RvaWZI4+KaQMd6aH4oO
         MZrwUfY7OQedgJ9ED9r57Er6tm/k3kvIK8D5j6/cm+E6RVzfkvT/T4tMvXzyVD9vsSyI
         NwcGKbbkvu2QDc/xOuFQYnveqkcyJR7q9OdG+ySNDpgSM13wDx3nlP+vyVgoSn2/uOf1
         Vh2U2tAXw7NDghiOvPcdz0HGU6YAiZ+o4KpEIQfCfG2IO5UJ9CNUApIPeMnYSUzHEBD5
         ymrBq7zTjEN4n80qbGPbiOPSONPdDngvauPdRhl1pSaDTBJD6LOvO9OktBLiXLdOhcF5
         BqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l33vmNjYbm+zidxlsmi9Obib1twP7+y4EKc9l3Fxd4A=;
        b=PTZiwqDWwconO/rmsVWyyIEr2ik3d+VFOy6vLNbpJvQX18cjiqAUNBoFNWKfReP3TO
         NN971Xvnv+269sh8vQBoDASgKVH+P6N7Bmju05+nXFEEnp6wmHbc64fBOCDqa1oro+Sm
         aAFfdRM1YuefF8zypNdcRwRwSKj1qq9ZwQBPccvE/gzgX9iqs10zQ3kr4iVgV5a+wDl+
         ZtXTJ77uG32862U3Njl0+3U60IoWWctG0dXs4Ac7Xe1VRjGu0ITtmgkVCtJJuU9FhGll
         AKE+MnKMA+rIs1IjgjF8Yfq2x3NM13lZsMuIwZUkPvQR5SnxrFDyQII9YVmIA9AVfhNb
         f/HQ==
X-Gm-Message-State: AOAM5304BmVhwiayVqD58cSeyA2miSZXQHcKWeWzFc/W9OaVS8OPekrH
        rXNdvrl1q7vZHVOnd8pXlZU=
X-Google-Smtp-Source: ABdhPJykraNxI+70mTruQMr6i1Nnx1U6CXa3migNAIW2dMbeGTQD3im95J4l/q4E80KcDoghJCQJEA==
X-Received: by 2002:a17:90b:1e05:b0:1bf:4673:7e7d with SMTP id pg5-20020a17090b1e0500b001bf46737e7dmr23036092pjb.10.1647017213534;
        Fri, 11 Mar 2022 08:46:53 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:46:53 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/7] iio: adc: sc27xx: adjust structure and add PMIC's support
Date:   Sat, 12 Mar 2022 00:46:21 +0800
Message-Id: <20220311164628.378849-1-gengcixi@gmail.com>
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
also add ump9620 PMIC suspend and resume pm implement.

Cixi Geng (7):
  dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
  iio: adc: sc27xx: fix read big scale voltage not right
  iio: adc: sc27xx: structure adjuststment and optimization
  iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
  iio: adc: sc27xx: add support for PMIC sc2730
  iio: adc: sc27xx: add support for PMIC ump9620
  iio: adc: sc27xx: add Ump9620 ADC suspend and resume pm support

v2 changes:
  fix dt_binding_check error
  adjust some code-style issue
  optimize the copy-paste functions
  the smatch warnings found by lkp
  and  ohter comments by v1 patches.

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  30 +-
 drivers/iio/adc/sc27xx_adc.c                  | 797 ++++++++++++++++--
 2 files changed, 764 insertions(+), 63 deletions(-)

-- 
2.25.1

