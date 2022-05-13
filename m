Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFC5259E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbiEMDFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376689AbiEMDFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:05:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B06297408
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652411128; x=1683947128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RKmc/JYK4Flm5C6llb5dgyed83U7HDxdTph4z1wb4ys=;
  b=JH4CrS7+5FyYahQu73UxUEUJMaV6YQXJWRJOGkSpS+zfPb0GIi2q30hv
   L3BbjFWga+XjQ9dIvAS5Mj8EUKM5fXXlc6pc/EFrF4z4oyx/Ttqq/iy2+
   cFdT5rHEgHMtKx99NHsU/TWhI8xg2UQ8It5Lr7DqIGoeqwRiha2ejwIaU
   V3GH+aP9Tw8+R7TmW4o23FhntSGWWozVEoqRY8hsaI+bEd5BLhiH1RwUe
   eBpe9ix2ZuJuuwZ0/VefozaH6x1zs3ORCSre3bOuof8IZaNIL/r62qMo1
   ayioUNFNX4hgD+Q9DmaNEp2VvTuirlJPZ1MLsqJ8EGMLoQbEmTLiUqIfW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295457225"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="295457225"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:05:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572793934"
Received: from wdwickar-mobl1.amr.corp.intel.com (HELO [10.252.130.245]) ([10.252.130.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:05:27 -0700
Message-ID: <ee786113-2173-b78b-774d-9d61d08b069b@intel.com>
Date:   Thu, 12 May 2022 20:05:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com> <878rr6te6b.ffs@tglx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <878rr6te6b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 18:27, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
>> On 5/12/22 17:08, H.J. Lu wrote:
>> If I had to take a shot at this today, I think I'd opt for:
>>
>> 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
>>
>> although I'm not super confident about the "fuzzy" flag.  I also don't
>> think I'd totally hate the "blind" interface where the kernel just gets
>> to pick unilaterally and takes zero input from userspace.
> That's the only sane choice and you can make it simple for userspace:
> 
>        ret = prctl(GET_XXX_MASK, &mask);
> 
> and then let it decide based on @ret and @mask whether to use it or not.
> 
> But of course nobody thought about this as a generic feature and so we
> have the ARM64 TBI muck as a precedence.

Well, not quite *nobody*:

 https://lore.kernel.org/linux-arm-kernel/7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com/

