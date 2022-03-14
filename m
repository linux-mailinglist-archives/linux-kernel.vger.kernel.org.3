Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D24D8E89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbiCNVHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCNVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:07:15 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A7E0A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647291964; x=1678827964;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=EW6PAc0gMHonh2hHGHFKRuvmzSFZwteDexqqY0dD120=;
  b=mPbviN6v0/VJNH9c+SujdGXgtDPrDzCM/dE4Su6Lj3PdCZMDveTvzdmR
   pnW32REISJudu0nFyyUshQTPHnZ4YNpx/6MxLp/2Cgl+6ygNgYZbq5ZGd
   +foTscjwwdV23waFGQjAG9Ri/0IsN9fe+wOmOPdwvcX27Kxi2Ibh+7Fuz
   C63FeGLzXEQkiWKZwKK1FYgkifRrlNb8nqKb21sSm6Ic0vWzIgBwylqYQ
   x3bEw3FaHf9sTwPWzxUcdOStnqzi7JJqLtUT86NMDyGPKQDzTYR4N60UA
   s/M6Q23X+o7GZY2aAg0Xwauzh594fgVOZlXsChjJ4vzGuddWojKLRDC8W
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316867002"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="316867002"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 14:06:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="613035621"
Received: from ssraox-mobl2.amr.corp.intel.com (HELO [10.209.55.169]) ([10.209.55.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 14:06:03 -0700
Message-ID: <6b28a6f3-8d3d-76f4-d517-62260ac5b337@intel.com>
Date:   Mon, 14 Mar 2022 14:05:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
 <20220311101940.3403607-7-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 6/8] x86: Add hardware prefetch control support for x86
In-Reply-To: <20220311101940.3403607-7-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 02:19, Kohei Tarumizu wrote:
> +static int broadwell_write_pfreg(enum pfctl_attr pattr, unsigned int cpu,
> +				 unsigned int level, u64 val)
> +{
> +	int ret;
> +	u64 reg;
> +
> +	ret = rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = broadwell_modify_pfreg(pattr, &reg, level, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, reg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

This needs to integrate _somehow_ with the pseudo_lock.c code.  Right
now, I suspect that code would just overwrite any MSR changes made by
this code.
