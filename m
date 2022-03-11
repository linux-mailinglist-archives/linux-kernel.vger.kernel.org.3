Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EB4D677B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbiCKRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350678AbiCKRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:23:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F45112A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647019354; x=1678555354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G8bJh+8Vok15nE7dEaU6t77F8wutWwiQPFPCIa6xWJg=;
  b=O0U2Hp0CSDQg7zCPB7OhtQbomKjVe7hyjRRJ3lNxujCLQYHYZYpytUnB
   7T8vLJ2mbkYJm7rPbyQ95KoyXw8xmBDd7K+gW47wPqCQvZpbzUNFz+vsK
   bBDad/7fBWdf5b5z7ynJNBXE4pt+S5sKOQtch41/Y5BcSKcdTNjCUB6yv
   2bE3dSJ+8StXwqGWIq203gxVPUN1kGfqBGRhW2SthHKWkODA1rCSe4FPJ
   HUAOeU6F8ClW8roesi4Ra+mkdx71ZTGIzrilcgf+Ae+1/6BHns33ZXh5u
   HYDE8Q0ZjyP1ySYd5bTH66q5i7dMsLHGvVzh6k69/5KkfIB6aC/zrXoEz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255803344"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255803344"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:22:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="644991411"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:22:32 -0800
Message-ID: <9fcfa987-4acf-689e-3fea-fd01dc7b4e26@intel.com>
Date:   Fri, 11 Mar 2022 09:22:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
 <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
 <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
 <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
 <9b2836ce-5267-8342-65eb-1084ba7e0cdf@intel.com>
 <20220311171848.g5wobw3rmi4e2zkd@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220311171848.g5wobw3rmi4e2zkd@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 09:18, Kirill A. Shutemov wrote:
>> Do we *WANT* #VE's to be exposed to the #GP fixup machinery?
> We need the fixup at least for MSRs.

Could you mention that, along with the implications for the other #VE's
in the MSR patch changelog?
