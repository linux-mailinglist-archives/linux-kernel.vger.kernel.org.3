Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6B47FDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhL0Nn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:43:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57608 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhL0Nn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC57860FFB;
        Mon, 27 Dec 2021 13:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C7C36AEC;
        Mon, 27 Dec 2021 13:43:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HFFJGz7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640612633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4VHVmdxDnw/5uH5g0BfZFtqGk916bztPM6sTPKTV3I=;
        b=HFFJGz7Jf/6zCu4+EYvty3fHiUcbfLWTOpCoGCd45ezPyNkjQCXGF2ytMJnVYHMJtsiMCl
        yeqsin2ly2k3LOPLI+Eqh66h2VgWi7bqUmFTadWLbexczAAOHON0kOj5SQMbYmomC23H/q
        eKfu3YSIEUOlo2hchjFpHmkL5NX+FK8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id afd2f686 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Dec 2021 13:43:53 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id m19so27295916ybf.9;
        Mon, 27 Dec 2021 05:43:52 -0800 (PST)
X-Gm-Message-State: AOAM530oLqxsaFSGEUaYyt2U0MqROCiwp2s6LhzbPgcM7HzP6pBtq9cQ
        pcLOcuyxLTaCHCWg5Qm++ru03Q2i0ksmkvRd1l0=
X-Google-Smtp-Source: ABdhPJyLotRuMiaC7IB3M5SDYqi2QUChl9JVn9pBv9Z0RICSjrEf6RfbxaNIxJZEPvJzHbPa4ntJ3UXP062SN4+b0bc=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr21353761ybe.32.1640612631824;
 Mon, 27 Dec 2021 05:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
 <CAMj1kXG7PFpj1Oz1osVCBW1NhCHQT+Oc=0WMLYSeRtC1QK4e8Q@mail.gmail.com> <CAK7LNATjF13vTrxMn9OTH4rmmrg6m-7aWjH6n3zV9APZwvus9w@mail.gmail.com>
In-Reply-To: <CAK7LNATjF13vTrxMn9OTH4rmmrg6m-7aWjH6n3zV9APZwvus9w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 27 Dec 2021 14:43:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9p95g0yWcRBfbrx_kX56HqFZrw8xcOLt6cn5fzVSCQXyg@mail.gmail.com>
Message-ID: <CAHmME9p95g0yWcRBfbrx_kX56HqFZrw8xcOLt6cn5fzVSCQXyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/crypto: blake2s: include as built-in
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Thanks for your feedback. Indeed it looks like you're right about the
CONFIG_MODULE case. We'll go back to using the kconfig system
normally, and cease tempting the beast with libs-y and such. I'll have
a v+1 for you shortly in case you're curious, though I expect it to be
sufficiently boring to be no longer worth your time :-).

Jason
