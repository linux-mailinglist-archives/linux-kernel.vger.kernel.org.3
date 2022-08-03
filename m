Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9E588FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiHCQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiHCQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:00:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F4658A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:00:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f63772b89so146376377b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eAisIG9SYnL867xAVoU/dDtuMJD7GNdC5GKMPKCuD7g=;
        b=JMz2yYj17JJK7s0GZLqf9eIFkzlpA7nq3xPU25hHCrDQ7XdXctLY8Ceh9CEUoOcZGW
         2mLH5QRSA32vCvPAHJzsMIVforgj8m1GuLzUzfIgxAB7QpSuKqPEtxjjRgJKm3wE0UbH
         Pa8Jtz6otJEGrj+mwb6yHBZArZO0pMPaoRp3RxpWMwy5hNzhe9yu2I8GlanHTRZ1zuJ3
         O9ToL5NxxRs1/v0R/z+dS2zV6mlCXCtkgrIp7G64qAEoqMbUuAPvFfTsvevjajffesvQ
         KY5qRrWbtkW+ty77a4js+wbwLMe0RWcITveh/pBllwmDrIxcvxByx96PcZHcVGesQPKC
         Y3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eAisIG9SYnL867xAVoU/dDtuMJD7GNdC5GKMPKCuD7g=;
        b=obkCF/EbT8eRj9uK7YP9Ikx7WrpgYMQwzFZw4n+Qupy4WF7zQ/MDocMhoIg3fC72yp
         ohBRV00Ksuq5AVkDR08sw5hyhKfImoiixrRZ8/FwZL7kg18OfgYn/RFTcBfZ69iJTPyZ
         LBVTrP3KOjx2mc5x4unOo6JDWxk5R+GucIusYp8P5vSoGSMVB4fEeXIEO/FGb1ZV3Cm5
         Bb08Qtya2WH+0MYlfW2RloFiXCESWtDIW3sVJi+CjplnEiyklUJjFs527kPsnvueyB76
         iJZHsgtBG8+lpa5h5ITrHVlOZNVnglLuZrQjfF1Egj8ffVG6Yw0NWkKkZFC0bV1fHiz7
         cytg==
X-Gm-Message-State: ACgBeo2ZUezQTIDof0Lh9x63cu3VzGpWcHPmgn5wMjSA+Ig+hOz4TlGa
        3KNmd2qqoeb7fwBlC40rFSqwVlwH+6fWstFMqC4dhEP8rotFPVcJlX1PkGicyh8BOGa9ba6oQ7F
        /V94VWt5ZB7hznBvPUI18jQTk70c41h1Py78VTFv7mmW/HoXgfqELBTGxM26Xkm6qME5LzjDY
X-Google-Smtp-Source: AA6agR71YvcoSwgPa6NrK7Oj522s06Mx/9cM5DqKl7zAdt+upZHk85GhPfcYFeMrqPg64Mtz373M0hgItcse
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:c507:f658:6cbc:da8a])
 (user=eranian job=sendgmr) by 2002:a81:53d6:0:b0:31c:c750:14f9 with SMTP id
 h205-20020a8153d6000000b0031cc75014f9mr23645722ywb.248.1659542454432; Wed, 03
 Aug 2022 09:00:54 -0700 (PDT)
Date:   Wed,  3 Aug 2022 09:00:31 -0700
Message-Id: <20220803160031.1379788-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] perf/x86/intel/uncore: fix broken read_counter() for SNB IMC PMU
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        namhyung.kim@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing code was generating bogus counts for the SNB IMC bandwidth counters:

$ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
     1.000327813           1,024.03 MiB  uncore_imc/data_reads/
     1.000327813              20.73 MiB  uncore_imc/data_writes/
     2.000580153         261,120.00 MiB  uncore_imc/data_reads/
     2.000580153              23.28 MiB  uncore_imc/data_writes/

The problem was introduced by commit:
  07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")

Where the read_counter callback was replace to point to the generic
uncore_mmio_read_counter() function.

The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
MMIO therefore reading 64-bit from MMIO. Although this is okay for the
uncore_perf_event_update() function because it is shifting the value based
on the actual counter width to compute a delta, it is not okay for the
uncore_pmu_event_start() which is simply reading the counter  and therefore
priming the event->prev_count with a bogus value which is responsible for
causing bogus deltas in the perf stat command above.

The fix is to reintroduce the custom callback for read_counter for the SNB
IMC PMU and use readl() instead of readq(). With the change the output of
perf stat is back to normal:
$ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
     1.000120987             296.94 MiB  uncore_imc/data_reads/
     1.000120987             138.42 MiB  uncore_imc/data_writes/
     2.000403144             175.91 MiB  uncore_imc/data_reads/
     2.000403144              68.50 MiB  uncore_imc/data_writes/

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/uncore_snb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index ce440011cc4e..1ef4f7861e2e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -841,6 +841,22 @@ int snb_pci2phy_map_init(int devid)
 	return 0;
 }
 
+static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * SNB IMC counters are 32-bit and are laid out back to back
+	 * in MMIO space. Therefore we must use a 32-bit accessor function
+	 * using readq() from uncore_mmio_read_counter() causes problems
+	 * because it is reading 64-bit at a time. This is okay for the
+	 * uncore_perf_event_update() function because it drops the upper
+	 * 32-bits but not okay for plain uncore_read_counter() as invoked
+	 * in uncore_pmu_event_start().
+	 */
+	return (u64)readl(box->io_addr + hwc->event_base);
+}
+
 static struct pmu snb_uncore_imc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.event_init	= snb_uncore_imc_event_init,
@@ -860,7 +876,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
 	.disable_event	= snb_uncore_imc_disable_event,
 	.enable_event	= snb_uncore_imc_enable_event,
 	.hw_config	= snb_uncore_imc_hw_config,
-	.read_counter	= uncore_mmio_read_counter,
+	.read_counter	= snb_uncore_imc_read_counter,
 };
 
 static struct intel_uncore_type snb_uncore_imc = {
-- 
2.37.1.455.g008518b4e5-goog

