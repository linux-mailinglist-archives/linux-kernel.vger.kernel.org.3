Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6534C47BE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhLUKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhLUKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:49:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E33C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:49:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 562F61EC018B;
        Tue, 21 Dec 2021 11:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640083744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/hn7oTHvZzhDLpZMRI0L64egB8wQ5gQbWGoWmwB9+v4=;
        b=DF44tDHlflkSDsywsF1hZN54oi4jvoxMmCPRrZRudgT9ATEppiJU7udV6zyCJzsq5s0F+z
        +Qtv3xlJ4rkL3j1JWK1qfXkr4O6//P2AWHB+miZN0XsiUsmvwif+MpmUsem0P1KsZNOfNY
        WDwO2BVnHLDeGm5UmS1mwHxRAtyj0rE=
Date:   Tue, 21 Dec 2021 11:49:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] x86/entry: Make paranoid_exit() callable
Message-ID: <YcGxInsnz2/cO5Wm@zn.tnic>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
 <20211213150340.9419-2-jiangshanlai@gmail.com>
 <YcDR92+JFkVAZi5c@zn.tnic>
 <582ad344-7b89-f43f-e8e9-e2d19f7b41b3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <582ad344-7b89-f43f-e8e9-e2d19f7b41b3@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:22:48AM +0800, Lai Jiangshan wrote:
> When paranoid_exit() is ready to be converted to C, it can't have jump to
> any label that is not in paranoid_exit() itself.

Then splitting out those 4 patches from the rest of the series was not
the right thing to do. Because how is a reviewer to know what your final
goal is without seeing it?

When I told you at the time that you could split the big patchset out, I
said:

"It might be even helpful if you could split it into more palatable
portions of maybe 10-ish patches each, if possible, and then send the
first portion, wait for review and only send the second portion after
the first has been applied, etc."

Maybe I should have explained what "if possible" means: if a subset can
exist on its own and is logically separate, then it should be split.
But, if, as in this case, it looks like introducing arbitrary changes
then I wouldn't do that.

IMNSVHO, ofc.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
