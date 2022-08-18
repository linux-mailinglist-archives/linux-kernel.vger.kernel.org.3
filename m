Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CB59891A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbiHRQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiHRQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:40:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D716BFAB4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660840844; x=1692376844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=llLrcHc/wK3CfmeEcVnkYQChSaB5jpfMLinYxM/52ds=;
  b=hFcBN1VrYHOudZFKwi9iquJO65AzlqyQeOWIS+eklaMwIPjBiY2KZTDh
   Cbd0x3jwX7IaohW+vNGC3VHe6fW0MJHX/jwzk4fzj81VWwMWxnMdgBGfK
   RhML5y/1xI40+YtL9ddvx7e0f9/puqZt/Jnyl1yw5F2yuq4tZlnO+E3th
   pfcK3PnV+Snk2pmwqsOeSoQvVa+ZUmTLfLwRZFtkABtBuVoMAPx4Kd3sD
   kznHD5RxIetYqtjAAvlOgNUkoOJifns2Sxlu9vzeLaJ4IQ0LGA16PptNy
   hNtqBQMz0Bqa3LhqQ3azFxD3gSUpTG2qKc+rMe+Yaw2MsTtsBWVoboHoc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272582263"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="272582263"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 09:39:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853473562"
Received: from amalikya-mobl.amr.corp.intel.com (HELO [10.212.238.171]) ([10.212.238.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 09:39:20 -0700
Message-ID: <8a09b9d5-d5c6-7a1f-1e44-9525b5b18661@intel.com>
Date:   Thu, 18 Aug 2022 09:39:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com> <YvUeB0jc6clz59z5@xz-m1.local>
 <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvqcGq44oonHNyCO@xz-m1.local>
 <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com>
 <E37036E0-566E-40C7-AD15-720CDB003227@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <E37036E0-566E-40C7-AD15-720CDB003227@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 14:03, Nadav Amit wrote:
>>
>> At least on x86, the hardware is not supposed to do so. The only case I
>> remember (and sometimes misremembers) is with KNL erratum, which perhaps
>> needs to be considered:
>>
>> https://lore.kernel.org/all/20160708001911.9A3FD2B6@viggo.jf.intel.com/
> I keep not remembering this erratum correctly. IIRC, the erratum says that
> the access/dirty might be set, but it does not mean that a write is possible
> after the PTE is cleared (i.e., the dirty/access might be set on the
> non-present PTE, but the access itself would fail). So it is not an issue in
> this case - losing A/D would not impact correctness since the access should
> fail.
> 
> Dave Hansen hates when I get confused with this one, but I cc him if he
> wants to confirm.

Right.

The issue is strictly with the page walker setting Accessed/Dirty in a
racy way.  The TLB still has accurate contents at all times.

