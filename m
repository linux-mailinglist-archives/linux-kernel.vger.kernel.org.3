Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A92552B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbiFUHDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiFUHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:03:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB92205F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:03:28 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:03:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655795006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdkDQIhfC7cpssWNBP1piNlmLoHC3/U6At/sRsoe+rU=;
        b=jhGf8KyfIAO2gyDlwFrSoGn6NchTV7CdMre3vRs0CG156iO1wLTmbS793aSUrxnJw6vBx6
        FTa3Y+rBUBpa13zOPdhtbdkiH1vq19F2orvRqGxyQtlqVO7CfdqH2myU5sYy8zR5Ki7iNH
        ULXJmbEPltX76cklds43+MJYFCDoWhOLE2DDTaagIO+7k9b/PSo6yW3EU2M89JGRcmqBBy
        GnU9Nf4HLZFgGFjjp+n2Yvb1+PQlCniD4sxjn1I/dDaHk5oVhSwVUFHf5f+LERkIfrOE1c
        bZTNALDbRsgUtrRN7Y1xnjRh1nR9kX0Rw6h2BDMUJ8r41d6LUhoWa1+s3n+y9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655795006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdkDQIhfC7cpssWNBP1piNlmLoHC3/U6At/sRsoe+rU=;
        b=A2jjLFihl/0JDSGAmgECFehN6v0oif4Novkf0hzP6B73qa17M4A9XI+nTC5R/swdjWNs8R
        mFstRycliQuZpNDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YrFtPYItG0+YgR/8@linutronix.de>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
 <Yq0EcG9GsAkoiF3H@zx2c4.com>
 <YrAlPKeOowD5qv/B@linutronix.de>
 <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20 14:00:18 [-0500], Linus Torvalds wrote:
>
> As mentioned, expecting an uninterruptible read is not "security". It's garbage.

right.

>               Linus

Sebastian
