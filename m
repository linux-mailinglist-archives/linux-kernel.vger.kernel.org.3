Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32414DC92E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiCQOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiCQOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:48:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472A2016B0;
        Thu, 17 Mar 2022 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647528461; x=1679064461;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=UZap/b0SYrOdXDP0hhu1xHuutZyUBeA2EnD7XmyjMwQ=;
  b=TU6M44X6GUEv/0pUrbPjRhwZKkdjetXbMx+CoierGZ+t3nuu/6lTLlKW
   vXNP8SUBChNuLdW9OKaZ2BqLdRRCCZ5wchYF7JeF0oIA6ZNq9YbO8yk4v
   8B8/vSiQFPzI/pjxNTK4Bl8LzkS8yZkanF0AC4iLuipBWG4C+1u6jvt1c
   kDRXMswZE7k0k2udarczaaZit4O5tDR9BtK8lg3H+XwEJmSUKe4PQxNDs
   D232WCIomDp9fs6mmrjs3vb7GRMMPzv4sj5f4Cv28fd1K4tHOOsV4GCfM
   HRC3VPGvmxlLZS9zhOxajiP+tPtE+wjhIK/oiqvhT/GEU/ARs6JBToty8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281671973"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281671973"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:47:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557958937"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.39.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Mar 2022 07:47:38 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nathaniel@profian.com
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
References: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com> <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net> <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi> <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <Yi6tPLLt9Q+ailQ3@iki.fi> <Yi6tinbF+Y7a66eQ@iki.fi> <Yi6va4dCaljiQ1WQ@iki.fi> <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net> <YjK7BppjPCio0xv7@iki.fi>
Date:   Thu, 17 Mar 2022 09:47:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1i6jdmnqwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YjK7BppjPCio0xv7@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 23:37:26 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon, Mar 14, 2022 at 10:39:36AM -0500, Haitao Huang wrote:
>> I also see this model as consistent to what kernel does for regular  
>> memory
>> mappings: adding physical pages on #PF or pre-fault and changing PTE
>> permissions only after mprotect is called.
>
> And you were against this in EAUG's case. As in the EAUG's case
> EMODPR could be done as part of the mprotect() flow.
>

I preferred not automatic/unconditional EAUG during mmap.
Here I think automatic/unconditional EMODPR(PROT_READ) on #PF would not  
work for all cases. See my reply to your other email.

Thanks
Haitao
