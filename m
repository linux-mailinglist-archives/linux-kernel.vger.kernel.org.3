Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D7511E19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiD0RLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiD0RL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:11:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B742F025
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e23so2684566eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=XGeqeNiNAy40QSZ1b7uWemHlUQTomh9n3vBdeswdMk7F8xK4atJkgASs1nBCeHPNUw
         fj8iTanx9ugZj3bYgk9vhDkdFmimSA+Ox7ft2lXxcRs+ZGc6c0mtGiVK+h5ScWc4FIY5
         dcamIDhMHE9pUJuSp7BpDQb5m60O/BlhLQmfTbkelRK5zVEBRPCjm+Wq5dTt5OvXVPqz
         rU377ZbRobZ4ExSpPpmcGzgcgUopsAyKmjb008X3fCmsVe6wcZxGAWpGezC2timZ9pYk
         HV4vab1JohblVN5dOIrPkK27Ke2oaCN1EGfDPuqjX4vXYZ+obHM/vIWrub8sDA6UzfVr
         3EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=A8wPJbMUWuzQl07Wqs+1bYFnP2GJ7syrJO/v1nwpWEUuDzU3cdYNPwGz0HmZ/H0WB3
         wlisU83pCUt4NaHYMziJdNzefwAl4dBZgGgRkatKNkm8/kolRw4Daq3Fu/REkWSpSGBt
         gAt/oh7PdO3Gy1SRiOIkwNFC2/4mo2ybSGOlokJEgfhSCynx6te+U7+O9Z/xNIF5Uwo0
         K/+WO96VFqhzm5QsAPyGOgFnAGW+/H/cErepgh5+eCXCsCEqKxRZLEp3tZydtrQn2mGm
         E05VgiTvN6oPHJzo+uQKn0VvkFF+9PS3IzqoMPAtnaj6xRX+3Cps9MH8czavJfszsyEc
         viFg==
X-Gm-Message-State: AOAM530mw6wX6KHUNeWZkMx/aznyxwipIm4LisN3fRrQVHZpSqteIUGh
        KWtC7JpicDWmjlMwLtYjWrM=
X-Google-Smtp-Source: ABdhPJzbDvXSVt1I6isfFiI2lRhSnT2RNiPt1AIt3VBoM7ZshYzYxkvkz9hQYZKyHEWVwRqOHI6sbQ==
X-Received: by 2002:a05:6402:1912:b0:423:7fe8:6b2c with SMTP id e18-20020a056402191200b004237fe86b2cmr30777467edz.253.1651079295541;
        Wed, 27 Apr 2022 10:08:15 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm6694359edi.97.2022.04.27.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:08:15 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 1/4] tracing: Remove usage of list iterator after the loop body
Date:   Wed, 27 Apr 2022 19:07:31 +0200
Message-Id: <20220427170734.819891-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427170734.819891-1-jakobkoschel@gmail.com>
References: <20220427170734.819891-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of the list iterator variable to the
traversal loop, use a dedicated pointer to point to the found element
[1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the head needs to be used explicitly if the
variable is NULL.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/trace_output.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 8aa493d25c73..733a4d6c20e2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -692,7 +692,7 @@ static LIST_HEAD(ftrace_event_list);
 
 static int trace_search_list(struct list_head **list)
 {
-	struct trace_event *e;
+	struct trace_event *e = NULL, *iter;
 	int next = __TRACE_LAST_TYPE;
 
 	if (list_empty(&ftrace_event_list)) {
@@ -704,9 +704,11 @@ static int trace_search_list(struct list_head **list)
 	 * We used up all possible max events,
 	 * lets see if somebody freed one.
 	 */
-	list_for_each_entry(e, &ftrace_event_list, list) {
-		if (e->type != next)
+	list_for_each_entry(iter, &ftrace_event_list, list) {
+		if (iter->type != next) {
+			e = iter;
 			break;
+		}
 		next++;
 	}
 
@@ -714,7 +716,10 @@ static int trace_search_list(struct list_head **list)
 	if (next > TRACE_EVENT_TYPE_MAX)
 		return 0;
 
-	*list = &e->list;
+	if (e)
+		*list = &e->list;
+	else
+		*list = &ftrace_event_list;
 	return next;
 }
 
-- 
2.25.1

