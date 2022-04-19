Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED1507C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357768AbiDSWYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDSWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:24:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D39722BE7;
        Tue, 19 Apr 2022 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650406922; x=1681942922;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FPoGNOFLlOXDs/xu3hONgTHzwKlS/vbPKmpCE0gDjo=;
  b=HnWtQxI0xa8kEbGSLMjLYMwO1/Sk+XoD9m9VfiV0dQH+gUndEVooD5dG
   KTI1ony/8LY7K1OEuaVUIxukdU/I3PuFDB2puJ0Ij2rDahI0W9a0nlL/L
   jnoV4F9D/taV9eRoDbPBTHAvQBRMtcvihlMX2Xi1TeH+olCWEqYW1BADj
   FUYnRS+L4OX0abGTn483wKveHwF2DM+P6KXNMReoEZJ8X+b9bYGWLHQ1b
   5uU9tHibQ9mWepblGOjpsbZo0QwmW6+zvQYPA3+8zW8bnxj97iUHEmZCy
   qyCnbnOOPuqUxQluq5hxVwMebIzYmt2Kvq2QvQiURxloWNJC+GNwk1NIJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264058068"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="264058068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:22:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554918565"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.15])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:21:57 -0700
Message-ID: <f40fe89d9b978d525ed5d56b0679d1c20b10864b.camel@intel.com>
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
Date:   Wed, 20 Apr 2022 10:21:55 +1200
In-Reply-To: <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
         <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 07:13 -0700, Dave Hansen wrote:
> On 4/19/22 00:47, Kai Huang wrote:
> > > From security's perspective, attestation is an essential part of TDX.  That
> > being said, w/o attestation support in TD guest, I guess nobody will seriously
> > use TD guest.
> 
> Are you saying you can't think of a single threat model where there's a
> benefit to running a TDX guest without attestation?  Will TDX only be
> used in environments where secrets are provisioned to guests on the
> basis of attestation?
> 
> > 

I don't think anyone should provision secret to a TD before it get attested that
it is a genuine TD that he/she expected.  If someone does that, he/she takes the
risk of losing the secret.  Of course if someone just want to try a TD then w/o
attestation is totally fine.

-- 
Thanks,
-Kai


