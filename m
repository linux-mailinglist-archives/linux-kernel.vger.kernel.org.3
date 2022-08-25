Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273B5A187D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiHYSNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbiHYSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43206BD29B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9sq97waYr8mH2rClKPdli1YiqFmptQI/NPj6B1KpLs=;
        b=IP+Au2YrNfmFfd/ufBx+XMR1lef1Zq1RRAoC5BcM0qznk/2wflRLB+SKE8tyuYVGQsYqUC
        wOn10KepEJ1QgJYq2088SA0nlxhu9s5xQx8zToilD6FUEo02tGP7TqsGiynIcmsz2yMmEX
        ZLUMs4qJ2+gB6CG5sJ0fEsYfny+7Nuk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449--nkxAs8AN2WHAworjh4X6w-1; Thu, 25 Aug 2022 14:12:48 -0400
X-MC-Unique: -nkxAs8AN2WHAworjh4X6w-1
Received: by mail-wr1-f72.google.com with SMTP id i29-20020adfa51d000000b002251fd0ff14so3616943wrb.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=g9sq97waYr8mH2rClKPdli1YiqFmptQI/NPj6B1KpLs=;
        b=k5DQRZIf2TOsG/CO7ffsHM8r5HSr+HSu+r4pAt0ctDR3X7twHOQMa95nR2aSD2oEYP
         aprG5t4UfwtJpQOuTN58wzyVXXU5xe9U2qP8u7IsWobIN/gXQqqqywi+bP0jLcQ4l7JI
         aB6mNeUvhIW1kEwImsswOpopfHBwwlC8uRHDMkmSI/8m3HurFqi4L4YSLqld/HBDcrs5
         VEIcEweiwLh9hDgjhj5stAW/QOuXsxor7+zNnuym3DGTnUl0Wr+XJ4bhWYwQq2l6JzL1
         f/dIRBgTbxLyANN6MG9Hjxg7kBdkHFVCuNH98hqhiIMqwd4FLikV2HZXG0h8qIPNplRA
         woqg==
X-Gm-Message-State: ACgBeo0MqjKed/wYENJlYxs+atgo3qjHRWtyELF6/mip/VERiHtUdwmB
        5pQtaRUXf3QNFDuqX197QPLyDj1TfWgiEFXkFz9XluARSVwEq0YD/GKQismKucbRK25Vmnppsc2
        8drTeGlCFTqFqDabpV5gti/E/
X-Received: by 2002:a05:6000:a0d:b0:225:4bf3:95bd with SMTP id co13-20020a0560000a0d00b002254bf395bdmr3076423wrb.289.1661451167717;
        Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5BpNbjLHR+235HnmP7arPWYZvpmPyiHCVfRmljczNrmIGhxXf4zF8KGcetcyQdkdacI6vzgA==
X-Received: by 2002:a05:6000:a0d:b0:225:4bf3:95bd with SMTP id co13-20020a0560000a0d00b002254bf395bdmr3076409wrb.289.1661451167560;
        Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v3 6/9] sched/core: Merge cpumask_andnot()+for_each_cpu() into for_each_cpu_andnot()
Date:   Thu, 25 Aug 2022 19:12:07 +0100
Message-Id: <20220825181210.284283-7-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the second use of the sched_core_mask temporary mask.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..b4c3112b0095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -360,10 +360,7 @@ static void __sched_core_flip(bool enabled)
 	/*
 	 * Toggle the offline CPUs.
 	 */
-	cpumask_copy(&sched_core_mask, cpu_possible_mask);
-	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
-
-	for_each_cpu(cpu, &sched_core_mask)
+	for_each_cpu_andnot(cpu, cpu_possible_mask, cpu_online_mask)
 		cpu_rq(cpu)->core_enabled = enabled;
 
 	cpus_read_unlock();
-- 
2.31.1

