Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9924EE3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbiCaV74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiCaV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:59:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA4242235
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:58:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id p15so2048190ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnKWR36qXN9DPKW78CAJffMBb1k2kT9rbH8v1Mt42bo=;
        b=L/xJXN/RhDZBW63j0nY789Dsf2UOZlqvxpAB1rQGvoQA/GqLDoAY0DhI3ZBKQiOotL
         XNeESpX4Qs0dj1uVvuobCtU9cQJHY4PDNS5j0ByL/atlKvlZgwlbpFRFwoaNEft/zEpL
         NxaU8ObrHcM2lQ6waRhXe4rW7MKQs4fEAWluACSW2zjZTMUOQKIgKgFXxdoMru2CqPgJ
         Owhb/XZXqYnp8cRlO19wRN5Pc4vnSPTQGw+UhyG2uCXv4LfxOxirMcCSHFt+opO1ucuS
         MtjgxDkdvYCIHx2feJ06dL5NEcdt3RXNY57PNNzzVI2qmqruFg6Za4r9iprkhjLnguSb
         3pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnKWR36qXN9DPKW78CAJffMBb1k2kT9rbH8v1Mt42bo=;
        b=hAnqowrtdX0eFxNEvlkBRzuNj6Q55ByYlJcHUGKqRY9G4dIBd/m2MxCitG3bFYQWLe
         zSDeoboLgZ1egRlCTsldiLL4uMTk1RB0EiL+EiEOKt1z6/pRW9WOGyWgEWg677GhEimm
         fyz9sdrY493sCBa8zZOAXIMZGutuGtXDSpxjX/fo/TnYCP7BLRuwiBPiQa3sTSHihbx9
         qxtco2Qn0jYVYzIEDegSklMlHXfnJI32/oGOcFRd6fOmuAzGoH/TA24w4MjWFJmgGg6s
         G5lKBNi1LrdWtTfpV1i+ABS8e+mrRC9yHvI8ZAJZQRcwse41RuAJpA12LDoyaSAHKEgp
         Uizw==
X-Gm-Message-State: AOAM532vZwKJC3ueSU12C2i0adcbYqAXLdtpuDfzaChTua2ZZ+gQ7Vtl
        SGLibfm40dbnJ/YUBUDJhxk=
X-Google-Smtp-Source: ABdhPJxdWKfmberRVzeq0deUU2sbCsLrtXf2QTvX91wCX0YIE3clMY9PAFVGN7Z+BXyR4yvT8tlFMQ==
X-Received: by 2002:a17:906:d789:b0:6e0:bdd5:a884 with SMTP id pj9-20020a170906d78900b006e0bdd5a884mr6561407ejb.201.1648763882802;
        Thu, 31 Mar 2022 14:58:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id do8-20020a170906c10800b006dfe680dbfcsm254109ejc.43.2022.03.31.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:58:02 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] clockevents: use dedicated list iterator variable
Date:   Thu, 31 Mar 2022 23:57:07 +0200
Message-Id: <20220331215707.883957-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/time/clockevents.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..5d85014d59b5 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -690,7 +690,7 @@ static ssize_t unbind_device_store(struct device *dev,
 {
 	char name[CS_NAME_LEN];
 	ssize_t ret = sysfs_get_uname(buf, name, count);
-	struct clock_event_device *ce;
+	struct clock_event_device *ce = NULL, *iter;
 
 	if (ret < 0)
 		return ret;
@@ -698,9 +698,10 @@ static ssize_t unbind_device_store(struct device *dev,
 	ret = -ENODEV;
 	mutex_lock(&clockevents_mutex);
 	raw_spin_lock_irq(&clockevents_lock);
-	list_for_each_entry(ce, &clockevent_devices, list) {
-		if (!strcmp(ce->name, name)) {
-			ret = __clockevents_try_unbind(ce, dev->id);
+	list_for_each_entry(iter, &clockevent_devices, list) {
+		if (!strcmp(iter->name, name)) {
+			ret = __clockevents_try_unbind(iter, dev->id);
+			ce = iter;
 			break;
 		}
 	}

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

