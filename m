Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CFE48DB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiAMQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbiAMQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642090703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WljrENSs391voS6qFK8OME4Xqxs32Ponbh/lShXKlhU=;
        b=P2Qbxj1u93yTQKkzUopU8OaVEkRVWLVuD3ag5cFDDH+bohtMrhtMIZZOV/VI+MXGa2Ifeu
        0GBprS2ilMmVRjcqQcjkSCjPbI5RuhNcHeUy3WPDDMOIFNS4Ngy+O8pfuMKLucJIChV5J5
        1r/Xl1PGKWkmK4WdOZovVCkiEyETDg0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-5SX0Ea5QMqmFrrMiGI5xjA-1; Thu, 13 Jan 2022 11:18:22 -0500
X-MC-Unique: 5SX0Ea5QMqmFrrMiGI5xjA-1
Received: by mail-ed1-f71.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso5798718edd.16
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WljrENSs391voS6qFK8OME4Xqxs32Ponbh/lShXKlhU=;
        b=LcRWPx6HMLdQUvLwl4ql3qFYQ+VDFzeaSt9flbjortcgnwiJ+mtxEbs1AJ+cWRoqDM
         2eFe91vFSXoaJ4+AzXkSxQTscFgassN6/hBDGFfUc6QMeulBJ2a8IOieJqw930TLuxhD
         j9jaY3LMMDd06MBno6Dv3uIg4e16/Od1fmHM5RxfLaINM7o4XxHqwZlbcSu2R217mY14
         am+11AytZRjduFWi48grzpTSZyDPUE/CudVBts+Y138+K/31Q0Rp6bYEU/QsKQz6XCpJ
         ObdhuvQhAH9A09z6DdaFMoqx0X/T0zpWTkCrb+3TOBy2N7iheyXYyInOSZZsCsiBn4yV
         xrQg==
X-Gm-Message-State: AOAM532P8G/IM3wybbXUiHizqTT00bJnL09yh9/NKCZ1QHkucmRFszhn
        /TDIBtRpznh1JgyEcAG+4ORgeBkw3MEn7TI/Jqb0trHzS72cdQ632hcUPFkOZSO0YXvxg40L0va
        YX/5bz0oWLMaGs+EtGDPa74VQ
X-Received: by 2002:a05:6402:34cb:: with SMTP id w11mr4851726edc.400.1642090699769;
        Thu, 13 Jan 2022 08:18:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8yQZWRkjYVxA8apiLfPy8Ad/B36lIg2/xcswxv8rUOOFQGvVPKHZ5N3R1yEL3zmYeY22wcA==
X-Received: by 2002:a05:6402:34cb:: with SMTP id w11mr4851618edc.400.1642090698289;
        Thu, 13 Jan 2022 08:18:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j7sm1355318edq.5.2022.01.13.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:18:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0995F1802D8; Thu, 13 Jan 2022 17:18:16 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Erik Kline <ek@google.com>,
        Fernando Gont <fgont@si6networks.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Subject: Re: [PATCH RFC v1 2/3] ipv6: move from sha1 to blake2s in address
 calculation
In-Reply-To: <CAHmME9qLPxVSypcMECUjNeFz8qeUpeDe-LiXFoZTBYnGW9=ukQ@mail.gmail.com>
References: <20220112131204.800307-1-Jason@zx2c4.com>
 <20220112131204.800307-3-Jason@zx2c4.com> <87r19cftbr.fsf@toke.dk>
 <CAHmME9pieaBBhKc1uKABjTmeKAL_t-CZa_WjCVnUr_Y1_D7A0g@mail.gmail.com>
 <55d185a8-31ea-51d0-d9be-debd490cd204@stressinduktion.org>
 <CAMj1kXGz7_98B_b=SJER6-Q2g-nOT5X3cfN=nfhYoH0eHep5bw@mail.gmail.com>
 <87ilung3uo.fsf@toke.dk>
 <CAHmME9onde38SNBBsmypzr_QDSDiQ_0opPiqJ7sU5X-iMDtncQ@mail.gmail.com>
 <CAMj1kXE0Hhi1kgXx2vNchoKOrQOZEBg1V6c5w7if3yN4_GNn8g@mail.gmail.com>
 <CAHmME9qLPxVSypcMECUjNeFz8qeUpeDe-LiXFoZTBYnGW9=ukQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Jan 2022 17:18:15 +0100
Message-ID: <878rvjfw3c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> On Thu, Jan 13, 2022 at 2:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> > Then, at some point down the road, we can talk about removing
>> > CONFIG_NET_OBSOLETE_INSECURE_ADDRCONF_HASH too.
>> >
>>
>> What is the point of having CONFIG_OLD_N_CRUSTY if all distros are
>> going to enable it indefinitely?
>
> I think there's probably some combination of
> CONFIG_NET_OBSOLETE_INSECURE_ADDRCONF_HASH and CONFIG_OLD_N_CRUSTY and
> maybe even a CONFIG_GOD_MURDERS_KITTENS that might be sufficiently
> disincentivizing? Or this ties into other general ideas on a gradual
> obsolescence->removal flow for things.

Making it a compile-time switch doesn't really solve anything, though.
It'll need to be a runtime switch for people to be able to opt-in to the
new behaviour; otherwise there would still be a flag day when
distributions switch on the new config option.

I don't think there's any reason to offload this decision on
distributions either: there's clearly a "best option" here, absent any
backwards compatibility concerns. So it's on us to design a proper
transition mechanism. Defaulting to SHA1 when stable_secret is set, as
Ard suggested, sounds like a reasonable default; then we only need a
single new value for addr_gen_mode to opt-in to using blake2s even when
setting the stable_secret.

-Toke

