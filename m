Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC44871E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiAGEuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAGEuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:50:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:50:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u20so4205727pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 20:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7M0agZO+lyLM0cmi/dQO8IIauT68RhHPtTp/wUvdeTU=;
        b=K660Fchd15Re0IJ+t4+CH0h7J7DRmSSof5IbwMBUHh2SlgTw8JjsWecBDlTx7b0Kcn
         mwoR1sIedy4PQ3MF5AeaWuLnHPmU74EV9JbFg4TvaGja9zUWcH/8G0Ypifk8CHEpFuQb
         rTILS0empLicmO8PGBB36iOip/Gcxaibx72/icI5aSb8mTErFo/HLEaUTtam9BphiM/R
         Bs3At1XKhwTs7sAV3hsWgHFX5ZrbSzIZ2fjysSUxDTegAJslFcNVqQrhTPsOUo3LQYDH
         vh5n3bDnMZCZYqkbjO74W08pGcitfuxqpZ8pdXq7a0OuJP8CQBcfoZT2FRhewkDxGA2q
         HRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7M0agZO+lyLM0cmi/dQO8IIauT68RhHPtTp/wUvdeTU=;
        b=hyXsck6wWAAsR2+aBdugbQAJpPbSqedO8Jy+SHe9a8ZlsZfJZMgEymKxpmwwaMC0TM
         KmWD/hTtgjUCbLuOxcnIrXBAvPshvT4ktH5YTU0hlfsQjaSkpv4xikCzd2iWCQzdocXU
         xma17VgkshTmfzgCedI7VVrUHPbcpkh0Uk8ANPR2u0Ds6kBgEMt+j3UMDRuPNak18jLP
         nzkdW2/w8rb/5b0tQi9t9ic0jU9SSNdf/01SMoD05I9jSDm225/rZEau8z06JqiTdqMd
         M/EX6yHhsAoZHoMgGf838cwP6uzcnUfr44rB+ADSGCQ0QULvU5lXNlalZxEt849i5nSv
         jJHg==
X-Gm-Message-State: AOAM5309ttOwEREySrchg77aadLBX7wjVrF3IPO+itkICjtOLkNuSaB5
        EKdJgJ4sxZY/kTPikB8b57KRHiLnHg==
X-Google-Smtp-Source: ABdhPJx1F9vKClAdLMFO0ymrn2NFanwDIsA0jT5iAV6LUHI5o18CSdTJM5nW0oh/P9pRNYGsBfB0VQ==
X-Received: by 2002:aa7:9155:0:b0:4bb:e7b7:73c3 with SMTP id 21-20020aa79155000000b004bbe7b773c3mr50892471pfi.62.1641531006108;
        Thu, 06 Jan 2022 20:50:06 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lp6sm8456115pjb.55.2022.01.06.20.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:50:05 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] tracing/filter: degrade addr in filter_pred_string() from double pointer to pointer
Date:   Fri,  7 Jan 2022 12:49:49 +0800
Message-Id: <20220107044951.22080-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107044951.22080-1-kernelfans@gmail.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since FILTER_PTR_STRING has the type of "char *", it is meaningless to
convert it to "char **". Hence degrading addr from double pointer to
single.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
---
 kernel/trace/trace_events_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c9124038b140..264456e1698f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -670,11 +670,11 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 /* Filter predicate for char * pointers */
 static int filter_pred_pchar(struct filter_pred *pred, void *event)
 {
-	char **addr = (char **)(event + pred->offset);
+	char *addr = (char *)(event + pred->offset);
 	int cmp, match;
-	int len = strlen(*addr) + 1;	/* including tailing '\0' */
+	int len = strlen(addr) + 1;	/* including tailing '\0' */
 
-	cmp = pred->regex.match(*addr, &pred->regex, len);
+	cmp = pred->regex.match(addr, &pred->regex, len);
 
 	match = cmp ^ pred->not;
 
-- 
2.31.1

