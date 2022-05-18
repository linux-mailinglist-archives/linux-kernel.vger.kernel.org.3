Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0052B631
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiERJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiERJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:20:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA7C1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:20:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f4so2474432lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=GKJLCH2lJWrU2y3uKn5XDixssi7wgR5jkODsM9EB1WA=;
        b=Odo5DWfp+MrJB0QFt2qllzGHNv+mP66gEbUZQ66kHh5rk1i71AFZprQh5DiyMyEscm
         pFfRHga1dvqYdzCepLnwOxoSJ12effeuj7jvpjiH16q1JM18dr06wrP/vZDM6waqFwwz
         sMQodP7FgEFh7ky6GFzZNoVUPW2ZYS2o2vIxqO+0sSJNhpn6g5c0fH9T5rMsrRp8Lxfc
         4WAEZnkSk96nUh4BaONd+4sRiBl32YXL0Br+kbZYg1kcN9ZtV1h+cPDnUnscrCrGQKnr
         leEYbtO5ZjSOCdzy07iiEvtCYHu++k65ink7pxYTEq7Z7hwJuBa1SHQ6+V800jTv6uPF
         zXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=GKJLCH2lJWrU2y3uKn5XDixssi7wgR5jkODsM9EB1WA=;
        b=rkV9zIRnZM7c4I+fcXsRmicOALZbQx1cnX/Q3U6b9663XoGFY/j+OGQr6bFwYMeYvt
         ShhaYvTcjxQH3U87J3U43AdcCuibbkGH8RIxn8XDdUVbzvmmo1B0XbIRCpxGcgHuFpj6
         uMjNrInRuAys8EMD8KdUSPK8o9CMpVTmubxZfaAAgUmZA8iNspfji/bX3Q0Gj3lgPgNQ
         KEUmtP5Z6EkwAjo5xdfM9J6aq4FqS/3naEqKj24RDJbK1iHb1JuY1SBe7gIDsBm/jkMQ
         G2/HkwZQxH8qH+mn4s4KoMP9aSIfTqS+0kd30eVc9ZZDPnlcSYWbTibUHtS8QKANZUAM
         xgpw==
X-Gm-Message-State: AOAM531anI6VVX6VRJrCHCmNVmGG7oHKMQZVJQ7FSLgbzsQziqMCGq9d
        ci0BNsPmzR+AGYUxBbrBqnGafVhadTKn+A==
X-Google-Smtp-Source: ABdhPJx2wFEOdKyym5d0YXSY1LH/uqQ/mNNRcYU8PMfA6Lp/xFIGrjVNUyXaYv+0lRMynIMXDQYp9g==
X-Received: by 2002:a05:6512:22d4:b0:477:be45:3667 with SMTP id g20-20020a05651222d400b00477be453667mr427543lfu.659.1652865649229;
        Wed, 18 May 2022 02:20:49 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id b19-20020ac25633000000b00477b086308dsm153328lff.27.2022.05.18.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 02:20:48 -0700 (PDT)
Message-ID: <7de7721b-d090-6400-9a74-30ecb696761b@openvz.org>
Date:   Wed, 18 May 2022 12:20:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] io_uring: fix sparce warnings about __kernel_rwf_t casts
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, io-uring@vger.kernel.org
References: <YoHu+HvaDcIpC7gI@infradead.org>
Content-Language: en-US
In-Reply-To: <YoHu+HvaDcIpC7gI@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse generates follwong warnings:
fs/io_uring.c: note: in included file (through include/trace/perf.h,
include/trace/define_trace.h, include/trace/events/io_uring.h):
./include/trace/events/io_uring.h:488:1: sparse:
 warning: incorrect type in assignment (different base types)
    expected unsigned int [usertype] op_flags
    got restricted __kernel_rwf_t const [usertype] rw_flags
fs/io_uring.c:3164:23: sparse:
 warning: incorrect type in assignment (different base types)
    expected unsigned int [usertype] flags
    got restricted __kernel_rwf_t
fs/io_uring.c:3769:48: sparse:
 warning: incorrect type in argument 2 (different base types)
    expected restricted __kernel_rwf_t [usertype] flags
    got unsigned int [usertype] flags

__kernel_rwf_t type is bitwise and requires __force attribute for casts.

To fix the warnings, the patch changes the type of fields in the
corresponding structures: poll32_events and rw_flags are neighbours
in the same union.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: updated according to comments by Christoph Hellwig
---
 fs/io_uring.c                   | 2 +-
 include/trace/events/io_uring.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 91de361ea9ab..e2a40c58654c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -585,7 +585,7 @@ struct io_rw {
 	struct kiocb			kiocb;
 	u64				addr;
 	u32				len;
-	u32				flags;
+	rwf_t				flags;
 };
 
 struct io_connect {
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index cddf5b6fbeb4..34839f30caee 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -520,7 +520,7 @@ TRACE_EVENT(io_uring_req_failed,
 		__entry->off		= sqe->off;
 		__entry->addr		= sqe->addr;
 		__entry->len		= sqe->len;
-		__entry->op_flags	= sqe->rw_flags;
+		__entry->op_flags	= sqe->poll32_events;
 		__entry->buf_index	= sqe->buf_index;
 		__entry->personality	= sqe->personality;
 		__entry->file_index	= sqe->file_index;
-- 
2.31.1

