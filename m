Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20546A3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbhLFSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343987AbhLFSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638814842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1OLtGzFBiLKQcxst9CuRPOTi8U+Of3w0FVoqKzvIME=;
        b=aF8mbp4WGQ/5XSr4O4mQUSHu4VOKZVLoTtmGa4fZgf1Z5m7Xwj6qQ0YYAC49uEflFkh+ll
        qyg8zgiipueW7LVP/io4o653T8MNQKoLFOeloqAS77K5PBDwUxho2krH5URCcHbVXxm6yr
        dU6njm3EPK33jZ2pZXn6VX1fElJGQ2A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-mYo-Sr5KNeqz0mGyvbd94Q-1; Mon, 06 Dec 2021 13:20:41 -0500
X-MC-Unique: mYo-Sr5KNeqz0mGyvbd94Q-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so9107131edx.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1OLtGzFBiLKQcxst9CuRPOTi8U+Of3w0FVoqKzvIME=;
        b=ZbRjDvJcalu8P/Gh0g6LbvefVLygP7l5KWSWBnqSxAjo0VuxlLafAGcyy/jWR9AWKe
         tEHCzCt4RiDW4xfAv3wLqAafwqoNrfT7uj2zpFh8QJrWuzk3Y0Em0MQGfeyOtOAx/TjY
         JRTl4mDRdfB9RXPXnKm+/xKBeKUPldDR77J1aNoNvwLQU+O14euSs7SNa6a8xLlzvVp8
         lOK7Cd57QhkHIQu8R5wGfKOcz73mzo5Jrq2ezPsxHSKA3iaMIMWoy/rkuf5GXoBuQdWY
         KvV756Fiy7ABbKJHY3AUJtMlSZMgdQt75sfw9TcQpmXTc+fqVrbtM/4UKSWl9P29V/py
         EH9A==
X-Gm-Message-State: AOAM530Cq9mQfjAhCMfs7h6RAaVziqUk0vNLgXMAxxBa44Qr4nXWMuUh
        2TkytQ5Q5VoD6trVvqhUtJrXBEad2saJJGEU3GU4+mPot9vGJO+uvWLcr2WYW/RTvBnlcGqRpun
        xl0cUeCT5tZuz2Lwid7PONuss
X-Received: by 2002:a17:906:9f20:: with SMTP id fy32mr48664873ejc.459.1638814840451;
        Mon, 06 Dec 2021 10:20:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQArv6Y/2ENkwxU8Xx9tbjrWi+nA/g9DRJHDPm40LntugSQf9A0xzqscx8YzkFDPrjK1yBIg==
X-Received: by 2002:a17:906:9f20:: with SMTP id fy32mr48664846ejc.459.1638814840279;
        Mon, 06 Dec 2021 10:20:40 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hd15sm7481740ejc.69.2021.12.06.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:20:39 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/3] ftrace: Use direct_ops hash in unregister_ftrace_direct
Date:   Mon,  6 Dec 2021 19:20:30 +0100
Message-Id: <20211206182032.87248-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206182032.87248-1-jolsa@kernel.org>
References: <20211206182032.87248-1-jolsa@kernel.org>
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

