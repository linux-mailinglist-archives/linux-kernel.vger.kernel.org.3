Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548BA4AF111
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiBIMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiBIMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:08:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08AC1038F9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:08:28 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 642871EC054C;
        Wed,  9 Feb 2022 12:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644404903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pVcoJQ/L7RiOQPedz5rtS/XCcY9bKSouDnzYyJVnx+g=;
        b=KakI3FTHRBi2wWdT4ywv0hUY8EiMiVB6Y8Z44UN5uLAKa2ObPNrrX4+GOEQLtxUVxC2Pqc
        eoVf447+EME7R4flp+4zN6lXlRJWUHY6DWd1RzJECk4bm1XTLakHIJIUPZA3l6AHTwwoBP
        r8dle9NOW6IMap175a8HVjm2/gU1TgQ=
Date:   Wed, 9 Feb 2022 12:08:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgOgog9Pb886lfsv@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209235613.652f5720cd196331d7a220ec@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:56:13PM +1300, Kai Huang wrote:
> TDX host support basically does detection of SEAM, TDX KeyIDs, P-SEAMLDR and
> initialize the TDX module, so likely TDX host support will introduce couple of
> new files to do above things respectively,

Why a couple of new files? How much code is that?

> and the majority of the code could be self-contained under some
> directory (currently under arch/x86/kernel/cpu/tdx/, but can be
> changed of course). Could we have some suggestions on how to organize?

So we slowly try to move stuff away from arch/x86/kernel/ as that is a
dumping ground for everything and everything there is "kernel" so that
part of the path is kinda redundant.

That's why, for example, we stuck the entry code under arch/x86/entry/.

I'm thinking long term we probably should stick all confidentail
computing stuff under its own folder:

arch/x86/coco/

for example. The "coco" being COnfidential COmputing, for lack of a
better idea.

And there you'll have

arch/x86/coco/tdx and
arch/x86/coco/sev

where to we'll start migrating the AMD stuff eventually too.

Methinks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
