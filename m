Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8B533095
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiEXSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiEXSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:41:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3109630D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653417680; x=1684953680;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j/5DR7tzKkv9kqbWuOe2Gdq9+5NSpJjwV1s4Q6desGs=;
  b=gURDOz6LvuWqBGJFinolwUJfYIAEgrrZkpU9DX4uOc/oXKTERGqTrRO0
   Lm/0eB5wIkZM0NOvwNrvMRDk3iFLCbI9xPXE6SGR2Ld8olsNJAByf6T/Q
   QBU6FaOExqnmJLO8bveay9A8w+fQCJPCAA0moaSblMqkFk1S6fhSiIiSI
   GzXuCCmf5ICYvZGhjhgwQzsGvRhnl2+VDJFpodbEywFxeRlFEVIgGyDJd
   32ZZO2XGYg+zyAxt95tiZkRxUawBG5+iojOpSrireFGbQYVK0l0mNuXNb
   PgKgsxgY1dBuilVmPrXqxY/d64loqEeMXUIvKwrBFVtqJdry+gXQkM4T/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273350586"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273350586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745348189"
Received: from tatac-mobl.amr.corp.intel.com (HELO [10.212.199.159]) ([10.212.199.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:41:20 -0700
Message-ID: <bc5e9175-e609-d5f8-da33-65e97d4fd813@intel.com>
Date:   Tue, 24 May 2022 11:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/resctrl: Fix to restore to original value when
 re-enabling hardware prefetch register
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 21:55, Kohei Tarumizu wrote:
> The current pseudo_lock.c code overwrites the value of the
> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
> Therefore, modify it to save and restore the original values.
> 
> Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
> Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
> Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>

Those commits are pretty old.  Is there any reason this is not stable@
material?
