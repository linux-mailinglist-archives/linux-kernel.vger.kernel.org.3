Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF550C9A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiDWLls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiDWLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:41:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84271BA821;
        Sat, 23 Apr 2022 04:38:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x33so18504479lfu.1;
        Sat, 23 Apr 2022 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EtoakrJrjTj5jLsYUp/T56xfz/HVSV91AzJtSvGSbU=;
        b=ev8cW5F027Wz1YcEXnGq0ELeFmb4UCHkXCgEsAYVEiBrxkAB7jwgmt/g4Aha+6T7zI
         ZJ4owIZ4ucBXZE13ovO2DNUkzVDEe2rP0ZoSrAeS+4JPEAVkRS5JeeAI+vmfHHxnX2Ua
         0yZJdPn+xkjl8Ivzf3FQbjyXant/1MMvtFR+WSyd+T0Tb3UUdbd7uqxqm6K86hm64xmw
         64iPp+joBvF2pkVC7pUvYLies6/2RgzfRk3qJcK7MYBcEMM9wMSdqEKp/e4sv54Ab9oP
         yUf1xeKcm0IiGzbHADRlV3wwpmQo7MLpAd1BshvibnV1vHAphE2w5cYBYnYahDm5Na2i
         7w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EtoakrJrjTj5jLsYUp/T56xfz/HVSV91AzJtSvGSbU=;
        b=qY+Wg77z0lsJtwujT+z4e0Omb2x0Pmqh3iZAWsCl2LYpTL+peO2MfZ9CeIXs6JJEuB
         tVJHF0Rzmrnze7It4/cX8KxNwvoqWH2BKueNJynAlasD1ZnQRphC+9xnq5Zv9cPojuST
         MSEeIHlNCHon/M3bDh/oztKbiOn/xBheMffc3ly/mtL+udCC41Z5slYqKn6+nRWMtINe
         sA0JRgkRhzAcYeGQG4m0pCRryNL0+lzv+GxJTAFFdk1yozyKrnoDGfst8qCy7nDDHNgU
         0LtJTGK3mpa+m3mGJExwIdAUil6D7WLHOuFSvdLXxMOKJt87qfzsiCGjGSAiF5qYIWCd
         O/Xg==
X-Gm-Message-State: AOAM5303FQfg0lq0oOHcv3eyOVT0p4LbnsDwyLH35DaxrRfvqRWoMI3g
        XR66LK0O3vJW97cVQV/Lqwk=
X-Google-Smtp-Source: ABdhPJyGdsEWmvXaacxzf676KaE3MCBTRwd20XKcfWXUk4tDCchpQPddCr3RuNB1+je4VIOlUO1tAg==
X-Received: by 2002:a05:6512:6d4:b0:470:f48d:44e2 with SMTP id u20-20020a05651206d400b00470f48d44e2mr6428203lff.542.1650713917064;
        Sat, 23 Apr 2022 04:38:37 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id g17-20020a2e9cd1000000b0024db538c2absm526411ljj.7.2022.04.23.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:38:36 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH RESEND v2 3/5] block/partitions/acorn: Remove redundant assignments
Date:   Sat, 23 Apr 2022 13:38:09 +0200
Message-Id: <20220423113811.13335-3-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423113811.13335-1-michalorzel.eng@gmail.com>
References: <20220423113811.13335-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments to a variable slot from function
adfspart_check_ADFS. It is being assigned a value that is never read
as we are breaking out from the switch case and the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/partitions/acorn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index 2c381c694c57..d2fc122d7426 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -282,13 +282,13 @@ int adfspart_check_ADFS(struct parsed_partitions *state)
 #ifdef CONFIG_ACORN_PARTITION_RISCIX
 		case PARTITION_RISCIX_SCSI:
 		case PARTITION_RISCIX_MFM:
-			slot = riscix_partition(state, start_sect, slot,
+			riscix_partition(state, start_sect, slot,
 						nr_sects);
 			break;
 #endif
 
 		case PARTITION_LINUX:
-			slot = linux_partition(state, start_sect, slot,
+			linux_partition(state, start_sect, slot,
 					       nr_sects);
 			break;
 		}
-- 
2.25.1

