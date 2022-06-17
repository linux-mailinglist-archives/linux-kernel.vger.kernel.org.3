Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B154F771
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381906AbiFQMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381190AbiFQMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:24:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CBE50B1E;
        Fri, 17 Jun 2022 05:24:29 -0700 (PDT)
Received: from dimapc.. (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B571B660179A;
        Fri, 17 Jun 2022 13:24:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655468668;
        bh=1lWpdp3cnfKdrU5D6f5ZdxAw3Yb16msYqFdidiHaCIw=;
        h=From:To:Cc:Subject:Date:From;
        b=bRiz/GGKtPMQSJnbjubjCyPewoA2RiugLa3pqAdwPuIfFFWSOo7cBlAQocAt0+oXQ
         vJZMlDbLX+3n12hDJad9m5/U0xfcS9Ivv0x7ONLYqDqt9+cY0DucX9bLS0tmoLH1ds
         FsRQMxdG7UTNSQVShMUjcEJiebtQGjKvHRh5WsteaA5dcPhQtMAsudtHKyLW3hbGEE
         9UOJhzserUguEidfPBZW3PO4RGmiflvCt3LZo4CVboRuhRDJi8WjsDW5+p9bJDTDzv
         9JyBgSsGun9p//BI0xrHom78ykBWkFP97fx2fgBiIzlOV9rg5yFsO6EPXhBtoXSEfH
         zOEk7kezN6P+g==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ken Moffat <zarniwhoop@ntlworld.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1] PM: hibernate: Use kernel_can_power_off()
Date:   Fri, 17 Jun 2022 15:24:02 +0300
Message-Id: <20220617122402.151782-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new kernel_can_power_off() API instead of legacy pm_power_off global
variable to fix regressed hibernation to disk where machine no longer
powers off when it should because ACPI power driver transitioned to the
new sys-off based API and it doesn't use pm_power_off anymore.

Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
Tested-by: Ken Moffat <zarniwhoop@ntlworld.com>
Reported-by: Ken Moffat <zarniwhhop@ntlworld.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 20a66bf9f465..89c71fce225d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -665,7 +665,7 @@ static void power_down(void)
 		hibernation_platform_enter();
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (kernel_can_power_off())
 			kernel_power_off();
 		break;
 	}
-- 
2.35.3

