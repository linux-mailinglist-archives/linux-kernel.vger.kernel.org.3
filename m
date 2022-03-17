Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E604DD0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiCQWc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiCQWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:32:20 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C35180054
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:31:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0FB442C0C23;
        Thu, 17 Mar 2022 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647556260;
        bh=5yzcYUXA1wnj+z0MDGmniYGpzv7rc9CIlYccVyLXRjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bl2yLBAlym2GIxAbqdK9FeXyK0q7GXittuf5QdUPpLQ/qOq9rdV9au0y/vaaQGrGL
         oKy1rOUlWBDgTqJA8/rTYi7oLWH0N1iddQhHBcDsTuLeinNYeYK+zSEazkQKVmbkz2
         nbitzFPdylzq1d0hn23FlZeDSBylLasZ9HLtEgdwpPbSm/q1N/jPAkoMU5B5zcYbkg
         ePm6LXfSuXCmIPrCVOoEkgiTAq2KvfmvE/LN2+t+r3p5mB7ZcMsbt/k5SQsqw0yy7L
         o5fpkZ9zP2ZYbAU2TKgKVReBYS5RoPscaAe+rc9vRtTBqLNlrWnyyJc8qlIvYD6cUN
         33VDvC3RFKmOw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233b6a30003>; Fri, 18 Mar 2022 11:30:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A769E13EE8E;
        Fri, 18 Mar 2022 11:30:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A8E0A2A2679; Fri, 18 Mar 2022 11:30:56 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 3/3] hwmon: (adt7475) Use enum chips when loading attenuator settings
Date:   Fri, 18 Mar 2022 11:30:50 +1300
Message-Id: <20220317223051.1227110-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
References: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=1utJVCOB_o5uIfT7QvUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify load_attenuators() by making use of enum chips instead of int.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New

 drivers/hwmon/adt7475.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6de501de41b2..ebe4a85eb62e 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1569,7 +1569,7 @@ static int set_property_bit(const struct i2c_client=
 *client, char *property,
 	return ret;
 }
=20
-static int load_attenuators(const struct i2c_client *client, int chip,
+static int load_attenuators(const struct i2c_client *client, enum chips =
chip,
 			    struct adt7475_data *data)
 {
 	int ret;
@@ -1588,7 +1588,7 @@ static int load_attenuators(const struct i2c_client=
 *client, int chip,
 						data->config4);
 		if (ret < 0)
 			return ret;
-	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+	} else {
 		set_property_bit(client, "adi,bypass-attenuator-in1",
 				 &data->config2, 5);
=20
--=20
2.35.1

