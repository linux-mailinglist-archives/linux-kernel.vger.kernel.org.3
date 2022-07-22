Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1757D7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiGVA1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGVA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:27:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD845774B2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658449630; x=1689985630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KpOG3xChQMGkM+hjSuhe3p8uiRSinY0Gs4eKNQtoQxI=;
  b=ktEGxhlysI/NV+zNmYNS7N6Fn6rPpPvzXzmYS5dmqj0fhB39cx8zuDZ+
   rEJJ4SvpS75QE3IrVR54IDdY0cXfHwud9+N+NjAPHCmwH3serf0PfV2Xy
   8WPVnR7yUCuwKLkYkzSR6jQx6eWVVNchFseAf1LM5KjDMXyU90Uh2Kgbz
   pCquEnL01zRsaBnfoDqgGvHhqnYjrA/7FF2mlXzN7/BOfBLNhJ4WTfmW0
   GsOTkMUwGzsbI/Eh0w6iVWa+1jyeeIVLJrKOp5sZCZNpj6pw/qp6IbRzo
   v5hNR4B8tJwBxjUaWfKbqcl9vnfKKLCAEdyzSTEyFVSHH2jNX7WceMDjr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266977459"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="266977459"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:27:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="573964506"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:27:08 -0700
Message-ID: <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
Date:   Thu, 21 Jul 2022 17:27:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, the second stage in attestation process is to send the
> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
> not support communication channels like vsock or TCP/IP, implement
> support to get TD Quote using hypercall. GetQuote hypercall can be used
> by the TD guest to request VMM facilitate the Quote generation via
> QE/QGS. More details about GetQuote hypercall can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> titled "TDG.VP.VMCALL<GetQuote>.

So, the quote portion of this is basically a bidirectional blob sender.
 It's to send a blob between guest userspace to host userspace.

Do we *REALLY* need specific driver functionality for this?  For
instance, is there no existing virtio device that can send blobs back
and forth?
