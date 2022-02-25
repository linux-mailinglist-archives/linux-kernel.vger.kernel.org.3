Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD94C46F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiBYN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiBYN4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:56:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAD20DB30
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h15so7534724edv.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuLFG9NTpKcLVnRYyUUQhtRmRBUPOcoQBht+YhsQp/g=;
        b=V5BaqrKWmIfKjQDH7LspDEVFF2LgoNQfhbLzPmlr8NgNs3nJBMYAlYsFpdgp2IsUTB
         ASDRmiLH1gQQ1xLkLEkW4UTKkvR8uVoNmtBiDCty9HV/6sJx4PVk6c8sgD3hloAis0Fe
         6vFeWzQn6WsxRi20zYZ6/tesKnA2+/fedGTIuTbRzFhfxGt90s90ZMgYACUkBY0LUv0g
         7AxKw4ayG5DW2tLuh9Vvit95OEjXnQqKdDqlyPortoBFud8zOYqULYzuunEtYC+A42mc
         2mX/AMNC/DCY8dmzNLmSQ0wCrmh23TA5CSTggzMg92dlGnq04aZrHxViF2jFaedt50tg
         MYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KuLFG9NTpKcLVnRYyUUQhtRmRBUPOcoQBht+YhsQp/g=;
        b=lLrJGCpp3KM4axhjnzYirWNKRs0PuPKx4z4zH7UDSvXkyTOXn24QrBguQWCoG50SxF
         3uhTz10eDxR4shu/w+rDdHqgV26o7oc8n9FwaHlMYUcy12rZRnZiraQIVcp9yo97mnuZ
         gA9WfJY0YItlG8KVobEuzYBm1nooFQpat+O2UYCu0H+gwz2qVorfkUS/BOs4OeFmcGXm
         DuOKqAX3GiVuaBlvmEGDZDqxv85367dk1YZhZDG82XkQj1MfgCXlavO/04sy5PHkb+t0
         lDDW5qBmmuRIZvz7mJ2vK52ylr1aGcLm+habdbxTQeTdT00rv8FRRdXQ6PaY4rGNbZtt
         KfyA==
X-Gm-Message-State: AOAM532D+XMLkzW+7thG677107jDQJ1jFXBMGypfWO3uxeu2IV11HOvd
        DZTNr9ZhfSyF8L8qBM0a/D/0rbkkRi3A+Q==
X-Google-Smtp-Source: ABdhPJwdUAy1M2zh9SsylKzurfqnHLAHo3x9ZQEgBx4fZqZsZ/n8xF2CkJfoqaTlafsr98oCc8N+QA==
X-Received: by 2002:a05:6402:369c:b0:413:2bc0:3f00 with SMTP id ej28-20020a056402369c00b004132bc03f00mr7303725edb.126.1645797340664;
        Fri, 25 Feb 2022 05:55:40 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id bm5-20020a170906c04500b006ce6f8892a5sm1056649ejb.7.2022.02.25.05.55.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:55:40 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/3] microblaze: Do loop unrolling for optimized memset implementation
Date:   Fri, 25 Feb 2022 14:55:35 +0100
Message-Id: <10a432e269a6d3349cf458e4f5792522779cba0d.1645797329.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645797329.git.michal.simek@xilinx.com>
References: <cover.1645797329.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align implementation with memcpy and memmove where also remaining bytes are
copied via final switch case instead of using simple implementations which
loop. But this alignment has much stronger reason and definitely aligning
implementation is not the key point here. It is just good to have in mind
that the same technique is used already there.

In GCC 10, now -ftree-loop-distribute-patterns optimization is on at O2.
This optimization causes GCC to convert the while loop in memset.c into a
call to memset.
So this optimization is transforming a loop in a memset/memcpy into a call
to the function itself. This makes the memset implementation as recursive.
"-freestanding" option will disable the built-in library function but it
has been added in generic library implementation.

In default microblaze kernel defconfig we have CONFIG_OPT_LIB_FUNCTION
enabled so it will always pick optimized version of memset which is target
specific so we are replacing the while() loop with switch case to avoid
recursive memset call.

Issue with freestanding was already discussed in connection to commit
33d0f96ffd73 ("lib/string.c: Use freestanding environment") and also this
is topic in glibc and gcc.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56888
http://patchwork.ozlabs.org/project/glibc/patch/20191121021040.14554-1-sandra@codesourcery.com/

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Mahesh Bodapati <mbodapat@xilinx.com>
---

Changes in v2:
- missing patch in v1

 arch/microblaze/lib/memset.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/lib/memset.c b/arch/microblaze/lib/memset.c
index 615a2f8f53cb..7c2352d56bb0 100644
--- a/arch/microblaze/lib/memset.c
+++ b/arch/microblaze/lib/memset.c
@@ -74,8 +74,19 @@ void *memset(void *v_src, int c, __kernel_size_t n)
 	}
 
 	/* Simple, byte oriented memset or the rest of count. */
-	while (n--)
+	switch (n) {
+	case 3:
 		*src++ = c;
+		fallthrough;
+	case 2:
+		*src++ = c;
+		fallthrough;
+	case 1:
+		*src++ = c;
+		break;
+	default:
+		break;
+	}
 
 	return v_src;
 }
-- 
2.35.1

