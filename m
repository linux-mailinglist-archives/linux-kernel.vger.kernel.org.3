Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29046D020
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhLHJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:35:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLHJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:35:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81ACF1FD2A;
        Wed,  8 Dec 2021 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638955933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SCwFerdjzwTA7lozIJo/7cN2zuWAsDUZzTz6KxaDJtI=;
        b=ejjgkZSglDZEyPWn4U1iCWi8m9fKj+UR7tBkrDm2yxr+gki+Q/mwA25ZY/wXeYHwhMqdpJ
        w50drJ2R+XO8ih33Uw66l1/4QzvatFRp65GcsYRfeFdxDsukxYKOssCR4CtjNwrm7mA/7b
        pSlnPzvkrR/uPsBZDvhtDsG52JSg4dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638955933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SCwFerdjzwTA7lozIJo/7cN2zuWAsDUZzTz6KxaDJtI=;
        b=tjZ1BatQAum8GenyxvhdR4g0nIY/Yy0c9HY9mKvvHPlKzRIhxizDjRoCWeCQaAr7vtAqi6
        eNcsXT4rHGd5oRCg==
Received: from un68u.suse.de (unknown [10.163.42.126])
        by relay2.suse.de (Postfix) with ESMTP id 48043A3B85;
        Wed,  8 Dec 2021 09:32:13 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     minyard@acm.org, kamlakantp@marvell.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ipmi: ssif: initialize ssif_info->client early
Date:   Wed,  8 Dec 2021 10:32:39 +0100
Message-Id: <20211208093239.4432-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe ssif_info->client is dereferenced in error path. However,
it is set when some of the error checking has already been done. This
causes following kernel crash if an error path is taken:

[   30.645593][  T674] ipmi_ssif 0-000e: ipmi_ssif: Not probing, Interface already present
[   30.657616][  T674] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000088
...
[   30.657723][  T674] pc : __dev_printk+0x28/0xa0
[   30.657732][  T674] lr : _dev_err+0x7c/0xa0
...
[   30.657772][  T674] Call trace:
[   30.657775][  T674]  __dev_printk+0x28/0xa0
[   30.657778][  T674]  _dev_err+0x7c/0xa0
[   30.657781][  T674]  ssif_probe+0x548/0x900 [ipmi_ssif 62ce4b08badc1458fd896206d9ef69a3c31f3d3e]
[   30.657791][  T674]  i2c_device_probe+0x37c/0x3c0
...

Initialize ssif_info->client before any error path can be taken. Clear
i2c_client data in the error path to prevent the dangling pointer from
leaking.

Fixes: c4436c9149c5 ("ipmi_ssif: avoid registering duplicate ssif interface")
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/char/ipmi/ipmi_ssif.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 0c62e578749e..48aab77abebf 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1659,6 +1659,9 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
+	ssif_info->client = client;
+	i2c_set_clientdata(client, ssif_info);
+
 	rv = ssif_check_and_remove(client, ssif_info);
 	/* If rv is 0 and addr source is not SI_ACPI, continue probing */
 	if (!rv && ssif_info->addr_source == SI_ACPI) {
@@ -1679,9 +1682,6 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		ipmi_addr_src_to_str(ssif_info->addr_source),
 		client->addr, client->adapter->name, slave_addr);
 
-	ssif_info->client = client;
-	i2c_set_clientdata(client, ssif_info);
-
 	/* Now check for system interface capabilities */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
@@ -1881,6 +1881,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 		dev_err(&ssif_info->client->dev,
 			"Unable to start IPMI SSIF: %d\n", rv);
+		i2c_set_clientdata(client, NULL);
 		kfree(ssif_info);
 	}
 	kfree(resp);
-- 
2.31.1

