Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADCF465ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355858AbhLBHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbhLBHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:47:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C1C06174A;
        Wed,  1 Dec 2021 23:43:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i12so27116922pfd.6;
        Wed, 01 Dec 2021 23:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aYYhLPh4+HbnEt5y+7p1g4uC3CXAQCN2WeTgiask7zE=;
        b=d8UbdhQWKxTus0ErEdwEtYT/an5mZBaZGPXKBxD8BLqnxXrvQ7bYtt27Od4DpyRC7a
         wX3rUeqZCIu1O2sabZyhchQhDlCY1ZDQshmQnN36XoSgcJuanX96FULx8vH+dhbDJdGo
         YtR0U/TNPa0EldA41/dkkvHY8Hf9Cb6mU9WtQ2y0FMKimJCvpqILouNSzzdHxSEtfdx6
         3l9DoXha11Cfp0O1OTEl1wovLS45BrWyVYZoZk0a6/snb950AzDK0G7wS0crHxJplRW7
         FYtftwIiNfdDjSE3anKhkYgVljKDToo3YdfuhM5ewLTYWd3M2T26P0WPuGcYucXHK5kX
         6pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aYYhLPh4+HbnEt5y+7p1g4uC3CXAQCN2WeTgiask7zE=;
        b=iqIWxUTyTPZFSVQ2nl7xLAmkMhdsPuWdI4J9oaZyPK7Urm9/6+ZVREIOu9RtGolDCS
         GOg4GiVN2J8oYO5EvD2bKKnE0xHRU9ACcSDmUFTkQZLIogLfV6/HnssSbdBcfkSwx61i
         lkr6cAnAVFTPtvn+v9wL8CPLE5aL2qhCDOvwIAEiyWg1sWEkoRv8SHlgcEZuHWsuM5ZW
         fRKVtKYpQXW31+ElBXORJ8suFV5xnN4OLUyBwFF6lLkC/JBJqTDHyTo2ve+VHp01UmuY
         kjzObDLHIn61cM3pL08hAfr2Szwk9/Ew/UzWtaJ3ShyyWSjY7bruCirc/t1nP76yGis7
         Jp1Q==
X-Gm-Message-State: AOAM5311u70b9MDsmZmNRs3iAHoaAJbpGd3rP+6PNsIj9sWbl5xylsz9
        0+ErzYgKGrpx8iV2NEkNk4M=
X-Google-Smtp-Source: ABdhPJzJz2ZIkK2SHKuvqOMNRpGFKQCcQ/u34pDhggtPphTRPzxNAHQl9e9dQzxzkrOF2xcCU1H7Mw==
X-Received: by 2002:a63:f410:: with SMTP id g16mr8198631pgi.423.1638431026388;
        Wed, 01 Dec 2021 23:43:46 -0800 (PST)
Received: from localhost.localdomain (59-124-112-150.hinet-ip.hinet.net. [59.124.112.150])
        by smtp.gmail.com with ESMTPSA id d15sm2144973pfl.126.2021.12.01.23.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 23:43:45 -0800 (PST)
From:   Steven Syu <stevensyu7@gmail.com>
To:     heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Syu <stevensyu7@gmail.com>
Subject: [PATCH v2] usb: typec: clear usb_pd flag if change to typec only mode
Date:   Thu,  2 Dec 2021 15:43:12 +0800
Message-Id: <1638430992-15976-1-git-send-email-stevensyu7@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set usb_pd to 0 when power operation mode
leaving power delivery. That can avoid user-sepace
read "yes" form the supports_usb_power_delivery_show() attribute
but power operation mode already change form power delivery to
others mode.

Signed-off-by: Steven Syu <stevensyu7@gmail.com>
---
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

