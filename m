Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B244F6606
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiDFQwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiDFQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED655624B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649254518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3OG4BKAk8L1Q03J/jLmreapPn1hOxRKaAx0Fk/vOW4=;
        b=hZBx8BlaREYpiqpkyWG24V5mSEChHF4X0ZO3wBFolWhZ9Ft2OoRxPkMCQCcSzMeCmMSqfH
        9GramegHRkUKYba5nN84N5mTUkJWmh3wHZqQSdb6CfiCwhrvLze5wjTe/ZkxjlJLVTb6VV
        imqRoan+RZDulx1j/4o0zXSwHv0WId8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-hxe-7-pVOk2Cs9g_6RMfIw-1; Wed, 06 Apr 2022 10:15:17 -0400
X-MC-Unique: hxe-7-pVOk2Cs9g_6RMfIw-1
Received: by mail-wr1-f72.google.com with SMTP id q15-20020adfab0f000000b002060c75e65aso550695wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3OG4BKAk8L1Q03J/jLmreapPn1hOxRKaAx0Fk/vOW4=;
        b=0n7D7nS8snPG6pt8gBepg+YNKMRkYLang4sdx8y+7k4zOUUVG9FAsHjmnx/53N9pFt
         nIkzaMLlP1sxy1iXjemOgqp+AcPzse8wjGckDNyfo78w2hLkpIEp+xp65aI6y19orIeJ
         PJhHFVQk3PEfXenrK783RG3gwInh/Esbw2UbutctM/2ZIMwpGMBBVh5r1tFph8+qMhkm
         pog+VPu6VtE2J0aWcg6fjE/EM9lpC7+YKU9E4NRe/kmfmft5cktO48eAPGoN5n8c8PCv
         GBuC07pkHst3Nnse9rnunXD76ZAFofnfZJs7aKLVl+g4NWf5jV/cI65BQ11cBmBBk1ib
         74fw==
X-Gm-Message-State: AOAM533NTnWk0Jif+T1kU7j8NCspPRmWX2vD3rQmrY5xaZnrSHcmf91Z
        xJ/mlbYwrgZsXm7e5gkSb9WIfhrW7T3pCouyizDBwHUxcnZov/T4CVQ0eAfWyNyTrkeZFrFZKUL
        ntDIP7JrVJ1Wu4v0xXjLJS6Ris+oTx8XYw/bDBghthVdnqqtLjN2SUxYoM/DfDMH5Das7C2/LRG
        PT
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr6662551wrv.653.1649254516441;
        Wed, 06 Apr 2022 07:15:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ105+ujRtB22Hn54oryMCG1jTWeQUMxPO8UogO6ymZldNACN8akpoCHfTmcgeQE4pGrk/NA==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr6662523wrv.653.1649254516230;
        Wed, 06 Apr 2022 07:15:16 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0038cc046cb2esm7708788wmq.32.2022.04.06.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:15:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as scheduler topology reviewer
Date:   Wed,  6 Apr 2022 15:13:14 +0100
Message-Id: <20220406141315.732473-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406141315.732473-1-vschneid@redhat.com>
References: <20220406141315.732473-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've messed around the NUMA/debug bits of the scheduler toplogy in my
time at Arm, and even though I've changed ships I still intend to at the
very least review those bits.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..74b739aae6b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17508,6 +17508,7 @@ R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
 R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
+R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
-- 
2.27.0

