Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6A4BC12D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiBRU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:28:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50236207564
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645216104; x=1676752104;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=FEyHDEeiGITgQ5C1kGhGtXe6uQjqnf5Jir8+Rthta+8=;
  b=CjDUwhhBADF1wW4WvASPUOfrhqVEn6kPG/HuLGUZuNwzGI8HsElaQA77
   PSRT7nhGrpGjsxhzvHPWDn2+/I0GRDBwpKrJJ9mvEimjPDptdvppiWwEq
   YF4yDg/UZKGR0j160KQGKCEhL9UacshYPqQBX7upAGjhPvkEX2GJ+gofu
   Ic+bqtEz0iQCxspnkHAN+iFeOcyavVQZocwFlnb2DMNlCkZP5lf9yJnb3
   8gepLjGfdKo/2AiH90duAehkDuA+UGBjrzq1tJUsRPUcYg9VhDu2XQ/rv
   qBPgipqGi3UBvHgcSCBWN+mwc1AHYDDtDaczi9MRAkmeaVn6p8aW9+4ww
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="234749830"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="234749830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:28:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546459085"
Received: from jabonill-mobl1.amr.corp.intel.com (HELO [10.251.27.55]) ([10.251.27.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:25:23 -0800
Message-ID: <edb6706a-6e06-2510-3bbc-84da97b8cd52@intel.com>
Date:   Fri, 18 Feb 2022 12:20:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-27-ira.weiny@intel.com>
 <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
 <Yg82L5ibjbn15AHO@iweiny-desk3>
 <d94be5f21bf18c844d7088a96ae35aa209a0ef4e.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
In-Reply-To: <d94be5f21bf18c844d7088a96ae35aa209a0ef4e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 09:28, Edgecombe, Rick P wrote:
> On Thu, 2022-02-17 at 22:01 -0800, Ira Weiny wrote:
>> Are you suggesting the PKRU should be printed instead or in addition
>> to the
>> PKS?
> Well I was just thinking that PKRS should only be printed if it's an
> access via a supervisor pte.

That's not *wrong* per se, but it's not what we do for PKU:

        if (cpu_feature_enabled(X86_FEATURE_OSPKE))
                printk("%sPKRU: %08x\n", log_lvl, read_pkru());

If the feature is enabled, we print the register.  We don't try to be
fancy and decide if it's relevant to the oops.  Why don't you just stick
PKRS on the same line as PKRU whenever it's supported?
