Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C833850D6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiDYCR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbiDYCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:17:24 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F303F894;
        Sun, 24 Apr 2022 19:14:20 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 12AF7121D3A;
        Mon, 25 Apr 2022 02:14:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 835C5121E04;
        Mon, 25 Apr 2022 02:14:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650852858; a=rsa-sha256;
        cv=none;
        b=d1vemvf4nhgWkSZZzsz9nDtbSdj/tDA84mWlcc4KPOGCIyqd/jxYvlRyUI471/sVAVDCLy
        MF+tHuTClI+V66j7OwOi4Gzt2zyJwFafqFrpXN5YyLodfnQvt91e4xXRlSeehiMug8CNhg
        kZJpjfb8IhAReuVCowZ9+FewJerGpYmFipm5S1HKFbo7XPys4Yh5VwIXA7Rycj2hsKj/MI
        DfieP10fyg0egW4dH6X15RzxOkLSHEnoCzMFs2hDc7/X7FHrFueJMF9StDuotu5CkC7Tei
        Zd4Te3jFx1zVUGenR+OHOptQXxPXybZDpFARk6Z9AOvYyj6FTI760KkSPmLelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650852858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=KxnLMzjR75kF8mNlPzwLdtNEw5lVgw9YWOw5RLRjW2E=;
        b=7ADHk7i9oKsQDDEYGoheIvlO+aeQizWNv5mCd1H816rPtvyoD2jbyY/wO7WxV2pIikqwdJ
        snVotR97pDqpcV0bMX06PFxz/fKOGIIqgCpNMN1dTnRkBw9Hbx2X6t8slu5pNoicc1lsKV
        BhRg38i4fe6zvG/wL9wKQAOGqnEtaARaW1hs+yjUaqfDmH/EeRkWkDPy+sLjpHpXowK6yL
        uncrhJq2d3G6OR/Ug2U5s7meV/BL1xYMS1XMo0Bm+LVUBUo4y2kPKLdBPCHjKeOFG6t3H/
        9+e8fZOIZIZZZY9Us9Xiux0XKr9AR+Mgfh1ag72gn7/d++kClyxyf9ygX66zvQ==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-tg62q;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Spot: 7569185d58f77829_1650852858927_1998791521
X-MC-Loop-Signature: 1650852858927:3081617291
X-MC-Ingress-Time: 1650852858926
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.129 (trex/6.7.1);
        Mon, 25 Apr 2022 02:14:18 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KmpVK606Qz2n;
        Sun, 24 Apr 2022 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650852858;
        bh=KxnLMzjR75kF8mNlPzwLdtNEw5lVgw9YWOw5RLRjW2E=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=c+2XlTSYiuVRbaPwwBz5Uh1RUz5FRMKTCCEONOiUgQZ2Mte1D3uUP3XEoQDiyQ0m1
         Ww29UOnQkKm3xW1i9B0B+AcKUQtvqwC1mh42eQErtOi/G+qGF4rt2qCcCiWbupCkbO
         MIyQ9zONnTUsJoLQDvqEwLTLK8RB5Nzq2f/jw9rjd9kbOyvDPzuDRiZidXCDYRpa0A
         TPwwrPgKsrQmVO7Q9jnNV+RTvrIxX7+S0hh/RiezPxPXJlsYK9MXzu/129tpCqbrbZ
         3PGlCNEiMNwXbwMmIiPNBwDqm8eqbi092/7fzxSNhFdR7EQSskY4rSUQC0Gyx1C6Fo
         SBCMnYkFmK96Q==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] drivers: acpi: clean up spaces to be consistent
Date:   Sun, 24 Apr 2022 22:14:07 -0400
Message-Id: <20220425021407.486916-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up a few line spaces so that it is consistent with the rest
of the file. There are a few places where a space was added before a
return and two spots where a double line space was made into one line
space.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/acpi/ac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index db487ff9dd1b..f8ec48cd7659 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -32,7 +32,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-
 static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device);
 static void acpi_ac_notify(struct acpi_device *device, u32 event);
@@ -125,6 +124,7 @@ static int get_ac_property(struct power_supply *psy,
 	default:
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -190,12 +190,14 @@ static int acpi_ac_battery_notify(struct notifier_block *nb,
 static int __init thinkpad_e530_quirk(const struct dmi_system_id *d)
 {
 	ac_sleep_before_get_state_ms = 1000;
+
 	return 0;
 }
 
 static int __init ac_only_quirk(const struct dmi_system_id *d)
 {
 	ac_only = 1;
+
 	return 0;
 }
 
@@ -286,6 +288,7 @@ static int acpi_ac_resume(struct device *dev)
 		return 0;
 	if (old_state != ac->state)
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
+
 	return 0;
 }
 #else
@@ -296,7 +299,6 @@ static int acpi_ac_remove(struct acpi_device *device)
 {
 	struct acpi_ac *ac = NULL;
 
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-- 
2.35.1

