Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A35B0C91
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIGSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIGSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:36:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95949BCCC8;
        Wed,  7 Sep 2022 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662575783; x=1694111783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2tfkmJJyjKLwr7gX3rJarPjPqogX9fLIbrmabSHPqNM=;
  b=Go9dl9O9s06WYDtkOjROQxoeoadsheJPayKt0hqC7zNlHgao8bPSL2zt
   MnfrJCLkFvldCilXPyaobObePdB7JURW9ksUzdVNY19OoQ9VXwztnzuAn
   bk382wj8qVCqiCOOwsHazOHVJvF+uT4r10NrbokXU2OFrHr8ghgwlXC7s
   3vEZG6YinopiNDuyJ27OKaXxQozmQBCIxxawdPaPsXzM5YjE0dyXezkEp
   PNmeEZwqRD96ItshRm5cjNjxyHF3AbaEuXylOZa0jw27aT5kZOMSSP5sr
   ahcp0lFoMxaPaU/jiWqWqsK0Wcx0pMIexkZ5J0SpOi+GSOD2QUP4e9P6V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277354932"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="277354932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 11:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="740395885"
Received: from tvang-mobl1.amr.corp.intel.com (HELO [10.254.70.166]) ([10.254.70.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 11:36:12 -0700
Message-ID: <ec61c77f-260f-d9b1-a85a-1888fc45545d@linux.intel.com>
Date:   Wed, 7 Sep 2022 11:36:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, sandipan.das@amd.com, tony.luck@intel.com,
        james.morse@arm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 11:00, Babu Moger wrote:
>  #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation */
> +#define X86_FEATURE_BMEC		(11*32+18) /* AMD Bandwidth Monitoring Event Configuration (BMEC) */

Shouldn't this be +19 instead?
