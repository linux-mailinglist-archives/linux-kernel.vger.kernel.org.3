Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC64506F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbiDSOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351450AbiDSOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:02:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440812A8E;
        Tue, 19 Apr 2022 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650376804; x=1681912804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aTbcgLlOaDyWww67qnVCIOb5s5dgXZijpchtigKlbp4=;
  b=L/fuIahuX1Xi1EqnKk1509+/8cbJIxsBCOut0t4COgxaBKIc/F+QOp+c
   KNoxnzmE3Y3gp7O9/9XzXEjB3azCoIp335QCR7qKryjGekO382yLIVM4k
   rsFtRx58o72ukt6MdCWq3kztqHu01mU9hSxmcB1Hm1rM3yeUIzCoc2nXu
   12eBUwNyVW9tlQMdgyqNTSlsWrnkVMOfLD0SWkLDO5VwnGvQOduCDxe4o
   eAreE9UuAWI3uggeWAIldY16i/l1fpmN5lzdAJL3XRpn+n9mYBfQPJtQu
   vnSlrpIh+9cyeQyBfiy4zKy+Xr3BtlvxCQ9Wc8c6Rc4YK/bjbAhHVPgJX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324212414"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="324212414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:00:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554739523"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:00:04 -0700
Message-ID: <07ef65c4-708e-1bcf-9a7e-f804acefcc7c@linux.intel.com>
Date:   Tue, 19 Apr 2022 07:00:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <0d532b0ce1155bf7778366b14c5d1311c45fef01.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <0d532b0ce1155bf7778366b14c5d1311c45fef01.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 1:16 AM, Kai Huang wrote:
> In fact after slightly thinking more, I think you can split TDREPORT TDCALL
> support with GetQuote/SetupEventNotifyInterrupt support.  The reason is as I
> said, GetQuote isn't mandatory to support attestation.  TD attestation agent can
> use i.e. vsock, tcp/ip, to communicate to QE directly.  Whether kernel needs to
> support GetQuote is actually arguable.

IMO, we should not use a usage model to categorize "GetQuote" support
as a mandatory or non-mandatory requirement.

For customers who use VSOCK, they can get away without GetQuote
TDVMCALL support. But for customers who do not want to use
VSOCK model, this is a required support. AFAIK, our current customer
requirement is to use TDVMCALL approach for attestation support.

If your suggestion is to split GetQuote support as separate
patch to make it easier for review, I am fine with such
suggestion.

Maintainers, any opinion? Would you prefer to split the
driver into two patches?


> 
> So IMHO you can split this attestation driver into two parts:
> 
> 1) A "basic" driver which supports reporting TDREPORT to userspace
> 2) Additional support of GetQuote/SetupEventNotifyInterrupt.
> 
> The 1) can even be in a single patch (I guess it won't be complicated).  It is
> easy to review (and i.e. can be merged separately), and with it, you will
> immediately have one way to support attestation.
> 
> 2) can be reviewed separately, perhaps with one additional Kconfig option (i.e.
> CONFIG_INTEL_TDX_ATTESTATION_GET_QUOTE).  I think this part has most of the


GetQuote IOCTL support is a very simple feature support, so, IMO, we
don't need to complicate it with additional config.

> complexity things in terms of review.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
