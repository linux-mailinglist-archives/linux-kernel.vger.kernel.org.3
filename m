Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CC04B68BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiBOKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:04:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiBOKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:04:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D5D317;
        Tue, 15 Feb 2022 02:03:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644919436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GQCwnsaZU0MpAE/uq/5vjVQ8fkLcXqKX/Mt5g4t1dw=;
        b=22hCEKSsdLw8SfXQm0MMks6a2ILm3RXNdFSFHkOqZEmZFHae7JScxAM7ruDKLR76zzE0nB
        bQMyw/JRetGpYbHqR9CUuPAQy9cjjdKxFkp92QlK5W9fRF0Dsef6jGhv0Bs/HK1TqWMLtu
        ruC9BwIG6GAyCP0oWurPALkU3IRlkAguU0d7VW7MD64QpsfjFRdUkjOk7x/cBK4qhE73CM
        nEHZ8A0rM4hVa6B2F0mv53buRZ7Jnc7lEYcHdqsixuYprLABJfRxLRqXuGR3cbYX3VgVhb
        0Ak8gRH2V6I6JNXGoPSZd7T78Nhbwdm2THIPEcPDc3FTPIlEP5skS27P2nfRkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644919436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GQCwnsaZU0MpAE/uq/5vjVQ8fkLcXqKX/Mt5g4t1dw=;
        b=8gLLKH1Egj/EfTRvnESRoEdVAYBPpMiswd0hHjPNNDEXBkLI16zb5B8letAJZMxTB2QKV7
        iMGhHVnOpHYR9uAQ==
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
In-Reply-To: <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
 <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
 <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
Date:   Tue, 15 Feb 2022 11:09:55 +0106
Message-ID: <87v8xg30qc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> On 2/14/22 18:25, Shuah Khan wrote:
>> On=C2=A02/14/22=C2=A03:45=C2=A0AM,=C2=A0Daniel=C2=A0Bristot=C2=A0de=C2=
=A0Oliveira=C2=A0wrote:
>>> Note:=C2=A0do=C2=A0not=C2=A0use=C2=A0this=C2=A0reactor=C2=A0with=C2=A0r=
q_lock=C2=A0taken,=C2=A0it=C2=A0will=C2=A0lock=C2=A0the
>>> system=C2=A0until=C2=A0printk=C2=A0can=C2=A0handle=C2=A0that.
>>=20
>> Please=C2=A0give=C2=A0more=C2=A0details=C2=A0on=C2=A0"lock=C2=A0the=C2=
=A0system"=C2=A0and=C2=A0how=C2=A0locking
>> would=C2=A0impact=C2=A0users=C2=A0and=C2=A0system=C2=A0operation
>
> It is a deadlock on the rq_lock. Hopefully the new printk
> implementation handles that better.

I suggest using printk_deferred() for this reactor for now. With
printk_deferred() the message and timestamp are immediately and
locklessly stored in the buffer, and the printing is performed in a
separate context. printk_deferred() is safe for all contexts.

John
