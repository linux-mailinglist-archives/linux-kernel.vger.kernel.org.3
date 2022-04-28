Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51845139EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbiD1Qi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbiD1Qi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:38:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE398888E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651163741; x=1682699741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rcuXjMkF8Ip+u/ASCnj8P5Cfp+tPtitJogFYRQ+vRQI=;
  b=Ieqge3cD1txlnLf43ldDIubkq3I5rjwrXh0jgK7YyJyHvsAI1jDfZhMb
   B/g8OOcOX8JsXYzMXGZqsoP9OFInVCloO3woMy0szNRIC7HyZrQAtly7d
   I4P4+tTiFZz9WQN50z2U0AJmtyzGmfTUi/C9jZdyzdMoFOJHlZvX/2SOs
   epcQLkuctpf/ue2YFZ8v4LBiG2cZ3yTFCm8jKzITGi+ONs9asmtNdRswT
   f8WZZpUFilrhY/95uUcVtc5OGOZHE1Xhrh2nymVLUDqu+gDGY704fQ4TC
   xWhPEmRAhNoVrOvQONH8CvpJUino1xuTAUgtVsPm3aIE5vJJtBLcvd+os
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266160097"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266160097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="559761235"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84]) ([10.212.0.84])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:35:22 -0700
Message-ID: <7ad996df-28ca-0aee-be23-e75bcca8d136@intel.com>
Date:   Thu, 28 Apr 2022 09:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com> <Ymq6aZCTdrOE60cn@myrica>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ymq6aZCTdrOE60cn@myrica>
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

On 4/28/22 09:01, Jean-Philippe Brucker wrote:
>> But, this misses an important point: even after the address space is
>> gone, the PASID will still be programmed into a device.  Device drivers
>> might, for instance, still need to flush operations that are outstanding
>> and need to use that PASID.  They do this at ->release() time.
> It's not really clear which release() this is. For us it's file descriptor
> release() (not MMU notifier release(), which is how I initially understood
> this sentence)

OK, maybe that should be: "file->release() time" to make it more clear.
