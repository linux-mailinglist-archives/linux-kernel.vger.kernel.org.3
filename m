Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFAA4A7254
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiBBNyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344679AbiBBNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643810049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqIBYhSED2KiLRiPVvQEcn95LWAaRUgov7svs5RNRz4=;
        b=Hu0l9O7ZHMS+sNZB3UsrrjPCVNpGtHd0VKhxdOYKbyv5Yi0f73V0nmPsetPrx/CKtNmhcT
        eLIQZxTFSuOO+wbdWs0VimFQQpVUg1i0Ly1oP0QjGN1qXiBX+vfe9Myj0UmItWbB+2BkLO
        jGnp8Bq7TIgi28atfiSpcmkuaiLDZ70=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-cXZrbyTHOoqgUg9rjesszw-1; Wed, 02 Feb 2022 08:54:09 -0500
X-MC-Unique: cXZrbyTHOoqgUg9rjesszw-1
Received: by mail-ej1-f72.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso8177906ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqIBYhSED2KiLRiPVvQEcn95LWAaRUgov7svs5RNRz4=;
        b=6nxIvAUtK1uK9E/O6BrtxZTk18p9KNeYNOrzHC2iTHcjebnAc+J97Z7qBet5TYbAoK
         Aq5OboQQjIxuKOzLwcXY2s5m84+ayhDJR4aAi6fys2t5B3oOBTxPYqbAKOthxAFtiIUK
         7KMSGloXoBKE1p4JYIblpkm2x+T3Medzyayk/HSOXoY6J4GwXdN3qbNmvPGyALCsviFA
         R5W/5cFxrSaal02GUqOIXXZ/XrvePFrBFFHXw5sgP51bv/7OdMnbHxxZRpXqK9ECYZQP
         TwkGYgmpRoJMG8PP5CKs+ft84xb0iOPm6/5ZaPfd8fveyerGsvGZk6Dml5spazNVwtoJ
         iuXw==
X-Gm-Message-State: AOAM532r6dBuQa4TovI/jQxLrngiOJV0BQcKACpnktLLILO4uclGAymC
        hkkKfKiLQGQhaf6RwHvM12nqWKmG6MU4pAXzzZ5V4Gzv2ZabCIL+1UZKIFc6lHAS8tlmZo4wsB9
        zjhuK8EEti0RrFRr1tX4boC7l
X-Received: by 2002:a05:6402:509:: with SMTP id m9mr29640223edv.237.1643810046235;
        Wed, 02 Feb 2022 05:54:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcUwK13/nY2kcApXDzGsFhV/cZCeMZ9htyubnhs5SDp70e98r81NKwfnOABmoL6EkvsLeXhg==
X-Received: by 2002:a05:6402:509:: with SMTP id m9mr29640200edv.237.1643810046059;
        Wed, 02 Feb 2022 05:54:06 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s7sm15703501ejo.212.2022.02.02.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:54:05 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 5/8] libbpf: Add bpf_link_create support for multi kprobes
Date:   Wed,  2 Feb 2022 14:53:30 +0100
Message-Id: <20220202135333.190761-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202135333.190761-1-jolsa@kernel.org>
References: <20220202135333.190761-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new kprobe struct in bpf_link_create_opts object
to pass multi kprobe data to link_create attr API.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c | 7 +++++++
 tools/lib/bpf/bpf.h | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 418b259166f8..98156709a96c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -853,6 +853,13 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, perf_event))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FPROBE:
+		attr.link_create.fprobe.syms = OPTS_GET(opts, fprobe.syms, 0);
+		attr.link_create.fprobe.addrs = OPTS_GET(opts, fprobe.addrs, 0);
+		attr.link_create.fprobe.cnt = OPTS_GET(opts, fprobe.cnt, 0);
+		attr.link_create.fprobe.flags = OPTS_GET(opts, fprobe.flags, 0);
+		attr.link_create.fprobe.bpf_cookies = OPTS_GET(opts, fprobe.bpf_cookies, 0);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c2e8327010f9..114e828ae027 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -413,10 +413,17 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 bpf_cookie;
 		} perf_event;
+		struct {
+			__u64 syms;
+			__u64 addrs;
+			__u32 cnt;
+			__u32 flags;
+			__u64 bpf_cookies;
+		} fprobe;
 	};
 	size_t :0;
 };
-#define bpf_link_create_opts__last_field perf_event
+#define bpf_link_create_opts__last_field fprobe.bpf_cookies
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
-- 
2.34.1

