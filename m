Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30C35091B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382340AbiDTU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382320AbiDTU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:59:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502047AD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650488169; x=1682024169;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=3Rtfob+huina/55HMFVC0p+JdnFzo9FvVFAZEOpk6b4=;
  b=bDCJ2EgioKQ1ZzH+IEQtg0+1XINwT3eTpDe6D951mPTMyimnxZf25LKn
   EOB1feMmFCN9jzeE5Gebh/6RRHFGwGn4FuAV9MF3EX49S1mfjOiDzNHAf
   GjbXWTYie0e5EPsrqHxTFM21grenYkgHrnTypnSLOS5/WGfjT8XXfAdT/
   t6r4ulv8oIki7E/Whp/rwKzfZVGNuLolLMv4GaLu98iS2c9iJ8q2pyvAb
   EPOJ64vz2HY2enfdR+PU6JVebCpFR2UqZR0V8Wsz0Qe/KvZTLuDVFQORw
   CN8p5AiC1FZqId3jl7JYDJ0bftUUNQ3jW8l1di2H45oMUsP3SLMtNgJ4F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244734017"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="244734017"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 13:56:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="562267203"
Received: from mileskin-mobl.amr.corp.intel.com (HELO [10.213.184.8]) ([10.213.184.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 13:56:08 -0700
Message-ID: <2eb705cd-8607-4b8c-2c0b-31265d503eed@intel.com>
Date:   Wed, 20 Apr 2022 13:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
In-Reply-To: <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 20:02, Kohei Tarumizu wrote:
> The current pseudo_lock.c code overwrittes the value of the
> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
> Therefore, modify it to save and restore the original values.

It would be nice to mention that the wrmsr()'s in this patch are only
done inside of an interrupt-disabled region.  Without that little tidbit
of information, it's not obviously correct that the smp_call_function()
in patch 8/9 is correct.

The x86 code here looks reasonable otherwise.  It's a little bit of a
shame that this is *ONLY* for BROADWELL_X for now, but I assume you were
just conservative about it because that's all you have to test on.
