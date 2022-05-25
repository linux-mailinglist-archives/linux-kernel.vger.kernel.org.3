Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253F53385E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiEYI0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiEYI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:26:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158295BA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:26:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m6so23660258ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=TROhytUCmYi1+1zbJFOBdbpnjKvBFc00UACuo78Blu0=;
        b=t7AXHImYt88F4yFcoFo/qiLCJPnM1PNNZclSW8YTDTfk0sG5d/ZeaKK/dKfcy4dkwO
         m+7UDPXDNxmpmmTghEnV/L3JOGc6DgyEBn4FBQ1QVEV3PBPP7KeS30IkhMdfrA93FYp8
         PLy0TxtWuwWlqGG3f/LH4bbArkBwE8muI0nLZSTBzkX6Zcch2vGKOR/gJv3Lpklnfg9Q
         S924EuMCX97wqhm2YucSMxJEMYugXOIVDrEPipfoDCXxzyLxzenQEIy2ikIVQfGkdDjo
         IUtvoRKID6OBzFaJ1EqKw6XtStq6bc9kax0JGmM3/XKnJ8INcBu3va9x6rXUG5alpisq
         KyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=TROhytUCmYi1+1zbJFOBdbpnjKvBFc00UACuo78Blu0=;
        b=D1vYYanRK0zqkmi1uxmCbJ9j8pjNkgRqnqQUMZtLlHoPig10OYkksYRe5tJpr6tacB
         gt1bDAe7wW3myQ9yKjH/eB0mSbz1seO9CceC5OYPSFBlPa+f96/irFxImfPIKo2X44FM
         lfwpPMPB6psekfSp+9lI55irW1nyqW8UqS/IzijD6Ze77i6VzvJWeYRRQy2WMStfnvYS
         XQLoFEAqpEMXRi7sT4z3LkU6OhRKIFMTS7JWPuHGxoCldCyO25RangMjIvphn5dDdZb5
         hZGQ43Qb/y9H69MHLsEvlAoChsgh2IB0sBG3iTFC4c8uGsXOxgySqO+OZhnAK38kuVDb
         Ks6A==
X-Gm-Message-State: AOAM5314xpd7zzppyyVrDRHSUSWE7ojAzAw2O7vFLaZ57F43M17p7Ume
        R+cSGC62k4f2YmgM3iARGWBpFg==
X-Google-Smtp-Source: ABdhPJyDCQbgxiitG7pP3j+6MDNq9Z3uJ1djPx06ET2ui6tpQIRa8zNilbO2coRGhFru9YrSGRlLjA==
X-Received: by 2002:a2e:894a:0:b0:253:e36b:83c1 with SMTP id b10-20020a2e894a000000b00253e36b83c1mr11560558ljk.520.1653467198883;
        Wed, 25 May 2022 01:26:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id f24-20020a19ae18000000b0047255d2111dsm2971117lfc.76.2022.05.25.01.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:26:38 -0700 (PDT)
Message-ID: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
Date:   Wed, 25 May 2022 11:26:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
processing.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 lib/xarray.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 54e646e8e6ee..5f5b42e6f842 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1013,6 +1013,8 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
 
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
 	do {
 		unsigned int i;
 		void *sibling = NULL;
-- 
2.31.1

