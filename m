Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074A4BA445
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiBQPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:24:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbiBQPYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:24:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C42B0B2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:24:04 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73E411EC054E;
        Thu, 17 Feb 2022 16:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645111439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vxtl5Qfckm7wf75ytDBuGeQbcw5DoZ2bN0ho+rxm0YE=;
        b=g8EDvadqROvjBUDOPX2RSRQ6jKFOsZIe5OGEygGD5FzWSnaJddx5qpktQYX3gL60Xxn98x
        4iwG475gMn9XxhmzZ+jw0ptpKOztFYRQHwuoExF3dh9Iakjbr1ikXG92IF/y6xN1XUDd1M
        +AtahF6T01dyGO+Pdu8lVJtEYJ6KD+0=
Date:   Thu, 17 Feb 2022 16:24:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <Yg5olU6u6jmPRmrR@zn.tnic>
References: <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
 <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
 <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
 <20220215173321.lwvfl6rxifrkcoit@black.fi.intel.com>
 <YgzKymHnbAUAVSMT@zn.tnic>
 <20220216153703.42wnvgxcvshgpkj2@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216153703.42wnvgxcvshgpkj2@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 06:37:03PM +0300, Kirill A. Shutemov wrote:
> 	bool cc_platform_has(enum cc_attr attr)
> 	{
> 		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> 			return intel_cc_platform_has(attr);
> 		else if (cc_mask)
> 			return amd_cc_platform_has(attr);

It is exactly stuff like that I'd like to avoid because that is
dependent on the order the test happens.

It would be a lot more robust if this did:

	switch (cc_vendor) {
	case INTEL:  return intel_cc_platform_has(attr);
	case AMD:    return amd_cc_platform_has(attr);
	case HYPERV: return hyperv_cc_platform_has(attr);
	default: return false;
	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
