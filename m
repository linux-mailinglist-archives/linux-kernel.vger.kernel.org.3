Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA74FE3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356644AbiDLOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbiDLOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:38:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76A5C37C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649774177; x=1681310177;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=JeWnAqK/BV2obmcOSf5I4zELcee40BbhqGtHiITzWPI=;
  b=Da1QMg4gUMJqKSsYZ8xQhRzAbU4QAlLlF4G+72JLv6sNZQz7ZvVeI+jI
   7dA7AcBvfEBv02X/e70bx2pKvI/Yij62pbdMHl2inji3o6ehYIgmUUogW
   ModD580mUJgCNbLSC5lCzHltV0PxCmGa8lfGVOSXC3Zf3a/3vKmx1CEUP
   p48KNfsvsVSQCFQM8w7+nE7LQyxaHT9nbk43VlRapmo8++OVQbVedlQ8F
   i/LFYDr0zulVUMezZ/EIVZWie7Bf/5cFK6jT83hD7wFXPXIo5nx1Rdkqi
   wrBL5AfcCtJqgoZVs3HRyH4irzY37Ihuqus1Bb12ITjbWnkY+0+v9r/BU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262568887"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262568887"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:36:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551735032"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73]) ([10.209.191.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:36:15 -0700
Message-ID: <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
Date:   Tue, 12 Apr 2022 07:36:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        jean-philippe <jean-philippe@linaro.org>
Cc:     Ravi V Shankar <ravi.v.shankar@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 00:04, zhangfei.gao@foxmail.com wrote:
> master process quit, mmput ->  mm_pasid_drop->ioasid_free
> But this ignore driver's iommu_sva_unbind_device function,
> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So
> driver does not know ioasid is freed.
> 
> Any suggestion?

It sounds like you're saying that the device is still abound to the
PASID even though the mm has exited and freed the PASID.  This is
essentially a use-after-free for the PASID.  Right?

The right thing to do here is to have the PASID code hold a reference on
the mm.  The mm "owns" the PASID for its entire lifetime and if anything
needs the PASID to live longer, its only recourse for doing that is via
an mmget().  I _think_ mmget() is the right thing as opposed to mmgrab()
because the PASID users actually need the page tables to be around.

This would still be nice to confirm with some traces of fork()/exit()
and the iommu_sva_{bind,unbind} and ioasid_{alloc,free} functions.

I wonder if the Intel and ARM IOMMU code differ in the way they keep
references to the mm, or if this affects Intel as well, but we just
haven't tested the code enough.
