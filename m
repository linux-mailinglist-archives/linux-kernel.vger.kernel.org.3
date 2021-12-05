Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EED468E16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhLEXYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241113AbhLEXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638746452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPFBVLd1MOqofeDRgWXlKm3vhAT8CZYo8WcwT7OAfdE=;
        b=CZQHZ3Lie8QGrpeUJNQu0wTzbXVrtkPE+SR4HbHi3I8F5LT6TPRFK3gAxlPocbPNL88EDa
        9PsiFdafZAkiR2vEyb8cq2hAAzD3h8crU3Zl4BC4CG8GTU3Y+tT8OrRCKyDVuy/loqf0S0
        cVupjDRiwVv0LOKcFIAfoS3pfDnJylc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-V4t0NF5yOEqXOv8x1_QzkA-1; Sun, 05 Dec 2021 18:20:51 -0500
X-MC-Unique: V4t0NF5yOEqXOv8x1_QzkA-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a05640234c500b003f1b9ab06d2so6810956edc.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPFBVLd1MOqofeDRgWXlKm3vhAT8CZYo8WcwT7OAfdE=;
        b=A84UGYokDIDlb0ewa/TzS4tGCSIt8cga7QkU9KVTELUq5wAFwX/NZrociXzUF9kSOL
         fxew4Xe3OV0WWx0xDxkspqZLRxOj3IneW723V8jPYhEAP8AzJakjRg+MRpXAq1DN9ZiC
         UTj6IcvzwgunAu+zhI4qCmvXjVR0mCXsrVRg0wRvPmH9goNy2wA5PZ4O3Y/+aWUr8iG+
         hPX5TvpY632U+udPyBGu3DQ9GAIQDIAaFrqRpO4sBbH/Zgc6R8RN6uD+wzB+x/Hy6lLx
         4EVGwTSfx3xuI0H3Mb9VDFM9vtzTxUUDrhx3pciaceVsFWaMNyIl74MK4nk5xMSlTr0O
         w2CQ==
X-Gm-Message-State: AOAM531BVbE25EqIQIuib9vDmIGiMO2zpu0hdJlozd+hy5kAiprWBsnH
        4ee6EkOUwT9Ud0cY/KWpTKnOQW7Gr/kqn32rgt+ilEQdYNkeR/hE1Snd9G+cp1L3Lcg+uUaDA1p
        AS1P1idf94uZQdfHz0XDL/0gP
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr48236473edc.393.1638746450110;
        Sun, 05 Dec 2021 15:20:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKYezZgx30TXWG/gKVP0Z5DwcdX9HMgfA/lBpQ7UrW8axbnrZUzd0N2momUUSCmsBXrXIy9Q==
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr48236454edc.393.1638746449944;
        Sun, 05 Dec 2021 15:20:49 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id i8sm7362450edc.12.2021.12.05.15.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:20:49 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/3] ftrace: Add cleanup to unregister_ftrace_direct_multi
Date:   Mon,  6 Dec 2021 00:20:35 +0100
Message-Id: <20211205232036.51996-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211205232036.51996-1-jolsa@kernel.org>
References: <20211205232036.51996-1-jolsa@kernel.org>
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

