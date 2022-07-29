Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20824585168
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiG2OSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiG2OSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:18:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDC79ECC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659104283; x=1690640283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WemGgDS6zuvQ+FbBLR0dwfq/9jtZtc/gA6NP2qy1hE8=;
  b=lT1/N/zvFjjYNaYA6O0NqTfLr36weSNtb9oSnh59IvmnlpfcOl0XvLfI
   ED2UoK1oK33+rVEY64b/su4Yd0odpskhxgXN7itrl3j2NnLVckB3fceLD
   4OGGz4A5X1ZwQMMmB6nwBwRntyL2FKjxO5sXc/FhL7EyHZ+Iuj/eQEFnc
   PbLZd/PlKdgfGPLLX2ep5FfGDhpxQG4vvMjDzrPcZ3sTPeHmHZ03JzW7o
   8yct3js56IHlbhUcY+Z75LX1hxC5GTTjmuD0eCzyi6nqupUEGuKyj3FCC
   ivBHPR1368uvg6XXd8ravE4iup8aiEaxPqQQfNtR5zh80vbxF+SfdcIeT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289973025"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="289973025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="598263734"
Received: from svdas-mobl.amr.corp.intel.com (HELO [10.209.20.175]) ([10.209.20.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:18:02 -0700
Message-ID: <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
Date:   Fri, 29 Jul 2022 07:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 07:01, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c05f0124c410..1f7f6205c4f6 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -104,6 +104,15 @@ struct sev_es_runtime_data {
>  	 * is currently unsupported in SEV-ES guests.
>  	 */
>  	unsigned long dr7;
> +
> +	/*
> +	 * Page State Change structure for use when accepting memory or when
> +	 * changing page state. Interrupts are disabled when using the structure
> +	 * but an NMI could still be raised, so use a flag to indicate when the
> +	 * structure is in use and use the MSR protocol in these cases.
> +	 */
> +	struct snp_psc_desc psc_desc;
> +	bool psc_active;
>  };

This thing:

struct snp_psc_desc {
        struct psc_hdr hdr;
        struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
} __packed;

is 16k, right?  Being per-cpu, this might eat up a MB or two of memory
on a big server?

Considering that runtime acceptance is already single-threaded[1] *and*
there's a fallback method, why not just have a single copy of this
guarded by a single lock?

1.
https://lore.kernel.org/all/20220614120231.48165-10-kirill.shutemov@linux.intel.com/
