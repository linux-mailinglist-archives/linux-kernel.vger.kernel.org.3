Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4851E036
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443349AbiEFUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443339AbiEFUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBD6E8E9;
        Fri,  6 May 2022 13:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC63160A20;
        Fri,  6 May 2022 20:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF87C385A8;
        Fri,  6 May 2022 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651869397;
        bh=FaJKk4lpjmUfqPc1hBjX7ULYsTAHts26Sy5B/hA3fJU=;
        h=From:To:Cc:Subject:Date:From;
        b=BZ77tpSEMPlorPtTlNv9P5WqZNKxtLZgS0S6Ts8F6IiHcS6dlHeZyB21a+MHDJ2dJ
         0pGkIB57JhUYWdzg9eKLacQmaouWApXO0uQrWA1y+dURFpOBJXEI0YOxuz9+J2B7V+
         F8DAURyLo5VWu5mmv19/PsPucV7H0iDsgv9yI/rv3dUtTYgjpm9WuLVIdg4Lqt0nEO
         t4nNlilEQoUm5ohp12zan7pGYAf+DU3vAXTki29SrdNn2DauYom3mlwPbYpjhNp8uB
         iEw/WbrWTgnx6Oct8z2Mz9Q4bjBogNpd4I5Vp9e3x5xbPxO0SBLNog/F5xsv1qSSfh
         rNfGUvtpb316w==
Received: by pali.im (Postfix)
        id 3F1CE1141; Fri,  6 May 2022 22:36:34 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: P2020: Add fsl,mpc8548-pmc node
Date:   Fri,  6 May 2022 22:36:21 +0200
Message-Id: <20220506203621.26314-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P2020 also contains Power Management Controller and their registers at
offset 0xe0070 compatible with mpc8548. So add PMC node into DTS include
file fsl/p2020si-post.dtsi

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 6345629524fe..81b9ab2119be 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -201,4 +201,9 @@
 		reg = <0xe0000 0x1000>;
 		fsl,has-rstcr;
 	};
+
+	pmc: power@e0070 {
+		compatible = "fsl,mpc8548-pmc";
+		reg = <0xe0070 0x20>;
+	};
 };
-- 
2.20.1

