Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A850E4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiDYP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243054AbiDYP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:56:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78045ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650902032; x=1682438032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OgI7VQnUPjqMWNGxE5sNT1Rye9YtELUHcykl0maLGbY=;
  b=Bh30bf/fA29fkTaIvRzGNYDS93Qo9O+z3OiwjJ6OP53sNdRd6tvtHEwS
   Y+nJ/GT4DhE6dFBEgjq+Tgvv4chDC8jkfZSvvrHeV+jJi9wTuIL4bRx8a
   +V8A7hWt2BoiXbV871HeIJMBqKPM4eLcjOMeaGu1LE0V0LqLfjopwT8D+
   I1sHDChx9JKYakzrk3Au1QtzddQLFWotwj4jvzar00IWgeOuf6G1LUxqA
   fLzXlTsnm/bWLsXN6pJTkvYuYiel+Kgbua45cn5rTLOYc8E1EwFAmTsuS
   vljzLDZBk2h97DBX/Cmx6876IyBkMyd1QLPrC6PJ+/DHXHFzhBMihciPM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="262883593"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="262883593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:53:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="595294518"
Received: from bjkrist-mobl.amr.corp.intel.com (HELO [10.212.88.70]) ([10.212.88.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:53:50 -0700
Message-ID: <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
Date:   Mon, 25 Apr 2022 08:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
References: <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmavoKkVu+hd+x0M@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 07:26, Jean-Philippe Brucker wrote:
>>
>> How does the IOMMU hardware know that all activity to a given PASID is
>> finished?  That activity should, today, be independent of an mm or a
>> fd's lifetime.
> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> queue calls iommu_sva_bind_device(), which sets up the PASID context in
> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> destroys the PASID context (after the device driver stopped all DMA for
> this PASID).

Could this PASID context destruction move from being "fd-based" to
happening under mm_pasid_drop()?  Logically, it seems like that should
work because mm_pasid_drop() happens after exit_mmap() where the VMAs
(which hold references to 'struct file' via vma->vm_file) are torn down.
