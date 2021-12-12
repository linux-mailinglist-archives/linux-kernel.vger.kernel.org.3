Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028A7471E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhLLW7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:59:37 -0500
Received: from mail.wizzup.org ([95.217.97.174]:43996 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230073AbhLLW7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iCURCfCbzJn+HEHUhNN/JYBZDwSNfAwJCRsM/r+iH+A=; b=awZCgtBEhWetUPvIgAOFRUewAO
        iEzXr9eIXFiUSqlZJU70c+9oM0WR8ngQInLfxu7cszQ6hpQlEGbHCovkh776gVELReNLc/lifg3O5
        xYr/dZwiGaEvFeGnQi9UZpNnrlANPGcZyE+9FEXrTTzzRA9G8sGl3IXOdMShFazLk1176V0dcNKIx
        YCMMLfw3SY0eLBp6YdyWQ1p5VW9M+PgSr9YTFFE1Fzz9VwZEwcTlUuWGSAsvKWaoVsgIpl1kVoXEb
        GBcD7VEk3Sclgz4nlTKWEwIJmCv8x4bpQy38X2Xded4SnDZNiyP/l/tV6+AQ4blSLDDM13UsjQnzy
        ciIbcacw==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwXoV-0001el-JE; Sun, 12 Dec 2021 22:59:27 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] pmic-cpcap: add motorola,droid3 compatible
Date:   Mon, 13 Dec 2021 00:04:58 +0100
Message-Id: <20211212230459.13579-2-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212230459.13579-1-merlijn@wizzup.org>
References: <20211212230459.13579-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Droid 3 and the Bionic appear to share the same hardware, so add
the compatible for the Droid 3 as well.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 arch/arm/mach-omap2/pmic-cpcap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 668dc84fd31e..b9188dde13b9 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -245,7 +245,8 @@ int __init omap4_cpcap_init(void)
 	voltdm = voltdm_lookup("mpu");
 	omap_voltage_register_pmic(voltdm, &omap443x_max8952_mpu);
 
-	if (of_machine_is_compatible("motorola,droid-bionic")) {
+	if (of_machine_is_compatible("motorola,droid-bionic") ||
+	    of_machine_is_compatible("motorola,droid3")) {
 		voltdm = voltdm_lookup("core");
 		omap_voltage_register_pmic(voltdm, &omap_cpcap_core);
 
-- 
2.32.0

