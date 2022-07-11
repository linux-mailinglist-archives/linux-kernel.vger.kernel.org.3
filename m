Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740F0570B45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiGKUWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3A2A712
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E4E615F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200BAC34115;
        Mon, 11 Jul 2022 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657570964;
        bh=Lnilogmtmk06htoPTgTWDngldwLQW5JRjeP+dpcQyI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=od93l4DVxhd/QwqZeCKEjqV/dJV7QPqE7/2LIg8Ogma2GA8l+YA/SlCwmJQ39P1gk
         Ghyqm9DFSo0jALWMcbyuFIoDR1PElqS0PWOY6HkoZcMR0VuxHlW5w3qGF9hnQxVQmJ
         ziF0t3uAuxbI4dBqd/SIu9DWMyUi6PdPybFgCgTk=
Date:   Mon, 11 Jul 2022 13:22:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
Message-Id: <20220711132243.76275f03800fc612589b3225@linux-foundation.org>
In-Reply-To: <f58ee2c553ea8ae991454a8e195dcbd2821f794c.camel@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
        <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
        <6a4ea3d21bfb4c692d257d3f38ba28c83f242dfc.camel@svanheule.net>
        <20220703133921.6800bf1e7df3b00cb586a3c1@linux-foundation.org>
        <f58ee2c553ea8ae991454a8e195dcbd2821f794c.camel@svanheule.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2022 08:51:08 +0200 Sander Vanheule <sander@svanheule.net> w=
rote:

> > > can I still send a v5 to move the last patch forward in the series, a=
nd to
> > > include Yury's tags?
> >=20
> > I already added Yury's ack.=A0 Please tell me the specific patch orderi=
ng
> > and I'll take care of that.
> >=20
>=20
> The updated patch order should be:
>    x86/cacheinfo: move shared cache map definitions
>    cpumask: add UP optimised for_each_*_cpu versions
>    cpumask: fix invalid uniprocessor mask assumption
>    lib/test: introduce cpumask KUnit test suite
>    cpumask: update cpumask_next_wrap() signature
>=20
> Reordering the patches on my tree didn't produce any conflicts.

Got it, thanks.
