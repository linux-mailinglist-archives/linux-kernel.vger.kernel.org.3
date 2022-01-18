Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A12492054
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiARH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbiARH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:27:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA6C06173E;
        Mon, 17 Jan 2022 23:26:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f8so13143445pgf.8;
        Mon, 17 Jan 2022 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qfNABkAMQ9lvs4J9n2+LJ7pGeCibSui0x9nCGYBI3Y=;
        b=cbrGOr4JycopPRJMZi+ClDgmEqcX39wdf6ziVx4RcPAFoO9hLROE7FlXdUtu+K8F1a
         mqrIkuX184E1KHWXXu9PHESah/ABUweD1mhe2NOcmzihU/CyOD6dl4bGDAR0cpX+VFeM
         bc9bthP9ngOeAJcBEJ+aOpESL/4XYLdOR8/4J36rogfGe6Amyw2AeKIgJcaycDfGX7c/
         zUqbz2TZPOitbrV4WkIG0GFF3XQfVTVN5WH0fLvbZb+hdqogAsyMFlQ0/b/R2YQ12Gl8
         GJ22E5+2+M/kZxv13yklRwjH7hgy9CiIM6iYVf7cHCg6/ppo5xLtsYaDxkPdeV0y2NAs
         r6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qfNABkAMQ9lvs4J9n2+LJ7pGeCibSui0x9nCGYBI3Y=;
        b=Z/2ykLTQ/Nff7RPNfO5he/w042AARGdTfS8Qyh4w6dptTTPz1ZkNFqShQjiRlV1e5J
         GY2LZ+RAWPxCFMpg/Q1vHvLAygoCdEz3FlpOv/mxBOHC4kK8AXxLPc23GPM3W977ntf+
         qFCDu08P106S+TKAbx749/AfG8KPJUPYNZC8UzoI7i2tbxbyZXnxz1TT5F+zpLqtNOAL
         yUNbunVOr9kGHXKsyjAYVUyGRaB0THGm9YEWka9xIdGSxoKz4gxRui2pncTAzhya+WaQ
         qkz2w00ib2YiPaVO1bEelVQ5FtDvNPwELRiyW+OKuLMKyfKxbPBHjoUEJrWSfvGqSpEE
         ENbQ==
X-Gm-Message-State: AOAM533Xq8tQ9nKmW/IJrF4sEJiRMFYK/dglj5YZOQCyg18BYCyKe/mQ
        P+8zaoygrw6LgxbOMLFjBUQ=
X-Google-Smtp-Source: ABdhPJwf5qRqctWXExur5xWVlFGQNa4ZqwDd40VH9XCc9/6x9YkW5V7oSqSASyhXVwSiPN/fDBPMbw==
X-Received: by 2002:a63:4f03:: with SMTP id d3mr7670077pgb.311.1642490809191;
        Mon, 17 Jan 2022 23:26:49 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:47 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] HID: i2c-hid: no longer need raw access to HID descriptor structure
Date:   Mon, 17 Jan 2022 23:26:27 -0800
Message-Id: <20220118072628.1617172-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can stop defining a union for HID descriptor data as we now only access
individual members of it by names and using proper types instead of
accessing by offset from the beginning of the data structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 07c2ea057013..aa7c573b35bc 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -98,10 +98,7 @@ struct i2c_hid_desc {
 struct i2c_hid {
 	struct i2c_client	*client;	/* i2c client */
 	struct hid_device	*hid;	/* pointer to corresponding HID dev */
-	union {
-		__u8 hdesc_buffer[sizeof(struct i2c_hid_desc)];
-		struct i2c_hid_desc hdesc;	/* the HID Descriptor */
-	};
+	struct i2c_hid_desc hdesc;		/* the HID Descriptor */
 	__le16			wHIDDescRegister; /* location of the i2c
 						   * register of the HID
 						   * descriptor. */
@@ -918,7 +915,7 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 			"weird size of HID descriptor (%u)\n", dsize);
 		return -ENODEV;
 	}
-	i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, ihid->hdesc_buffer);
+	i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, &ihid->hdesc);
 	return 0;
 }
 
-- 
2.34.1.703.g22d0c6ccf7-goog

