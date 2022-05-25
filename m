Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7902E53377D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbiEYHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbiEYHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:37:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B555F8DA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:37:21 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07E8A1EC026E;
        Wed, 25 May 2022 09:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653464235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8u5f+st9be8iJPgGCFOASHddewdsOrOCFvjK4bbUSVU=;
        b=ctaPw7KVSiAvPMgNMRyeGT7aSyjB31H3tD1si+l+fG7o/4TqeFxReX/mAFe2PmB/VcYDIq
        o1GJ+LJ3gk3lpWNX1XiTEMqxf1L5YjGL604Sl91Yo+EIsdrCKZJEQqQAyqaXdw8qKux2bO
        M83x+KxaJr1qKBkEtR4zLtF4FZqQ1YM=
Date:   Wed, 25 May 2022 09:37:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Message-ID: <Yo3cpb1yZhwhHEga@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525065940.GF2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:59:40AM +0200, Peter Zijlstra wrote:
> On Tue, May 24, 2022 at 06:03:04PM -0700, Luck, Tony wrote:
> > On Tue, May 24, 2022 at 08:53:24PM +0200, Borislav Petkov wrote:
> > > +	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> > 
> > Seems harsh. Updating microcode to the latest is arguably the
> > way to make sure that your CPU stays "IN_SPEC" (since the microcode
> > may have a fix for a functional issue).
> 
> Then use early loading. There's too many fails associated with late
> loading.

Yes, short of

TAINT_YOU_DID_SOMETHING_DANGEROUS

we simply don't have a better taint flag.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
