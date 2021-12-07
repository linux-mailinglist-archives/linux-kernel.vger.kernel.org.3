Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3756D46C4BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLGUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbhLGUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:40:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC238C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:36:33 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638909392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjJH5mMK1NjranKzgVWHF1Rdi35tEUoQhKJi7tzLktQ=;
        b=mYDs8W40YGi+/DTyX8hoWoIBSww7NIa7OVElQOOuEiIeuj1QaM3mTbv14bwKHTHGbLr75n
        v239VwCwm04kBctyflDLN3gPTBxPACVJ00fP9JTon7lhFAVvG+ZRuwmq92InL64JyikQf9
        UYe54AuKgCvRAwA49lhucZPR3rBxxZ3d/BItxiZOfK6nUxKuEhHSJiWb9G2CG3vHLi94Dg
        rQ06oOESVofgMz7wd7x339RwfOG8YLMeBnI0mBwuT3+cMn8Ch+dmiRftcNzAg6XbcjN4Ll
        UFMYO4Z096AV9EwV/0n+JVLHpNhW4OMFPTxKxCSTTN5WidnoVLMvFjCuc8rwzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638909392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjJH5mMK1NjranKzgVWHF1Rdi35tEUoQhKJi7tzLktQ=;
        b=e4D4rcUF58F0bvRjvm3o9fuD6bHQeJKDoeplDIXPuTyaSHpUEv5gISzZxZ7ayRZiISFtW4
        UjqVRoCQwmbzXlBg==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [x86/signal]  3aac3ebea0:  will-it-scale.per_thread_ops -11.9%
 regression
In-Reply-To: <81783AEA-1313-4353-837D-8217DEF3B9A2@intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
 <87bl1s357p.ffs@tglx> <81783AEA-1313-4353-837D-8217DEF3B9A2@intel.com>
Date:   Tue, 07 Dec 2021 21:36:31 +0100
Message-ID: <875ys02lv4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2021 at 18:49, Chang Seok Bae wrote:
> On Dec 7, 2021, at 05:38, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, Dec 07 2021 at 09:21, kernel test robot wrote:
>>> (please be noted we made some further analysis before reporting out,
>>> and thought it's likely the regression is related with the extra spinlock
>>> introducded by enalbling DYNAMIC_SIGFRAME. below is the full report.)
>>> 
>>> FYI, we noticed a -11.9% regression of will-it-scale.per_thread_ops due to commit:
>> 
>> Does that use sigaltstack() ?
>
> FWIW, I was also wondering about this with:
>
> $ git clone https://github.com/antonblanchard/will-it-scale.git
> $ cd will-it-scale/
> $ git grep sigaltstack
> $
>
> But, the test seems to use python via runtest.py. And the python code has
> sigaltstack():
>     https://github.com/python/cpython/blob/main/Modules/faulthandler.c#L454

But how does that affect the test written in C? Mysterious!
