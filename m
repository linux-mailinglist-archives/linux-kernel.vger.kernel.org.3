Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F850932C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382992AbiDTWvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356345AbiDTWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:51:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F027CEA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:48:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t11so6385572eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp5tZQ7qKQ49GSZM1yPmNJ5oK0s+w2IXfr+FHRYWSrU=;
        b=0jjY/qM8j3pcWzq0ZPZkPt9JZzMWSCVK4pVwdAE/rpuMyHZE13e4YcAEWLSewzj9Q9
         Yy1xI/6AwUS4fZIR2woMHl7SLQ8K6rG/bahHeq322LBOFv3mfEX7TTcGRyvp/pYpLMK6
         +GkLfeORlDY6dM4ETj/2CvvQ3gA31AkUgzgUwqiV2idyKHDn9mWlbVLDv8zdMF7/lJbi
         n7kfaM2yoAST7QR5fJXYgTJ1AcUCMwq6eqBLN8ZUy2MtTk/LVZUJwOQi//spLCEbdeT9
         Av29ikX9iY7EiqKuBSAZb0Bf0E+jg4Uv4W0PIldQlHH9o61Gis1bukJe1JgwgEtDWAOE
         XGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp5tZQ7qKQ49GSZM1yPmNJ5oK0s+w2IXfr+FHRYWSrU=;
        b=4pbrpY1ApiLGfVpSRnFrChvEQbZkh6TaUo8ErY54KOjJ58DpCTI2gz3L4pWP6Yr5V7
         f+NwxWviKmHh7WIc/dL1+/I5tOfY5zoLF6XMtG2PKMjvG7I52/jGCC4VoPt9q6S9RdEi
         WDc/wmVnwnWTUy9o6O8OVsOWKyQP69kTA0jmZEBgM/vDFTjA3SMtKiej9lT/DlSa3kCz
         LyuT9M8/tVdqNLVxen9C+R/fsvXlvES0QPoviLSwZI6Fbn/BiWrxzsm1Yv3mBPOGzKwb
         Lg6RKpOm4b406208+PMsqa3Wk0FljA2j/moE7j4Tyqx4DENclk6IVE/yajLpMt0or8dc
         CAzw==
X-Gm-Message-State: AOAM5311Eu0CtDZmbj2p1nhTIvaKX7oUBE65ErEnAyAorkYeYkgpVtBm
        2isMPG3sFTE+EPZpPIXd4tN/38pnPCW2+sP/IF7l5A==
X-Google-Smtp-Source: ABdhPJwQCqU10CkHWIOQIcpL40kj1pefwH4AZuzAmjelrMm8GIwKeaHAhbME34XioDoRRqshrgXsA+isLactc8MAnjc=
X-Received: by 2002:a17:907:2d23:b0:6e8:807c:cd94 with SMTP id
 gs35-20020a1709072d2300b006e8807ccd94mr20369071ejc.502.1650494900319; Wed, 20
 Apr 2022 15:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <202204161940.BrRZvzdD-lkp@intel.com> <mhng-dc5227fd-20f9-4cda-aa97-d458d528b05b@palmer-ri-x1c9>
In-Reply-To: <mhng-dc5227fd-20f9-4cda-aa97-d458d528b05b@palmer-ri-x1c9>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Wed, 20 Apr 2022 15:48:09 -0700
Message-ID: <CAHBxVyEwN=Xf1kM6OUDQD2JvyesvQjpPzfovcQu5hwzFWNEwdw@mail.gmail.com>
Subject: Re: drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn:
 potentially one past the end of array 'pmu_ctr_list[i]'
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     dan.carpenter@oracle.com, kbuild@lists.01.org,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:38 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Wed, 20 Apr 2022 02:31:33 PDT (-0700), dan.carpenter@oracle.com wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
> > commit: e9991434596f5373dfd75857b445eb92a9253c56 RISC-V: Add perf platform driver based on SBI PMU extension
> > config: riscv-randconfig-m031-20220416 (https://download.01.org/0day-ci/archive/20220416/202204161940.BrRZvzdD-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 11.2.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
> > drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
> >
> > vim +464 drivers/perf/riscv_pmu_sbi.c
> >
> > e9991434596f53 Atish Patra 2022-02-18  444  static int pmu_sbi_get_ctrinfo(int nctr)
> > e9991434596f53 Atish Patra 2022-02-18  445  {
> > e9991434596f53 Atish Patra 2022-02-18  446    struct sbiret ret;
> > e9991434596f53 Atish Patra 2022-02-18  447    int i, num_hw_ctr = 0, num_fw_ctr = 0;
> > e9991434596f53 Atish Patra 2022-02-18  448    union sbi_pmu_ctr_info cinfo;
> > e9991434596f53 Atish Patra 2022-02-18  449
> > e9991434596f53 Atish Patra 2022-02-18  450    pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
> >                                                                        ^^^^
> >
> > e9991434596f53 Atish Patra 2022-02-18  451    if (!pmu_ctr_list)
> > e9991434596f53 Atish Patra 2022-02-18  452            return -ENOMEM;
> > e9991434596f53 Atish Patra 2022-02-18  453
> > e9991434596f53 Atish Patra 2022-02-18  454    for (i = 0; i <= nctr; i++) {
> >                                                             ^^^^^^^^^
> > The <= should be <
> >
> > e9991434596f53 Atish Patra 2022-02-18  455            ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
> > e9991434596f53 Atish Patra 2022-02-18  456            if (ret.error)
> > e9991434596f53 Atish Patra 2022-02-18  457                    /* The logical counter ids are not expected to be contiguous */
> > e9991434596f53 Atish Patra 2022-02-18  458                    continue;
> > e9991434596f53 Atish Patra 2022-02-18  459            cinfo.value = ret.value;
> > e9991434596f53 Atish Patra 2022-02-18  460            if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
> > e9991434596f53 Atish Patra 2022-02-18  461                    num_fw_ctr++;
> > e9991434596f53 Atish Patra 2022-02-18  462            else
> > e9991434596f53 Atish Patra 2022-02-18  463                    num_hw_ctr++;
> > e9991434596f53 Atish Patra 2022-02-18 @464            pmu_ctr_list[i].value = cinfo.value;
> >                                                         ^^^^^^^^^^^^^^^
> > Off by one
> >
> > e9991434596f53 Atish Patra 2022-02-18  465    }
> > e9991434596f53 Atish Patra 2022-02-18  466
> > e9991434596f53 Atish Patra 2022-02-18  467    pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
> > e9991434596f53 Atish Patra 2022-02-18  468
> > e9991434596f53 Atish Patra 2022-02-18  469    return 0;
> > e9991434596f53 Atish Patra 2022-02-18  470  }
>
> I think this should do it
>
>     diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>     index a1317a483512..50394ef1adef 100644
>     --- a/drivers/perf/riscv_pmu_sbi.c
>     +++ b/drivers/perf/riscv_pmu_sbi.c
>     @@ -457,7 +457,7 @@ static int pmu_sbi_get_ctrinfo(int nctr)
>         if (!pmu_ctr_list)
>                 return -ENOMEM;
>
>     -   for (i = 0; i <= nctr; i++) {
>     +   for (i = 0; i < nctr; i++) {
>                 ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
>                 if (ret.error)
>                         /* The logical counter ids are not expected to be contiguous */
>
> but I'm not super familiar with the perf code and there's frequently this
> pattern of "0 is reserved as a special value" in the RISC-V specs (interrupt
> numbers, for example) so I may be wrong here.  IIUC none of that is going on
> here, as these are all indirect/non-contiguous, but I'll let Atish take a look.
>

You are right. This was just a typo/oversight on my part. I will send
a fix asap.

> Thanks!
