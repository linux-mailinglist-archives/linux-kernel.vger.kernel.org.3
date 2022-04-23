Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1251D50C99F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiDWLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDWLl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:41:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB91A04F;
        Sat, 23 Apr 2022 04:38:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n17so12475340ljc.11;
        Sat, 23 Apr 2022 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSOBiYrJmNaRQKYvQ7ACT7tJByUwQn0t0NjQZI493e4=;
        b=pqQDbw4RNWGcL08nmRqyvsk7VcZjZULEDn/DTHgGlSFCPd6rXe5laDjJpufm96j0Ns
         DLjKk4lBqxrzba7tl0m8WAB/iH7q0ypWZaqja4O6LXnx4GOuJaxWiyoKM4LQ/4pbOYJp
         V0toXlRCeB00f6oQ9J/OsbDeNSWYRmMfAaFySoA28A+B5PKmykTLMf+Q4vvrFJcxov0L
         veyLID366e70c/5NFbkkR6oHwTQ5F4gqmvWLOOQQ5NnzGLHWuMPu5qdi6AOiecpPvaxn
         eju9iPoH3jpmYxXiIlitaLqLCg3JU/pQNw9xHmwKFQOFJatB8MM8EPDxbydFSxkQZkY7
         nlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSOBiYrJmNaRQKYvQ7ACT7tJByUwQn0t0NjQZI493e4=;
        b=EkWVVgJ4etUZ6kuUMGAyUFfSdC9uax5xCRMsiotp+5ChrxXKzhpL63ZMYPnQATbd4O
         bxmm7QmdHTj0DayMq9soh9Ac8NSV72UgKAZV94TzPYlzzU+WDOW0KSac+wxDCNfpgtCE
         /czW/BTDJfBodqRKiul5Q3XiCSkeKeANVuZfGaoJQ1q65z9KZ1T0a0TwN120Gtv1Ea/h
         iuk38SNxoZqy4lSSzRGcBRK2YXZodvzbgKmJjuLD5V6S8tQyPLp5SfRkuWBciSZBrMa3
         UdR+eBBLmQuEkg3oE3gqc7BGNq4eu1EGJs8P/l4illmWw0s12NVqLv4109zSIBRyIT7/
         1H8w==
X-Gm-Message-State: AOAM533WAxCTkpAElHaCLPLQxDVTrII0Z7i8BDS7G+u0qiNmPVoEhSzo
        9lW4HhkMdbWdV08/ulCbO0U=
X-Google-Smtp-Source: ABdhPJyd/PgxrOLjdrlaAYRz7cdirlOXUSeWNoFiBhHafKI7Ef6ntic9mpwNXmVl9XDmNjkGeMfFzg==
X-Received: by 2002:a2e:a40b:0:b0:24d:c4d4:5796 with SMTP id p11-20020a2ea40b000000b0024dc4d45796mr5370110ljn.202.1650713911189;
        Sat, 23 Apr 2022 04:38:31 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id g17-20020a2e9cd1000000b0024db538c2absm526411ljj.7.2022.04.23.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:38:30 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH RESEND v2 1/5] block/badblocks: Remove redundant assignments
Date:   Sat, 23 Apr 2022 13:38:07 +0200
Message-Id: <20220423113811.13335-1-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of redundant assignments to a variable sectors from functions
badblocks_check and badblocks_clear. This variable, that is a function
parameter, is being assigned a value that is never read until the end of
function.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/badblocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index d39056630d9c..3afb550c0f7b 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -65,7 +65,6 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 		s >>= bb->shift;
 		target += (1<<bb->shift) - 1;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 	/* 'target' is now the first block after the bad range */
 
@@ -345,7 +344,6 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 		s += (1<<bb->shift) - 1;
 		s >>= bb->shift;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 
 	write_seqlock_irq(&bb->lock);
-- 
2.25.1

