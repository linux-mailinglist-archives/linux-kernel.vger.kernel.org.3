Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AE481D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhL3PLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhL3PLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:11:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F365C061574;
        Thu, 30 Dec 2021 07:11:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o12so55164051lfk.1;
        Thu, 30 Dec 2021 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25gPE1M09oN8YrsQ7EedKvu1Nlub3NmgdpsF+z+nV2o=;
        b=pEDv+2QIhGyWVoakqtkOEPAge/rRZUZ4H7/dtqrlICetNG02IT8UgWsbOqU+EM4ya6
         pIsiLng+8FoQaBvcCpzdA4dbKMWkH+WckGl3R4HnYGPFDhCvhTfzATWRMQn1C9dLS+yM
         6K++jQrzn/WSDVAaPEToh7RqMo9Cb6o3JX0e0PJOaadsmyJGiRTWwdKrLNRsDvxPxcjH
         6n8+YVYxddQu/g4y3h7WRIztsqNF0KNykNTf/dK9GZPBncW+qgJdbVTnaUyU1zoIsvGt
         9UULvXumRTymp+9x/YPyXkO68GWa6tKOORPK6TY5Ry+Cobd3Yo/kU0w4PiXFaUOUXarA
         l6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25gPE1M09oN8YrsQ7EedKvu1Nlub3NmgdpsF+z+nV2o=;
        b=h/NA1SYBcYv9MaEnzf/pkgRTQqgOek1USGrx99f0XkgC4cke3kiju6Th0O1EXkdpCV
         dJKTMykdZlULC8XL3f1m5L67zGO9YKSPtZ+hef1H8yqVLdwLhb8pZrQJNaLMH27f/mpd
         QjCyvzWo0wMWi/obGfJbXwW/HyKkcBCrCYtmhESpYcl38rJWAYGpGz44c+b1A1Gkpz81
         BDQYfqZQOwp7GkxlOtSZyfrdFkNmgCZuuJETCnN4VnDOXbdwa4tyfTFvpwDqdaz+zahI
         onGNfltQDmpjpUPTrPXQEZsrtkvICPOshyLCZzQTnlPb7tDJqH+zXITL7ATqSDBIuTyi
         VxhQ==
X-Gm-Message-State: AOAM532MHPGYHjiMkDTSaQO+oJ0bboHPNJXctdA3kIqk46oEpOvILrmW
        Tj/VewVu6EMVMpT9kjjjaUs=
X-Google-Smtp-Source: ABdhPJw/+ynSKnGXNZQ0sEEeoH7eFHBqPDdsjXpW3eYkqYPGV98hOjcDeDedrPDAavUPldcQ1xKOUQ==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr27486987lfk.222.1640877103736;
        Thu, 30 Dec 2021 07:11:43 -0800 (PST)
Received: from localhost.localdomain ([185.6.236.169])
        by smtp.googlemail.com with ESMTPSA id l7sm1983392lfg.89.2021.12.30.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:11:43 -0800 (PST)
From:   Maxim Kiselev <bigunclemax@gmail.com>
Cc:     fido_max@inbox.ru, Maxim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
Date:   Thu, 30 Dec 2021 18:11:21 +0300
Message-Id: <20211230151123.1258321-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T1040RDB has two RTL8211E-VB phys which requires setting
of internal delays for correct work.

Changing the phy-connection-type property to `rgmii-id`
will fix this issue.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 099a598c74c00..bfe1ed5be3374 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -139,12 +139,12 @@ pca9546@77 {
 		fman@400000 {
 			ethernet@e6000 {
 				phy-handle = <&phy_rgmii_0>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			ethernet@e8000 {
 				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			mdio0: mdio@fc000 {
-- 
2.32.0

