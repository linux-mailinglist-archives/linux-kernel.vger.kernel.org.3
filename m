Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6535A4DD107
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiCQXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCQXFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:05:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8F2C2752
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558255; x=1679094255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcx2pvuYRJlbZfM/GWFl8nSn4/vkEAjnqC1ZiKdWoyY=;
  b=VMdMJaudbp00A9afpmeLn7oLhwvLnxKKig+FF23ut+/lqqZzkZopEoFu
   rdv/plc6DMQC5iow8JQE3BPFYbw7Nk747cRCQI7GTwbC1y1rjKxrXrk7W
   i6/lYJ/AaxI38YfV1SJhHQopSxSjcRr0I012BjcKHwW0KUT+qfIEjKXV7
   7b2BH8cEcUfXvAuzCiKNX8IN/tOA79XMG0zEhJHkBiWhAxdszoloqqX0k
   EIhkTvHfuwodjvbbmJPyRb6X7K9rVLUQq8kOjeWrD7+JC+mezsJ1nwePN
   7P+1TJNpzUpRhGnFZsFffCt1NtsKyip+vGoxgI1cBrOn9y5GjV2AW01jp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254558110"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254558110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="558146973"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 16:04:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 62605107; Fri, 18 Mar 2022 01:04:28 +0200 (EET)
Date:   Fri, 18 Mar 2022 02:04:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCHv6 29/30] ACPICA: Avoid cache flush inside virtual machines
Message-ID: <20220317230428.uqfbm6y7v2qbgknn@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
 <f60f4310-8a03-2fdb-d495-be2658f08abe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60f4310-8a03-2fdb-d495-be2658f08abe@intel.com>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:13:18PM -0700, Dave Hansen wrote:
> On 3/15/22 19:08, Kirill A. Shutemov wrote:
> > While running inside virtual machine, the kernel can bypass cache
> > flushing. Changing sleep state in a virtual machine doesn't affect the
> > host system sleep state and cannot lead to data loss.
> > 
> > Before entering sleep states, the ACPI code flushes caches to prevent
> > data loss using the WBINVD instruction.  This mechanism is required on
> > bare metal.
> > 
> > But, any use WBINVD inside of a guest is worthless.  Changing sleep
> > state in a virtual machine doesn't affect the host system sleep state
> > and cannot lead to data loss, so most hypervisors simply ignore it.
> > Despite this, the ACPI code calls WBINVD unconditionally anyway.
> > It's useless, but also normally harmless.
> > 
> > In TDX guests, though, WBINVD stops being harmless; it triggers a
> > virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
> > were left in place, TDX guests would need handling to recover from
> > the exception.
> > 
> > Avoid using WBINVD whenever running under a hypervisor.  This both
> > removes the useless WBINVDs and saves TDX from implementing WBINVD
> > handling.
> 
> Looks good.  Did you have more acks on this earlier that got removed?  I
> thought I remembered more acks on earlier versions.

I missed Dan's Reviewed-by, but it was the only one that got to my inbox.

We had few (actually few too many) different approaches to address WBINVD
and some of them got acks. Dan was the only one who acked this version,
before current submission.

-- 
 Kirill A. Shutemov
