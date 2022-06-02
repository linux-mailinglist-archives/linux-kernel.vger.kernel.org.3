Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67153BCC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiFBQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiFBQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:47:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B9E02E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654188458; x=1685724458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A8LiKaAE36i4kEOLQiMiWUcBtJI+3DyK4ToZlO6mza8=;
  b=UhoF05iNsO9QkOdOqI7iWzwUIjI8KysOpMjpY3DcS0Nu00k+K5RY0oCA
   LQ244ZtYfn2aSSg0t06rupIVbrvvdDgTR1jWpCeUMLvbsdzcVJt7Qyki3
   qitv2BMM7fWDNNenTfW2PVF8MScmggksohod4cU6aI3VLJAtB2c6IPPbr
   yvD0r18nv5Gg3iqCJ3a/vhUNLysxpKzvXuw+JYX+WeJzLZoitnNwBk7jj
   udLAgZcHUo3XtQnVBGrPSlZMm91yaJjyWZa/GFDoZqjUGmIFDS5IzKd6P
   xoLgtZcXQlhWhwUWIqcoBF4nQD0s+shdZLlj/FevqwmI/qGHM29/JYvOv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275737502"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275737502"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="577592309"
Received: from bkakkar-mobl1.amr.corp.intel.com (HELO [10.212.249.147]) ([10.212.249.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:47:35 -0700
Message-ID: <1f0fd9f4-295f-6b44-47ff-b6b56892e680@intel.com>
Date:   Thu, 2 Jun 2022 09:47:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Is _PAGE_PROTNONE set only for user mappings?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        akpm@linux-foundation.org, willy@infradead.org
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com> <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com> <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net> <Yn3tssUR8w8mC1DJ@hyeyoo>
 <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
 <YpNLxXvGFQpyPjRa@n2.us-central1-a.c.spheric-algebra-350919.internal>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YpNLxXvGFQpyPjRa@n2.us-central1-a.c.spheric-algebra-350919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/22 03:32, Hyeonggon Yoo wrote:
> On Mon, May 16, 2022 at 07:04:32AM -0700, Dave Hansen wrote:
> Writing code I'm a bit confused:
> commit d1440b23c922d8 ("x86/mm: Factor out pageattr
> _PAGE_GLOBAL setting") says:
> 
> 	"This unconditional setting of _PAGE_GLOBAL is a problem when we have
> 	PTI and non-PTI and we want some areas to have _PAGE_GLOBAL and some
> 	not." 
> 
> Is this this sentence not valid anymore in PTI,
> and just unconditionally setting _PAGE_GLOBAL would be okay in kernel
> side regardless of PTI?

I believe it's still valid.

IIRC, there are three cases:

1. No KPTI.  All kernel mappings are _PAGE_GLOBAL.  Basically, for
   present mappings, if _PAGE_USER is clear, _PAGE_GLOBAL is set.
2. KPTI with PCID hardware support (or in a few other cases): The kernel
   image is mostly non-global.  Anything mapped into userspace *is*
   marked global, like entry text.
3. KPTI without PCIDs: Basically case #2, but with more of the kernel
   image left global.

So, not only are there different KPTI modes, there a different pars of
the kernel that require different _PAGE_GLOBAL behavior.

pti_kernel_image_global_ok() in arch/x86/mm/pti.c explains it pretty well.
