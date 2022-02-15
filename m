Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1B4B7804
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbiBOUmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:42:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiBOUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:42:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8BC0851;
        Tue, 15 Feb 2022 12:42:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x4so128646plb.4;
        Tue, 15 Feb 2022 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r7aQKfHQNbvXQAZ09x2kfq74/yB7edBqYghwPcSjWB0=;
        b=eMFRIjI5Q57RNmJQhdWK3fH1rbwCZxUEa9rV8cFqiP9kxdW5e+dSp8Z8XPL7tyP0bV
         aB+tHe0E8tXE/s/SPBSf9IJgiPsBNLfnnc5AfQwIEgQO3DdQkVVkZ2+RZ4Lwv2MZI7mE
         zJ5rX2QU4C56EUjDFoe4SypIP43OJkhI9hlhpwIdSOxQsUpcPRow9dWm86/n5oSVjtlr
         4AxeOWeGbFJpsNgIL5/1xpWlMJfUhe3Vi6OGWg2FZkL43Ja/g5DSgs34JceMw2K+34O1
         XANwDQUY/qoSMzBYQNs8i3qPBP4xWiWD9bfXg19e1IssakqsZFCQUd8TKDsalJd1LH9e
         m0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r7aQKfHQNbvXQAZ09x2kfq74/yB7edBqYghwPcSjWB0=;
        b=4dUpIf8GW3fdMm5xQ6VaF1EbsyIOHK84V6z9xDJ2HCck62/YWPKafH1BrbfP1Nlywi
         NMbZ+ZqpvtmVT8LMPayiqXad82g3y0724oXMZPd2yTxeufwEjApWFfkJitWlgKgYwiPt
         mmKSU00OlSEK+kCUYyMXGNz8SKx0aK86PUj/oi3NZaTYp/uuHWkt1dv7NYAiy9mPHtdr
         rHpXihdM4C4HK0oJlmFVh+eBiV/vlmandTqJRlamN1o+8SULEowcBuudso/sAHsIYp3e
         7vm0L9fT/I8AVAJnx7YmsURffKSHU5HcP6+g9/uNqe2GI1DPFehJH6oB8j+/N9ojOrm6
         HKnA==
X-Gm-Message-State: AOAM531y91zIGhvMUnLEZffLeUDF39Iilm4sfP82MxcL0P2m5EcVwOy0
        TVeShdrnt8g4kHNuAeqext7k3oiqzyY=
X-Google-Smtp-Source: ABdhPJwHBj/C5jLWrWfnn9OyDmzUxDz9sNJdroORzhGRYcF14jDbQd+wFpy44/V3MVPodkLBGH5Xbg==
X-Received: by 2002:a17:90a:d3d1:: with SMTP id d17mr715698pjw.38.1644957755172;
        Tue, 15 Feb 2022 12:42:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id ls14sm15472912pjb.0.2022.02.15.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:42:34 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:42:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajat Jain <rajatja@google.com>, Wolfram Sang <wsa@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: psmouse - set up dependency between PS/2 and SMBus
 companions
Message-ID: <YgwQN8ynO88CPMju@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we switch from emulated PS/2 to native (RMI4 or Elan) protocols, we
create SMBus companion devices that are attached to I2C/SMBus controllers.
However, when suspending and resuming, we also need to make sure that we
take into account the PS/2 device they are associated with, so that PS/2
device is suspended after the companion and resumed before it, otherwise
companions will not work properly. Before I2C devices were marked for
asynchronous suspend/resume, this ordering happened naturally, but now we
need to enforce it by establishing device links, with PS/2 devices being
suppliers and SMBus companions being consumers.

Fixes: 172d931910e1 ("i2c: enable async suspend/resume on i2c client devices")
Reported-and-tested-by: Hugh Dickins <hughd@google.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-smbus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index a472489ccbad..164f6c757f6b 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -75,6 +75,8 @@ static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
 				    "Marking SMBus companion %s as gone\n",
 				    dev_name(&smbdev->client->dev));
 			smbdev->dead = true;
+			device_link_remove(&smbdev->client->dev,
+					   &smbdev->psmouse->ps2dev.serio->dev);
 			serio_rescan(smbdev->psmouse->ps2dev.serio);
 		} else {
 			list_del(&smbdev->node);
@@ -174,6 +176,8 @@ static void psmouse_smbus_disconnect(struct psmouse *psmouse)
 		kfree(smbdev);
 	} else {
 		smbdev->dead = true;
+		device_link_remove(&smbdev->client->dev,
+				   &psmouse->ps2dev.serio->dev);
 		psmouse_dbg(smbdev->psmouse,
 			    "posting removal request for SMBus companion %s\n",
 			    dev_name(&smbdev->client->dev));
@@ -270,6 +274,12 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 
 	if (smbdev->client) {
 		/* We have our companion device */
+		if (!device_link_add(&smbdev->client->dev,
+				     &psmouse->ps2dev.serio->dev,
+				     DL_FLAG_STATELESS))
+			psmouse_warn(psmouse,
+				     "failed to set up link with iSMBus companion %s\n",
+				     dev_name(&smbdev->client->dev));
 		return 0;
 	}
 
-- 
2.35.1.265.g69c8d7142f-goog


-- 
Dmitry
