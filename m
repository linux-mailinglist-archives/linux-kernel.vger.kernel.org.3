Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344D8466A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbhLBTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbhLBTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:20:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF438C06174A;
        Thu,  2 Dec 2021 11:16:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id k4so697769pgb.8;
        Thu, 02 Dec 2021 11:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icZeasEa5qBq3L8d5srtUANYqE41LiH/z3sgJm+fPJk=;
        b=mqbD/6pSOGpoiznFKyrI4XqOazyzb74jum4qEY7J66AGmj7jxs/Yu4CwHTHNdDqTc+
         FN6/q2YOlbxUY3TWstoFCyhXwx8GOb8FUiUbrLWZNBsfUFvdcQods66rKkgLHzfbCsx0
         GO2NxijCurY7kbM/abAkt2GMoyQYwH1Sx/mopV4n2xNbAZpXAL89J3BxUqJfFRX/IRxW
         dSN5Hxd6ALDxndArAlCfFZxYWb6V1usbiPeJcbsHGmiRFf7xYty/vUUrcIjC/UG+WF1V
         y5Re89VD0GPILs6x655gOrh1z7/IUrJCLGkCQAROOKGpbra4FVhYk6fciqBwnWHldWXM
         gVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icZeasEa5qBq3L8d5srtUANYqE41LiH/z3sgJm+fPJk=;
        b=ghC7lBu6SDKU9PUpA85wD+cJr1Ou+0PuuHhKksLx3gZKuaHZ+5Xj7VQ9si+uUCxHcd
         2emofqybX3jiguox3dj82GguKxa+KH0QHCsHp7uSEhiwSaFfSW5ffdeNVgq9kIVxnKL8
         Q+CnJaA40aYs4YOdwTU2236frFzPBRx4MBmH5/cKbeFnmlbEmqzEAxnOwFB29/Vu//iO
         rO6yChSZhQxhzjSrMUeh4SyDnp5y544a6UZXpDwWHwbixgw3n6SwdroK/66uqcOXDla0
         uBozY4AyjSXSiAH3cE0V+M052vCa8VnD/esaZjPQm28KD819O82iixLV4uCRt3RMDzB+
         W9Bg==
X-Gm-Message-State: AOAM530DgKdZqvhpXMwvB0fpKFB01S6BFQLbv80hmx85NfZ6KnRY35lU
        ZzZPOX8/VYgoTGUSFLa2vwXHCGs26no=
X-Google-Smtp-Source: ABdhPJyGMARj3AkzMfhyvvlcCbMFPzdg3jD2tNeAfYl/NHsTkBLla9Yo3mGMLKbH76yqyZuHqiYFkg==
X-Received: by 2002:a05:6a00:1905:b0:4a8:2f86:3f18 with SMTP id y5-20020a056a00190500b004a82f863f18mr14665364pfi.52.1638472600288;
        Thu, 02 Dec 2021 11:16:40 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:517f:74c7:9fe9:b5e8])
        by smtp.gmail.com with ESMTPSA id x14sm289897pjl.27.2021.12.02.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:39 -0800 (PST)
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
Subject: [PATCH 5/5] arm64: dts: qcom: surface-duo: Add surface xbl
Date:   Thu,  2 Dec 2021 11:16:30 -0800
Message-Id: <20211202191630.12450-6-jaschultz@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202191630.12450-1-jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce device tree source for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v3:
 - N/A

---

Changes in v2:
 - Updated to reference an offset inside of imem
---
 .../boot/dts/qcom/sm8150-microsoft-surface-duo.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5901c28e6696..abb7964daac4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -430,6 +430,16 @@ &i2c19 {
 	/* MAX34417 @ 0x1e */
 };
 
+&imem {
+	status = "okay";
+
+	xbl@a94 {
+		compatible = "microsoft,sm8150-surface-duo-xbl";
+		reg = <0xa94 0x100>;
+		status = "okay";
+	};
+};
+
 &pon {
 	pwrkey {
 		status = "okay";
-- 
2.25.1

