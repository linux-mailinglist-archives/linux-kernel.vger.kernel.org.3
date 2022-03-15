Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667484DA3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbiCOU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351688AbiCOU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84E527CF;
        Tue, 15 Mar 2022 13:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE81B60C11;
        Tue, 15 Mar 2022 20:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8594C340E8;
        Tue, 15 Mar 2022 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647376061;
        bh=lPid5CXtPfW3o72M2MpfIOFm7dpvPR/IEytoPY4JkGA=;
        h=From:To:Cc:Subject:Date:From;
        b=j1UldcV/o+ezaF2TgjsCVr+8NhHzHqV1B1SGmZBuMhbsajxalAJBsvBAxadGAzmbd
         iD2WuMRSZM8M2ZePgXX5GJ+ErfWowM2Aq585kFJ1kjS7PNR5nelOLKOakwYtdxxoDt
         YUl0MufwZXwGuq51SBNqo7gjQhtK/N5YRVo9wmKpWwlYA2rP7+exU8W46KLxMmE0VH
         qgmuaInlKQFGMmjPmDHtd5955jksDC09onSZu5U9qXJTHwrUd6HXTRLDY+c7r3HjXi
         gD06ViV8drCFXA+gf2IC/KQ6uanS5U1xTnK9X9IBEtofGnFHZnJG+GsLP134yJuVTQ
         tu7SWA1Jwh0cA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next v2] dt-bindings: kbuild: Make DT_SCHEMA_LINT a recursive variable
Date:   Tue, 15 Mar 2022 13:25:43 -0700
Message-Id: <20220315202542.2071351-1-nathan@kernel.org>
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

v1 -> v2: https://lore.kernel.org/r/20220315202032.538911-1-nathan@kernel.org/

* Fix stray "i" in commit title (I promise I know how to use vim...),
  sorry for the mistake and extra patch.

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

