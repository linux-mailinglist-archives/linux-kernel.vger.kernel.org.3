Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A096C51E042
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443550AbiEFUvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiEFUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:51:29 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245145ACB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:47:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 572EA1219F1;
        Fri,  6 May 2022 20:47:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A7CAC121C1F;
        Fri,  6 May 2022 20:47:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651870058; a=rsa-sha256;
        cv=none;
        b=PYMHuFimCV4mPT0zA3FohWIbqtldqpt2Yt6GECAIkFNmPOopAXcrdORmVPvgTD1fD/StR/
        8muCsmqphb+OKi3gtM7IJEdL51rGPuglCWemPk0dTIuLWfbX6ehCPdbFNbMIqStHi0iWM6
        1zaIfg53cYgpkqJJ5ciWMvwQ+wwS/AOcy7SxZMsA9hru+n2PLYNE4tuDkmCCQQFjT+LYYq
        V1dsr+NStNpY2kHFBAcDdbFVvfuduCgL6/ca/oTuvUF8qef/DkwX5Fn3qV+zfi0eTRrcJ2
        HrqYaqNiFkLNsH3J6lmoW4otf5gdHB3CJcDzOlY4dvSDKVjNhQGtpP9Imt1P9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651870058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=ni7bqdS03z4h5SXMAsYuuzVOnX1oevvYBXsf9q9pN0U=;
        b=flrzyR93UR+9cbeNYvYGEo1VWXl83kfLw2ysv7xdjZduSk/xCiOwdIo0JQ5t7EKWLa41zC
        9tzSTZ7RLAn6VRRJoaNkF05tQGuHSrWzwg+WIJj5t7SGNCaVdP7duAxdAfKA1i1yhkX/8W
        vAqUYALVRfTpIzeKnuAwX9MZgBLVFp6j6+jtwMEUOwkXSIFfCscLZQIgw+frAVBOpS4dXw
        RxPAqaWZ9085TQtXsXLeSZVSDUZJaMtoq+GLmlKGLZ0jz9cAoTGDiZoyNf+eLwod51k33W
        4uRIjt+vSJQfoDarI4OpnY2yjp65gXdgkPA+GE9byYcNLg3PIg9FUawUCM2EKQ==
ARC-Authentication-Results: i=1;
        rspamd-847cd55849-z7gxd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Quick-Cooing: 2a94c6b13ff68ba4_1651870059003_335350544
X-MC-Loop-Signature: 1651870059002:1064267323
X-MC-Ingress-Time: 1651870059002
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.134 (trex/6.7.1);
        Fri, 06 May 2022 20:47:38 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4Kw2gs66BNz3V;
        Fri,  6 May 2022 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651870058;
        bh=ni7bqdS03z4h5SXMAsYuuzVOnX1oevvYBXsf9q9pN0U=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=scUwtUP29ocNYAs4+MZOgbf2Oy/LkuQTr5o5JiyQ4gYbZFDAPU82UcuKbgfjH+Fzh
         q0kQgyVbxgVkL+eKvcFY5AivbSb+k2Xz0QwSPWQYnerb5srlS8HLDR1gTv1GURGot9
         dgctQNSkV7ciqMgqxTJVcLmefqQNevEzPlftZVxdoV5gF8H+rK2YQq8n9SVMcoH1zz
         CtTIf2QvHwUkTyb7dHjSezhu2NxVY6FJF/Z8Axq70sJTC++ZwwCbOVpv+IbYLgCBEH
         o+MiRcG6U8TSHpOxH6u5/EicLNFY4LcHdjG3FyBY2l+KPtzvY7ovoeE/pyDABcQjsD
         qVHc1Ik0cCBYA==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v2] drivers: acpi: clean up spaces to be consistent
Date:   Fri,  6 May 2022 16:47:31 -0400
Message-Id: <20220506204731.330378-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

