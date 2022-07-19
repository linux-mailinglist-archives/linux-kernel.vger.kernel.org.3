Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C257A278
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiGSOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiGSOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:54:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686DF7E;
        Tue, 19 Jul 2022 07:54:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id by8so14067043ljb.13;
        Tue, 19 Jul 2022 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZU0Bu2rg9jlNUnlDr9BOrJmTz+1TW5Vgl1xGRwguT1I=;
        b=dBOtQ2L34N7/ZUS0IW7WRgJmuqRO+OaEK0XQfXqdkeaBFaHNK1IhBpKVuy4r5kypW8
         PcI0qnMQDupjucogn5YD9nhWlq8m4bk16a7y4A7/KqmE6CFFCRGqHQNDjrV6N4fvukNu
         Q7xntwch8Koq2Kt8bAsQ8AzkZeUHbYz6MBK8wOP3lNkhODfhJ2LojzLSTm+UTMJhoufe
         iHvZx78/rzMjy6f6/680BbsEEPaemGTjoAL5e1bahG1MhFNLW7BfrWbZEizMMQ/YTlvW
         NtpZnJeU5CkDovDVWK6kREY71u7tNpdrQMXMR7fK8P0r1iHGm4cgKn9CMV4CSpCkEXGr
         1fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZU0Bu2rg9jlNUnlDr9BOrJmTz+1TW5Vgl1xGRwguT1I=;
        b=2HjG2tLWc2zZd7lboUviRO9jrsUhqpubZ9vHIyRq53JhjMThlk1TuIQoJfFQUM2aTp
         mtJN2sq/vRhTALHv4wCmOTNCGtQZDT8Bgqnmy2eCtOY3U1MADZumDAHdYXfG2oUIMnJ7
         yJlHh56Q3W5s+15d6/OP1vCiQAsQoImwBPU3qz2Quebdeu+7rrGdz1JAuDseU//6o9bO
         34q14ia5Ho45gR7wVzhHio0Jhn6vgq6Y/WojTWafInAA1ZJ2PdP4I5cS7C+GgPghLlAW
         MgX4ngtOsYBDKe3sbY02nwgEgmfNdWavsYkIvBc4G6D72jgZHOW+RzvvLfj7r0qcSNKE
         ELMQ==
X-Gm-Message-State: AJIora/Za4N3ZdizyF0YIxWpPdRxA0BttXRUyOffYN4KEXkb/ywIR5mW
        lKLwQFM450MgULT4M3CtNl9bSJC/bOhEVYOR
X-Google-Smtp-Source: AGRyM1vumWCwbaQAZKdozbWuO9f8JGaWExrVofDlFag/GxRk8+pbOFzZvYM/AWi46nrd8X9sTt0NWw==
X-Received: by 2002:a2e:a58e:0:b0:25d:7113:7f30 with SMTP id m14-20020a2ea58e000000b0025d71137f30mr15140220ljp.74.1658242438460;
        Tue, 19 Jul 2022 07:53:58 -0700 (PDT)
Received: from localhost.localdomain ([31.180.181.180])
        by smtp.googlemail.com with ESMTPSA id v12-20020a2ea60c000000b0025d5c86d44dsm2623101ljp.103.2022.07.19.07.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:53:58 -0700 (PDT)
From:   Artem Borisov <dedsa2002@gmail.com>
Cc:     jikos@kernel.org, dedsa2002@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: alps: Declare U1_UNICORN_LEGACY support
Date:   Tue, 19 Jul 2022 17:53:24 +0300
Message-Id: <20220719145324.8107-1-dedsa2002@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U1_UNICORN_LEGACY id was added to the driver, but was not declared
in the device id table, making it impossible to use.

Fixes: 640e403 ("HID: alps: Add AUI1657 device ID")
Signed-off-by: Artem Borisov <dedsa2002@gmail.com>
---
 drivers/hid/hid-alps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 2b986d0dbde4..db146d0f7937 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -830,6 +830,8 @@ static const struct hid_device_id alps_id[] = {
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
+		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
 	{ }
-- 
2.20.1

