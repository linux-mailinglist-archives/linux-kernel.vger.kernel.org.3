Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1F4883EA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiAHOIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229667AbiAHOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641650883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PocnGmnCbMvgl/mM4UqClsCjrZwW9G0adKzchgFrwe0=;
        b=iLB5RW9dFvOyNLjleJPnR8RNYyAvHOI3RR6RvFQwIESAbnY/GyV3U822N1QYRlkze7Yk8g
        UIzi4low+y6hLGKd/E4bcNjKndrHCCZEecL/loon5v6x/pZiTkuHRq6yCLB4TZ1O08v2pr
        1VEOjfimHjDRdE/OHTlT3z2hN8Ol0FI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-QfPMwBi9NfS7_VlScco9hQ-1; Sat, 08 Jan 2022 09:08:02 -0500
X-MC-Unique: QfPMwBi9NfS7_VlScco9hQ-1
Received: by mail-oo1-f72.google.com with SMTP id q6-20020a4a3306000000b002daad7a3be2so5937405ooq.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 06:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PocnGmnCbMvgl/mM4UqClsCjrZwW9G0adKzchgFrwe0=;
        b=pC4Hrz+YNdsWtgCtSIIFLFGl5xx7U5BqT4ZjfLSsT4aRe1c2wCbb9d4aUan3umuSq/
         fxkbwEuu3GXlv/uGAs37N1E7zheIAqKin9YZFryUuDjI85ifOf9HVRswByFCmjwG9A6t
         f59edG39AoxjJJV8Nx1B6rU2A0qLzmUies4E50LRddqczCXHnoGl7125k1Yg2kjnjjl8
         L4ajxNuh2FQhgfsegMJt/8oIqHXiv+MML9IYwpAQSV1EynHsrh8z14K6Gto2oJfwL94Y
         /u/+In75Wrm0KtHOK7MOx+YZ6WxPQoHTwoPFtYe95k2IOpvqQVKwQGj25eeDNr6JsCvW
         ZYyA==
X-Gm-Message-State: AOAM530EH8kE3v1gSne1Qj0txZdwvA4K7xEnWzxOYhzOFFX3YY99tfBK
        I/EETk/jb2OctEIFjC57G2jtMKE4XZZbJP+H1e9A3EUGTObX+WiszpD5MdJ79jNvW9Xfwyg7PyV
        iYJ8x08HS1WD4RwRQVj6P5ffF
X-Received: by 2002:a4a:da59:: with SMTP id f25mr43483445oou.46.1641650881926;
        Sat, 08 Jan 2022 06:08:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLFcO/UPfE7QdAafOO6wi0ODe4Q/vmKo+QUX+NZH/NVBUk5VTc2tOqw3QSi/spK+bC/u82nA==
X-Received: by 2002:a4a:da59:: with SMTP id f25mr43483434oou.46.1641650881740;
        Sat, 08 Jan 2022 06:08:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i27sm348535ots.49.2022.01.08.06.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 06:08:01 -0800 (PST)
From:   trix@redhat.com
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: hda: cs35l41: fix double free in cs35l41_hda_probe()
Date:   Sat,  8 Jan 2022 06:07:56 -0800
Message-Id: <20220108140756.3985487-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
cs35l41_hda.c:501:2: warning: Attempt to free released memory
        kfree(acpi_hw_cfg);
        ^~~~~~~~~~~~~~~~~~

This second free happens in the function's error handler which
is normally ok but acpi_hw_cfg is freed in the non error case
when it is still possible to have an error.

Consolidate the frees.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/hda/cs35l41_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index aa5bb6977792c..265ace98965f5 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -476,7 +476,6 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	ret = cs35l41_hda_apply_properties(cs35l41, acpi_hw_cfg);
 	if (ret)
 		goto err;
-	kfree(acpi_hw_cfg);
 
 	if (cs35l41->reg_seq->probe) {
 		ret = regmap_register_patch(cs35l41->regmap, cs35l41->reg_seq->probe,
@@ -495,13 +494,14 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	dev_info(cs35l41->dev, "Cirrus Logic CS35L41 (%x), Revision: %02X\n", regid, reg_revid);
 
-	return 0;
-
 err:
 	kfree(acpi_hw_cfg);
-	if (!cs35l41->vspk_always_on)
-		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
-	gpiod_put(cs35l41->reset_gpio);
+
+	if (unlikely(ret)) {
+		if (!cs35l41->vspk_always_on)
+			gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+		gpiod_put(cs35l41->reset_gpio);
+	}
 
 	return ret;
 }
-- 
2.26.3

