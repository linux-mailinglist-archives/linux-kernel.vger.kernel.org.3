Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34794D2C14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiCIJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiCIJep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:34:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8B6AA5F;
        Wed,  9 Mar 2022 01:33:46 -0800 (PST)
Received: from zn.tnic (p200300ea97193859a096270e94cb9aa6.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3859:a096:270e:94cb:9aa6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2371A1EC02B9;
        Wed,  9 Mar 2022 10:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646818421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=69vdQtTpsHh6zZFEeXCX5VhdZ9ZJr7n91rFwrjF4ThI=;
        b=gGKcL5wjP1iEsYL8UifJPnDRaz6VQGQdC2gxJ+ZnfOpB3TX0VJaOUtSZBMGo3Y1j3ZT7Yd
        YB3ClgB36HpRo6qQOHgmDFa4eq6ia9NprJlj00FiSpvBn4G8EpGJfbg9C+h7UhmUSS/JQo
        Hkxyc2doodJ4B+pByfXpsKJdLLafdY4=
Date:   Wed, 9 Mar 2022 10:33:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: Re: [PATCH v1 0/2] x86: Avoid using INC and DEC instructions on hot
 paths
Message-ID: <Yih0d4Red0ICo/MO@zn.tnic>
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
 <YiX81kD/668UdFBr@nazgul.tnic>
 <11dec988-0b4f-00f2-6fa6-8d08be95d106@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11dec988-0b4f-00f2-6fa6-8d08be95d106@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:37:59PM +0700, Ammar Faizi wrote:
> > Also, I'd advise going over Documentation/process/ if you're new to this.
> > Especially Documentation/process/submitting-patches.rst.
> I might've missed the benchmark backup part. Will review those documents again.

The "Describe your changes" section in the abovementioned file has some
good explanations on what to pay attention to.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
