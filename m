Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB557D40B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGUTXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiGUTXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:23:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7288E11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658431384; x=1689967384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u3Up2dozZlzzD/rPJelkCl8XNBwiL6BGYGzTfhZPNcw=;
  b=ObHv58j/XykZeTPUuZNXtOL8d4tbK2UO4nxiSpig8rx5lPufn+ZM5J9F
   osRqZGFgIa+YnASOyx0G0C+shOhxNHMZnkobSVKyjtIbeWT4Qu2YegOhN
   7wl1xkQtIpz6lSF6+RNz9YKMFhGrSCfC6bEjLKe5CEjW+Vi09Ani+tUq1
   VaHAdqQwfi5wYG/7I8+NWmnGfU4ZI+cB/5CxqtCbemD3ppKN/VgpvxJNL
   F3tSo683B3p/3FLoB8OxDEwRBFl1MtFgowC2OHPnhLWIeAgNbSMEBSXVx
   HIoWbX04JgVDbfGhDecpCeC5KoUk9ExaAFxHyWCbAvfbfipYJD1XZhWi9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348853956"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="348853956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 12:23:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573876760"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 12:23:03 -0700
Message-ID: <71f3326d-319b-c78a-345b-499001e766ff@intel.com>
Date:   Thu, 21 Jul 2022 12:23:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
 <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
 <20220721184221.GA3288872@ls.amr.corp.intel.com>
 <1fdecc17-8f4f-fceb-8da0-4a21ca0d58be@intel.com>
 <d0a3d1cc-dfea-0731-c801-97c8eb2cd535@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d0a3d1cc-dfea-0731-c801-97c8eb2cd535@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 11:57, Sathyanarayanan Kuppuswamy wrote:
>> How does the VMM know how much to read/write?  I have a theory: the spec
>> says that R12 is:
>>
>> 	"Shared 4KB GPA as input – the memory contains a
>> 	TDREPORT_STRUCT."
>>
>> That's *A* 4KB GPA.  The maximum is one 4KB page.  That's the only thing
>> that makes sense because there's no length in the ABI anywhere.
>>
>> What am I missing?
> I think you are looking into the old spec. Please check the version
> "FEBRUARY 2022"
> 
> Following are the ABI details:
> 
> R11 - TDG.VP.VMCALL< GetQuote > sub-function per Table 2-3
> R12 - Shared GPA as input – the memory contains a TDREPORT_STRUCT. The
>        same buffer is used as output – the memory contains a TD Quote.
> R13 -  Size of shared GPA. The size must be 4KB-aligned.

Yeah, silly me.  I assumed the ABI was stable and wouldn't be, you know,
adding and removing parameters.

I still don't know how this all works.  You just said:

> Current ABI allows attestation service and agent to decide the quote size. So
> we can't make assumptions on what that size will be.

But, the guest *HAS* to make assumptions, right?  It's allocating the
buffer and handing a pointer and size over to the host.  It's also guest
*userspace*.  In fact, this implementation *ABSOLUTELY* makes
assumptions about the buffer size.

If host userspace some day decides it needs 5MB of space, then all the
guests will just stop working.  This implementation is limited by the
max page allocator size.

This all just seems to work by chance.
