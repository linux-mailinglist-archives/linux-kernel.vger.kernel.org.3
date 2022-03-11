Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A934D66D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiCKQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCKQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:52:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6BD31FD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647017477; x=1678553477;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=K0UqcHvbTRf6joZBkaiWA4uWSixwGJw8D96064Fe918=;
  b=PAOB4W6IbBOZSmFC+a+2r8SjcZYHZNRt8pI4ffXu5FkvI5iOgylfVlSP
   XJIiLm7/9AenaA/OXOrgVDawlZJQtmxv23CkLKn4UhPTxnPMhl0y4JI+R
   ftSz4XVoCDsmikyy6Jn4cTuNYAYvlbxHGQLpuPwuK8Fe0Aa9fCijF1Kqf
   Tk+dOh0Bs3354RkbQfNxYsoH6Q15Uaa8yB5nlAcZxA02VusBYbczQf2vd
   CaW8vrGX19Yg8RY+SaZg1qlBdkAA+/Z1cxcbeh/ivq3g6mAL2lxIl3Blz
   F6Bq3NjnLe8i7jx5Te1x3dPzQJX6N0SFrQwCvyvaEvzpQQWg840L6zNJ4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="243054352"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="243054352"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:51:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="644982258"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:51:17 -0800
Message-ID: <cc8df752-e92d-3848-8130-d3c48f5a4302@intel.com>
Date:   Fri, 11 Mar 2022 08:51:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Bharata B Rao' <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
 <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
 <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
 <15fb8774026b4350b2653ce119c85820@AcuMS.aculab.com>
 <363b91f7-a1d7-b5b5-de86-40bcf61ef818@amd.com>
 <6191fb9390a9458ca75b73798c3b6d74@AcuMS.aculab.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <6191fb9390a9458ca75b73798c3b6d74@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 01:36, David Laight wrote:
> Wikipedia also notes:
>     Intel has implemented a scheme with a 5-level page table, which allows
>     Intel 64 processors to support a 57-bit virtual address space.
>     Further extensions may allow full 64-bit virtual address space and
>     physical memory by expanding the page table entry size to 128-bit,
>     and reduce page walks in the 5-level hierarchy by using a larger 64 KiB
>     page allocation size that still supports 4 KiB page operations for
>     backward compatibility.
> If they implement 64K pages then you lose the extra bits.

I can't believe I need to say this:  Wikipedia is not an authoritative
source about what anyone is going to do with their CPUs in the future.
Please don't base any Linux decisions off this information.
