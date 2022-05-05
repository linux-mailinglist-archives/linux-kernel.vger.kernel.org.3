Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E551BCF2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355133AbiEEKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbiEEKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:18:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91CB515BE;
        Thu,  5 May 2022 03:14:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id iq10so3801557pjb.0;
        Thu, 05 May 2022 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW1SYqHDdzQ1HznA5LWZCuAo5BZ76JYOeNfHxD4Rcc8=;
        b=CUyg5QW+W1vLB6vd6qExcOVZKR9ZlCQBWnIsjgywNmifR6Xq3e7IrLxJBOtKmFjPYf
         121o+5HKbSaVN41Rj7Nr2ZZQYnsjSsYZ5dVYf9VQKUbbUOI+1sXDDXpa5LoY2UR0aqUU
         ZkSTZ9qRf7KxnkihzLVpAB3XZA1lR2mDBio26cg1AiaXpvXbQpNWRRDEQOO4s57bmbVb
         F4CnKroEIsc4/nKsByU/514Oy0aPDoyWV0hXkZzQ2lXGIbbnJ/sEVGKm/CY8ygqIcovv
         J9KRKuffYi3lZRvl9iOq1lPx6nYynLd0B0Bb+NL5KQQ5PYFiRROGCmm4PZlBvFE5dnYo
         hsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW1SYqHDdzQ1HznA5LWZCuAo5BZ76JYOeNfHxD4Rcc8=;
        b=PfhkZUupyA2CvovPZ7y+9s94bVfrQ7awVe/hWE+o05ub2t/tvK+hh465yKWH/gUDu/
         JDal9+ZeF9sPcqOJnYcNmYrw0fSvKAmEStCAgiD90mfO6mELaFaFF3ZQDOauVVDHbXIF
         qXFjM8dqCrmNx5+VhVuAAyVKQP/4mUyJ+dTe9TEpl6bqzpRjT9jYbU9FTjOG7J4PeHda
         6TSVA/zD/nn0pqjz/T8r+1zIvfoB99N0tLVsafnh0TsSazHLxZLtMnx7F9Eu/7G8xvOQ
         DCJGfPaNhbnPU+7qETnBhOuoQpxJWIGD9nYMLDH7L8ZmFe2eeQGw05Afntr4WWCNi0WU
         T2dw==
X-Gm-Message-State: AOAM533LhJsy0zNg0pMeWjkCwTRSSlSG0gCha7dZx++Qzwh6ZZZAGbgJ
        ms6fT34n0T5A/WDLnysq+hYafM5oiH8=
X-Google-Smtp-Source: ABdhPJzCPuyrCXIcabZJGAL9MQp/URskwNuTJTzk9loEeTY/BHnC+ig4iM3xFuOHxKbsq79QmnnpWQ==
X-Received: by 2002:a17:902:e809:b0:15e:c67d:14c5 with SMTP id u9-20020a170902e80900b0015ec67d14c5mr8064604plg.13.1651745685266;
        Thu, 05 May 2022 03:14:45 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b0015e8d4eb2d2sm1099717pll.284.2022.05.05.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:14:44 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Add ums512 clocks and relative bindings file
Date:   Thu,  5 May 2022 18:14:29 +0800
Message-Id: <20220505101433.1575096-1-gengcixi@gmail.com>
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

This patchset is add the UMS512 clocks support

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

v3 changes:
  fix wrong indentation and hint: "maxItems" is not needed with an "items"
  list when use the latest dtschema.

v4 changes:
  move the syscon bindins from clk to glbreg yaml file by pickup 
  chunyan's patch for global registers bindings
  fix the comments from Krzysztof in v3 patchset
  add the Acked-by: Krzysztof in patch v4 3/4
  fix the  warning Prefer "GPL" over "GPL v2"

v5 changes:
  Add review tags.
  fix the comments in ums512-glbreg.yaml.

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (3):
  dt-bindings: clk: sprd: Add bindings for ums512 clock controller
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: Add clocks support for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |   71 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
 6 files changed, 2742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

