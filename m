Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7C49CC99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiAZOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242297AbiAZOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643208274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h+Gqz+i3jr65DckDxVwcGyle0pa93d1ByC6vRQ3mUOk=;
        b=G9P68YnRgUPutOkTeFPu1gKg1YGdMmEIVPNeM2GRVZEYuEBuLtRgQndzCmzQE3lbM/osVY
        KuTimsCce6bkGTVoUqe5fTjaFu88/rWmLYR78Y+offHK1i3srejHYImAbAZSH0Pm5DQ0U2
        UKTwM4zGIcuezBcnQ+cSNDLEzklH6dM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-TTsIWBVVNsquhpL7Enjktw-1; Wed, 26 Jan 2022 09:44:32 -0500
X-MC-Unique: TTsIWBVVNsquhpL7Enjktw-1
Received: by mail-ot1-f69.google.com with SMTP id 30-20020a9d0a21000000b00594d9ed4bf1so15446425otg.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+Gqz+i3jr65DckDxVwcGyle0pa93d1ByC6vRQ3mUOk=;
        b=O6S8bGMN4oB3lQ36tHvuD0DuS58GZ5EU47znuzekIeCoJ/OBDri6NfGdHjATiOKIGK
         8kKExNj4L6IsXu7nTHeLkw7kw9/REEYMrD52HHxq0g75Z9QOBjuOdd95TYXcXq6pLuKU
         4jUSvxib0K5Fbfayd4igXytjvT47AreyFUeWxgoP6qpdoukBCsoTgHLPw2i7c2XnipfE
         HfgEmcY2xlFxwhYDweXXpMvNyOCI6WZPDq7yisEJzI3+UubqQ8n12JnZOSrEf2hDpY8A
         Pql92YOvvzGwSEA+jPpuYU5tStTcgrXKp1yNa4mf58ZgHRhgsinTtrgKMobsukbDWWtl
         TVzQ==
X-Gm-Message-State: AOAM5331ClajqkGoLzZuiGQ29/ZfvOfHzkskqDyGAzm56/OtFwLmL1sD
        5bbXC9wN/Hy63bRFEuPQOrCxpNz/AulrvOep8MW74ecf05If/hgK0binY5coxXTLIzH969yPf58
        SS2wZnBOQCfjCQpV4d1B8E/y5
X-Received: by 2002:a4a:d02c:: with SMTP id w12mr352037oor.38.1643208271955;
        Wed, 26 Jan 2022 06:44:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHGKh36XsGYbRTM/FfJGvF4MhP6mweAYuEeF4qWKixv/xgkH90AL3sP2UBkWdd0n152muikQ==
X-Received: by 2002:a4a:d02c:: with SMTP id w12mr352021oor.38.1643208271748;
        Wed, 26 Jan 2022 06:44:31 -0800 (PST)
Received: from ovpn-116-179.gru2.redhat.com ([2804:2984:10c:7100:db78:6ebc:9e65:6c6e])
        by smtp.googlemail.com with ESMTPSA id m130sm8896672oif.21.2022.01.26.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:44:31 -0800 (PST)
From:   Lucas Zampieri <lzampier@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lains@riseup.net, nlopezcasad@logitech.com,
        Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH] HID: logitech-dj: add new lightspeed receiver id
Date:   Wed, 26 Jan 2022 11:44:00 -0300
Message-Id: <20220126144400.130797-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of logitech lightspeed receiver fw version 04.02.B0009,
HIDPP_PARAM_DEVICE_INFO is being reported as 0x11.

With patch "HID: logitech-dj: add support for the new lightspeed receiver
iteration", the mouse starts to error out with:
  logitech-djreceiver: unusable device of type UNKNOWN (0x011) connected on
  slot 1
and becomes unusable.

This has been noticed on a Logitech G Pro X Superlight fw MPM 25.01.B0018.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/hid/hid-logitech-dj.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index a0017b010c34..9f68c0631439 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1068,6 +1068,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
 	case 0x0f:
+	case 0x11:
 		device_type = "eQUAD Lightspeed 1.2";
 		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		workitem.reports_supported |= STD_KEYBOARD;
-- 
2.34.1

