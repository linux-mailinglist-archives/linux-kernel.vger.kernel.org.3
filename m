Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8075576A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiFWJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFWJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:31:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEE48302;
        Thu, 23 Jun 2022 02:31:55 -0700 (PDT)
Date:   Thu, 23 Jun 2022 11:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655976713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdy+QUhPkvFcFC80rvjevTMJhfdSl1qbxeO2CTdvv58=;
        b=NEhmq8viQ72FOh+cau9QybpV1lZZv76F0Y0skF4OQ3K33zgzmjPISWBUw8wZ8ejYmmzZtJ
        Za/VxomJ8D0EbRmyHsp9iIgo5KJtEtw8W01lx6LJFRXY7qpRtQEeftXKQrJEcY8hZzGlao
        KFURtbeaNG/jIDaSC6pLEds9Sjs2tQ+rHR0NN2Ab4xtI0Y5BCzxPZgxN0ZT2FcYK9XAvq7
        gSwZLLW3g90EflW0hduk0fFEQjhbAh7nK+ixMY00pRCxuxyhm4XqHCAREYUSI49F4mfXAT
        T+c1qZC3PMNYcahuSC2DpV5oXODqczdVooKzp4pXQI/smcHSisXnnjHwclyScw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655976713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdy+QUhPkvFcFC80rvjevTMJhfdSl1qbxeO2CTdvv58=;
        b=1tpp+G+oSQjiwNGLj9aUmHGzkXlmunN6sB7hmmrXtf56s+eH5ZchYT6PhUcvWW8snWnOb/
        i9anyEfJ1+O1mHDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <YrQzB7sPD8BNxSFq@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220620111520.1039685-1-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20 12:15:20 [+0100], Valentin Schneider wrote:
> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
> of mutex_trylock():
>=20
=E2=80=A6

> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softir=
q context")
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
> v1 -> v2
> ++++++++
>=20
> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>   (Petr)
> o Slightly reworded changelog
> o Added Fixes: tag. Technically should be up to since kexec can happen
>   in an NMI, but that isn't such a clear target

RT-wise it would be needed for each release.
There is also a mutex_unlock() in case an image is missing. This can go
via the scheduler if there is a waiter which does not look good with the
NMI in the picture.

Sebastian
