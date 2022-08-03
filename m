Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5A5888F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiHCI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiHCI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:59:26 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B32251E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659517103; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Z0C1RFtHhWVL38VXioPhEM9PPXQDeSm2BDZOVRVGojx6UymDi/ZUoEg/9UlUSIi8g46xDsAVg3Wogu/iGCelF+aWVZgdR30N2JlZVoWe0d7g9IZEbw8HknkaCjZS/WUf9xENkOYap7Kid2PxtROalZuz9xImGkscEjCgzYGXK/w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659517103; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UWM3Q8d65CxhgoPYwJTl/FGjavrP+S1bO4WDYI0LZmM=; 
        b=W1ZXKcqpJWvXzse0uYPyMk5Wbt9n5kgRL/CVobzc02368p5EC0Ah11Wp88I6dQluMagaIz4YapLyoKV4I92lJKghTxunvVTR7ciVfMNZTYGJTZrhddT9YrFsVYVxEqNoANNhdj+Cq8NcBSExPI+hLofdFE4yO4jASvWPZLYwIZc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659517103;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=UWM3Q8d65CxhgoPYwJTl/FGjavrP+S1bO4WDYI0LZmM=;
        b=aCGxjGguCX3vmghCE0g7WVP1LHmEMjvjiTKUyp/oqsYrIKb3ZJNjNRLgT+oM4CoJ
        rWMDVAwlOrhZwXBzDi0MRaLxBoGofBlWCY+U+51CCIwe+hrxMUUzFVdUFsrOuwCpAcw
        54wHQHb2HtbY4dhL/2oz06j/DHLsiwL0BnUp6/mc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659517084780174.63182416015275; Wed, 3 Aug 2022 14:28:04 +0530 (IST)
Date:   Wed, 03 Aug 2022 14:28:04 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     "x86" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me>
In-Reply-To: <Yuo2UkkyaYtZ3rMZ@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me> <Yuo2UkkyaYtZ3rMZ@gmail.com>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 14:18:18 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> 
> * Siddh Raman Pant <code@siddh.me> wrote:
> 
> > On Tue, 02 Aug 2022 16:37:44 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> > > Your fix makes sense I suppose, but I'm wondering how testing didn't 
> > > trigger this warning.
> > > 
> > > Off-stack isn't a rare config option:
> > > 
> > >   kepler:~/tip> make allmodconfig
> > >   #
> > >   # No change to .config
> > >   #
> > >   kepler:~/tip> grep CPUMASK_OFFSTACK .config
> > >   CONFIG_CPUMASK_OFFSTACK=y
> > >   kepler:~/tip> 
> > > 
> > > What am I missing?
> > 
> > Maybe this triggers on certain config options set, or maybe due to new
> > gcc version? (I'm using gcc-12, I also likely saw while on gcc-11.)
> > It nevertheless is a helpful warning.
> > 
> > I just now tried `make defconfig` (default configuration based on
> > 'x86_64_defconfig') and compiling with `make -j13 all`, and gcc doesn't
> > give any warning. (CONFIG_CPUMASK_OFFSTACK isn't even listed in the
> > .config file produced, grep fails.)
> 
> Does 'allmodconfig' reproduce the warning for you:
> 
>   $ make allmodconfig
>   $ make arch/x86/mm/numa.o
> 
> ?
> 
> If yes, then this could be due to gcc-12, as it doesn't reproduce with 
> gcc-11 for me:
> 
>    gcc version 11.2.0 (Ubuntu 11.2.0-19ubuntu1) 
> 
> Thanks,
> 
>     Ingo
> 

There is no reason why allmodconfig would trigger the warning, as it has
CONFIG_CPUMASK_OFFSTACK=y, but the warning is because of the other case.
Still, I tried that, and as expected there was no warning.

Did you try the config file I had linked to earlier?

Thanks,
Siddh
