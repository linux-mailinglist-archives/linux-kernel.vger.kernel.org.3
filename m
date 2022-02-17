Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBEA4BA425
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbiBQPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:19:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:19:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246801CC298
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:19:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E3651EC054E;
        Thu, 17 Feb 2022 16:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645111173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i8K4bncMAPh3ow4byvYa0pYHk/tWxBeg+lOHsR6HPjM=;
        b=fRgZO4gvTL7myuSQ6ro1Jnc5pmv4eRv0RftZqIh/Rn+WXw5M8XkCiNXXcbZsQkcv9SsHID
        KCJwpmJeI02R7RP9tqe9Nm8tmOizgCk+J/YKhb0iiHduxDcyuAmvOnlkVKt4a1zFtryz5p
        k312dhsB/cZ+eUAT3a9VTzsaTWJJ/Ik=
Date:   Thu, 17 Feb 2022 16:19:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <Yg5nh1RknPRwIrb8@zn.tnic>
References: <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 06:48:09PM +0300, Kirill A. Shutemov wrote:
> So, any conclusion?

Lemme type the whole thing here again so that we have it all summed up
in one place - I think we all agree by now:

- confidential computing guest stuff: arch/x86/coco/{sev,tdx}
- generic host virtualization stuff: arch/x86/virt/
- coco host stuff: arch/x86/virt/vmx/{tdx,vmx}.c and arch/x86/virt/svm/sev*.c

New stuff goes to the new paths - i.e., TDX guest, host, etc - old stuff
- AMD SEV/SNP will get moved gradually so that development doesn't get
disrupted. Or we can do a flag day, right before -rc1 or so, and move it
all so in one go. We'll see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
