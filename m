Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A17522E13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiEKIS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiEKISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:18:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7098585656
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:18:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652257098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3iVgEwbMFJsyJvWT1hDaew/TfQ/jheJPXp7YQRJh8/Q=;
        b=Or5fbemMvJUAC2o0AxwvWrsMzFV4C8MiFrqqEs67QaGb8tI538GPqyycaWA9BBqN2Rxm7P
        FZ6CnBBeCQuiSNuRR+YwzL905DKVwMk9dVWwjGDq5BXHLX78+M4/xA2ZMBIxcln9i5lu/2
        36WDvLebhy9MpKp8nfXGVN1VLKglQY8pMkVTyLQSIghiYkAyW8Lw5FkuNxv1dkQRZpj+bF
        iVR5srnVhKK2qFFr7nBJB61RPZBpwabJjFTIdN5orna4SXMnRofsnEug1oMJdlNOMqzffS
        BVhEWQrI+aN7FbBkMpDlUtT1uPsjRtnhWNRWcwpfEGK7Cz2oP16MUg95ZK1gYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652257098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3iVgEwbMFJsyJvWT1hDaew/TfQ/jheJPXp7YQRJh8/Q=;
        b=DsAJitHjBEUOodkfnfk/eNDXuMTtYNAe/+z/tvmkQDIwN1MR8rzU6XoBguFAIhOXtlLI+u
        0WD8ErhteDNN46Bw==
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 22/22] clockevents: use cpumask_weight_eq() in
 tick_cleanup_dead_cpu()
In-Reply-To: <20220510154750.212913-23-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-23-yury.norov@gmail.com>
Date:   Wed, 11 May 2022 10:18:17 +0200
Message-ID: <87mtfoh48m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 08:47, Yury Norov wrote:
> Replace cpumask_weight() with cpumask_weight_eq(..., 1) because the it may
> return earlier.

'because the it'?

