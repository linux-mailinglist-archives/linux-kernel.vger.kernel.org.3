Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB89493037
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349773AbiARVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349660AbiARVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:51:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB73FC061401
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:51:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bu18so942207lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=Fh88UieW6M3tWsjtjC/VnGD/KSjEuK5OFMLJWUnuCow=;
        b=dxSQq+S4FDQSUQHu6og87yfSFEKZ7VwwgvfVP0ypGeLxAWpyg6p84iP92YGMNP3PbB
         RNtvkOFn5BYHTjAGLoLMBYk3RTL+qJSWtnEHNQFeXnwQvKFk86F8Opbk9G0UQLy2fIoA
         bPUCNja0E7VUKDij25LC6ZaxL0oEZKhq5AkQMaCB6pXwv3kh8bza+q+EDV1auYPY+8Uk
         VL5RtYkp7L5SYJrr6pwHvIvdBw/07aMvd7pCLyyaWHJMCTh/qLr0qOhedf+tiPx3gral
         TdFIMrs4KzEVqcvsiEIZSzoXnG0CV/TzKz/DAiI7a/BzxLMe2xBtxfjsva++gKE0GiQT
         aWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=Fh88UieW6M3tWsjtjC/VnGD/KSjEuK5OFMLJWUnuCow=;
        b=28EmzNdo4cRT/slFQ+QfSxxHlZujntpn+FMnJQs7KzWZaspJHLSIj80HCRCGO3novF
         mHKzoJUwoemWrHlqedJAsSiZUFlimXuRZJ0RTaiX0tj3lYt6CJU+wS31KUk5d18caM0J
         Pkcqn1xb1AhET2ELolt2teJpav56tYWyx7lRL2T8WHwzBFoYqNnpFyJEaCqngAOJXeKn
         CfUjVjzh31eeNb0oH+Mjnhin7iqIIC8UndNvflXEffvlZTAfIT8CVDLNjdL/+Kntyh7Y
         Aftel5UWkHnZS9sxvQ6RsQOlZZ+MDqzuLSW9GRE9M98rqjjy6wInA/zcrlekEQje4Ko9
         ABLg==
X-Gm-Message-State: AOAM5319jUR7vhGzOXSXsGr2/aGFAccXb1Wt3ryThHx4jskXhj66lBzQ
        IOZyyYqD69/GxXkHUNtJ5Ztpwg==
X-Google-Smtp-Source: ABdhPJxYJU4hIMsPmX47okJRLdOdBxNXXO11G7oGsTPSSdPTN2zTc/EXE0bTmhvpGf1opGlzns8huA==
X-Received: by 2002:a2e:144f:: with SMTP id 15mr21537821lju.326.1642542670287;
        Tue, 18 Jan 2022 13:51:10 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id w5sm1704808ljm.55.2022.01.18.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:51:09 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shruti Kanetkar <Shruti@freescale.com>,
        Igal Liberman <Igal.Liberman@freescale.com>,
        Emil Medve <Emilian.Medve@Freescale.com>,
        Scott Wood <scottwood@freescale.com>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 3/4] powerpc/fsl/dts: Enable WA for erratum A-009885 on fman3l MDIO buses
Date:   Tue, 18 Jan 2022 22:50:52 +0100
Message-Id: <20220118215054.2629314-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118215054.2629314-1-tobias@waldekranz.com>
References: <20220118215054.2629314-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block is used in (at least) T1024 and T1040, including their
variants like T1023 etc.

Fixes: d55ad2967d89 ("powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA FMan")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index c90702b04a53..48e5cd61599c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -79,6 +79,7 @@ mdio0: mdio@fc000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfc000 0x1000>;
+		fsl,erratum-a009885;
 	};
 
 	xmdio0: mdio@fd000 {
@@ -86,6 +87,7 @@ xmdio0: mdio@fd000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
+		fsl,erratum-a009885;
 	};
 };
 
-- 
2.25.1

