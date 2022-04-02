Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536474F00A8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354345AbiDBKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354335AbiDBKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:31:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C360044
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:29:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so10653984ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=PnCyQzWYZfowMMLFepox8LSupe9oBT98ViN0jGp1KPeRVTKS0lQJ105RNbRGBHkfBC
         vYriAZJRL5Ms2YxlyHTO7sojUiIEdFCbecRX4uj2dhveN4QNkey/NDXw1OuCMC2p8+63
         IR82ikIuH2bcGnV8wm2Wp6hEBk8axhNbTzZBOGBHCe3JgUVIUO3x0tx0NtPO9+kDDcKD
         rpAd4N3tLRqClad+W9n4EmKaJ9re+mfksTQ4fUna7TWeabvPH0z8/c2q83hgz3mKfNzO
         PMX38a/y7YDAoDDakCB5yw3Maumkpp2MVeRgqW/hE/RWoCr9yYaUutEc6AMP/IEjaBTv
         8aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LastlIlp3ExuBmWFIzRxFtrilFT5BPcN0d/npk5blEA=;
        b=K4DXXJfyoW+J5NTzK17/74V5nB2OvwqMR4PL2zTsuLzSTVzQ6hDOmY+4y1BRbX+i+a
         hdpCMwHJ5x9XVAIImHTSFAcCBAASkOIGA5dG6Xp3CT9kAypldfAETkIjBlNSqRerrXWg
         wTvvR9zy8cz6OSDiNj0NKTxX0hGL9/58YrXAlzzmdtsLRU6Eizga9r0Fcokd4rtlZcZR
         7BBfQXDPNYcW959JUDhzRGc7vFaQP0wVBTynupCSmAS1ehgOINaul1n5iMuThMQaoGjC
         MRJ+HcDyzmhgnNlBztjSv7GvNDOxGwm8UpHwyJQNDLdcGu8R73A6lcMz72wePJuCWAiR
         yhKg==
X-Gm-Message-State: AOAM532mkQBrhVdYbluByO+ik0ND4UQweKxSI6cnHP5J0YpvsbwB2vxR
        jd6wAH1GZE11tYgM0LO082Q=
X-Google-Smtp-Source: ABdhPJzE+ftupkONrdbBMv0aFZ6kBjc3RScrgJGYwat9UGVhM/XZ05LCG5dOy+D5qcEvi8fUvfqH5w==
X-Received: by 2002:a17:907:6089:b0:6db:a3d7:3fa9 with SMTP id ht9-20020a170907608900b006dba3d73fa9mr3428769ejc.593.1648895374047;
        Sat, 02 Apr 2022 03:29:34 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm1952187ejc.171.2022.04.02.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:29:33 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 1/4] tracing: Remove usage of list iterator after the loop body
Date:   Sat,  2 Apr 2022 12:28:45 +0200
Message-Id: <20220402102848.1759172-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402102848.1759172-1-jakobkoschel@gmail.com>
References: <20220402102848.1759172-1-jakobkoschel@gmail.com>
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

