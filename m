Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FA555B523
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiF0CLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0CLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:11:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233F2739
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:11:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so14169147lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=l3AbRcb3euHIPSR9NMXHx/86nFq6XgvCj4Y708407TI=;
        b=o0XCv7KUDJSIdcVmSBhxbsYa0J3ql98Deo9ytYEOPzqH2Urm67Hxxy/ZP677pKTbHk
         82l3qp7hq5PQ1I8LcLBh8+vZ8vDsJC8q8JLAe2NBc20Uthc2x6PcfJhlWyV3DxTcVnmc
         64k1BjpS8AJUbQwqwUyYI4fxkEHSVynTciRK8xJPzQ9VdIK39/QBsTdVys7zbzA2LK0f
         CQYF2r0f7qDjBNvbsmCDdcsSZ6WoBh/wO7A1IpCtgz0kABXJ7sDvre6cV8caASu1Vt0+
         gq0Q7T8+9emWYjCddt6d4CynBSRyRqh4ANhQwOux3JrZy6nwA02R6X568g4eF/B/sT6E
         igtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=l3AbRcb3euHIPSR9NMXHx/86nFq6XgvCj4Y708407TI=;
        b=lKbxwobLFjkTmLkMebi7Uh1Tmi4GCCa4D0PNvog8aji2hEpTXE8B+7Kj965Aj4MQQ9
         shT5AXzycEv/SGY/dU12ScSyWjvCIjnPlrcGe524yh0srG9qcCOQqIZSP1hvhNWeY8E/
         BXluR7PH0NMZbaongr8xtMZK5ZuPMS7N9oU0IXIHJcG765iNYy85YBJdee6bhZ7aMnUC
         U/7tPXWc6O7+owYi4q9h6jyewJlW6xJvtJxMUGz5EaoSRYvqyikAzejz+FBRTK3zfmOt
         JEhymGJ7BNygZtAiEUfKvfq+DPgBLnPT/hEppgGDBAJXIKeLjDu0X+iUS9eAJWM6b4Qx
         1VSg==
X-Gm-Message-State: AJIora8xJmnD97jNiFYs5GtvI0v79fJ2T4v5HSeBier3nmOvzk+AuJ5A
        TAAUKh/VKF3YDCbXnBs4wOfLFQ==
X-Google-Smtp-Source: AGRyM1v9nBS6jCJNXDIPdAYita7qHptEOH1qpFE5bnUpUQqu2nx+/5JbrrP+vSYZMUNeoHwykzIRVA==
X-Received: by 2002:a05:6512:2289:b0:481:1d4f:ac9d with SMTP id f9-20020a056512228900b004811d4fac9dmr875001lfu.510.1656295888261;
        Sun, 26 Jun 2022 19:11:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b002556cf330e8sm1193297ljd.99.2022.06.26.19.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 19:11:27 -0700 (PDT)
Message-ID: <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
Date:   Mon, 27 Jun 2022 05:11:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2] memcg: notify about global mem_cgroup_id space
 depletion
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <Yre8tNUY8vBrO0yl@castle>
Content-Language: en-US
In-Reply-To: <Yre8tNUY8vBrO0yl@castle>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the host owner is not informed about the exhaustion of the
global mem_cgroup_id space. When this happens, systemd cannot start a
new service and receives a unique -ENOSPC error code.
However, this can happen inside this container, persist in the log file
of the local container, and may not be noticed by the host owner if he
did not try to start any new services.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: Roman Gushchin pointed that idr_alloc() should return unique -ENOSPC
    if no free IDs could be found, but can also return -ENOMEM.
    Therefore error code check was added before message output and
    patch descriprion was adopted.
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4c606a06bcd..ffc6b5d6b95e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5317,6 +5317,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
+		if (error == -ENOSPC)
+			pr_notice_ratelimited("mem_cgroup_id space is exhausted\n");
 		goto fail;
 	}
 
-- 
2.36.1

