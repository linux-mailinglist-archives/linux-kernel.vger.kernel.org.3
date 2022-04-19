Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9F507D03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbiDSXFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiDSXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:05:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C324F38;
        Tue, 19 Apr 2022 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650409371; x=1681945371;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLC0T6kqi1/zOVAyrMi+mXunlB8no/BrDd00I42Lbds=;
  b=E2M7uuqD7oX4HBlz1+/vJ6EC7fZ7XeIUzUsRWQPSWfTRAS7ioc88R5OZ
   rjSSzjNo3boKyZmrK9mJ1JuPvoS+vPt5nhW6eKWOTTOhgxrZsVV8X0vn2
   wCgZefqdHkw0z0T74s/6qhMFMKf2NPSmv2UJ9x+7w64wNnlsRL+eTeKSS
   3eR6VHm6mwBNuTi8ohQXZAu5xt9jgvM+NtZN3jmRxYKSnNohwGT4YiWpr
   TgdEnUlFyLNnfVlMfZEF9y5Vvp5Wzpqc7g1SkOJzmamD5QyCI13DR6FIl
   oiSc8Z1aZUiWE38v6yNqN6YyII0hQAwqUklvVxW5wXN8Gav7pVNK/C1u2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251198994"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="251198994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="667183262"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.15])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:02:46 -0700
Message-ID: <79119cc04552617ad462d314dcd8bdbec90a1b20.camel@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Date:   Wed, 20 Apr 2022 11:02:44 +1200
In-Reply-To: <ec60ed6f-eafc-80eb-affc-3102c5dc3165@intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
         <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
         <f40fe89d9b978d525ed5d56b0679d1c20b10864b.camel@intel.com>
         <ec60ed6f-eafc-80eb-affc-3102c5dc3165@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 15:49 -0700, Dave Hansen wrote:
> On 4/19/22 15:21, Kai Huang wrote:
> > On Tue, 2022-04-19 at 07:13 -0700, Dave Hansen wrote:
> > > On 4/19/22 00:47, Kai Huang wrote:
> > > > > From security's perspective, attestation is an essential part of TDX.  That
> > > > being said, w/o attestation support in TD guest, I guess nobody will seriously
> > > > use TD guest.
> > > Are you saying you can't think of a single threat model where there's a
> > > benefit to running a TDX guest without attestation?  Will TDX only be
> > > used in environments where secrets are provisioned to guests on the
> > > basis of attestation?
> > > 
> > I don't think anyone should provision secret to a TD before it get attested that
> > it is a genuine TD that he/she expected.  If someone does that, he/she takes the
> > risk of losing the secret.  Of course if someone just want to try a TD then w/o
> > attestation is totally fine.
> 
> Yeah, but you said:
> 
> 	w/o attestation support in TD guest, I guess nobody will
> 	seriously use TD guest.
> 
> I'm trying to get to the bottom of that.  That's a much more broad
> statement than something about when it's safe to deploy secrets.
> 
> There are lots of secrets deployed in (serious) VMs today.  There are
> lots of secrets deployed in (serious) SEV VMs that don't have
> attestation.  Yet, the world somehow hasn't come crashing down.
> 
> I think it's crazy to say that nobody will deploy secrets to TDX VMs
> without attestation.  I think it's a step father into crazy land to say
> that no one will "seriously" use TDX guests without attestation.
> 
> Let's be honest about this and not live in some fantasy world, please.

OK agree.  No argument about this.


-- 
Thanks,
-Kai


