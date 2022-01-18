Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D695A492C05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbiARRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:11:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:13488 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346947AbiARRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642525911; x=1674061911;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2AX5z3CbkJRVb4Ql9dSq/ITQ6aTiN9iCy/YMAWKIyy0=;
  b=aoxbU5kiAqJuqohk/w0l2GyhUXNTb0L12M1XLnvgf3hwZyztDWJnI3rc
   64VKqiyYBPiu3xWRXzqlE7ycOFg2vJaEL+Asx+HesIBSeKF+qvgB0HcfX
   PCa8EdXZAbyPkrlQZ1K8wPTSVShxUnQn+vxNyUX/0bFCEFzhs1ouE5LAg
   0Yt8PD9/r4+iuIbBaYJjL6o3UhYuT1h5OVYE/1y9c9qF2oxzCckAEHke5
   sFvpeUpUS+ZYHVGgrj76tiaEbNVaEROU/xcQifzoxP6XxEzPZ6BDCoGKO
   A5tSKvTPbUjBS0G7kxUP643u6z5/wtsAVseC0atxoYTUkYR4x/i0VqzLl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="242428620"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="242428620"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:11:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="764653361"
Received: from ssrikan2-mobl2.amr.corp.intel.com (HELO [10.209.52.128]) ([10.209.52.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:11:50 -0800
To:     Like Xu <like.xu.linux@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20220117062344.58862-1-likexu@tencent.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
Message-ID: <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
Date:   Tue, 18 Jan 2022 09:11:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220117062344.58862-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What tree is this against?  I see BF16 and INT8 in some old versions of
Chang's patches, but not current kernels.  All I see right now in
tip/master is:

> #define X86_FEATURE_AMX_TILE            (18*32+24) /* AMX tile ...

It's still in the wrong spot, but the other two features aren't there.

> We have defined the word 18 for Intel-defined CPU features from CPUID level> 0x00000007:0 (EDX). Let's move the definitions of X86_FEATURE_AMX_* to
the> right entry to prevent misinterpretation. No functional change
intended.
Please, no "we's" in changelogs.  Don't say, "let's move".  Just say:
"Move..."

The subject could probably also be trimmed a bit.  Perhaps:

	x86/cpu: Move AMX CPU feature defines to correct word location


