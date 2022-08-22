Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75759CB10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiHVVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiHVVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:44:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853B34DB5E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661204661; x=1692740661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I/APJLw3N5Gycwk6ZwEtRyX+OrahnhXskpsQXycDjI8=;
  b=NQspfIUPDAx53hXSA/vaEy9jiKgXQ+Wyy1Dz0fLgyHGT8lgI1J8fh3HB
   qKl0HXYCnebP5NoCvDtESAXE06tCE/Q3iLvzaQzcK9XkY+7J0+J6dFtG0
   0/Fz/FnzBw5W4cljFvPCDXopXpn0ezSVB58W2fpsyJgoFIjhnAppqus5T
   BLBCzfBK/K1NqzIWCeHkm7r/Jx0zwA15iEfJEOyZsnXCD9S/dDFZhN/fI
   YLAduMbP+VlRBaAvhHZ1Jdx1nIa/+ERF5IIQWejlLm4aQ17SFDNWXxt3D
   OcYV7IiksTviahduSWCkzUjG0fpaNk10USSxwRJ2iKyUd7fwWEgLvBCMj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273278557"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="273278557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:44:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751441053"
Received: from jcsarker-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:44:20 -0700
Message-ID: <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
Date:   Mon, 22 Aug 2022 14:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic> <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
 <YwP27a6/9Yq8LBM3@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YwP27a6/9Yq8LBM3@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 14:36, Borislav Petkov wrote:
> Which makes my initial suggestion of calling this whole guest
> functionality a "tdx" driver not such a bad idea... Depends on
> whether there will be a split at all or it'll continue gaining more
> functionality.

Yep, let's get the crystal ball out.

TDX folks:

What other ioctl()s are in the pipeline for the guest side?

What ioctl()s are in the pipeline for the host side?  Are they all part
of /dev/kvm, or are there any TDX-specific "drivers" for the host?

We want to avoid both:

 1. A driver called /dev/tdx (or "tdx-guest) which is only and will only
    ever do TDX guest attestation.
 2. A driver called /dev/tdx-guest-attest which shares a ton of
    functionality with some future TDX guest feature like
    /dev/tdx-guest-snazzy-feature-foo.  Then, a new driver every time
    a new snazzy TDX feature shows up.
