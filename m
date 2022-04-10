Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D784FB09F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbiDJWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiDJWIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:08:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DC25C53;
        Sun, 10 Apr 2022 15:06:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t207so7918032qke.2;
        Sun, 10 Apr 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUcJJmfd/iKH5QzT7MteJYXqisZV9mqEGEpy1uMnjR0=;
        b=kVQ+O2fXRoRP9P2JAJlKbts4usvZAKbC9A/O3T5gjHXO/6JpiRb1h6qayogHtW44If
         5A60r1kq+s2pR1DXMjn9fwnkCH3cMvWDGNzBN2WwPXst0mmrtXYDpKWhSiffGFRExtBh
         crVPvHdRpe03KeA5XzXanuzw+rTqw1YzTcUZ0k0vqJjrIhFqxACEG7FMYiV3PtfJRH9s
         JmZ/ufHEPlBxMPfmw5/hWVuvHEMjNLCpZ3zoZjuxJcz0rlykdPVOF5+xWhOZrCFS8kZl
         RwbaAn3c8hSQJnW6JLVKBWiYJB0XMtaG8sPfZpm/plaMlqpSOISur5JbpX6qMBEkAZ/S
         mjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUcJJmfd/iKH5QzT7MteJYXqisZV9mqEGEpy1uMnjR0=;
        b=pRfMZl/wMBf1truKftRB16q22sNyeI2onu+bFAL/7iu327DOrNKADexH4rG5xkOk30
         wzMePaPAPh/qYh8uNjoufeDmL7EHD6sA24ky4Csc4N68wMCELnon9EUuToYRz7B72Aj+
         VUtet/g0EtArox3ogaY7/OpyDCyZ2RC8UGGKSXA+DDSjucEz2fH7I77DkOYbri5VpTNx
         ZaOMebgxMU+0uCTAmV89r+8bHshxey0839KXZXEtzuq9O2S3EVQfdsVxe/VCZWyjcU/O
         DX9qMi6/FUHLwHEaQs28KY8MqQR9hGmMBcbLQFHT33zewr73B7JoPewzgGE7bTxj8sud
         d5gA==
X-Gm-Message-State: AOAM530W48jZifWNIQ9qqW0TrtIreD2H0kbzV+Q7JRWs0w093CkAhtHY
        2rzegD5zlYMjso19uB+aYn/aou20rIOo
X-Google-Smtp-Source: ABdhPJzRNctQz8OrVtRyXjs9kyzfCMG4ZVnB90KI8d5kihZ/gf4srvIUDKa1LRx43exU0vdDusibeA==
X-Received: by 2002:a37:9b52:0:b0:69a:e26:61aa with SMTP id d79-20020a379b52000000b0069a0e2661aamr11509149qke.159.1649628400671;
        Sun, 10 Apr 2022 15:06:40 -0700 (PDT)
Received: from arch.. ([2607:fb90:966:1288:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm22688416qtg.0.2022.04.10.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:06:40 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH 1/4] input: uapi: Add trigger_left and trigger_right to ff_rumble_effect struct
Date:   Sun, 10 Apr 2022 17:06:33 -0500
Message-Id: <20220410220633.5235-1-dbdaniel42@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 variables to the control the trigger motors into the struct that
gets passed in from userspace.

ff_rumble_effect is part of a union in ff_effect. This does not grow the
total size of the union so should be ABI compatible.

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
---
 include/uapi/linux/input.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index ee3127461ee0..d187e00d91a1 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -415,6 +415,8 @@ struct ff_periodic_effect {
  * struct ff_rumble_effect - defines parameters of a periodic force-feedback effect
  * @strong_magnitude: magnitude of the heavy motor
  * @weak_magnitude: magnitude of the light one
+ * @trigger_left: magnitude of the motor behind the left trigger
+ * @trigger_right: magnitude of the motor behind the right trigger
  *
  * Some rumble pads have two motors of different weight. Strong_magnitude
  * represents the magnitude of the vibration generated by the heavy one.
@@ -422,6 +424,8 @@ struct ff_periodic_effect {
 struct ff_rumble_effect {
 	__u16 strong_magnitude;
 	__u16 weak_magnitude;
+	__u16 trigger_left;
+	__u16 trigger_right;
 };
 
 /**
-- 
2.35.1

