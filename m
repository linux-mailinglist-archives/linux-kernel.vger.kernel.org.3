Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59107598450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiHRNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245126AbiHRNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07C3AE47;
        Thu, 18 Aug 2022 06:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12F3616BD;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879DFC43144;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=Gr+WTBMpsUX+XAe05AEyOnHiXOlilMHU7yC/Y/6/lMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSnWzXOFd5o4iXvFNL3WRvxE6qY1gux2sGl5Ud43H6kboOxE5edq360GzqbCigMv9
         r83oaUMFqR9YOu1zwNL0zMyqUq3FqMVM2LHE8wgpcYD7V7K9QwL3sK9IIknrVI05tE
         guDfkC9M9rbBM6lGR8GhFWw1tU0q3Qyhd+sWZgp1okQldF341jfQL24ENTiFjkvtvw
         6qVwDI0OsoIfavnKIIStVc2ghnLOivsJ5lsYc5Y1+ziBZ9QSlvrj2FYY+QucVnE//9
         VDqwJeg5AxVHNkL+fJLRyINTdndnmSoXkjQKFInsA02QW3btXHpU/phKG6Qe5TjEqM
         neEWJa0f5f/zQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7Z-E7;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] Documentation: coresight: fix a documentation build warning
Date:   Thu, 18 Aug 2022 15:38:52 +0200
Message-Id: <ff5c57f03d106dc5cc14448ec0db224267fb1bfb.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using wildcards for cross-reference doesn't work, as the Sphinx
automarkup plugin is not smart enough. So, changeset
c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
tried to fix it, but at the wrong way, as it the building system
will keep producing warnings about that:

	Warning: Documentation/trace/coresight/coresight.rst references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm,coresight-

As automarkup will still try (and fail) to create a cross reference.
So, instead, change the markup to ensure that the warning won't be
reported.

Fixes: c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

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
2.37.1

