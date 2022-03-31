Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D64ED199
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350995AbiCaCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351636AbiCaCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:17:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBB673E4;
        Wed, 30 Mar 2022 19:16:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d142so18721353qkc.4;
        Wed, 30 Mar 2022 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=whcJsZ9fSHzKHYP6NYYtiLzIxY/tNE+6wAUb6nx0WLc=;
        b=R/v69GupsJQ4en76Cj6ODf5L7kUqp/mkhPQScuNH7IA2FcrIOLeMuNz38sfY2LHUQR
         qAf7o8W2q7zsDqoIOKUdCV393FI+u7j06tZwS9pAuLXKgrXj2RqtZJeMOEGFGVWpbKRN
         N00NTn6YBmx41ysOfYV12CcimDhrFDW1INirx7XLFQgumP49BmAOdEJANtYexZ+l1ZVy
         j/9Y9RBUZuYinBQKCl3mFr+mSS/F7T/2leaaleuT+Wepe8Qr8cazqnWcQREigndl60J3
         BUfNh/Of7lynWOUblviFesM6W5EdRtWk6Cp9/hB76fCf2YWj5RasvYgIn17KJ3sxRxLm
         q39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=whcJsZ9fSHzKHYP6NYYtiLzIxY/tNE+6wAUb6nx0WLc=;
        b=1lA5efvIfS7SouuV53s63CobykJ/tkC17FV+as+OkGa75ullMQRpf9K2J2QHBP143u
         0OmjttS0DjbYeGnBzUaeAVkVxM856qgiudQJSPRTV1rUv55n7rejvB51m18pfqid784Y
         TZgi1ABwtJX/c29AhIz9pazeYeWs18pbEdhaQ0eiN3IvKyaQV3DveNAC2WxpC5cFP4ET
         e+SYD0lhJ7VJ/douWiptCJboyE9UJbHGtyUgG+F5LZkzKekjOdKzRG7O+LVBPmBCwfgz
         CF94rHGU8Vbn9EdABgh30PKIENtvPL17WBJzi5ZjTmttg2G1Jgt0EC1q06MIfp8/W8Ob
         NLtg==
X-Gm-Message-State: AOAM533xmPrjMbiXZNhD20VsXivDkSXKzu1r83ONCDZaJ/33a77OCJlo
        Yog69qo0QIHFUK4HuDY0sFawmw+W3jr/62eb
X-Google-Smtp-Source: ABdhPJz7aNtBu1MwpRLHndDEAn7FrTjYqTXB+wEJGYIoMZOPdUIW3YdtU4tNpZCzSkv1iWij7kz+jw==
X-Received: by 2002:a37:684b:0:b0:67f:2fad:a294 with SMTP id d72-20020a37684b000000b0067f2fada294mr1925710qkc.640.1648692964917;
        Wed, 30 Mar 2022 19:16:04 -0700 (PDT)
Received: from [192.168.1.115] (cable-217-24.sssnet.com. [24.140.217.24])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b0067d27e196f1sm11093377qkg.133.2022.03.30.19.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 19:16:04 -0700 (PDT)
Message-ID: <6327b17d-4c64-fd59-28bb-d5f2f3a5c496@gmail.com>
Date:   Wed, 30 Mar 2022 22:16:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
 <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
 <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
 <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>
From:   Ben Westover <kwestover.kw@gmail.com>
In-Reply-To: <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jzTj0r0e300cjlTncdD401te"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jzTj0r0e300cjlTncdD401te
Content-Type: multipart/mixed; boundary="------------ESYsYFsZVUwTQ2NUHsPCF37h";
 protected-headers="v1"
From: Ben Westover <kwestover.kw@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <6327b17d-4c64-fd59-28bb-d5f2f3a5c496@gmail.com>
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
 <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
 <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
 <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>
In-Reply-To: <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>

--------------ESYsYFsZVUwTQ2NUHsPCF37h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Masahiro,

On 3/30/22 9:34 PM, Masahiro Yamada wrote:
> On Thu, Mar 31, 2022 at 3:40 AM Ben Westover <kwestover.kw@gmail.com> w=
rote:
>>
>> Hello Masahiro,
>>
>> On 3/30/22 11:31 AM, Masahiro Yamada wrote:
>>> On Wed, Mar 30, 2022 at 11:34 PM Ben Westover <kwestover.kw@gmail.com=
> wrote:
>>>>
>>>> When riscv64 or riscv32 are used as the value for ARCH during compil=
ation, like
>>>> in tools that get the ARCH value from uname, set SRCARCH to riscv in=
stead of
>>>> failing because the riscv64 and riscv32 targets don't exist.
>>>
>>> Can you refer to the code that really needs this?
>> Some software like DKMS compiles out-of-tree modules by running `uname=
 -m`and
>> using that for the ARCH value. Without this patch, that compilation fa=
ils because
>> uname shows either riscv64 or riscv32 while riscv should be used.
>=20
> It is a bug in DKMS.
>=20
> The ARCH=3D* in linux kernel does not necessarily match to 'uname -m'.
>=20
> For example, we use ARCH=3Darm64 for arm 64-bit (so called aarch64),
> but it does not match "aarch64".
>=20
> The kernel has freedom to determine the supported string for ARCH=3D.
>=20
> DKMS must adjust to the kernel code.

Ah, I see. Originally, I opened an issue in DKMS, but they led me to beli=
eve it was
a kernel issue. Now I see that *they* are the ones that need to change.

>> This code already exists for sparc and parisc, as well as x86 of cours=
e.
>=20
> This is because there is a historical reason.
>=20
> If you look at the old code  (e.g. 2.6.x,)
> arch/i386/ and arch/x86_64 were separate directories.
>=20
> They were unified into arch/x86/ now, but we still support
> ARCH=3Di386/x86_64.  It helps to choose a different defconfig.
> See arch/x86/Makefile.

This makes more sense now. DKMS based their ARCH value off of uname, and =
because of
this vestigial code, it worked on x86. Now, trouble is being run into on =
other
architectures, and their bad design comes back to haunt them.

Thank you for the info; I will now try to solve these issues in DKMS and =
open a pull
request since they don't seem want to do it themselves.

Regards,
--
Ben Westover

--------------ESYsYFsZVUwTQ2NUHsPCF37h--

--------------jzTj0r0e300cjlTncdD401te
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOGnacqRhdU6eNmtFwxHF9U6JtpgFAmJFDuIFAwAAAAAACgkQwxHF9U6JtpiK
Mw/9FbPp84qmuCxgr2rcj/ksr70nDdilTvOyqnRjaZc3EtC5frrsvdE/NZfEAYiDTZ7JgHNyBxSV
qoTxRLmF9iLpOilIDlKvs57+IvroE+Jbkrog6wEWrPh1VsBQ4TUoKycEwefn7597PNUMLo5ZCsul
jo1mTGBGr/6rNWTzdFQZicg9+HcWg5SGIqYCjuOxlLKyL0RNwNhyDuD3MlEL0Oq2CuGTcRCdqnqI
jWO4igsOvmcYzC1SC7v7p/qMnG1I5nLVinXiIqn3kKgMfIhrW7vxLq8Tpo9Tgo9F3q5dIq1Bh9Ct
ZEIia6kekKXxzJi/RnVx0+jjFGblZqLXVAXuehi3cgh/per3o36U16wiuJomiV0mVE4ENeq1oeCA
65GkZQARz36CgRukUpknxqscxP/u9XtQQiz62e521AJH/jwi55ytrWPOAmnA1Qp0ZzMAFW6yUbV3
k9HQOsM5iQJEo+LOoUfunpuQVu54kHTTys2fWcdFMLkkRfVf2f4944gANI31/qCyEimSQ8+/qRgK
isS5L9K7IIuR7Wvbi0xER5PErGNaPExblBgICsGYaolXwXlcOHUMrNpSwGdIy5j64Z+t/mJ1CQKJ
P6B/5lm/co0pk47YheKUJ5fD/gVdtmvQeTX8h0Dm/wRIVfIjLfae+ZxqbXrmIqk06XmsJYdtw77y
WIA=
=mSCH
-----END PGP SIGNATURE-----

--------------jzTj0r0e300cjlTncdD401te--
