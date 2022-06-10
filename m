Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019695466BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbiFJMfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFJMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:35:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BB1AAD8B;
        Fri, 10 Jun 2022 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654864549; x=1686400549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vm6FvkmJGVU3kZjFvEVLAroyVBFPXI97WRUP2X3VzsY=;
  b=cVGaJpaHYhitGAAD7kIxPUwNTmRmhG3ceCTYqw1+CsMAp0Xg5BW18uml
   QKsOlHilwV6qt0EfvRELmCc0XMcLD9qmsr0XcocW/sB+/fW3B4HLbv61i
   aD+a4YVa3s4P5gbNXfKtUNY/3aGwHOOUAdsa9/T7KFLL5EFXsxnjHk0JC
   nknyQCq+QUeN2jSJqmHZsohvYPR0uVwkGx8CCHyOZ0ACmO6g1P1YZaeCw
   B96YvZcfVnaUm8rd/WbIXX274t3KtO7odR2R0u5Hv4WYII+q0RwY+T6pg
   iBaz5YJyLlAPHEIQArzVCoY5ycnMvtP8eeKlkqkhRrG01p5PtkJ3Ln0Kg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277651079"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="277651079"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="684520680"
Received: from elmerred-mobl2.amr.corp.intel.com (HELO [10.251.8.219]) ([10.251.8.219])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:35:29 -0700
Message-ID: <7eb4762e-723b-51e8-3d70-1c28568ac4f5@intel.com>
Date:   Fri, 10 Jun 2022 05:35:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86: Change the return type of acpi_map_cpu2node to void
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, chenhuacai@kernel.org,
        rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        mingo@redhat.com, bp@alien8.de
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220610104423.201739-1-kunyu@nfschina.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220610104423.201739-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 03:44, Li kunyu wrote:
> Reduce eax register calls by removing unused return values.

Please stop sending these patches, at least with these repetitive,
inaccurate descriptions.

This patch has *ZERO* to do with EAX.  For one, it's patching two
architectures that might not even have an EAX.  (I'm blissfully unaware
of what the ia64 calling conventions are and I want to keep it that way.)

Second, (and this is important), look carefully at the function in question:

static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)

See the "static"?  That tells the compiler that acpi_map_cpu2node() is
only used locally.  It lets the compiler do all kinds of fancy things,
like inline the function which allows the compiler to do all kinds of
fun optimizations.  Now, armed with that knowledge, please take a look
at what effect your patch has in practice.

Take your patch, and disassemble acpi_map_cpu() before and after
applying it.  First of all, even before your patch, do you see a:

	call ffffffff81d0000d <acpi_map_cpu2node>

?

Do you see a call to numa_set_node()?  That's odd considering that
acpi_map_cpu() doesn't directly call numa_set_node().  Right?  Do you
see unnecessary manipulation of EAX?  Now, apply your patch.
Disassemble the function again.  What changed?

Now, armed with the knowledge of what your patch actually does to the
code, would you like to try and write a better changelog?  Or, better
yet, maybe it will dissuade you from sending this again.
