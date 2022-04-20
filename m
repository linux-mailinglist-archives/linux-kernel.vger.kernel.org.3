Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140825092F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382868AbiDTWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiDTWlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:41:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF2BE35
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e62-20020a17090a6fc400b001d2cd8e9b0aso3396850pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1s4gUhN00hvXjHQF/+x0N4gKH6WVZc/YWM+Yr6Op0YU=;
        b=5JyuAuOTwJTohS87I/3Ve6D+H+T+O15/pe3TEl7x+PM1CTgjSUT+VHl9QLbTz0UTzm
         bBfxrM3EKNJ0RHy16fHhCIkbZBdlEYQWS2vNRsIXmMAPIX1Z+qRdpwc0T5gx4YdmKPeO
         ZbZZ9uGY2P3cFXqY9YQ/cYQ9RPUD+8+69VH5IRZndVPhYrI7D+UzoqFqK3ykS+cV37nC
         xG+J+U1m4g0uZMZrpBQBR1AuYACU2My0O0pN/iF8HjnUOylf3ymuKiAThdvcQ3xqplTu
         wQ1VUKC4Dpvb5s1voLQPVwNjCdVKtmb8c85k7k2Lr8fwnm9URqgfykxQHZIg1WkymCcB
         Bt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1s4gUhN00hvXjHQF/+x0N4gKH6WVZc/YWM+Yr6Op0YU=;
        b=oxoyrNqMVnZiBekXfjFWfsQ9Y3cx+8ZlUjxtxLwV5xNGPtj43tWIou7u4VwvTfBx7k
         ihmlET9k19DI+K8HjE2quhigyxvBs3As9cQ37Tx+0AM4tdNeZ6+xKPtjwH5Ss80cb9mO
         UuyQIcthJPqoG+zh3uyzrdC+rxTztG4Ult+hXXdkhLc3+BjIX9YlrTq4wMLaoTmUavKo
         WwWxzEOtAha5c7iURBguYollUtfEPqpX3UI7vgtOHNrNOAkGdULiHYFB8Ew+wUc4EyWd
         5UCPGPWmcOUT9TFqavS4vly7flZ4CvBPXLf8uTLP/zU3rVglf+4fmfyvWjFnQHdhHzEV
         RpcQ==
X-Gm-Message-State: AOAM533wLvugndBfreT6+ECixm2Y3qPUX0iE0la2Cvuvpq8nh0sITGJx
        e7Fj+EhNb6A2+S/K7TY72O86Zw==
X-Google-Smtp-Source: ABdhPJwIZxrWlq6zpYuqMSflGPFvJ3TjSsoOPmt0rnBxaXjCWb8zDsCL5+u3pglRkvmQq64RL39BOw==
X-Received: by 2002:a17:90b:4a8a:b0:1d2:bff4:b44f with SMTP id lp10-20020a17090b4a8a00b001d2bff4b44fmr6872379pjb.118.1650494292709;
        Wed, 20 Apr 2022 15:38:12 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x69-20020a628648000000b0050ad2fe3b18sm589106pfd.60.2022.04.20.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 15:38:12 -0700 (PDT)
Date:   Wed, 20 Apr 2022 15:38:12 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Apr 2022 15:38:10 PDT (-0700)
Subject:     Re: drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
In-Reply-To: <202204161940.BrRZvzdD-lkp@intel.com>
CC:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     dan.carpenter@oracle.com, Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-dc5227fd-20f9-4cda-aa97-d458d528b05b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 02:31:33 PDT (-0700), dan.carpenter@oracle.com wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
> commit: e9991434596f5373dfd75857b445eb92a9253c56 RISC-V: Add perf platform driver based on SBI PMU extension
> config: riscv-randconfig-m031-20220416 (https://download.01.org/0day-ci/archive/20220416/202204161940.BrRZvzdD-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
> drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
>
> vim +464 drivers/perf/riscv_pmu_sbi.c
>
> e9991434596f53 Atish Patra 2022-02-18  444  static int pmu_sbi_get_ctrinfo(int nctr)
> e9991434596f53 Atish Patra 2022-02-18  445  {
> e9991434596f53 Atish Patra 2022-02-18  446  	struct sbiret ret;
> e9991434596f53 Atish Patra 2022-02-18  447  	int i, num_hw_ctr = 0, num_fw_ctr = 0;
> e9991434596f53 Atish Patra 2022-02-18  448  	union sbi_pmu_ctr_info cinfo;
> e9991434596f53 Atish Patra 2022-02-18  449
> e9991434596f53 Atish Patra 2022-02-18  450  	pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
>                                                                        ^^^^
>
> e9991434596f53 Atish Patra 2022-02-18  451  	if (!pmu_ctr_list)
> e9991434596f53 Atish Patra 2022-02-18  452  		return -ENOMEM;
> e9991434596f53 Atish Patra 2022-02-18  453
> e9991434596f53 Atish Patra 2022-02-18  454  	for (i = 0; i <= nctr; i++) {
>                                                             ^^^^^^^^^
> The <= should be <
>
> e9991434596f53 Atish Patra 2022-02-18  455  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
> e9991434596f53 Atish Patra 2022-02-18  456  		if (ret.error)
> e9991434596f53 Atish Patra 2022-02-18  457  			/* The logical counter ids are not expected to be contiguous */
> e9991434596f53 Atish Patra 2022-02-18  458  			continue;
> e9991434596f53 Atish Patra 2022-02-18  459  		cinfo.value = ret.value;
> e9991434596f53 Atish Patra 2022-02-18  460  		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
> e9991434596f53 Atish Patra 2022-02-18  461  			num_fw_ctr++;
> e9991434596f53 Atish Patra 2022-02-18  462  		else
> e9991434596f53 Atish Patra 2022-02-18  463  			num_hw_ctr++;
> e9991434596f53 Atish Patra 2022-02-18 @464  		pmu_ctr_list[i].value = cinfo.value;
>                                                         ^^^^^^^^^^^^^^^
> Off by one
>
> e9991434596f53 Atish Patra 2022-02-18  465  	}
> e9991434596f53 Atish Patra 2022-02-18  466
> e9991434596f53 Atish Patra 2022-02-18  467  	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
> e9991434596f53 Atish Patra 2022-02-18  468
> e9991434596f53 Atish Patra 2022-02-18  469  	return 0;
> e9991434596f53 Atish Patra 2022-02-18  470  }

I think this should do it

    diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
    index a1317a483512..50394ef1adef 100644
    --- a/drivers/perf/riscv_pmu_sbi.c
    +++ b/drivers/perf/riscv_pmu_sbi.c
    @@ -457,7 +457,7 @@ static int pmu_sbi_get_ctrinfo(int nctr)
     	if (!pmu_ctr_list)
     		return -ENOMEM;
     
    -	for (i = 0; i <= nctr; i++) {
    +	for (i = 0; i < nctr; i++) {
     		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
     		if (ret.error)
     			/* The logical counter ids are not expected to be contiguous */

but I'm not super familiar with the perf code and there's frequently this
pattern of "0 is reserved as a special value" in the RISC-V specs (interrupt
numbers, for example) so I may be wrong here.  IIUC none of that is going on
here, as these are all indirect/non-contiguous, but I'll let Atish take a look.

Thanks!
