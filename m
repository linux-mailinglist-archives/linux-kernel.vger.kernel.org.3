Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E04F00B5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354403AbiDBKf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350473AbiDBKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:35:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77704F9544
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:33:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a17so5632929edm.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=qvysjYio+jn5bNdMLOOFpyAVg/y4GfHySl3OV/+G3ttTph1rUoz8ruHWZPDEYgoqV0
         3Eb91ZKTxqCSW0utwO0bo67gzijYl/Z3o6Zfysn0aACn1yCB4lRn6IT3Q+L/c1u3egRX
         sxlvLumga9zCmaCH12sYSYFcBv51l0Cth48A608/ofNZ3yUigUUi4SIT7hnMxF2LYQ2D
         RDOE+0zYErNwEcNq7gUyabAvA+s4oFbuM/07YvSOjU49v13x0RawxFSLRTf9k0PfZD/G
         W0U+NSQmUhF9x2ky0RqueRQcWVt5hrpLHc8/oStTOFonKXXw9VHmHHl4GQQ1gSks/JUR
         vjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=C6ahXU6J0m8WDudWgcqjzS8IRpbSkL4pMQeAOI31FHMTnnIkeWUwL9p+tItmA7Rll7
         eQBzjuG2Bz0nd2DvKB/MpP8TQzZzw1/VAL92jqZF3ftdw/DvToBBoDJEyt26nW9x5ZFX
         IR9Cdco3pl/QkPbN83azS3bp3EtLtARLJ5ePJ/W1kVh86oJx8ItBgGK33wj0voG/K+a1
         KpW2boJMe46d+w2ABndlGKWTAtBEQ/1d6P37HswJFoK4hxywcgb+44mA7eU2u2i6Dvfa
         pDN4wKUJSX22xP27OD5TlvJ7HGZzLgJv7asdiNm8j4YQFzbr5Ck4n+JcmPM5TMLUs1np
         HacA==
X-Gm-Message-State: AOAM531eBhXXFvT3Ag6DVSkMYdK7YJeWv8Ng6SuQqnG/ouBHAY/v6qs5
        MfECiYEa1iFZ6Qv/2erQOAM=
X-Google-Smtp-Source: ABdhPJyepaDh+72OJQAb//NtMAZ1iAKNbliOLrLT9DCb8OUjvFb4zCCtWijVSnGfPMi4FdhK3FfLWA==
X-Received: by 2002:a05:6402:362:b0:419:2b6d:a662 with SMTP id s2-20020a056402036200b004192b6da662mr24946416edw.54.1648895637045;
        Sat, 02 Apr 2022 03:33:57 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id ka22-20020a170907921600b006e4c1ab0bbdsm1886965ejb.207.2022.04.02.03.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:33:56 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 1/4] tracing: Remove usage of list iterator after the loop body
Date:   Sat,  2 Apr 2022 12:33:38 +0200
Message-Id: <20220402103341.1763932-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402103341.1763932-1-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
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

