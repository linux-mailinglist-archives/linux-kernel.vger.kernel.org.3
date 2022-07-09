Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977D856C8C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGIKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1BF4B4B5;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB0960E96;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81939C385A9;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=55E4N17aXi/OdUFEEFl7AvCQy6V+4IMeLShqiXZ/LR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcAgM5p4BaJffDY0NmEhUVZuGOVesGqvBixS3FGpvkwhfuSBs7j+atRVgyDjYraS9
         hdIEgjpGoG0U2gRCAB6oqPF4xGFjMkUs/uQP9shQEMiO0+9KAYfvWVVlSUnQl4k5dQ
         02fDNEyQrugFuWNdOKzVLjN3LFJZmKgLZ6IhwNImKE3YUKBgo6ceIpHE/3YlE15qed
         cWRsvTBMREXkeZSQFDgeL5uI8809hyKHGc51i8VGqN5AGljK7z5MS3eJ4BILzZJoyM
         dg04Zv/+awz3Oul31vRn2IZE+13Mm7qpUaw2JgFxMGv5TT+MDNgzsTeQB4jMFpLsDt
         HCJlo421+s7dg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EHV-PT;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/21] Documentation: coresight: fix binding wildcards
Date:   Sat,  9 Jul 2022 11:07:34 +0100
Message-Id: <e8289cf7306a24c20d2f43251f6f7d0d74d7667b.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changeset c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
fixed a Sphinx warning but introduced a new warning while building
the docs:
	Documentation/trace/coresight/coresight.rst: Documentation/devicetree/bindings/arm/arm,coresight-

As it basically broke the cross-reference breakage detector that
runs during the Kernel build. Address it the proper way by marking
the references to such documents as a code block. This should make
Sphinx automarkup.py extension happy while allowing the script
to check if the doc reference is pointing to the right place.

Fixes: c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 Documentation/trace/coresight/coresight.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 4a71ea6cb390..826e59a698da 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -130,7 +130,7 @@ Misc:
 Device Tree Bindings
 --------------------
 
-See Documentation/devicetree/bindings/arm/arm,coresight-\*.yaml for details.
+See ``Documentation/devicetree/bindings/arm/arm,coresight-*.yaml`` for details.
 
 As of this writing drivers for ITM, STMs and CTIs are not provided but are
 expected to be added as the solution matures.
-- 
2.36.1

