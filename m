Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422924E9596
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiC1Lqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbiC1LhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:37:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40E28E26
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:29:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m22so13716843pja.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=K1GDc+QJWhYEe9B5KwJciqzvBoL8N5FOvcNlONWFAIU=;
        b=RubwMEPDFLu856QooxU8gVDiQIA2hT1b620J4DxI9O8yZdT5Q3ZmepeXh/LsHlKr9Q
         ga31VSpBvCU2kgCkEQo57UWND6TOscCSI2C9+kKt9ik3dLiG1217Yr1XaAGzeMAnedpF
         w3V/Neo4elRASPM4JWEA6uuNkXjAHyqDvTuyZMZlv7BVMKdZriYyhu6t+zlpXAbxPvfl
         tne8ytdGQXMFroeRM47d1y71A4hIgxsRpdyDbyCh3lZaFtmUMBo3jV8hGSfv789g0uE9
         wAhydDl29xGGcoxRL/JI7969bFs7NE/WQ+C30E8I9/UA33RexHtMBBWYmbbqX0EXlL4a
         3l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K1GDc+QJWhYEe9B5KwJciqzvBoL8N5FOvcNlONWFAIU=;
        b=v70sMsAFbY5/BCIYUa15gAcivWdefcmSm1f5+OH6rxdMJCPGlE90D5VgD6Z+5YzXc4
         NCwHrgteHXKcd+aYh65ZvjVjqajsTE5Pgq5jZsg0QPqUC/5ZbKnCv8lHVysF5I+J4MSb
         7lCdYoMHsBPQuRcv3jQBicwIT1x+4SbSnuklqhaFbeXr02fD+GY9z9COLn2Wpgqfk0FW
         XGCUnw1fLiw84eQNTiMSaMH9mxFw8Gg9RYgUfYF6eIONPwKR6rOMITENLf1KgIpphnYJ
         MzJRZkMlvhfpNAIfAvG6sXluBR1x7ISzFbebdwhIzT6hte1VyXb5XqjcS8Pn+sFGahHV
         Z1ig==
X-Gm-Message-State: AOAM5339kCVYvKijErMlkgrXbIHWshe4Z9WA7q37esxLA9iHaU5qIAB0
        Yia3mg0QCJR5fytC0NyH/YU=
X-Google-Smtp-Source: ABdhPJyCMbkOGpR1KCqR5Kq4MYgOKdA4gGy4GsZX0tn++dQ86W4p49spqRifXX6uFwSAN3xYFK6+SA==
X-Received: by 2002:a17:902:d2ce:b0:154:7271:9c0f with SMTP id n14-20020a170902d2ce00b0015472719c0fmr25690548plc.85.1648466979418;
        Mon, 28 Mar 2022 04:29:39 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id c69-20020a633548000000b0038554192b91sm13064338pga.38.2022.03.28.04.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:29:38 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] damon: vaddr-test: tweak code to make the logic clearer
Date:   Mon, 28 Mar 2022 19:29:30 +0800
Message-Id: <20220328112930.31229-1-xiam0nd.tong@gmail.com>
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

Move these two lines into the damon_for_each_region loop, it is always
for testing the last region. And also avoid to use a list iterator 'r'
outside the loop which is considered harmful[1].

[1]:  https://lkml.org/lkml/2022/2/17/1032
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 mm/damon/vaddr-test.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 6a1b9272ea12..98b7a9f54b35 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -281,14 +281,16 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
 
 	damon_for_each_region(r, t) {
-		if (i == nr_pieces - 1)
+		if (i == nr_pieces - 1) {
+			KUNIT_EXPECT_EQ(test,
+				r->ar.start, start + i * expected_width);
+			KUNIT_EXPECT_EQ(test, r->ar.end, end);
 			break;
+		}
 		KUNIT_EXPECT_EQ(test,
 				r->ar.start, start + i++ * expected_width);
 		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
 	}
-	KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);
-	KUNIT_EXPECT_EQ(test, r->ar.end, end);
 	damon_free_target(t);
 }
 
-- 
2.17.1

