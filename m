Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB914CF867
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiCGJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiCGJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:41:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8975D198;
        Mon,  7 Mar 2022 01:40:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so30560394ejd.5;
        Mon, 07 Mar 2022 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=02/z7rGh7wq3Rx0moWAvG5QcxZRbuVyz3BcvKrgSmHQ=;
        b=ZRAJsePtFV1DPUqouisAqP8JZqypceQuD8Ou8X6d3+5Zh7jCb60ZVLaeDc93eDSDlP
         A2GSEGmPcwjuOdo4B25dwdb5j5AOxACih77T0FYWjLBJhgCghoGusRjzspnh+tTq1I1q
         3qs8wA4P5ZrEi1/nG7ShpByombFkAdbdaV28DXlQkAKEIFe4z3RR4zNcevBnofnYhLoS
         dfyHDmyrrnXy6Xa5omBzS8hxY/Xmon6JvC7rggBljTVPkUZMBqJTP0o//quAWm9Obowo
         M0xGZGnKtIpuL5Lc28K7YXxshFJlXl7aiaKwQFnYWDDaR3vjgLF2JedsSPXjl5/h3GiK
         nyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=02/z7rGh7wq3Rx0moWAvG5QcxZRbuVyz3BcvKrgSmHQ=;
        b=lvfaPo7qmJJC20KSNUgSYMJwU6qJFEhLgFxrcaYsiiB1bxGvor7bIi2i6AVyG5mJOf
         84U6xmAxmVZBJ6M/w0/5GTNozE7H7CDqP2EZdCNNpttySD+lce7L6MnFQwbz2hqd9h0E
         5zxyeSNlhuYYSVDdUgBLzgyT9OVKYWlBXTfmGfXGr9RXXm+TP1TqDzxXDX0KzuxYy6wg
         Aw/KWbP+lNJE7lAPymNYmx8mJ+6CtHF7Vot8B2kq3SzoTdk4WogDCW/yS6wyL/kSFbre
         nMrSq9wCgsCPAO0E71hJirBwK/7IxzpZ/STGapEl5w+sW0NRz9Jf8u3iroTRkKN6l1rF
         pfmw==
X-Gm-Message-State: AOAM5310A6xzt9lEZ4QpPBuiNtPyk/kfPyUnoFhMoNeWtTa6iTRZ7P40
        QYTTiHoGt9RJjmjRXp+zZLg=
X-Google-Smtp-Source: ABdhPJx8KrYFuscnBUQ7T29vOwNyOFDlnyThkAvMJB0HvDDE7CInnFmDb3e4RErfrN1RzDZodekIIQ==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr8909924ejc.395.1646646004536;
        Mon, 07 Mar 2022 01:40:04 -0800 (PST)
Received: from felia.fritz.box (200116b826f87d009c8e984acb545ab7.dip.versatel-1u1.de. [2001:16b8:26f8:7d00:9c8e:984a:cb54:5ab7])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b006db31196e2bsm691029ejq.218.2022.03.07.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:40:04 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND 2] taskstats: remove unneeded dead assignment
Date:   Mon,  7 Mar 2022 10:39:42 +0100
Message-Id: <20220307093942.21310-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
  [clang-analyzer-deadcode.DeadStores]
          rc = 0;
          ^

Commit d94a041519f3 ("taskstats: free skb, avoid returns in
send_cpu_listeners") made send_cpu_listeners() not return a value and
hence, the rc variable remained only to be used within the loop where
it is always assigned before read and it does not need any other
initialisation.

So, simply remove this unneeded dead initializing assignment.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
added Nick's Reviewed tag from the first resend:
  https://lore.kernel.org/all/CAKwvOdk68xzVVCCGgdEDj3fSD9nwgh8=7zi6QGa-hhxweRibYQ@mail.gmail.com/

Andrew, please pick this minor non-urgent clean-up patch.

Balbir Singh, mentioned in MAINTAINERS, has not been active lately.

 kernel/taskstats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..7cdf4018a9c5 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
 
 	genlmsg_end(skb, reply);
 
-	rc = 0;
 	down_read(&listeners->sem);
 	list_for_each_entry(s, &listeners->list, list) {
 		skb_next = NULL;
-- 
2.17.1

