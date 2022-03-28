Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8344E95E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiC1L5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiC1L4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:56:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDB3FBF9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:53:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so14556667plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Q9Y80Me/FKZXwIk/FXh37Xcqjr72zJSb5A51MgW/+68=;
        b=MfgAoZoDmpoKcdQ2l7qme85CsjdL/bh1edE+LxzIkbbY8G2h1Q505y1rUrVO62nTmx
         yibtwAaEYeJPyhAcNpMLBcVTMyyEKU9Nc/F/WXovNFws4C7NSX8AdMih0+gGvwpeN00H
         4/Kxg34Uy0DZYeo6ifni3NZzJil86bDG34WE75hLa6ksBq5WzMq7+n0naJnsmjvC1jgO
         XVy7VEIbrKMoh/vMvvt161PxkoVdhDHR29oNNKZlbcNmOllJgnIb4CrYYLauoGeeJOxX
         9AMW1hoDEoEv1LyXrfPtvsb0s26rifav2OuRpc7RjAN/uTBfTtNJ7FiDRWRKhdhbyCBa
         19Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q9Y80Me/FKZXwIk/FXh37Xcqjr72zJSb5A51MgW/+68=;
        b=x2mX5m2gHjNoT+5W0oHs41zdO2az/B8Bbkihg1Z6SgKiAdoXpvlTNtMjNaDMKEUOx8
         PlrhLDKN0o4w56tO7eUP3yBlpog/IXtBtH7rcKyS0QV0aTnfJlVRogOSTgJFodqLlp+T
         lI0Un9SnEp2vaI6pVGSfiUXUjDYG1B0ILRKjembvKll5AM5LWg5Fi3yGiC+adq7B8WQW
         7Puw3VPZ6x+TLnJnYJp2kvroI3KPf5ck0y+gE4IuHyitILgB0GXv2UL9fZSnuCbGPJ9v
         VQVAIcY9VG9UckE5g4u34MYhEXwbSxzh9bNKHtyIFJ6GFfKrh+wEbxXECqw2xK0A/wEF
         ocQg==
X-Gm-Message-State: AOAM530ss1No7lQKh34YpuOBcYuHhRxBp1qNCNcqW9l+Y0g5EbW7h0FT
        Ckxyjm9cbzE6ssE0Q0+Vn+k=
X-Google-Smtp-Source: ABdhPJxuR5zWnAdKnW87IOOgssws/XB1hUqtT+pD/XtpR+VleB/5GgF6oIjju4J6k7TlvID8p4oxUw==
X-Received: by 2002:a17:90b:2242:b0:1c6:80e3:71b6 with SMTP id hk2-20020a17090b224200b001c680e371b6mr40375303pjb.152.1648468381131;
        Mon, 28 Mar 2022 04:53:01 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm17644787pjl.3.2022.03.28.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:53:00 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] damon: vaddr-test: tweak code to make the logic clearer
Date:   Mon, 28 Mar 2022 19:52:52 +0800
Message-Id: <20220328115252.31675-1-xiam0nd.tong@gmail.com>
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

Reviewed-by: SeongJae Park <sj@kernel.org>
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

