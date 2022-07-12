Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCD570F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiGLBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiGLBjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:39:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343230F69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657589952; x=1689125952;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CkXhM9uVu0VJKKvs+R6HCnd+Wqoswxx0eolYOc5vPDg=;
  b=EHH1s1t6lw2FDkLt7hjDLGfms9D4to8WCEUwL6UB1XxkRSja9o9mSA5c
   eoKo2qvdBQY/gMjif/GuKMjAyoWO+OWUj/n+HfPANNPxwZ9OTnlUFk/S6
   CANw1qSU/ZMwfF+rxAKS0Fitcm/XCCGxc8nZo3IpfIQLBbYMHSy6KNjFK
   L/5rZxNHUnM1lYCeqaKkVJLNRY/6bP/u8Khe9NEtmD4uGNsX4viR/n53X
   qDccnjPZ109TOZJGwDAS8gWRQh9Me4VX/bSCBanZ4geSAW4jOmmk6Bs1p
   E8vMKmGCb1j5P2l5jixi6fucKWeueUQ7cZ1fMvs61T5ATjuw6D6Ak56Gr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264602390"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264602390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:39:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="622312038"
Received: from snaskant-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.60.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:39:09 -0700
Message-ID: <07ff13d590cf290a14232fb113ff4183a6fa352d.camel@intel.com>
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
From:   Kai Huang <kai.huang@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com
Date:   Tue, 12 Jul 2022 13:39:06 +1200
In-Reply-To: <YszFkTZ7RtXS1rd7@google.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
         <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
         <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
         <YsxZKGxVUY61zPEt@google.com>
         <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
         <YszFkTZ7RtXS1rd7@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> > This patch basically tries to fix the issue that TME flag isn't cleared=
 when TME
> > is disabled by BIOS.  And fir this purpose, the code change in this pat=
ch looks
> > reasonable to me.  Unless I am mistaken, detect_tme() will be called fo=
r all
> > cpus if TME is supported in CPUID but isn't enabled by BIOS (either LOC=
KED or
> > ENABLED bit isn't set).
>=20
> But this patch doesn't handle the bypass bit, which _does_ effectively di=
sable
> TME when set.  E.g. the MKTME spec says:
>=20
>  Software must inspect the Hardware Encryption Enable (bit 1) and TME Enc=
ryption
>  Bypass Enable (bit 31) to determine if TME encryption is enabled.

Yeah so my original reply said:

"But perhaps it's arguable whether we can also clear TME flag in this case.=
"

And I only gave my Acked-by.

It completely depends on the purpose of this patch, or what does this patch
claim to do.  If it only claims to clear TME bit if BIOS doesn't enable it,=
 then
looks fine to me.  If it wants to achieve "clear TME feature flag if encryp=
tion
isn't active", then yes you are right. =C2=A0

But as I said perhaps "whether we should clear TME flag when bypass is enab=
led"
is arguable.  After all, what does TME flag in /proc/cpuinfo imply?
