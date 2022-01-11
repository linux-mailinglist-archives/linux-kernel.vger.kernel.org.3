Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2809B48BB59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbiAKXVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:21:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36042 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiAKXVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:21:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E89B61451
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8227C36AE9;
        Tue, 11 Jan 2022 23:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641943262;
        bh=rOCGhPadQvRT3ln3KwBxU4CiCad3Fl/1OvNtQ6RDExQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WuVBoHTDIjCwUqmZhAtGBYYvzPYS1SZp/VEgXM+8OcSM5nP1GWiDVADyL7sfNYgRA
         CB+5VhE0IQBZGJ8yB/IfIiuZRPYtB4f/XRn8Q72ng53+C3RkpsyVjRh4bgL7BJlxnC
         z6mCMumQSDtVndPwjzpJZDazdvSmRFRtqaFxSDaiOBKr3UsfqVt9cuidBlUT9RgH1d
         KBxaYeq1ppT9k3LDt1DIOQ2+5Vmqdvdl+SiYtCw3tah9Ys1A3iCDcQ1siMkRyGSnPS
         a0MRN0Ugb9Sc61fjvvZ7XAjpZpSHvrCRjk0Ns+tNc5cu9J4iW/ZD+L5yLq2LM6LTYC
         33RlxxAzFtbcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 88AC35C0DA1; Tue, 11 Jan 2022 15:21:02 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:21:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        caihuoqing@baidu.com,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] drivers/pcmcia: Fix ifdef covering yenta_pm_ops
Message-ID: <20220111232102.GI947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220111215431.GA2609427@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi9_UKV6Dkroz5O11+P-=sw+gu5z2RJTmdGuRE4bBxBGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9_UKV6Dkroz5O11+P-=sw+gu5z2RJTmdGuRE4bBxBGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:50:26PM -0800, Linus Torvalds wrote:
> On Tue, Jan 11, 2022 at 1:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Currently, yenta_dev_suspend_noirq(), yenta_dev_resume_noirq(),
> > and yenta_pm_ops are covered by "#ifdef CONFIG_PM", which results in
> > compiler warnings in kernels built with CONFIG_PM_SLEEP=n and CONFIG_PM=y:
> 
> Hmm. Wasn't the pcmcia tree in -next? Or how did this get missed?

This bug happens when running the rcuscale and refscale tests, not the
usual rcu, lock, and scf torture tests.  So I would catch it only if
I ran my overnight torture-everything test against -next during the
critical time, which I failed to do this time.  :-/

My guess is that others building such kernels don't often test against
-next.

For whatever it is worth, here is my overnight torture-everything test,
which takes about 15 hours on a 16-CPU system:

./tools/testing/selftests/rcutorture/bin/torture.sh --duration 10 --do-kcsan --kcsan-kmake-arg "CC=clang-11"

> Anyway, applied directly. Thanks,

Thank you!

							Thanx, Paul
