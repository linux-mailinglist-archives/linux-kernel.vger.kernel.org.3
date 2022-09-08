Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC625B14C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIHGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIHGhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:37:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E6C0E6F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:37:42 -0700 (PDT)
Date:   Thu, 8 Sep 2022 08:37:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662619060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5caOl+kTQwoBp97UxIKqZHl3t4gL124ornrbJ/bWIMw=;
        b=l1VQEKhOnTHbOA1hgaePJR/sBv8m7EvEZtmrArlvWiJ3eVRLCEi7FhQJH+UvEFVj/Q36/b
        74YyuT6y4aPvjbKfvznOuK2CJFfmpeLILgiMKAQAQ86smAdqlb2xVWf1WqYIwVK4gh2uM7
        kHQCbNMUSHQctzBxNWojrkkWURrGgicIzrufnZtX4QqRpSlM0lXzVI/FRqXRfBdB0rqNMA
        qra19fekkqfI56jjoJS8TdKqfQVdV6A+rx1Gt6jO4sFffQZAlE2QjpVxslq0GoatUqF3Nj
        F1FQ0Iy7YgKv2PN9zRp69iQ5H4Yu2uhI0fPOSLU4mNQD7kGJlTGVMRas6ndqow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662619060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5caOl+kTQwoBp97UxIKqZHl3t4gL124ornrbJ/bWIMw=;
        b=ZvbOSUgXiTVvIwNbwHny++jRoB8avSn+6UMWSXMeJSR/zb00i2OH2g97Dt76JodCxKwfIJ
        A2v45Qy59/Ol6vBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: Detect includes rwlock.h outside of spinlock.h
Message-ID: <YxmNsnCPSPt1SJcz@linutronix.de>
References: <YweemHxJx7O8rjBx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YweemHxJx7O8rjBx@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-25 18:08:59 [+0200], To linux-kernel@vger.kernel.org wrote:
> From: Michael S. Tsirkin <mst@redhat.com>
>=20
> The check for __LINUX_SPINLOCK_H within rwlock.h (and other files)
> detects the direct include of the header file if it is at the very
> beginning of the include section.
> If it is listed later then chances are high that spinlock.h was already
> included (including rwlock.h) and the additional listing of rwlock.h
> will not cause any failure.
>=20
> On PREEMPT_RT this additional rwlock.h will lead to compile failures
> since it uses a different rwlock implementation.
>=20
> Add __LINUX_INSIDE_SPINLOCK_H to spinlock.h and check for this instead
> of __LINUX_SPINLOCK_H to detect wrong includes. This will help detect
> direct includes of rwlock.h with without PREEMPT_RT enabled.
>=20
> [ bigeasy: add remaining __LINUX_SPINLOCK_H user and rewrite
>   commit description. ]
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>=20
> This is to avoid patches like
>    https://lkml.kernel.org/r/20220816074816.173227-1-bigeasy@linutronix.de
>=20
> in the future which is not the first I sent=E2=80=A6

polite *ping*

Sebastian
