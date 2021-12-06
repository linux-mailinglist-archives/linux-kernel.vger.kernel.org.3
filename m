Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192F746A3E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhLFSYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346733AbhLFSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638814848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPFBVLd1MOqofeDRgWXlKm3vhAT8CZYo8WcwT7OAfdE=;
        b=bYet4wm01mfN12cDHXMksH6U174LqM8jrG9grigOJdQr4awbIlsA9RDPTysJuDxOdEUjI5
        AlTbBaDd8/6HvAV9L1E2988/HK/3C8IZiKJ6LYyY/pztfyfOM13FwyjaxoRNottZUozKQy
        hl+ODzAbNiLL5mq1uw9DKF/zsbbIIDI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-atYudtBmMLGoB1gB1A5v2w-1; Mon, 06 Dec 2021 13:20:47 -0500
X-MC-Unique: atYudtBmMLGoB1gB1A5v2w-1
Received: by mail-ed1-f70.google.com with SMTP id v1-20020aa7cd41000000b003e80973378aso9053348edw.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPFBVLd1MOqofeDRgWXlKm3vhAT8CZYo8WcwT7OAfdE=;
        b=ZZHIYIYIDq6IT3prRS5FGp/bknQ2LFxB6qX9p4x78f5cbLTzCCfV2uhxhk4vjyVbCD
         9py0eGolg47Xa0MNtVK8vauCwLK7Rt4w3gh5fXhA1u/q4Wr68QguWEhDMnnTXRuOI5vx
         NW4MtFe7aG52wTYAftlgrIqQs+uT2w3NW5AG5kFkhMLC0BbCmlK5twC6lFmKuMng4QSm
         pBEZ0D6u/IBAqixPK6whVvRrV4RhS2zyRxJ7cjdQm0+U0G0f8kCWq2p4/DKwC1swvrAQ
         k6cOmXBK0vSbE6sGd3MIpHAHrI4KlKZN8CiqhPVgF8TVuHtufFguyV7v8ih5hQnQvbVl
         Yoww==
X-Gm-Message-State: AOAM530Q3tqDHf7GhleR0v2IOlP7uyjOel1BkWgHBHmxvqgfuBEgekcU
        SC6ixu1rYGp3tA79PoUWBqNIDKtZwaJKB4iDsphADm1/3/fcXBZSKMEtAJUoTSFjZNkT7xOUNa1
        2CcCNBdtQEE5qEREw93V0yoU6
X-Received: by 2002:a05:6402:51d2:: with SMTP id r18mr1031615edd.13.1638814846186;
        Mon, 06 Dec 2021 10:20:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDOryBEIvVZJTEI+9Q7vUYuZ9ebbj0SXbi/Nf9pRZAXPY8XsoPkFDGtCkLPA582Hp+JYtgvw==
X-Received: by 2002:a05:6402:51d2:: with SMTP id r18mr1031604edd.13.1638814846055;
        Mon, 06 Dec 2021 10:20:46 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hv13sm7588896ejc.75.2021.12.06.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:20:45 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/3] ftrace: Add cleanup to unregister_ftrace_direct_multi
Date:   Mon,  6 Dec 2021 19:20:31 +0100
Message-Id: <20211206182032.87248-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206182032.87248-1-jolsa@kernel.org>
References: <20211206182032.87248-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ops cleanup to unregister_ftrace_direct_multi,
so it can be reused in another register call.

Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7f0594e28226..be5f6b32a012 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5542,6 +5542,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	err = unregister_ftrace_function(ops);
 	remove_direct_functions_hash(hash, addr);
 	mutex_unlock(&direct_mutex);
+
+	/* cleanup for possible another register call */
+	ops->func = NULL;
+	ops->trampoline = 0;
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
-- 
2.33.1

