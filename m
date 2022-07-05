Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1A567A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiGEWbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGEWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:31:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A217058
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657060299; x=1688596299;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DZzT8f+uQNK5QnEykXG7AbT4bxjb/H97d5ERA9Tt41U=;
  b=ZS26EJXqp5f5L9n8TdQPk7md2O/3vR2yAS+oPAGnmW/SO7P31++cP/ZT
   h1A2FaAU5AVoxpOYXHFjabcd73Fvi+1jUihzd4ivwOmrzWSE9ozd7vIB0
   N3cV+LmHHrNF0RLDmIsHnrAtG6iNLFGWrE00buP3eoRcLBStfqU60joJp
   iDPIP4J5+no9/XLocfrRFHtWqVlWXfwvcuMr39HzjbUfRGyh+vWg1frPV
   dw5MKfn6aPlU0erHOnOq3cxBHNAs5mYNdElvG4S56jafBvqelwuP+Fzu7
   yupXap73PoMgCMs7Zo7TWYChVk/mYGZy/En0wA3e5haEuj2J5OxxtlSLp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281096677"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="281096677"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:31:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="590571865"
Received: from atornero-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.166.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:31:34 -0700
Message-ID: <932869b757b384426ada376cd9791697353c2247.camel@intel.com>
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Jul 2022 10:31:32 +1200
In-Reply-To: <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
         <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
         <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
         <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
         <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
         <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
         <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
         <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 14:21 -0700, Sathyanarayanan Kuppuswamy wrote:
> SGX is a related feature. It also uses IOCTL approach for enclave provisi=
oning.
>=20
> arch/x86/kernel/cpu/sgx/ioctl.c

SGX isn't a good example here.  The IOCTLs are used to create enclaves, but=
 not
for attestation.  SGX attestation relies on enclave itself to get/verify th=
e
report, etc, so has no interaction with the kernel.
