Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FE533E81
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiEYN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbiEYN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A55A0D35;
        Wed, 25 May 2022 06:58:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso1012054otr.0;
        Wed, 25 May 2022 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPEelTcpA7Az+N5/wDvzWQHkEK+u2NGiIBIfSbHK08k=;
        b=DTPZ3tmOneAboeVn2wStrfxHE+BQJEcyWALYkFPbzUGcH+3DNtd3d6AH+lY5McK8vk
         6TSuTzDzp+nupMypaijlyxmsdbSuE2iD0D9qe8UZ8TdC1VK8nXilgj78ZSiORI5f3WKU
         7Aki7w0I6RzAZpfPKT0w3b/tm4Hh6gQKDiZUnsLnMaJN9ymnUD6jI5vNxesZ6aM1ogiE
         T5QPuo4450lyKSfnEqSss76lXifzy5swqI4AuCGAwmgwLltTLOomDD0AMWCuC8EM/e5U
         Up5sJuQ3uadE3/arbLDKUnSQXJxyNqg4qB0TApvLkrUxUudZXWhzttTRnekUqZjleb2W
         5NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bPEelTcpA7Az+N5/wDvzWQHkEK+u2NGiIBIfSbHK08k=;
        b=W354L64bcSaKWeiZ7U+5H0HpstVxoI20/1Wf4T/NScupmsat2bzX1BJWjS0FX7RPBM
         yR1xh5NpxX6+jmjnCV9lebsvc7PdzlEM6GHWC6P39tEh/UNPdZ0vwNpDcHQKWBBUOhP1
         N2vUNav53ggPKabhHRpC+7/FNg4BAx141jnewJgNQDdUh9AtVWejnMz0/FCJ3QnTOpyM
         QfgEd8upR6mJzBA1cxLf2Qru4S+2Dz1i1wQyIYpdcH9TlHMY1pXymqp6TA33dwnf/kr0
         Y/VAxEJ1SO1ciwGlDSL8PsTcC8SQ4eEX01znZfEF2snqa5z7G2Haz4t2yPM75R4qvIwp
         SpbA==
X-Gm-Message-State: AOAM532+TEppYBjqyusTdIk8eCjDUPdm/+3Gkd97D0yggtGmOkdiQymZ
        pBBU6p42C/HB6DPbDhbTSXz7AtYoR08QYQ==
X-Google-Smtp-Source: ABdhPJxc2r03rbomuDro3uOZFSGQ2JzvXKXS1z7gTjUCgASX5t++0le2C7WEyt1qBeO/5qQ7VZAg8A==
X-Received: by 2002:a9d:3eb:0:b0:60b:697:7ccf with SMTP id f98-20020a9d03eb000000b0060b06977ccfmr7478552otf.349.1653487098406;
        Wed, 25 May 2022 06:58:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1-20020a05687014c100b000e686d1387csm230370oab.22.2022.05.25.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/40] hwmon: (lm90) Add partial PEC support for ADT7461
Date:   Wed, 25 May 2022 06:57:27 -0700
Message-Id: <20220525135758.2944744-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revision 0 of the ADT7461 datasheet suggests that the chip supports PEC
(packet error checking). This information is gone in later versions of the
datasheet. Experiments show that PEC support on ADT7461 is similar to PEC
support in ADM1032, ie it is only supported for read operations. Add
support for it to the driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst | 1 +
 drivers/hwmon/lm90.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index f107d4a159fa..9886a298797f 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -322,6 +322,7 @@ ADM1032:
 ADT7461, ADT7461A, NCT1008:
   * Extended temperature range (breaks compatibility)
   * Lower resolution for remote temperature
+  * SMBus PEC support for Write Byte and Receive Byte transactions.
 
 MAX6654:
   * Better local resolution
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 8ba95ea06f0c..6c79422da420 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -356,7 +356,7 @@ static const struct lm90_params lm90_params[] = {
 	[adt7461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
-		  | LM90_HAVE_CRIT,
+		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
-- 
2.35.1

