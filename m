Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7859C26E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiHVPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiHVPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:13:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49354054E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661180958; x=1692716958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ClVYPn882gNwCF86xclRfA24N8oucaUlGT2UzD0nKNg=;
  b=IL/O+H7duzbyKKvuuFnu/M5HdiM8KTt/bEfKSRsnnTPrMca+Vvbnrped
   98+CPy7WgIi96wHsHNJD2y2E3QUsSNzzWeBgHqjjI8/tywzymqZfcJuCN
   imtCycRsyky74u/52TfOv3LgVBP5sV3bmCnBS0O9g+ulEG+fvz6cQdZZm
   CHtKbWvgwSSVNhJ99jqk7DBB6ZgyX901RFX0hzZmWMMLKq03mrgqLeJBu
   nrSozdtld3VdzBYhgEFYIft/dlu2zRNdqqhMT0Bm2CtVJsseyRSo0O/X6
   ht5WozXAL/lvJu/pc32MAQnUvr/7VIHO+egqfPDKr0xheAYBfw5h5bV8P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292179194"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="292179194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:08:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585556317"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.228.10]) ([10.255.228.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:08:56 -0700
Message-ID: <c09ba37c-f685-15a3-3042-8cb3a0f91282@linux.intel.com>
Date:   Mon, 22 Aug 2022 17:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2db93498ff71..232e24324fd7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4473,6 +4473,11 @@ static bool init_hybrid_pmu(int cpu)
>   	struct x86_hybrid_pmu *pmu = NULL;
>   	int i;
>   
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		pr_warn_once("hybrid PMU and virt are incompatible\n");
> +		return false;
> +	}

It's totally possible to virtualize hybrid correctly, so I don't think 
this is justified

-Andi

