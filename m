Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDA572E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiGMGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:32:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546EECEBA8;
        Tue, 12 Jul 2022 23:32:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso1997419pjk.3;
        Tue, 12 Jul 2022 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zkUBfNycAFx70zEJPDO/9NKNPncrE72YacmrSo4Jgw=;
        b=UKC+J8G8yu9r8W+qpsU7hNAjsxUbVX8NxJSSzgMt4U8KgEqizdczylZQxv/kaGZV2p
         /yreHf1a9sZ/UrlCQc/7X+l6Td8w3NqJDVajiSw17Tg30PQ/c4WxTXIe2kVBILRW4YQ8
         MBKD5N9hBqLzwzqPnhywx/u5qAQWxYU9ZT1k1RaGrj6f1EC6JxeMQr7+GU/hrhkNg89T
         vvZxlBXoWREW/deZzKSYeOd7vxc26tEVv1LhNLZehT1LigKK8ui10FuPFyexl9r68Ngr
         ZS2vyS1sLIT+GXcbXITn9ZNYrd0J2kQW04RAum/S0wXLYARElTu7eLmYL49B75mO6Dag
         XEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zkUBfNycAFx70zEJPDO/9NKNPncrE72YacmrSo4Jgw=;
        b=5aD+r/N2wrnKJvu5NKqKv/BvEHQ1xkK1g5KXaz/bQ07aa16OEmRXnLJrZLjaK5JZi2
         UCLSrfwRRfMb7bkgkX2XkWsdKV9pWxzWKawkzSd9Ev8PJntRMoqW5Rh8fZc0rjGZbawh
         YSCZFEY+S20fn2rspwsB/HFztx74/ndrNd+QdVu3rm4NtA1KYBBV0TdPppPAbUPYBc9q
         5BW+NOOP29BVOaduDKIvR75o0whZUL6YggEC2d7a5/gIiUZGa+3jKsWh+iq5ATAfKqc9
         Y9owkP2CRsvPxHuZqR3wEaxly4Nx9wA0iR9YhDCbvtkCLnVf+wNEWhNDBIQhGBZsNeWg
         JyCw==
X-Gm-Message-State: AJIora+kvaSq39qfWQ2TyGPzzBUZ/GDrcBfrXVGoecPMZ4itqkH9uBU7
        Y48/uaHgpqq9I+sEpI4XXEE=
X-Google-Smtp-Source: AGRyM1v4G+Y7besLuV09AjVRXjFIYJB36foqvmWuinIu+oCK/z5yvqSmN38tj8e75Sq7n7e3cHgMDg==
X-Received: by 2002:a17:90b:3502:b0:1f0:986:e36b with SMTP id ls2-20020a17090b350200b001f00986e36bmr8693841pjb.154.1657693952861;
        Tue, 12 Jul 2022 23:32:32 -0700 (PDT)
Received: from fedora.. ([103.159.189.141])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79590000000b005289cade5b0sm7901023pfj.124.2022.07.12.23.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:32:32 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        khalid.masum.92@gmail.com, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Subject: [RFC PATCH 1/1] net: kcm: Use sk_psock size for kcm_psock_cache
Date:   Wed, 13 Jul 2022 12:32:04 +0600
Message-Id: <20220713063204.6294-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713063204.6294-1-khalid.masum.92@gmail.com>
References: <20220713063204.6294-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct sock` has a member `sk_user_data`, which got its memory allocated
in `kcm_attach` by `kcm_psock_cache` with the size of `kcm_psock`. Which
is not enough when the member is used as `sk_psock` causing out of bound
read.

Use `sk_psock` size to allocate memory instead for `sk_user_data`.

Reported-by: syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 71899e5a5a11..688bee56f90c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/syscalls.h>
 #include <linux/sched/signal.h>
+#include <linux/skmsg.h>
 
 #include <net/kcm.h>
 #include <net/netns/generic.h>
@@ -2041,7 +2042,7 @@ static int __init kcm_init(void)
 		goto fail;
 
 	kcm_psockp = kmem_cache_create("kcm_psock_cache",
-				       sizeof(struct kcm_psock), 0,
+				       sizeof(struct sk_psock), 0,
 					SLAB_HWCACHE_ALIGN, NULL);
 	if (!kcm_psockp)
 		goto fail;
-- 
2.36.1

