Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F2466210
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357186AbhLBLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357179AbhLBLLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:11:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4DC06174A;
        Thu,  2 Dec 2021 03:08:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so2034314wme.0;
        Thu, 02 Dec 2021 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqeD85cqFGozfFIm5oZsrFAr294CbtLB+VwPu7f+M50=;
        b=YMnCj38jZ28aPCdVto1jRlTwQXsxbtVBe9GOJS6gob+gfE7PiDYXck7MRTtJ5mZu7F
         iQozi7L+MLoTiVYCGXXYnnlVHqQY30o8gOY0gs0GYUnXEVYQB2VJ+6GF6TqYCLARJUa9
         h2cWxImLTfuTQI61MvaXC9XZuR0KSmmm1dRYmIXMP0C/Mmt88JoANpLfeCN/oxgccExu
         o2UzOzsj6nI5yhg8Djon8JjSZZPAKmQomYaGow0iC3hv8o3kk3YvufgcIRHhzJoWSmcA
         c76eUxHBCKDgUxMvh/XURn/B0eLfEPWXoK/mCWboEXM3z4cetlvkwfcUs0fwMiy/brJi
         KRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqeD85cqFGozfFIm5oZsrFAr294CbtLB+VwPu7f+M50=;
        b=JiOc4WCCKuV8IkBuQv9EvPC9lzLeX+h3vFa35+jQbSaS3NvNcDeyk92f9S+O0/Bq4O
         63uRHmRYKmGEqU22KQdq/eihF4TzsPPeOHJbNM8lAwrBtpEBEfnGW0sGlgRfs0PdAxwI
         +dNvKO8qSAr/1dQ9rxvrX+bPMlGUUqhltGeInDrhS32zsv5VzQcAUh6T7xKQT1+FwG87
         A4NLfVgnhDOLJfpZrq3xPkMCuHVJXCUio2ZrVAZ05ILRjUdSSNkj9iiXXkDi+M1gT5UE
         A2juY6bLTqEF88VVdLW3pqrD1icoCAHVQChn4BKupWtcBLecc6+ciKebgR8fU1/o8/gl
         5YvA==
X-Gm-Message-State: AOAM532qVfgnNtPvS8G8gUPfYbVl4R4CwlSIFuiSzE3LfF49hpwVAc5F
        +jqSpk1eGY9E7N0MgRIb8RQ=
X-Google-Smtp-Source: ABdhPJwdGodF0K3JKvGj/yCG/6klDw7RfhSXCQ1coGK6dBOx01Kjuf298JHFCEztQpHWCphiOiWtHw==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr5398943wmo.136.1638443295925;
        Thu, 02 Dec 2021 03:08:15 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id o5sm2163495wrx.83.2021.12.02.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:08:15 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, peter.hutterer@who-t.net,
        roderick.colenbrander@sony.com, dmitry.torokhov@gmail.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/2] Input: add input_set_property()
Date:   Thu,  2 Dec 2021 12:08:06 +0100
Message-Id: <20211202110807.6783-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202110807.6783-1-jose.exposito89@gmail.com>
References: <20211202110807.6783-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buttonpads are expected to map the INPUT_PROP_BUTTONPAD property bit
and the BTN_LEFT key bit.

As explained in the specification, where a device has a button type
value of 0 (click-pad) or 1 (pressure-pad) there should not be
discrete buttons:
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

However, some drivers map the BTN_RIGHT and/or BTN_MIDDLE key bits even
though the device is a buttonpad and therefore does not have those
buttons.

This behavior has forced userspace applications like libinput to
implement different workarounds and quirks to detect buttonpads and
offer to the user the right set of features and configuration options.
For more information:
https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726

In order to avoid this issue add a helper function for drivers to add
device properties and make sure that the conditions associated with the
INPUT_PROP_BUTTONPAD property are meet.

Notice that this change will not affect udev because it does not check
for buttons. See systemd/src/udev/udev-builtin-input_id.c.

List of known affected hardware:

 - Chuwi AeroBook Plus
 - Chuwi Gemibook
 - Framework Laptop
 - GPD Win Max
 - Huawei MateBook 2020
 - Prestigio Smartbook 141 C2
 - Purism Librem 14v1
 - StarLite Mk II   - AMI firmware
 - StarLite Mk II   - Coreboot firmware
 - StarLite Mk III  - AMI firmware
 - StarLite Mk III  - Coreboot firmware
 - StarLabTop Mk IV - AMI firmware
 - StarLabTop Mk IV - Coreboot firmware
 - StarBook Mk V

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/input/input.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/input.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ccaeb2426385..f7e23b3b6ae5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2125,6 +2125,41 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
 }
 EXPORT_SYMBOL(input_set_capability);
 
+/**
+ * input_set_property - add a property to the device
+ * @dev: device to add the property to
+ * @property: type of the property (INPUT_PROP_POINTER, INPUT_PROP_DIRECT...)
+ *
+ * In addition to setting up corresponding bit in dev->propbit the function
+ * might add or remove related capabilities.
+ */
+void input_set_property(struct input_dev *dev, unsigned int property)
+{
+	switch (property) {
+	case INPUT_PROP_POINTER:
+	case INPUT_PROP_DIRECT:
+	case INPUT_PROP_SEMI_MT:
+	case INPUT_PROP_TOPBUTTONPAD:
+	case INPUT_PROP_POINTING_STICK:
+	case INPUT_PROP_ACCELEROMETER:
+		break;
+
+	case INPUT_PROP_BUTTONPAD:
+		input_set_capability(dev, EV_KEY, BTN_LEFT);
+		__clear_bit(BTN_RIGHT, dev->keybit);
+		__clear_bit(BTN_MIDDLE, dev->keybit);
+		break;
+
+	default:
+		pr_err("%s: unknown property %u\n", __func__, property);
+		dump_stack();
+		return;
+	}
+
+	__set_bit(property, dev->propbit);
+}
+EXPORT_SYMBOL(input_set_property);
+
 static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
 {
 	int mt_slots;
diff --git a/include/linux/input.h b/include/linux/input.h
index 0354b298d874..5f357687da42 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -456,6 +456,7 @@ static inline void input_mt_sync(struct input_dev *dev)
 }
 
 void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int code);
+void input_set_property(struct input_dev *dev, unsigned int property);
 
 /**
  * input_set_events_per_packet - tell handlers about the driver event rate
-- 
2.25.1

