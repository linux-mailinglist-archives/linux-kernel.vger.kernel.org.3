Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F84EC86D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348350AbiC3Pke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348311AbiC3PkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:40:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97808338B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so174756pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeiakI6ZdfDqy26wAEKtPtiKSfYNO4Hqsr8Ua8hMV6s=;
        b=nrS6qOjHi3EhirqIG6pDj0g4N09YKZLwksyGxAsNeS5zL69Y2hwg/RfRuCxzrUtxYl
         v7jQN4L85S48zZt4kac2+icIhFRUUxt7mMBo1eL+aynzkPZtu/RdgQkVfX6e1FT5rbk0
         qbCzDVoGSMEsX2SgJ0bM2JCSlsPYBypGz/DZLvhCFT6uOPlbNB1yIi8S//burANkm550
         iP1jWXu0vst/oHtGxCzZUjgDpC0OOlqglIlFR3wWARtJQ1KSAVOpYTv1tK2TNUOx3kvI
         xQuzHjcx3IdHCGQJ4FJ2eBVgrthM2ZABheWSIccFndfxGfNeE+1uV2UiV3xa1hSIA56t
         bGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeiakI6ZdfDqy26wAEKtPtiKSfYNO4Hqsr8Ua8hMV6s=;
        b=M/HAQN5Ivr7JNgGGwvu80dZ8Pi6NsPnIpQxhen1M/yqOc7sweAo/KPm5ilYVvzmk+b
         9YnE22mrKhkOfNwMDYwchUux5Rj1oJomrlNME5q4KZGzQyitaOWB9/8WKybXfWK+gPfw
         IFARXuyE8wPM1x0406czXzWYgE37E9CVqK8hTS75vI0wKqtFEdOWCysZyqiIlW9n7LRa
         t26+9EZX4mpXtmPndqNGBlyzNKCorZ/7NvxknWLno35l8eqyMxTSPFG4uL0m3fWy3HdF
         kkxT1BVLyoZfTbsQ/xtuJ85ulDvh1RzUwFGo4s7tP4/mDvEpOlth6vidUKlVUdIRw75Z
         P+6w==
X-Gm-Message-State: AOAM533SZZuJgeu4iWnjoTsj8I3O17OVRyZ9TTcF/k2x2mAw49P/Y7ln
        2V27mw0wnhdf+vPUjklaZFqZEw==
X-Google-Smtp-Source: ABdhPJxYsUVAVVFAUKw0isQyNo9pKj3eD+47hgdFaTL8oWHpFu17OySjpRL49cBEu4QmAaAEKUAozQ==
X-Received: by 2002:a17:90b:504:b0:1c7:3095:fd78 with SMTP id r4-20020a17090b050400b001c73095fd78mr6449pjz.142.1648654717088;
        Wed, 30 Mar 2022 08:38:37 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm6686039pjp.9.2022.03.30.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:38:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 3/4] sysctl: allow to set extra1 to SYSCTL_ONE
Date:   Wed, 30 Mar 2022 23:37:44 +0800
Message-Id: <20220330153745.20465-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220330153745.20465-1-songmuchun@bytedance.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
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

