Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF155466A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376839AbhLBTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376700AbhLBTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:20:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1596C061759;
        Thu,  2 Dec 2021 11:16:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m15so685787pgu.11;
        Thu, 02 Dec 2021 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f8Dvme7pLW3dtVQrEYhboJoVI/hxfZihp2fMPO4X/Q=;
        b=k6WtECBb84sXQ1YVFL3lC3DqtJQJ+LC1qvcBkDI9pWfBlRsIu3plHo2F7DgLqOcpC1
         SR4UlQQyADW27XvQPzEOg4YA6rIHRsqVPJgiJVmBH25N3SNdziF+/F/R9n1qxs3hrVgS
         c3CxG0qjtMrafBMnP3Xibq8QsDKtK1f7DwER90/ElfSb5GvMEfpQTd9gajQyMoh4Br+L
         sq7nbOUP+e/++a1janXtX2weFSFZuLQOqAUL3OKvwEw+FyNAE5G90V/aEFZ4B8GvqKYg
         rK9Seye0PVmYb1vU9Vj4fPkWQKZB31/5D4XwLzCH4IgEfqkmvA+8Gn028obwx3ERyN1G
         n28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f8Dvme7pLW3dtVQrEYhboJoVI/hxfZihp2fMPO4X/Q=;
        b=pBKopl94YslCOzEgdvBIKgBmq4Od1TkxjSIzjJzXZxt4//QaOiHxovqx/eGiawuw1y
         /BJ6QnUKxr+nN3dzWpe+dDEiixQRYXNn5SRaEVFglxsGdux2worz0QOjWLNxww5jagVg
         F0zVI1lkUm79yZZenh8sntxcuRgcmHOq/nIsknzTs3pFybZpIqfNcTcZ27IAJ4F9NrNI
         CTOeY3nc1+qnTDtH2MUoQ4P4i3/FhWHY0MqhuN2T1/XmmOvoePW8Jc0V2oYuTAXKutUL
         Wj4Jf6S/P4CVX+rD3wqtxUjGobiyctB28mIeosg1PUpbCMG5awWzcV0MdRwb5CsANWzj
         lywg==
X-Gm-Message-State: AOAM533kl+Ol3SQmtM3iw+WceRbB6R4kcPfEWdgDzm7qcOvhEyWDTdBB
        0gM1qQKocbhueusmj0mynnI=
X-Google-Smtp-Source: ABdhPJxwJycOfRhjkzIlJc8JfZKoidNtDyJG9woEMOQd4CQ712KoQDMh+BDZFaj0vLCXbaXW01BKmA==
X-Received: by 2002:a05:6a00:a8e:b0:4a4:ec38:b66a with SMTP id b14-20020a056a000a8e00b004a4ec38b66amr14425322pfl.7.1638472599367;
        Thu, 02 Dec 2021 11:16:39 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:517f:74c7:9fe9:b5e8])
        by smtp.gmail.com with ESMTPSA id x14sm289897pjl.27.2021.12.02.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:38 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH 4/5] arm64: dts: qcom: sm8150: Add imem section
Date:   Thu,  2 Dec 2021 11:16:29 -0800
Message-Id: <20211202191630.12450-5-jaschultz@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202191630.12450-1-jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the imem section in preparation for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---
Changes in v3:
 - N/A

---

Changes in v2:
 - Created to properly reference the xbl section inside of imem
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..bcfcb7306cdc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1175,6 +1175,14 @@ gpi_dma1: dma-controller@a00000 {
 			status = "disabled";
 		};
 
+		imem: imem@146bf000 {
+			compatible = "simple-mfd";
+			reg = <0x0 0x146bf000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x146bf000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
-- 
2.25.1

