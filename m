Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCA56A2F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiGGM5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiGGM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:56:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8C31DF8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:56:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e12so30950255lfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+/ZVPt3U/lu0gkn4JYhnqM2dENcEUukg3rF+ztpMp8=;
        b=aiInV8wkI4Ru4vjyTWbX9ib5eRWxnEEjwhFJbYSIBg3CqX0ravkePdB9v+Onju0LVb
         K+eypJaNYPPgfOHCCII9hz0792sYA4Gu3Zxy6zRnPs/FQco7QEgMsBY4HjhmodJSkPW4
         8h0Oq3lI6b7WbvVYEmUcXV0d5McEZvuHU5ZTWvxZNq4lTlI6iuu7teZtBlU4MrEI9SIm
         ij+p1IFQzpEq4J1SNAo8vpYGish6Yo4NGQFOi0m58CEuyrKCdzCwGACHr0eB382yHqxg
         qaIzhHmWTPrwq+0vIPgLCTFqMoRgG2H5Vuds/yvUU+ZIHXPBYgcgMUwnUZHPqhsPfXSs
         /Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+/ZVPt3U/lu0gkn4JYhnqM2dENcEUukg3rF+ztpMp8=;
        b=kBdQCkiL14QCZ23dEZlHNrbErexFVVKwfhoZq1CC6sayYoJbsvi7h96EciEbVElaXv
         D2IsghsRUeCpLd8K6Ic3M5UGr8zWVPGJur3VGECa9AzFuQas8hftKmDcIEzTqVDuIF/B
         vraKw/YWTSdXwoQz45IzykgD4jTX6y7gpAq+mYggxTNvXtvBTF7Ww4Iasq8Pd8zVN0c0
         X73TfLAS0w9MurCmL22/J/N4pqSYFJgOMg4gl2mPrC/yxu7jfJEnVI74zB8gNNOAXgd9
         pn9Abjs0phvIF6JJ29/nLXSlRQlFXbhQbWReZ3VYWMUkD+mhWFw1ZpgYJm5tnM9x7gOt
         txyA==
X-Gm-Message-State: AJIora96c328WBrR2gzxVpGUbObBtrvhLY358w8RebSQYdM3hF99vCsP
        oBJ6M5pfdR6zswpuMHzkETs/AVCeUaqtmA==
X-Google-Smtp-Source: AGRyM1sQMa/AsCwWa2+anJrNkfAWw1jwy0vKBCC9ftMR04N4rDu7gPvhFPpIUWkxTvpiSPGpcyEIeQ==
X-Received: by 2002:a05:6512:2a91:b0:47f:6e1d:d22c with SMTP id dt17-20020a0565122a9100b0047f6e1dd22cmr31529344lfb.550.1657198581450;
        Thu, 07 Jul 2022 05:56:21 -0700 (PDT)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d2111csm6810361lft.75.2022.07.07.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:56:20 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org
Cc:     jaz@semihalf.com, dmy@semihalf.com, mario.limonciello@amd.com,
        seanjc@google.com, dbehr@google.com, upstream@semihalf.com,
        zide.chen@intel.corp-partner.google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
Date:   Thu,  7 Jul 2022 12:53:23 +0000
Message-Id: <20220707125329.378277-2-jaz@semihalf.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707125329.378277-1-jaz@semihalf.com>
References: <20220707125329.378277-1-jaz@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the LPS0 prepare_late callback is aimed to run as the very
last thing before entering the S2Idle state from LPS0 perspective,
nevertheless between this call and the system actually entering the
S2Idle state there are several places where the suspension process could
be canceled.

In order to notify VMM about guest entering suspend, extend the S2Idle
ops by new notify callback, which will be really invoked as a very last
thing before guest actually enters S2Idle state.

Additionally extend the acpi_s2idle_dev_ops by notify() callback so
any driver can hook into it and allow to implement its own notification.

Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/restore
hooks is not an option since it will not allow to prevent race
conditions:
- VM0 enters s2idle
- host notes about VM0 is in s2idle
- host continues with system suspension but in the meantime VM0 exits
s2idle and sends notification but it is already too late (VM could not
even send notification on time).

Introducing notify() as a very last step before the system enters S2Idle
together with an assumption that the VMM has control over guest
resumption allows preventing mentioned races.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 include/linux/acpi.h      |  1 +
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    |  4 ++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2963229062f8..d5aff194c736 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -520,10 +520,21 @@ void acpi_s2idle_restore_early(void)
 					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
+static void acpi_s2idle_notify(void)
+{
+	struct acpi_s2idle_dev_ops *handler;
+
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
+		if (handler->notify)
+			handler->notify();
+	}
+}
+
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
+	.notify = acpi_s2idle_notify,
 	.wake = acpi_s2idle_wake,
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5bc6d98..b32c4baed99b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1068,6 +1068,7 @@ struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*restore)(void);
+	void (*notify)(void);
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 70f2921e2e70..16ef7f9d9a03 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -191,6 +191,7 @@ struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
+	void (*notify)(void);
 	bool (*wake)(void);
 	void (*restore_early)(void);
 	void (*restore)(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..6ba211b94ed1 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -100,6 +100,10 @@ static void s2idle_enter(void)
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
+
+	if (s2idle_ops && s2idle_ops->notify)
+		s2idle_ops->notify();
+
 	/* Make the current CPU wait so it can enter the idle loop too. */
 	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
-- 
2.37.0.rc0.161.g10f37bed90-goog

