Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173257A132
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiGSOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiGSOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:20:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422AF62485
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:02:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os14so27394661ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CmdStA6vypQg2oavVstr5dnAYNGqZ+2TKvct0NXz+Ow=;
        b=fFNwbc/QPVDNUcVntB412v41OF7k/V1xKqaEQxrdm7eVV0MA5iFjkDBYwa7f2Mw5ip
         HnBQSZJ7a78ZUZaambrut3/CR5pHiulCv93zJm0qLTF2wUPBwwjwEwvFaQeVyHYy7is/
         dQtAMcxJ4qPhspOSp4rYcfVd0LdCdL/uA6Xs9uDBaQkvSpyWD1m9DPQbX4KjsPgFkLy9
         iIpbWo1qeOE+pxfN2NRiU839DWVX33TkkwCKlDJAq1WrYemKFlHITI37/Ov8iv0j9ID9
         c7+T9bBQh7oLJ3xq0f1FS7pJOUbjC1sbLAVVdiiBL+VR4NOUwS4U5dGbrNRCD5d6Wabn
         BM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CmdStA6vypQg2oavVstr5dnAYNGqZ+2TKvct0NXz+Ow=;
        b=O7ajdGlBcZuEZwIx83XeJwqEXkRSzc2t6tTJRrUzJ02i4AIdvsjS5oxWAHBX94R0Hz
         LkUBgNHzz/3/HQEIinza2JS5dYiEEVJXn1cJqEaFDC/VMLuugjQZjKNMDpdENinW76lj
         wYUU4enf5vFjw9E+jAzqOvzqJqWFS1StJvHqpiz4vJaBGo46pgD/Gi8bt4jrayfgh9o3
         Zk5DDacjaKqo5dGdXEWia4sKddrIeVpgN84DE11CLx1Yx7rKVoXPFQMAwSRR0ZJd9QoO
         uH+w0LpyI8cTMSBg9AQTpqaMLnDRuMQbmKB9jKJT+nyAobP+ykNI5HllEZqu+Q2QtoOJ
         VfIA==
X-Gm-Message-State: AJIora+oEnxpuzm6qaOpMpNobECP1t8SQ0L2LGhcE420q0p72Na1PAT2
        Yo9rdyLtWAHhTxVU0pzeMoguz3rOEO0scgm0
X-Google-Smtp-Source: AGRyM1vtXnkjVnIiUjrk9WgyQUXE3rE65vjkNocA67sFO4hOYONxVwPMcBYIDHFbUuT7Hxy+QBAFIw==
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id dc1-20020a170906c7c100b00711d2e999d0mr30752629ejb.639.1658239321794;
        Tue, 19 Jul 2022 07:02:01 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b006febce7081bsm6715986ejo.163.2022.07.19.07.02.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:02:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
Date:   Tue, 19 Jul 2022 16:02:00 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators marked with "regulator-always-on" or "regulator-boot-on"
as well as an "off-on-delay-us", may run into cycling issues that are
hard to detect.

This is caused by the "last_off" state not being initialized in this
case.

Fix the "last_off" initialization by setting it to the current kernel
time upon initialization, regardless of always_on/boot_on state.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
drivers/regulator/core.c | 5 +++--
1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f..398c8d6af 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1565,6 +1565,9 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
			rdev->constraints->always_on =3D true;
	}

+	if (rdev->desc->off_on_delay)
+		rdev->last_off =3D ktime_get();
+
	/* If the constraints say the regulator should be on at this =
point
	 * and we have control then make sure it is enabled.
	 */
@@ -1592,8 +1595,6 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)

		if (rdev->constraints->always_on)
			rdev->use_count++;
-	} else if (rdev->desc->off_on_delay) {
-		rdev->last_off =3D ktime_get();
	}

	print_constraints(rdev);
--=20
2.36.1

