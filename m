Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90346CE36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbhLHHWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhLHHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:22:06 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062DC061574;
        Tue,  7 Dec 2021 23:18:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l64so1295160pgl.9;
        Tue, 07 Dec 2021 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WSNq3zJ7WU0qx1y83Y7TKyyXelC9tIaxgdOENA640bs=;
        b=FFbyCzgpL0sqjwPm0yxnVR6qlLAN79mQpr0fRfVtw3ryV8eBgSxA8yYiUA5iCVxIKp
         CZzmXoWGFTIZ7stjshKMhzn1cZ3Y3NrI+1aXSkxz1GwFQJ0NAu2k+s36K1btJ2d9v+Pl
         O033KebN10I623Gs7IsPq5k1piysHB0L+mJb9puxdOKUnJXmIlAUgOky/n+Kf/8EKODm
         0vmhrB46dXkFYk3wZu8Ds6P1Vby6wsAS1vEuCR59AuZTtwFxsKo/i0Ibd0LG3GZM4MrX
         xSAiBuIGEBQuYDSkeAmfrMGcIXjAgOGn3htaQKbuKPie1HBKY62hd4ZCjQRdrqTPazKx
         HzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WSNq3zJ7WU0qx1y83Y7TKyyXelC9tIaxgdOENA640bs=;
        b=bqHUL0FfywqdMlIPvOzzFRPBsKecI9JGs8tgG9EML4V3b6JXO+liI4WTPhJXId5YJv
         RWlCamqiotwSdzi1N5sRUOj4Zb9PGuwb3uiQ9m/FsRXOFBNYCamruDxKyl9xSfK24j4R
         Trn9c47LeXmXeimwdu5vgPnQkIjJaf5uB/amyjs5w3fWCxgLWgkvmCAMA9D0h6Fe2RHS
         5GD56rAE7Fa8EswhQIGdDrOupCTZKanF/fH4+nwEQzmsXDrbbSulTSPgrQy6wZ+jXn4d
         0E1FL8EV428k+zmlj3SgtbHJ76a5C/CkCASc48GsuSatvXspfItQFRqZnSSbeQ1YE9Bb
         N4fg==
X-Gm-Message-State: AOAM532S2576yq5hSxxFTnblZHZwfDcekccKGCcTVhxqv4+mYFGYXSTu
        675EjnjH7ZuJFM4htIvDvj8=
X-Google-Smtp-Source: ABdhPJyfzfZS+YrYJhAigzleHWcOoizlWMTuzeO8kwTd8wCbhwZj+Nb9b7DfXbrA6FeNPMC0TukxXQ==
X-Received: by 2002:a63:1b1c:: with SMTP id b28mr27772608pgb.288.1638947914374;
        Tue, 07 Dec 2021 23:18:34 -0800 (PST)
Received: from localhost.localdomain (59-124-112-150.hinet-ip.hinet.net. [59.124.112.150])
        by smtp.gmail.com with ESMTPSA id k16sm2310767pfu.183.2021.12.07.23.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 23:18:34 -0800 (PST)
From:   Steven Syu <stevensyu7@gmail.com>
X-Google-Original-From: Steven Syu <steven_syu7@gmail.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Syu <stevensyu7@gmail.com>
Subject: [PATCH v3] usb: typec: clear usb_pd flag if change to typec only mode
Date:   Wed,  8 Dec 2021 15:18:25 +0800
Message-Id: <1638947905-2502-1-git-send-email-steven_syu7@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Syu <stevensyu7@gmail.com>

Set usb_pd to 0 when power operation mode
leaving power delivery. That can avoid user-sepace
read "yes" form the supports_usb_power_delivery_show() attribute
but power operation mode already change form power delivery to
others mode.

Signed-off-by: Steven Syu <stevensyu7@gmail.com>
---
changes for v3:
resubmit and add the changes comment of v1->v2

v1->v2:
1.remove sysfs_notify(&partner_dev->kobj, NULL, "supports_usb_power_delivery"); when operation mode is not PD.
2.resubmitted patch by private email for remove footbar in the mail.

 drivers/usb/typec/class.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453..2043e07 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1718,6 +1718,8 @@ void typec_set_pwr_opmode(struct typec_port *port,
 			partner->usb_pd = 1;
 			sysfs_notify(&partner_dev->kobj, NULL,
 				     "supports_usb_power_delivery");
+		} else if (opmode != TYPEC_PWR_MODE_PD && partner->usb_pd) {
+			partner->usb_pd = 0;
 		}
 		put_device(partner_dev);
 	}
-- 
2.7.4

