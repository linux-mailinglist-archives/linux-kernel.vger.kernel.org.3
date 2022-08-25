Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5FD5A0F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiHYLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHYLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:42:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253209E887
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:42:27 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98f5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98f5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CAC01EC050F;
        Thu, 25 Aug 2022 13:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661427741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vh+yXND8jbqs07msgUgEfuD6EdfdarrOdj9azKZ93v4=;
        b=koVZ3WzX+coXmWuagCZ7A8QrddQqqwpUDOeKr40npBAQboceootNSjcsAzr0pEAXw4lDw9
        5VpOzdHcnyYMY/80uuoArWZA/m195ycE8cDnn4jx/3lRI8xKhJdFycHBSetEeSG/lU+xm0
        vEfnoVvR1SE0PfWH84erqcR76X4O0rQ=
Date:   Thu, 25 Aug 2022 13:42:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 02/10] x86/mtrr: remove unused cyrix_set_all() function
Message-ID: <YwdgGFJWTV1YF3n2@zn.tnic>
References: <20220820092533.29420-1-jgross@suse.com>
 <20220820092533.29420-3-jgross@suse.com>
 <YwdPb4pWqppgzIpm@zn.tnic>
 <aff049cb-ebdd-68ad-5597-d22f87026297@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aff049cb-ebdd-68ad-5597-d22f87026297@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:41:05PM +0200, Juergen Gross wrote:
> Maybe the alternative reasoning is much faster to understand: if the
> Cyrix set_all() could be called, the AMD and Centaur ones would be callable,
> too.

Right.

> Those being called would result in a NULL deref, so why should we keep
> the Cyrix one?

I know you're eager to remove dead code - I'd love that too. But before
we do that, we need to find out whether some Cyrix hw out there would
not need this.

I know, I know, they should've complained by now ... maybe they have but
we haven't heard about it.

What it most likely looks like is that those machines - a commit from
before git

commit 8fbdcb188e31ac901e216b466b97e90e8b057daa
Author: Dave Jones <davej@suse.de>
Date:   Wed Aug 14 21:14:22 2002 -0700

    [PATCH] Modular x86 MTRR driver.

talks about

+/*
+ * On Cyrix 6x86(MX) and M II the ARR3 is special: it has connection
+ * with the SMM (System Management Mode) mode. So we need the following:
+ * Check whether SMI_LOCK (CCR3 bit 0) is set
+ *   if it is set, write a warning message: ARR3 cannot be changed!
+ *     (it cannot be changed until the next processor reset)

which sounds like old rust. And which no one uses or such machines are
long dead already.

Wikipedia says:

https://en.wikipedia.org/wiki/Cyrix_6x86

"The Cyrix 6x86 is a line of sixth-generation, 32-bit x86
microprocessors designed and released by Cyrix in 1995..."

So I'm thinking removing it would be ok...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
