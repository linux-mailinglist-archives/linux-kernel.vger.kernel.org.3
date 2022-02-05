Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0924AA993
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbiBEPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbiBEPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644073562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HFOiB1hRKVRXNI3vSujXABTzt/FIH2gAktqkFb6ckUk=;
        b=e2lbGmrSVcgqaCHp8zV0Lp/7g76TlFJ7Cf5q+1WecjC2OPRixbsEvue9MxNdAvhJVTmRYl
        wPEaibkDJWMgpiukMPAUZ3cdxjYTcVm6peG4Ai9Vc30QM3QmJ1TgQv63Nq0DhovYb+ba6n
        HaZk8cKcUzoNHdzFH6t/MiaFQN+kMVo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-L_RURwYHN_irGG00bEaJgw-1; Sat, 05 Feb 2022 10:06:01 -0500
X-MC-Unique: L_RURwYHN_irGG00bEaJgw-1
Received: by mail-qk1-f197.google.com with SMTP id u12-20020a05620a0c4c00b00475a9324977so4707724qki.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 07:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFOiB1hRKVRXNI3vSujXABTzt/FIH2gAktqkFb6ckUk=;
        b=CHRlnWFRt/iIqSSl0+Wv3BSfcNlddNA8Tr5Qda6MlIbJX9eoIes14EknvTgAIXZerG
         O2UKHX6i18R4Sd/P/vCAsBnwpwCUHwxC6yap+17lNjEva8JD0NIlL31cD1iaer9dnR8N
         TRU5rMzTeO3a5d68x/VQWhxV5TLYpDcz/OW9yEWt0aVxnFIUM4fj+Q3TJuf7InGguBHR
         /5pycggm5AusJHgq8mKw0uGedKtwvHV6GF/enhHVFhixrOVRfCsBQky1Vjm/5g6Dyehv
         AMQc4JQUphtjHN6GeXAHHkPxH01vGaMDbrAAE1LQGOVVHHLqFP0KRnNnhcmzzpO04C8P
         mSlA==
X-Gm-Message-State: AOAM530uidq+WMmVDbCn5FEZ6OpZzBtMG0LO12btTQK2fl/hqhVocVqL
        Xovlu65w0n02WKHCZR0Qn2LtxZJJn9mqvwo2nLM/dnA1yneow5Rtvk9EGFVsjY0YtDZn5V+J84c
        qZ7qiitCMru7z1ReCZswxzU3h
X-Received: by 2002:a05:622a:249:: with SMTP id c9mr2799085qtx.109.1644073561010;
        Sat, 05 Feb 2022 07:06:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHdY9gPLzZ34BA6/NkHsRadtILz/Da4LXrmosm2/PdejzarCHuBbYQ1iuqbo53IySijVUi9A==
X-Received: by 2002:a05:622a:249:: with SMTP id c9mr2799047qtx.109.1644073560650;
        Sat, 05 Feb 2022 07:06:00 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f14sm2728592qko.117.2022.02.05.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 07:05:59 -0800 (PST)
From:   trix@redhat.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sched: cleanup double word in comment
Date:   Sat,  5 Feb 2022 07:05:53 -0800
Message-Id: <20220205150553.1968684-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'into'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b33ba9c3c420..f82a81b4a5271 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2507,7 +2507,7 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
 #ifdef CONFIG_SCHED_CORE
 	/*
-	 * In order to not have {0,2},{1,3} turn into into an AB-BA,
+	 * In order to not have {0,2},{1,3} turn into an AB-BA,
 	 * order by core-id first and cpu-id second.
 	 *
 	 * Notably:
-- 
2.26.3

