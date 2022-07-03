Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F435648F0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGCSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGCSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4279627B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656872267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VCKl9j7lixqYhrfaZVBrVSB6bBOfCLezxzbPVQjUoo=;
        b=a0ngEOouFjwuo9Snt7+tMCIx+cx7/5oCQBqsC36wcnhpUEOp+JNT9hWwvgwid3WU7LW76L
        p0BZePZ4329TmKpi0xLKiA5YPan46jeGH+8EKIFwcuwKP2LUjrQttyri5sPbSg1LEfh+Vx
        Efw3WW6XJqPmoAt4cVvI/6Sg3X9HqxQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-nhXI8Lo0O6qnc4arpVHgJw-1; Sun, 03 Jul 2022 14:17:46 -0400
X-MC-Unique: nhXI8Lo0O6qnc4arpVHgJw-1
Received: by mail-ed1-f69.google.com with SMTP id y6-20020a056402270600b00433940d207eso2203598edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VCKl9j7lixqYhrfaZVBrVSB6bBOfCLezxzbPVQjUoo=;
        b=VW4eSawc58q4GRP5otiIa6sSrJA23zNEqE2fv6xRCwe1HP3ycOhTD+C5ODKRsQat1J
         DQey1yWyKE/ZTY4bwaNIbabnjPlrL2elfKqJcGItqHvym3b6nfUg6loPhDQfl7vB5zAs
         2KG0CmMzwtxy/KFjqKoB3f+cQ+vEQzN8Uq0ouRqUjbsU4Y9WYqgDuEKWyZsXuXME3BbU
         z/JlhSwNDvj1LxPj5msNoimQOsjMrfNeW7qyHkQh/Ju7m2YAX5uEhPV5g2fD1I10QwpZ
         CCNI0wzQmaSJbeLh8aPywba1lItlEvjdTOf1mcMIyZrrSLKII1wCirXPhvsr+PW5TTTy
         37jw==
X-Gm-Message-State: AJIora+4pdwZxqN+xxH7wSeGfzpIwI9ST8MuaOrqeBW14oSoYJr8EgAp
        hZUfqdHfVTJ67+zzGAumkbPure1Ep0eWUdDRwNHwGwXbsVbBbubf3E8MzX2o4wGKlU96yLm0j/i
        1wkpB4pBh82+2zGghemtLj4Sf
X-Received: by 2002:a17:907:7639:b0:72a:98dd:58b9 with SMTP id jy25-20020a170907763900b0072a98dd58b9mr10377961ejc.614.1656872265244;
        Sun, 03 Jul 2022 11:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tn30U8VpEG0/uAZ6YMxLWwj5KleLa3Q2L8vKMz5Ki6156+H1VAQyMdLwSjZs/vCGF6vVHHIw==
X-Received: by 2002:a17:907:7639:b0:72a:98dd:58b9 with SMTP id jy25-20020a170907763900b0072a98dd58b9mr10377955ejc.614.1656872265097;
        Sun, 03 Jul 2022 11:17:45 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm18959371edt.24.2022.07.03.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:17:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/2] doc/idr: adjust to new IDR allocation API
Date:   Sun,  3 Jul 2022 20:17:39 +0200
Message-Id: <20220703181739.387584-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220703181739.387584-1-dakr@redhat.com>
References: <20220703181739.387584-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDR API was adjusted to match the IDA API, adjust the
documentation accordingly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/core-api/idr.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/idr.rst b/Documentation/core-api/idr.rst
index 2eb5afdb9931..53310d1a2552 100644
--- a/Documentation/core-api/idr.rst
+++ b/Documentation/core-api/idr.rst
@@ -24,9 +24,9 @@ Start by initialising an IDR, either with DEFINE_IDR()
 for statically allocated IDRs or idr_init() for dynamically
 allocated IDRs.
 
-You can call idr_alloc() to allocate an unused ID.  Look up
-the pointer you associated with the ID by calling idr_find()
-and free the ID by calling idr_remove().
+You can call idr_alloc(), idr_alloc_range(), idr_alloc_min() or idr_alloc_max()
+to allocate an unused ID, look up the pointer you associated with the ID by
+calling idr_find() and free the ID by calling idr_remove().
 
 If you need to change the pointer associated with an ID, you can call
 idr_replace().  One common reason to do this is to reserve an
-- 
2.36.1

