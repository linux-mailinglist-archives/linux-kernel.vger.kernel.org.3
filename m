Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953E4E7556
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359386AbiCYOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359381AbiCYOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:48:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E9D8F74
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3758B82833
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B45C340E9;
        Fri, 25 Mar 2022 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648219602;
        bh=peblrPaVsTZSqN4NFkHWnuMa9Xm8rfy7w6kuO+AoweI=;
        h=From:To:Cc:Subject:Date:From;
        b=crdCtzAXe56dGFCWJeXmc3ylQZp0gVSIzUW2U4ff6xZvVD138fY//Rqr7a6WE/OTl
         hnNmLqoz4R0faHjEljFPnwsyUqylxsDExUUlO4Lg9vg53n2s16aYDZPwek2iMj+22i
         qh8Frwnmmj+Y5MbH8fsPqjmEBWLUDhY6Po2wyWvhGPj4YB0badiZj6LyzjE2LuBnZO
         r2lt4YGt/EorLF9fjbLciYRR0NSp3Q9g3j+Z+ZaeY2YQw99z6B79DUZsOHVp1IAS5W
         a/ODJJRpsuqf/GRPjGJ0TqgKWLYMZEeMuP8X/rs45SElFVgBerEW0V2CvMQb4k9IHM
         QKV2s+b/VBRbA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: Flag uncontrollable regulators as always_on
Date:   Fri, 25 Mar 2022 14:46:37 +0000
Message-Id: <20220325144637.1543496-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; h=from:subject; bh=peblrPaVsTZSqN4NFkHWnuMa9Xm8rfy7w6kuO+AoweI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiPdWzM6PQ+T+JMl8LiX+XPI5Gu0PIdZffRDK0CL8/ Bg2+G5eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYj3VswAKCRAk1otyXVSH0FGgB/ wJJUdaVQ26AfR8J429bDiN8/wuNTqOcuco8UY0uvLnW8XJRkQZdqzEmvrLHmF/oZ01o+5rskJGhlur ChlhxzHyE8Ib87UTlRM+o7ixiJDdGu4vTe7U6tLRaJEo0k66qfyim8QiXEtYjtVz5K3fGvFAml+1F8 6o54ISfpHOuaj1tTXTE6+gEMaFxB3UZr5aG0HOrwcqqwtsbhpLguZ4eQcCzqWHmBVv8mybTPlpoV0E ZmDDjeeCkJP5z7qcDPpsGf6aO6yEZ4XC6VFHN7dImTr76tzxRQNEfPjlTZcxRLdTmzGajlwHfkRNIK yuw3tT+WUhsnN97fETUkw4gH+MzyNm
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we currently assume that regulators with no control available are
just uncontionally enabled this isn't always as clearly displayed to
users as is desirable, for example the code for disabling unused
regulators will log that it is about to disable them. Clean this up a
bit by setting always_on during constraint evaluation if we have no
available mechanism for controlling the regualtor so things that check
the constraint will do the right thing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2553970a67b..a8a95d09ca11 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1522,6 +1522,24 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		}
 	}
 
+	/*
+	 * If there is no mechanism for controlling the regulator then
+	 * flag it as always_on so we don't end up duplicating checks
+	 * for this so much.  Note that we could control the state of
+	 * a supply to control the output on a regulator that has no
+	 * direct control.
+	 */
+	if (!rdev->ena_pin && !ops->enable) {
+		if (rdev->supply_name && !rdev->supply)
+			return -EPROBE_DEFER;
+
+		if (rdev->supply)
+			rdev->constraints->always_on =
+				rdev->supply->rdev->constraints->always_on;
+		else
+			rdev->constraints->always_on = true;
+	}
+
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
 	 */
-- 
2.30.2

