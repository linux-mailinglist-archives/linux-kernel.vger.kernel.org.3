Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6A536885
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354751AbiE0VaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354795AbiE0V36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:29:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810DAEE10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso5434632pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhXfUexqjilsLMChy39uhcV1ViCwU++I4yhRQJkaZ9M=;
        b=YikbCdocbI5qO1dQMuyOh0SqpeFVValjgg+9sIP0Hnbdx8vcc35LjVNcaDh2t4siHl
         DfPHj4nlYG/aBGyg7e/MI2pHbLioW18FalPCT60WQBERxfymZs9Q3tdHVc3fTR59FxWS
         3Bvpm6l6+dstlEaOlkAU6teMa9GrlMDMa4Sq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhXfUexqjilsLMChy39uhcV1ViCwU++I4yhRQJkaZ9M=;
        b=iGywDlENfGGD1SBaCFZdC7SshEUy5Wy7wFqMYsMLuU231rl2xLvm7b1uPkX6Wujy+d
         K4rnzl6XKDoMns8GjAmvCDVR0dRZcX8wW5SjCtwKNZM1uLfgaryenYO05uSSITM+pUDT
         MbNgWCX1xv3kz4Y2a7p95fKzk8IoYCsWVnH9jZ132/eOvYNrfIJLza6tq7HSrpNzptTt
         jixr7Qg4LUWXzqfUmQPV5dt+orWE/DcRVJwrfW0UxVspQirV4eRWYB3vAem/mvoYrMU8
         Fr4LNvBCTI9ex6J9nVXeVhuf34mi+Rgai2oE/zwwjZOjiyYSEubbhno8cpiSkzCVXQz/
         amQA==
X-Gm-Message-State: AOAM5328VBbvm5yNVQoAMpKxXjPMgs0tAz+qbC+nBR9ahYtxOX3HIdza
        GxT3i6NKTsa21vak3jctZBNXmg==
X-Google-Smtp-Source: ABdhPJz3HqXfRsgeMrWPsWIMJ38E+s2sWT9IeHysdsoRnUT+uAv5B4J6/nBIgj9+oE/8GN+ldRhKNQ==
X-Received: by 2002:a17:90b:1b08:b0:1df:f11a:7d51 with SMTP id nu8-20020a17090b1b0800b001dff11a7d51mr10498457pjb.190.1653686995383;
        Fri, 27 May 2022 14:29:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001637d72b314sm4063638pld.10.2022.05.27.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:29:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Kees Cook <keescook@chromium.org>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] media: amphion: Replace zero-length array with flexible-array member
Date:   Fri, 27 May 2022 14:29:53 -0700
Message-Id: <20220527212953.797574-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; h=from:subject; bh=nqnneLVAuOT5XH2WR1t/JGWDTSepj3ryGFJRhd1e9ok=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBikULQd851CKNz88uKVchNrNuHHm0hg5svRrMslIp5 rredE36JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYpFC0AAKCRCJcvTf3G3AJvCfD/ 0dREGfK+ZOxhiWJMFctrUirIMxBqf1GXmaCp2v/YfkGXFq0EvC/hZvAEIu2uS1Cp8W62lo9Y6XSEtd 4WRBoKXW9rzILaNK8bSgc1AlMWDL5qn4z2JYKpRYyKVRrSXiIbv8urqUh9LZEexktxwPBYzG9eq4s2 +PyUb2wCPF9mkjvgK6fnjhXvxnzl9ImJpnwl8U7Hc9JnzWr7MIcfLoaE5/Ibmz4VIS3wAnar84Yq1g mdj3p1sp0wnyZjfXG7Jsv5pcHr/+c+oXIS9Gg3It8IlQHZhzNiEnk47HrSqWdywHebzH2vHdnqmWLU qSd4Q3hD47GJyqHVsI9pclDV7swsL6g24UQfuzzWS9AWE+quL2xYq5pRMb4NV6j3+iykgzl2XJeZDd 2p7uFzXmVyo8vsKjp6dUv/T5cjMK2He52fD0oEfmLqhYXgXAMvLWYFc23J5vHkCUdAPVfkEv85Bhgk saRqs+wvHitDjYzE51SjJbTns1MEbTb0tEAmtEyuxq7USFZAN612DBxTX6ykQEQBkOrv5PtJsTBDIh 7QtS7aAJlqt3UD8u6YxqIXoCHWr+jIbaZqwp2BbDw3QjiK7xoJ5eLbc/MTpsQ9yZM61QJVhkTd+vfn 5j2J+zhEUxNzXP8muXgSjnTKIbIgNnp40gPs4cv9v81RRq005RM4tmxp8xgQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should no
longer be used[2][3].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
[3] https://github.com/KSPP/linux/issues/78

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: Ming Qian <ming.qian@nxp.com>
Cc: Shijie Qin <shijie.qin@nxp.com>
Cc: Zhou Peng <eagle.zhou@nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/platform/amphion/vpu_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index da62bd718fb8..f72c8a506b22 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -27,7 +27,7 @@ struct print_buf_desc {
 	u32 bytes;
 	u32 read;
 	u32 write;
-	char buffer[0];
+	char buffer[];
 };
 
 static char *vb2_stat_name[] = {
-- 
2.32.0

