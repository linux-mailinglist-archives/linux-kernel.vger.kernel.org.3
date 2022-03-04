Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9254CD86E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiCDQDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiCDQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:03:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E53F23E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:02:34 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-252-111.2.247.pool.telefonica.de [2.247.252.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08B7B1EC0453;
        Fri,  4 Mar 2022 17:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646409749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PQSe/WuToPxitH0j2JuHjLkBHngDYdnMJimKK+BmX9I=;
        b=m/xI4bPX/4sYco1edwOAEOGAc8zNx9hU+HY4zzZTvSAKggyrpZAqE0GfBUeKxrSyeETwln
        rl5RXzmJUX06p/x/fkaieX6OBJPIlaPD82p2j2IHgug0HMRPl3wJxHdlWYKe63Dm7z4RXn
        LjvqvgesmSw8FOCkAKZEgrj/qE68Dy0=
Date:   Fri, 4 Mar 2022 17:02:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv5 01/30] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <YiI4GXQt5YOXr4qW@nazgul.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-2-kirill.shutemov@linux.intel.com>
 <YiIzgg3Ql81He0X9@nazgul.tnic>
 <4de457b3-eec9-5415-7e7f-0d5abd4ca08b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4de457b3-eec9-5415-7e7f-0d5abd4ca08b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:47:37AM -0800, Dave Hansen wrote:
> Pure reviewer paranoia. :)
> 
>   https://lore.kernel.org/all/YhN5edJQ+LkVc0us@grain/

This is one of those things where when you look at them months, years
from now, you'd go "WTF was that added for?". Because it clearly is
there to catch, well, something you'll catch anyway in testing. Because
if you fail detecting you're running as a TDX guest, you'll know pretty
early about it.

So if it is pure paranoia, you should drop it. Or if there's at least
some merit for it being there, then slap a comment above it why that
check is happening.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
