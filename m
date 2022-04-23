Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B850C684
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiDWC0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDWC0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:26:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033860FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:23:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so11627159ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=0nar+vOcHE5FjOvmnVFX1nRAr93yV+Z5U7Ssa2/c0kM=;
        b=fCDMzoPFlUUwKBUpqFCKPmXsXcchgvRoyomcnMGy1JQWDzSZQbxfTGSUBP9y6FRLzV
         g2RGe4si8/RwGCkMr1rWvCQ+kbg/P3wTFXuFKlewOLBqQ5Sg5FrY7GjrJi5WQOKkOdhc
         5moD+faJXOwEGXGkimLt5F5MwTwc0wAZNrQ4e5g4ISAFYnD/sZjIemX/HKY9wRoGTzKI
         NCHcQM4Jwq3sPGqN1FAlflE9oNadJfSEPsbw6m159aD8TNWxTp1KCAtLNjsdBmCmSjzA
         0kaC0IC7c5TgTGl33OtG9Yyt6fyCleOybi17vTzLVPi/h9ZLlVRDevI9kM11nHO0g64d
         NiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=0nar+vOcHE5FjOvmnVFX1nRAr93yV+Z5U7Ssa2/c0kM=;
        b=W84BW3Uo48s68qUlZxsPtib3Od/LAmOWau8ZjL++SKV8ikBNs1GAebx7zbubYzMwAa
         tkd41+xWLr3dnrrmR5BcZY0IhZ2dYe6VKnOgmfST/ynWoC0wMBAFReZuF7QlA9bOB3bJ
         fEeZ3F8hbQzwXnjspjcx1mdh4E70aclKlR1v96hyDrdVj3C61h1wpAljlpiq7hxnfONo
         06fZiDcqvjsOjGHwATXnyHDih69usQGpzu+/zDnvJFnzVXk/bHYHvYKAN7VPiuY0xhFD
         RpNhmjXgkMjybxCakDzRHTHI6OUidHwm1Mp3xUZb21nw6QKmDIIH3YGPUERW+W7W+NIz
         FVdw==
X-Gm-Message-State: AOAM530gX9Re4lI0DSPAN7FB273dMc3U94fTAIfbOSPA6pjbjt40308w
        w/LZjHk3GPFlM8+DOGq+rHqXNA==
X-Google-Smtp-Source: ABdhPJy6g5IfXgsz1OQefP4xJEteLD9SCFiUPR64ERxz9I3od9D8457/eLQejjZ17hX3o5zgcWloVw==
X-Received: by 2002:a2e:8190:0:b0:24d:c12b:e55f with SMTP id e16-20020a2e8190000000b0024dc12be55fmr4433879ljg.23.1650680584459;
        Fri, 22 Apr 2022 19:23:04 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f102000000b0046d09d60becsm431918lfh.141.2022.04.22.19.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 19:23:04 -0700 (PDT)
Message-ID: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
Date:   Sat, 23 Apr 2022 05:23:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] mm/memcg: minor cleanup in non-memcg_kmem version of
 mem_cgroup_from_obj()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace leading spaces by tab:
 WARNING: please, no spaces at the start of a line
 #X: FILE: include/linux/memcontrol.h:1480:
 +       return NULL;$

Fixes: commit 8380ce479010 ("mm: fork: fix kernel_stack memcg stats for various stack implementations")
Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a68dce3873fc..294515d06dbe 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1753,7 +1753,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 
 static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
-       return NULL;
+	return NULL;
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
-- 
2.25.1

