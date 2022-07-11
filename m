Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A3570004
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGKLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiGKLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD69747A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:40:32 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff601329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f601:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 964B31EC0518;
        Mon, 11 Jul 2022 12:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657536026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DQveIvP21h/SanKF+N0Kr1ZyhDAmgYuWOYIW71suvFg=;
        b=CnP+YTdQFXXeMz4yz7lRKZrtDOotgh/qmneigxkyjFPzRx22eIHesEikobYkfzhA0eFGHx
        bgWLcABXTonqdCSQS/VeaNriU3qJ60lGziMlFEFviVrJ4ncqEsKyuMs/HXtUf2QXs9ucao
        boRyB8MdlK+myKDMfvTxFNaK5ZPE7Hk=
Date:   Mon, 11 Jul 2022 12:40:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Message-ID: <Ysv+Gh0Gk4+uGwrb@zn.tnic>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic>
 <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <b7fa785b-cea3-3e05-c101-d6c7bd101ef3@suse.com>
 <YsW/3/fEuNYAuFwZ@zn.tnic>
 <bc13c66d-a885-e405-7b53-8cd7afdbecff@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc13c66d-a885-e405-7b53-8cd7afdbecff@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 08:38:44AM +0200, Jan Beulich wrote:
> Well, right now the pvops hook for Xen swallows #GP anyway (wrongly
> so imo, but any of my earlier pointing out of that has been left
> unheard, despite even the code comments there saying "It may be worth
> changing that").

Oh great. ;-\

> The point is therefore that after writing PAT, it would need reading
> back. In which case it feels (slightly) more clean to me to avoid the
> write attempt in the first place, when we know it's not going to work.

X86_FEATURE_XENPV check then.

> If I may ask - doesn't this mean this patch, in its current shape, is
> already a (small) step in that direction? In any event what you say
> doesn't sound to me like a viable (backportable) route to addressing
> the regression at hand.

Backportable to where? To whatever tree has

bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT with pat_enabled()")

? If it is that, then 5.17 and newer.

Anyway, I don't mind it as long as you put the proper splitting out
ontop and it all goes as a single patchset, with the minimal fix
CC:stable and queued first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
