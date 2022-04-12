Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41B4FE6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358068AbiDLRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358052AbiDLRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:19:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956451E5D;
        Tue, 12 Apr 2022 10:17:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r2so9583661ljd.10;
        Tue, 12 Apr 2022 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KL8N/pY8zwyCNOWClL3aPmpkcSCytFBXhGWYeb2tSlM=;
        b=hP9jomFsM9tiJmHqu5vhtQiaU4M38sOGV+VyG5U1ayhkNImHv8cDQVu6qLaHigHgGW
         IircsUEfdpLF/+pRpka+/QJDiCVhBLPfxujwGGkzCaB3Oexql1I+IgmqcYh+UcLpkjdB
         meHco10Zx9W5IG4TEPgvsmvCe1PjZKlPcCykBoVwtKnraHEwfDHkkYgo1kRcqRnjGYjl
         UbVRtOvvYFQoeobeFWs/6EmjfkUW/RYqYHWPNOZuDJHZY1MklKDjJ/7k3+MPR7pzoD2B
         p8L0If2ZZWbFpsCdEoiKYQmz7FJDYvvKiWQjNagbcNvyi5FmgKzsDbhh+v0kynnYIz3E
         gZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL8N/pY8zwyCNOWClL3aPmpkcSCytFBXhGWYeb2tSlM=;
        b=C3rT22fGAakH20fZacI3munhIYmvw929zDwuGI90bcGmzilI1OCxsD4mbWfJ8xwZ8L
         s4xNywZmnPrgAP7DcLF6wT+svs+Lf1w2vmVQ1ralLau60sfzwWagaL8ao5oFGKjYJQKV
         bX0dT2eaUb1QA25czAt7RSennMvinFDDxHFbI192dgBV5XnblmI3gAqcnRR05QaZAY7z
         D2azKFEzTK7tsNYPJ25iy5Mz10kpxn0wGUeRvJdlWxUqb6b1KPmWwG2Ou2lJFkckLb6U
         syTXugZ11iFChGly13ZZUTc3T3/UIo1YP7Husp48Ttdmh972EzVSB4mwUJpBzJV1SAid
         6uIg==
X-Gm-Message-State: AOAM531INANs/5vHPxzmPzh4C1UCmZ1O4AaUQKu5q2Pw/hvjxSP5tmmD
        YSIu2i2i053DWrqd160sfUKIrU/v4UfG3zH2
X-Google-Smtp-Source: ABdhPJwVvkzm1MBZLQgrTyEN1DXXBA06k5rCSKlVyVM7hBSk8jiH0NLNKGfxpryWtrvHIPGGp5/yWA==
X-Received: by 2002:a2e:6e0d:0:b0:247:fc9c:284e with SMTP id j13-20020a2e6e0d000000b00247fc9c284emr25043669ljc.251.1649783834914;
        Tue, 12 Apr 2022 10:17:14 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id m2-20020a05651202e200b0046ba665cd6dsm723928lfq.141.2022.04.12.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:17:14 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 3/5] block/partitions/acorn: Remove redundant assignments
Date:   Tue, 12 Apr 2022 19:16:49 +0200
Message-Id: <20220412171651.19812-3-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412171651.19812-1-michalorzel.eng@gmail.com>
References: <20220412171651.19812-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments to a variable slot from function
adfspart_check_ADFS. It is being assigned a value that is never read
as we are breaking out from the switch case and the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
Changes since v1:
-move the change into a separate patch
-add analysis
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

