Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2473D4BA475
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiBQPeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:34:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiBQPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:34:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924B2B2C73
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:34:07 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 000831EC054E;
        Thu, 17 Feb 2022 16:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645112042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UOZd9jMSsS6Cmq3P1vAhSIV9RLiEmjv6FMsfKKgwGoY=;
        b=XiPwUs6iuCM8+PoJ/FD1ZF/y/BIViUFUSu9usW084bJIULeg23QTsdbUITKWIodTti6bE7
        jvAfZenBlRr/NJ8dzLBPYqF7QZljQ73bXRBx3Zn/dMjKFTP536xKy0Plup93PFQP2bVoio
        E/cB0PV1Ze960QreE8IcO+Q1c5yqQuA=
Date:   Thu, 17 Feb 2022 16:34:07 +0100
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
Message-ID: <Yg5q742GsjCRHXZL@zn.tnic>
References: <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
 <Yg5nh1RknPRwIrb8@zn.tnic>
 <20220217152613.chm4zh7564ddzijq@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217152613.chm4zh7564ddzijq@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:26:13PM +0300, Kirill A. Shutemov wrote:
> Okay, so on TDX guest side I would have
> 
> arch/x86/kernel/tdx.c => arch/x86/coco/tdx.c

Right, and to answer a previous question: if that file starts becoming
too huge and unwieldy then we should split it, by all means. What I
don't like is getting a bunch of small files with no good reason why.

> arch/x86/kernel/tdcall.S => arch/x86/coco/tdcall.S
> arch/x86/kernel/tdxcall.S => arch/x86/virt/tdxcall.S
> 
> The last one going to be used by TDX host as well to define SEMACALL
> helper.
> 
> Looks good?

Right, that looks neat.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
