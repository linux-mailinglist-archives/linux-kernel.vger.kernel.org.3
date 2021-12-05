Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548C6468E15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhLEXYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241162AbhLEXYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638746446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1OLtGzFBiLKQcxst9CuRPOTi8U+Of3w0FVoqKzvIME=;
        b=Pbrzkidb7I4HBF+5DdMsYTgHBMgYVMGfeBn55wp3dlkkuATyTanWXbet0VKmaMkPvJ6++g
        HlTiU8pTHkW1LNAdQVIpHbFLTr0XQsv6FMMVZa4tdk03EfMomSK5kq4+KDizdkL8Yse2WM
        P61Mg+VegTifupCqKJSFBuXq0wVA+6c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-233-SpMe6te5NdSslxub6ocLtw-1; Sun, 05 Dec 2021 18:20:45 -0500
X-MC-Unique: SpMe6te5NdSslxub6ocLtw-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso6717428eds.21
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1OLtGzFBiLKQcxst9CuRPOTi8U+Of3w0FVoqKzvIME=;
        b=dQJwccStbQmny6KzeViVWKsl5JaNr2UuumPLPENqXn4nr2FJjv680+llcRCiHL8QSV
         SMHZITXumrWvm9bbh3nTzNi9e6f7Kao3NHHKUGY0DRQsSxt9F7MqmnVNrnA/6ZR3qZHO
         1l+m1BUyjyPM45OE4M/p/dAkr9igGeUaknU2TEIUq8l8NjfJ6iBFANEZTbhbYjuRDNr0
         V8MQ7bUOSWOPfwdc3MiyRH3KFQf+tOKruxZiJEpjx6Q6eUKv/7jM8LZiImJqMATMctW/
         gKhtGmmsEIawOHeanVthUqWOV5KcvVp154HEAwyIUNCs16bl2TIC79T2/sYdF1LTCkxI
         +5mw==
X-Gm-Message-State: AOAM531BiIM1JpHkNAkQB1NMkVFSt85jW4mrvBUxKKTk6JhYE5nWyufI
        eIZged3LDGD4FjN5DXHslZJvyA72wcJBEsXNcxp1h49dFpO46/rLpsApKHg3YBJeXNyPLXOrFdk
        rg4NGddGq5MHZuH8El49hO06J
X-Received: by 2002:a50:eb85:: with SMTP id y5mr49953457edr.173.1638746444165;
        Sun, 05 Dec 2021 15:20:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDzyJ2IfcpLqNcEPKoDVx2NxC9rXN3Dsyl54XvJop4er9kX/R27a4SjddSxSt3Bt49UqGF9g==
X-Received: by 2002:a50:eb85:: with SMTP id y5mr49953441edr.173.1638746444052;
        Sun, 05 Dec 2021 15:20:44 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id jg36sm5769715ejc.44.2021.12.05.15.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:20:43 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/3] ftrace: Use direct_ops hash in unregister_ftrace_direct
Date:   Mon,  6 Dec 2021 00:20:34 +0100
Message-Id: <20211205232036.51996-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211205232036.51996-1-jolsa@kernel.org>
References: <20211205232036.51996-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when we have *direct_multi interface the direct_functions
hash is no longer owned just by direct_ops. It's also used by
any other ftrace_ops passed to *direct_multi interface.

Thus to find out that we are unregistering the last function
from direct_ops, we need to check directly direct_ops's hash.

Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..7f0594e28226 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5217,6 +5217,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
+	struct ftrace_hash *hash;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
@@ -5225,7 +5226,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	if (direct_functions->count == 1)
+	hash = direct_ops.func_hash->filter_hash;
+	if (hash->count == 1)
 		unregister_ftrace_function(&direct_ops);
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-- 
2.33.1

