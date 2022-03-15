Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7D4DA3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiCOUXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351691AbiCOUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD4D1B794;
        Tue, 15 Mar 2022 13:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2B960B16;
        Tue, 15 Mar 2022 20:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0444C340EE;
        Tue, 15 Mar 2022 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647375710;
        bh=obfmGqylSH5u0Q12sqtMoFbJxkTAQ2oft0YJvmwoZY4=;
        h=From:To:Cc:Subject:Date:From;
        b=erv2eTaHBIMTXTmzyHX95tf8o2s2Vl0ZLYYtfFOgMLNpuXMuRL1ioK0hd2XUIu/zT
         F3YJb6y3a6SmNASxqbFpWMWFXDnkPDPmVbkUe38yNtRAZM9OflBFxyIlhfxSaR2Bex
         3RUctkFotm8WxeNw9fNj2r1dZtFuaG8AbB3nYqtVEB28Q6yLO0P55RiQ8LZbK29gho
         /3264p1oL5n7rQCLjyK0Qz1xUcKJcPQx4HGK12TfTAT8PDk1EMS6YWNKy6Kw7t9e8f
         KBwz8Vp/JUePkWHdeny3h7E56/ti4657bAp1zi2YzdaULsKPOjlpg6HFaGY8rVE+cA
         jFLYXH5UxscOg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] dt-bindings:i kbuild: Make DT_SCHEMA_LINT a recursive variable
Date:   Tue, 15 Mar 2022 13:20:32 -0700
Message-Id: <20220315202032.538911-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change added a warning when yamllint is not installed, as it is
needed for 'make dt_binding_check'. However, it also changed
DT_SCHEMA_LINT to be a simple make variable, which is evaluated when a
Makefile is evaluated. This causes a warning when running 'make clean',
as Documentation/devicetree/bindings/Makefile has a "clean-files"
variable:

  $ make -s clean
  which: no yamllint in (...)
  warning: python package 'yamllint' not installed, skipping

Make DT_SCHEMA_LINT a recursive variable so it is evaluated only when it
is used. The warning still triggers when 'make dt_binding_check' is run.

Fixes: b3e664a7f449 ("dt-bindings: kbuild: Print a warning if yamllint is not found")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index e594e5898be0..c9953f86b19d 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -3,7 +3,7 @@ DT_DOC_CHECKER ?= dt-doc-validate
 DT_EXTRACT_EX ?= dt-extract-example
 DT_MK_SCHEMA ?= dt-mk-schema
 
-DT_SCHEMA_LINT := $(shell which yamllint || \
+DT_SCHEMA_LINT = $(shell which yamllint || \
   echo "warning: python package 'yamllint' not installed, skipping" >&2)
 
 DT_SCHEMA_MIN_VERSION = 2022.3

base-commit: 593adaa6459903728cb59392239f2c615b8dadbb
-- 
2.35.1

