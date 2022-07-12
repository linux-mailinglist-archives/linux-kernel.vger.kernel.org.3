Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD8570F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiGLAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGLAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:46:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6E626552
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:46:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f11so5310561pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=MrBfNE+lDrxaFJmsqP9cx+ZcpAfc2gGGi9kDbUQJuak=;
        b=AgrBuA/N7SPeE0ze9eLiHhmshi8vqlRkj6fI2MAJDwco8R8Tvrg6CDeXNUfe/8Baw4
         FarK65V59sOTTqzNrJOSrUU0RZ4FY08LQ0d5cKMSFPC/84q8HywdMytK/LVqp7tXb2O9
         9I3oHj2WJQsRZCxdo3+hXo0xkxm8D5GgcFb4mh+gIpVXYezDEF21wxEqlYogJ1FmKhWC
         beU+RNCStS8JyRun+VfxbJCQQqZi3juCOwd9ksruWpx7kTirKBb07/O8qX2hmGpGUEol
         mFijh2GiX5mcMOwTrFejgTbN+9ILgW4I4c8ghHR9lMTG+Trv0Caes+KLPTewt72igFc8
         0IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=MrBfNE+lDrxaFJmsqP9cx+ZcpAfc2gGGi9kDbUQJuak=;
        b=r/IKsD+/dfowxqg9cg6IVV5ue0xLnFkjXVr0Ya8doHubcOHqm60Gj/SBh328xSPZXj
         XgD249uVFtYAHSS7yDWco/IqT+Zi/6HCeeIz8zUoBUhfKYhP3mHiMLvdfZ/Y0LjFgzlL
         6Lo0QQivdBQttHqx4EqctqO11JKf46ZwmiL1/8AQKWuEenjBWloShn0EQZj5oYVqmFOW
         Nuci8J+NXIq/jEspz2DSeC9T++fxkiS6ehrlUmFmOMflhJ5EJhYQHhlgCVZ8qBhj7/1P
         zfrIKpXWkGhXK1YkJMb1YJIaBVDsDeKXjsgHoYWKasfUwee1qUzerW7xZNCGy1/IDb4c
         oycw==
X-Gm-Message-State: AJIora9wtKCGxgs+9afxNeRf3X+0ZeZCCgrVuta1RsO36j9JUBCMoa2t
        xHXlMvdNp5JvZRIwayHMmd4=
X-Google-Smtp-Source: AGRyM1u1a9zdg2qkjZET4V7deeC+2n7ftFUv8TmGkg0fEk/WCC0IChTXrOM6WwDrob4HObq4C0zaJA==
X-Received: by 2002:a63:9041:0:b0:415:c0e8:c588 with SMTP id a62-20020a639041000000b00415c0e8c588mr15801558pge.282.1657586788141;
        Mon, 11 Jul 2022 17:46:28 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b0051bc36b7995sm5349494pfj.62.2022.07.11.17.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:46:27 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:46:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 06/13] locking/qspinlock: merge qspinlock_paravirt.h into
 qspinlock.c
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-7-npiggin@gmail.com>
        <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
        <YsR2tlnJZ3c0ZeaP@worktop.programming.kicks-ass.net>
In-Reply-To: <YsR2tlnJZ3c0ZeaP@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657586071.6w3o6t2gfx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 6, 2022 3:36 am:
> On Tue, Jul 05, 2022 at 07:20:37PM +0200, Peter Zijlstra wrote:
>> On Tue, Jul 05, 2022 at 12:38:13AM +1000, Nicholas Piggin wrote:
>> > There isn't much reason to keep these separate.
>>=20
>> The reason was so that other paravirt implementations could be added.
>>=20
>> The CNA thing was also implemented this way...
>=20
> Also, (TIL) s390 seems to have a copy of all this:
>=20
>   b96f7d881ad9 ("s390/spinlock: introduce spinlock wait queueing")

Right. powerpc is going to add another one. I've also been struggling
to make PV qspinlock work well for us and the PV hooks didn't quite
help. This series is just me dumping what I had done while working
with the code until now, feel free to take or leave it.

The PV things could easily be moved out again or conditionally
compiled when another implementation in tree comes up.

> it might be nice if it were possible to fold that back into this with a
> different paravirt implementation; but I've not looked at it in any
> great detail yet.

I would like to fold powerpc some time (or at least merge it with
s390 which it is possibly more similar with) but at the moment kind
of need prove it even works on our systems  and solves issues before
bothering other archs with it. It's not all that complicated though
so not too concerned about carrying it in arch.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-July/245977.html

Thanks,
Nick

