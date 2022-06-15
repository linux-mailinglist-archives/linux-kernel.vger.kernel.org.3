Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8754D4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiFOWnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFOWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:43:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DC3B3E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655332983; x=1686868983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOkKIF1zj4v3HvWCe1Wl62pksKaDezBETS9z2NLNPsw=;
  b=dpSO5bwBCez9tzCVvujrP//3OAFBjTUB7739GI0erLcboqdmjLlnwmBD
   +0o4+XUjAdCtpv1WtxddWv9erwP9MI+IerP/UAhYAdFlMQ4ls4iSGDqgz
   Zgskd/s8BXRF13MDxenibpN1tmDfVDVkh3CuekCI2MPOhRybDjKicHcc0
   AV3IScUZDcSXrCLMjsGBzeZifJTr35aWZs0KJeCt+ooq4qxdeeJeKWEyK
   uabsyn3UpzGm8N3g/3XGi8YHiKv0316j4XwPKJt8c0i99D4UfBHur8ex4
   u7mDni0GLXgsD89BTTeb/6Udn/9Qx/HpUoS2q+kKohBPT2Vxt+T3VJBLO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304554766"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="304554766"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618667193"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2022 15:42:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BA860109; Thu, 16 Jun 2022 01:43:03 +0300 (EEST)
Date:   Thu, 16 Jun 2022 01:43:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615224303.el4qtowheu2rgpdn@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
 <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
 <1d190555-2bb1-e483-2405-e28ddabead07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d190555-2bb1-e483-2405-e28ddabead07@intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:55:13PM -0700, Dave Hansen wrote:
> On 6/15/22 10:10, Kirill A. Shutemov wrote:
> >> I thought this whole exercise was kicked off by hitting this in testing.
> >>  Am I remembering this wrong?
> >>
> >>> https://lore.kernel.org/all/20220517153444.11195-10-kirill.shutemov@linux.intel.com/
> >> Says:
> >>
> >>> This is an actual, real-world problem which was discovered during TDX
> >>> testing.
> >> Or were you considering this a different problem somehow?
> > They are different.
> > 
> > The patch by the link addresses issue of load_unaligned_zeropad() stepping
> > onto unaccepted memory. This was triggered in practice.
> 
> OK, so we've got two problems both triggered by
> load_unaligned_zeropad(), but where the fixes are different.  We
> actually hit the "unaccepted memory one" in testing, but that made us
> think about other problems in the area and that's where this one came up.

I will reword it like this:

	The issue was discovered by analysis after triggering other issue with
	load_unaligned_zeropad().

Works for you?

-- 
 Kirill A. Shutemov
