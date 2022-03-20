Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8024E1BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiCTOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiCTOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BED111BE45
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647784813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HqtBnaidAKh4bnH8X6OIwDCPKflO5zN16a0ESKUGgsY=;
        b=P9yGgRkG8TyaCEejnlJ7XbkwyxfdvNgyVFpdiDkrzLPhLQUooF0f+39WDJCg1skpAd2CEV
        RsTkZE5o4bWILajsbP9Z7KOa9iWjCDseWx2qLEoZAjbIo0GxVDGdXL/HLo1aTndINa/Vf9
        nNRhBniRnKf8fdm2WNdAArx5yFpKLdQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-5ZkeIaYlP7GDX2olJGnlJQ-1; Sun, 20 Mar 2022 10:00:12 -0400
X-MC-Unique: 5ZkeIaYlP7GDX2olJGnlJQ-1
Received: by mail-qv1-f70.google.com with SMTP id h18-20020a05621402f200b00440cedaa9a2so9915692qvu.17
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 07:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqtBnaidAKh4bnH8X6OIwDCPKflO5zN16a0ESKUGgsY=;
        b=fd4a3+Nl8r3fnmnD8r7P4+mowdXUspyHuWIlLFjH6txVpa7+jAJkN4aJGZ0HfKPPH1
         pd9IhDfvffmmmTo74KEWMSchc6poi/m1yq6OV9hKuiTsbApqMklCOH297oS14JsjEVO1
         kWTBEpL/2xYZt4pAz2+6447Bf5rLx+wAzHglOmyAXcFGmIXj0p6mCopC3HptKMp/Pu3Y
         6MJVGQOvtJQy6K3+ToMV8/XulOWtZzyW8UiVP2oeKsi5IgktgHAMl5PPB9crr9XgTqxW
         keUQ4gofpDJhQuZIFKXCe4paV8FZgBCrA24dcWQmiYlybQpbxnkfl01mkrHVx00hWWe6
         W44g==
X-Gm-Message-State: AOAM530SDAivFmGdIimcF6nvqyFHOCYnEN6jKOrMS0OVS9H21B/D7fR9
        3fhsPHh8Qfg4mDgYa6IP/Gy0t331jfq7Ld6bLJ/BjDmrrUrU6MlCP2psPRF5Pq/IllYdNyjdbdX
        OC5iDh3fGu+nR9ZEDj4MWV8ja
X-Received: by 2002:a05:622a:1009:b0:2e1:a2e8:4e63 with SMTP id d9-20020a05622a100900b002e1a2e84e63mr13276891qte.668.1647784811817;
        Sun, 20 Mar 2022 07:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlqaEeWCI8SmnIB2oKIVuA19Yctu0B6K5Ke0aAHbQCy5tIqe6tYsJr/bBcM2Tr/0lC3rE78g==
X-Received: by 2002:a05:622a:1009:b0:2e1:a2e8:4e63 with SMTP id d9-20020a05622a100900b002e1a2e84e63mr13276879qte.668.1647784811591;
        Sun, 20 Mar 2022 07:00:11 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a245600b0067d6dae634csm7202133qkn.9.2022.03.20.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 07:00:11 -0700 (PDT)
From:   trix@redhat.com
To:     minyard@acm.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ipmi: initialize len variable
Date:   Sun, 20 Mar 2022 06:59:54 -0700
Message-Id: <20220320135954.2258545-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
ipmi_ssif.c:1731:3: warning: 4th function call
  argument is an uninitialized value
  dev_info(&ssif_info->client->dev,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The 4th parameter is the 'len' variable.
len is only set by a successful call to do_cmd().
Initialize to len 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ba779f1abb5b2..f199cc1948446 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1625,7 +1625,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	unsigned char     *resp;
 	struct ssif_info   *ssif_info;
 	int               rv = 0;
-	int               len;
+	int               len = 0;
 	int               i;
 	u8		  slave_addr = 0;
 	struct ssif_addr_info *addr_info = NULL;
-- 
2.26.3

