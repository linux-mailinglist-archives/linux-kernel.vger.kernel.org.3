Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA970492055
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiARH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbiARH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:27:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC03C06175A;
        Mon, 17 Jan 2022 23:26:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q75so5414056pgq.5;
        Mon, 17 Jan 2022 23:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FvLWa2TvyJ6Dd9BiAJ7VPRCB014iQemLHUSFzvWnWU=;
        b=h3iIB2y8FkG6MKnZaDBFUhMwfS62Rr7ktzTHy3yh2ICJyDJRH0rBiw7WLu3lZWGry7
         uVPQYqiY02ci2moKyxdUlEHCTMXRXuRQwrsUkJLzRuAo7pN80bYoYYVN35m39oiq3SnH
         U2WjSqamnusgMkMAsp5rjwLBi61kv/P2KeSGYxME/lyM12zf0Fb1EgJlKOGh2wPuIrDJ
         8qIwG9Np7wmBvmCj3mzZaTLYKqcbdMLo9arQQFiJgnkwnUMk+A60PafPr0vNiTp9xJmB
         xdQGX0T7dy6xRuKlJOItr4bmC2oWJnmAtiubM4fEv1j9+pKD32R+PKg1ZVRj4bjul5Tq
         TJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FvLWa2TvyJ6Dd9BiAJ7VPRCB014iQemLHUSFzvWnWU=;
        b=L/BuxlG+dWGiXpvzUoPYyi638kTlH0GnHZ6FYOrO7k6gqZiYSVmZvyIJKbFCszOZWf
         QTbmsHW4Oosbvxfyh9Z3AnIhCz0UOuxrUNPommP5VEjSkoeQOT2vBjQvTq9EEtqC8ftG
         XOLSw/oFuwuw+2i64hjS9yUhAENjfEDHTkSpbc/7VvskrgqSSzbsnApy7uFAI8e42zg3
         sMp68ZhE5jn8ZejNI9PwdA3dL7yR4g2E/paVuaHIkcgxO48M7v669zCJKk6RMB+tTPb8
         cxpuDZYMGtx7oFpFF3M66ZLsenahBadTzIW+wwo+gpcuVEGbOUjzOp8s6HNDqMM4RdDl
         ficQ==
X-Gm-Message-State: AOAM531SSBotrpU1zT5vYZrpGyAHBVgF9dpr/DFZK0SAR6bTC1L6i3SD
        4g5/0kLWbftyC+MztBbK+mc7DskrHGw=
X-Google-Smtp-Source: ABdhPJztueEeTXZP+eCSDmu5GHanYJ4WiG6kPm9zlg+DjVkc4ncXIWE0B3PfTtorjbKJYarWOkoKEg==
X-Received: by 2002:a63:8b4a:: with SMTP id j71mr22134690pge.430.1642490810698;
        Mon, 17 Jan 2022 23:26:50 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:49 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] HID: i2c-hid: note that I2C xfer buffers are DMA-safe
Date:   Mon, 17 Jan 2022 23:26:28 -0800
Message-Id: <20220118072628.1617172-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All I2C communications in the driver use driver-private buffers that are
DMA-safe, so mark them as such.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index aa7c573b35bc..92dd86c42975 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -180,7 +180,7 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 			    __func__, send_len, send_buf);
 
 		msgs[n].addr = client->addr;
-		msgs[n].flags = client->flags & I2C_M_TEN;
+		msgs[n].flags = (client->flags & I2C_M_TEN) | I2C_M_DMA_SAFE;
 		msgs[n].len = send_len;
 		msgs[n].buf = send_buf;
 		n++;
@@ -188,7 +188,8 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 
 	if (recv_len) {
 		msgs[n].addr = client->addr;
-		msgs[n].flags = (client->flags & I2C_M_TEN) | I2C_M_RD;
+		msgs[n].flags = (client->flags & I2C_M_TEN) |
+				I2C_M_RD | I2C_M_DMA_SAFE;
 		msgs[n].len = recv_len;
 		msgs[n].buf = recv_buf;
 		n++;
-- 
2.34.1.703.g22d0c6ccf7-goog

