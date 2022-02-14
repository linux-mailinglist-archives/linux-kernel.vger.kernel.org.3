Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1A4B53BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355374AbiBNOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:49:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355383AbiBNOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:49:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D784D26A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:49:28 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:49:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644850167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyCvB7KwylgRZ+t8Dz4cSlAiX5vo7CCD/TI1SVOF4yE=;
        b=3hRc4Lsu7xIl8PCUzGEYyGHkD5pmduBFGAkLeUjHBl4kFQ0R9LvIdOLDuf8PI1NndMYgPB
        rOnWsAH0jKaxoQiPVCX4io6x7HgevbDF7M6XouVzy4U1Z8Ydgd7Nq9qvnGKNvBcyd8gWc5
        Dvnr1wPHkfLJpUE0z87CT2UzKWmyKyz2M2kwgSaf/Ve91FIALm/qF/rjvVgFD5hvXmGxws
        oIxpQCirn52gPUUs8IQyfOiklrmVg1bc4MBYVf8iwG0yxxAuZbm19EOKXBZYTCFVPPWSRu
        0PTkICl5AMe2hJiNyFAEkIqsAlFWy89cLC11xucyKIyC73oTL5npzB/O3mOgYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644850167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyCvB7KwylgRZ+t8Dz4cSlAiX5vo7CCD/TI1SVOF4yE=;
        b=p99NsjSgb/EbSw1prGR6oPzkbwAqiCKWG+KEvhYvEN5AURvBrwPD6X+5Axr5tAnWXHpXJC
        k4QjDRS2fXNZZqBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
Message-ID: <Ygpr9Xg0I+ZVzp9v@linutronix.de>
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com>
 <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 15:42:50 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> If we move this to startup, is there a phase during which no interrupt
> will arrive? That is, can this happen very very early in startup, so
> that zeroing out count happens *before* ++count?

Interrupts will arrive starting with CPUHP_AP_ONLINE_IDLE from the CPU
HP point of view. My suggestion had a check for upper most bit and only
clear count if that bit was seen. So we wouldn't clear the counter if we
wouldn't suspect one of the rare corner cases.

> Jason

Sebastian
