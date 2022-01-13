Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4090348CF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiAMATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiAMATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:19:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A620C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:19:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m13so8234467pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF5Ls1sb2CQFBzCSyRPSIJo9fSFz4AHOfm9dcoWo+2w=;
        b=Y8QfIbVMxvQCli4PhtNf8FyU8P2Aqw2HvMkBVSCl793tLHboIj34ZAwRq3/MPgD2pN
         Cnxce3voqzB9a3CcaYm/SXgFMoLz36VTkl3rS+B8AHDRg8zNyQgnO0US+397ypNsXakU
         lmVVp0ChTcN90kjw6Fwd5Ix+Ts/ZV5Mf9CueM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF5Ls1sb2CQFBzCSyRPSIJo9fSFz4AHOfm9dcoWo+2w=;
        b=UojYlGX9m6ZzvfPw429NiiOa25Sjj3lrhfY+tN1Ak3poMSzCre4mBaM5SJ7LoT3/yc
         tH7UlQqaow0PxBfX9DxN+YEeO98eymfKXiPhxBkVil7GWspnOASh8WVWYzs/KrQQjoCD
         X7WxpRF5pz64j4caTZ1Pdj42c6UX6dR8qgom/5iHshx1CSo/lDAkWpPY4u/9xqHKjhzG
         gLlKaOG8UFoYAzAY5Q04YkMQWIw4Vivj5LGvf5J8Jo5+KTqva+CX8NR63Qbz+ED029a5
         N/hrnT5axO5eJLcxM95iNnWEAz2XT6hpN74x8NelIhvZSG4VVZGdmhZ87ah79f8N0BpS
         bkaA==
X-Gm-Message-State: AOAM531nhLthHUqQDfDRQAMmNYlnr8dsSathOl0bMPBuO9Or0IvsLvjG
        4L6o5ZaSenngd46yMjBlKgAJ4L51ih5MBQ==
X-Google-Smtp-Source: ABdhPJxWnv7wDFAep/GW/Z2BsgCkrmxrhSUJ5DHHikLX9c78w3OsDcW6/OOKZu0NLgo79uivCJ9twg==
X-Received: by 2002:a05:6a00:1acb:b0:4bd:bb9:4649 with SMTP id f11-20020a056a001acb00b004bd0bb94649mr1850426pfv.46.1642033177966;
        Wed, 12 Jan 2022 16:19:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id qe14sm735042pjb.44.2022.01.12.16.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:19:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Martin Kaiser <martin@kaiser.cx>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Check for NULL header value
Date:   Wed, 12 Jan 2022 16:19:34 -0800
Message-Id: <20220113001934.3455851-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; h=from:subject; bh=Zmi3fjZGyAfVSBSf4uQJo3gwV1oUVCB/Nh5e/ReE5wQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh33AW3Ti5Xn/EzwreXPTWXeWCbp/shR/gDd2CsI0Z po8mz1aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd9wFgAKCRCJcvTf3G3AJrU0EA CrVQSc4PKaFcWdOWEpq1bcppiQd5uGg2C2qAFzAA/V6N8fA9Mi6N+iWt0+ICa/G85xDAFzuedbeqnS vyklSZyiwfH67R2Tw1sisD4Oj2RM1LNHHxYIrU6HC4ISJvEeXHGY/7nkB46WXhVqWRA/e7u+yGqDJ2 1a85/PNExS927iGtQPSPRq10zI88tE1vcEdjC9/y02KAhAiPZXu8+xJpP27ijzMhiBnbGnQXnVuHni vlfgvrF4+VWv+L+T/4+Tlg3GnmGrNANNfoQ94eHHUgFUsPF9ozMfhVIbevX4tcnyk4QSh4yK0zzHag O/ClMOaE5YMSKK3PDzlmvkscIJsw/gE0lJ9KQQAIRPbGUtYeRpTdKh0YUUsoDR5A8FSo+ptcbfudyp Y5xMwqXa5YKuIXB/53yjs1juwC+vzihFJHso3AXGoziHV6pH5VY5Jyh1KG5mzsDFF5FUBO4hK667B7 oILw2V9R6ewLQdXaTMsXd4DXgJQgeWisb5JCbJt3P+XG5pQeJEY23aUu4Q0gQevhrf3Q8FyTzH6vG8 8HRgh+iDUoikzPB2LupyB6KDjhGPNAAZ/ajQJkYBWe+mjFyqDi8QPQGDQjBWV029Hc6Ra7Q5SKq6Xi phuT8hPTm2gTwJjV/LR+b0OF0Un4eH0vtnfoOf+My1yXg1zrKSR0zdPSUikQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Warray-bounds, the following warning is emitted:

In file included from ./include/linux/string.h:253,
                 from ./arch/x86/include/asm/page_32.h:22,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/sched/signal.h:5,
                 from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
                 from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
In function 'memcpy',
    inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
   41 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^

This is because the compiler sees it is possible for "ptr" to be a NULL
value, and concludes that it has zero size and attempts to copy to it
would overflow. Instead, detect the NULL return and error out early.

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..93b0aa5688e3 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1191,6 +1191,9 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 	u8	*ptr = get_recvframe_data(precvframe); /*  point to frame_ctrl field */
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 
+	if (!ptr)
+		return _FAIL;
+
 	if (pattrib->encrypt)
 		recvframe_pull_tail(precvframe, pattrib->icv_len);
 
-- 
2.30.2

