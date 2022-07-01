Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB3562E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGAInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiGAInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:43:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5426338B1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:43:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q18so1723982pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmYj1R8fqef6hjY0ZIaJ4EVhhQeQQM7IVJe6YNZh+2A=;
        b=dyhcLzqYNaEyrVk9WoBaNJlmfFqbm2dxaEqOjNhdpZ2drRmo8wYb+YMHBImK35/6j7
         Ki0kApLNgdgsHERLs7B6WvV9ku/UgIco4c5+aEFGRONnjKUUGG7/ZnKqyvyGxUhqZzbD
         2iIQQjuAFgsbKMwTVo8EIW4s6JqiNi7RhdGM9zqHQmFWVd4gaa9cXuEtLmtmEeEP6BeZ
         z4pteM/oGUpp/WVfTj51GncvyBQwjcVBFJkfMf7fk5Mpbpxz0XCHl01L6+jLPm9/fUr3
         YKsCOw5hrr1b34Qo+FKNkenxLZW0e7eBAakdobbkwaSHRwcsbHb6jQRUtnB+kcNVLnz0
         56JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmYj1R8fqef6hjY0ZIaJ4EVhhQeQQM7IVJe6YNZh+2A=;
        b=pZkkAw4wZiL0GiCaWV6NB1wzHvwjFmPQKTB2p6ol16URejsxiv4Pum2tWoBdL/gb/J
         DmVsP5Z7tkWFKY9g3RVtmktF2fZlJp40D9P+KjlOKnpVd0E8U59rAtlyccy2JEUtNNOo
         FCUjNPptm6vx4yT+3P5+e0kBiIU4GahB5VuPzmRT3Thk1HTrm60rygDASsO/pMp3gXAe
         j18sBaSRcFZ1cJh5I8SGmzzTP9wMmIQjtU6ttCnqeewX5FCRgbJIvB4d3WUMkrjpuWBQ
         bl0CsR57cetFMwgxcaFNbTCWegrugN/7YPdk8cCpkAc1+Xvguc8+Cngc/ZjpuJrk1/Yj
         Qn/w==
X-Gm-Message-State: AJIora8sdjkNddm6F226MHBM1ZvvP+c9Oszgb/la1xwqDvpuZFwjv/Cz
        fiH3/8ZWTtXBLRWYZdkVPEw=
X-Google-Smtp-Source: AGRyM1tFDhFw9jJ0Wulabf8bI84CTnlYH7+zHREuqIN1zsCQV9cqBwxoYJHWM4kxOo0qQWOr+RqoJQ==
X-Received: by 2002:a17:902:ea47:b0:16b:a612:208d with SMTP id r7-20020a170902ea4700b0016ba612208dmr10944437plg.96.1656665009253;
        Fri, 01 Jul 2022 01:43:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902dcca00b0015e8da1f9e8sm14710158pll.77.2022.07.01.01.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:43:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, minchan@kernel.org, oleksandr@redhat.com,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH linux-next] mm/madvise: allow KSM hints for process_madvise
Date:   Fri,  1 Jul 2022 08:43:23 +0000
Message-Id: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The benefits of doing this are obvious because using madvise in user code
is the only current way to enable KSM, which is inconvenient for those
compiled app without marking MERGEABLE wanting to enable KSM.

Since we already have the syscall of process_madvise(), then reusing the
interface to allow external KSM hints is more acceptable [1].

Although this patch was released by Oleksandr Natalenko, but it was
unfortunately terminated without any conclusions because there was debate
on whether it should use signal_pending() to check the target task besides
the task of current() when calling unmerge_ksm_pages of other task [2].

I think it's unneeded to check the target task. For example, when we set
the klob /sys/kernel/mm/ksm/run from 1 to 2,
unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
all other target tasks either.

I hope this patch can get attention again.

[1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
[2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 851fa4e134bc..df915531ad9f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1173,6 +1173,10 @@ process_madvise_behavior_valid(int behavior)
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_WILLNEED:
+#ifdef CONFIG_KSM
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+#endif
 		return true;
 	default:
 		return false;
-- 
2.25.1

