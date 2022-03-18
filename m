Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A814DD7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiCRKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiCRKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C11FAA1E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u17so9003764pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeiakI6ZdfDqy26wAEKtPtiKSfYNO4Hqsr8Ua8hMV6s=;
        b=RDQVX1ZRVvaucfFOAP3mBrB+koiw+26bwZKvIYeeTs9vsVtInLLnzToEhxEYTdN3ut
         ktUd0StaxKeGjBvUjKB7VKrY/VDc3VFbPXOe0TGBIKu5UEG1v0lvtubKLYNMaa75In78
         xcs7Or2qQHTGxd4TttERqtkqxUQlMfb5qHJkMA5Fp9fBFxYUU7uuu55o7C7GwZcjQsRQ
         DLsXM42iBnB84MxvsJvE9jmVZYgtVZiG02+14Twn5UBcdG2qUx6trWh2k2eZKX9PLq/G
         l4iQpMy3PEelpVzA5kUBnDvgDu0Gs0NYhJz+c5WRLndFcTXsyrArxFXPGyHUVfCAlJxg
         yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeiakI6ZdfDqy26wAEKtPtiKSfYNO4Hqsr8Ua8hMV6s=;
        b=KwJ76kReHY00JJkPWB7KHlsUAsMAJKmNHooTn1M2VHQl7W5gr1tU7YGkquf7d4gTrr
         RtnUxevMHrMphCoYgv/eFyOB+QkV2GM1AD7pcJOnyvpcgPW/bE4IYbL+d1kIuTqa9qmD
         w+ekje2bZc1MKcY7JE4umT2NeJ8CYn2HQx/6kS9pN5oJ745EnjB9av1lL7DDwFBFfxQh
         3TfA5+1yReC8YlFArGkiVy8HFYCNPY7NLwz079j1jEi74zVoaKpijSnphUKAcio9uxaQ
         yetvxEZlZZXa6y8+u4qb6RucGiX0D6DimrX4Epdf3HrbC6mOgVMCRnnfPNtSYy5zCeUD
         bROg==
X-Gm-Message-State: AOAM531Vyx8e5q1vTaM/yBmAiHzS+YlfRyU7Icq/2Cy76uHQnVRNJx4N
        9Dc+8iiz2GP1452AxyhbUVbQWg==
X-Google-Smtp-Source: ABdhPJxCCJnh1IXzUQpPAo1+tedl1QUehfYAAocuezbBd0A4UaNgvcR+Z92fhQTN/b1bZhBXA8y/uw==
X-Received: by 2002:a65:418b:0:b0:382:250b:4dda with SMTP id a11-20020a65418b000000b00382250b4ddamr3508780pgq.428.1647598164788;
        Fri, 18 Mar 2022 03:09:24 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004fa042e8216sm9541252pfj.2.2022.03.18.03.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:09:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 3/4] sysctl: allow to set extra1 to SYSCTL_ONE
Date:   Fri, 18 Mar 2022 18:07:19 +0800
Message-Id: <20220318100720.14524-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318100720.14524-1-songmuchun@bytedance.com>
References: <20220318100720.14524-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_do_static_key() does not consider the situation where a sysctl is only
allowed to be enabled and cannot be disabled under certain circumstances
since it set "->extra1" to SYSCTL_ZERO unconditionally.  This patch add the
functionality to set "->extra1" accordingly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 770d5f7c7ae4..1e89c3e428ad 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1638,7 +1638,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
+		.extra1 = table->extra1 == SYSCTL_ONE ? SYSCTL_ONE : SYSCTL_ZERO,
 		.extra2 = SYSCTL_ONE,
 	};
 
-- 
2.11.0

