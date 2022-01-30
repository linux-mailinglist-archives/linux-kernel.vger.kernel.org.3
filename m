Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A34A338E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353786AbiA3DkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 22:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiA3DkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:40:09 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA91C061714;
        Sat, 29 Jan 2022 19:40:08 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 13so9076003qkd.13;
        Sat, 29 Jan 2022 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to;
        bh=w0jqfbg3kgGx+9Z78D7E7J2qiluF5r+yauiuia9Gi94=;
        b=E4JmKlPGY8B1Lxv9Z+uIYxmP5HiM4EaVqcnvbuP9FIf40natyVDgZa4aD3v7DvW0M5
         dvNkHHz3xpVrrrH4l385m3bfJu2nqxM+IVzaLOF5JcIVvrCJX5KMJSjF1qr2IIghjquW
         xg4JfQiSiVqtBPcQ3wR0r0dcFOaZX6P79QT6aik6QblpQWx+tFfqTAOYAsISr3hshA3a
         TBg9R3Z1SHC2UGXdw8BCXi6rHZIRDZtOdikrABGsyhcdzeq5b/IGqoJSPqpE5QVGXHqQ
         0s3wPa/jL1pbS2dvZQUfYk64yQXdXfN4F8AzrTqG4VZ6QyfjMVx0y6RbfAbsEiplxEf2
         9ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to;
        bh=w0jqfbg3kgGx+9Z78D7E7J2qiluF5r+yauiuia9Gi94=;
        b=pykMIrynkEWHLmKTRDxueuQkXNOLyNX7QrcMSgeSSNtOR//ZIDw1qCMHQB7JShErNw
         oh1UCc+ad6a21OI0umPzKKnW6HVoFakn45GwttV4XP/15JU9XgAdhYrhMUonr4+WVS4e
         qT1B+4aJzWoLU63xu3yipS/SsX6dava86Yz9KJWcfvddvrYGIkEos/SX8i5Pdn3H9t6h
         y+4JL9TEqpOXh/lqCLtc+ZgNDoKXvfpj3LRIslnQAsQKX/kH3MZ04DLS7/XnaeGFc1X7
         PV82AC7LvjzTF4R0P5ggsAmgcY3wRsIrkazIiM2GAAuRvUJRnaPT7Z+hUyw/KOKKqRWu
         oqRw==
X-Gm-Message-State: AOAM531RrZ5EfvDEHnfCGwGnjqY663HdZ4cLp09wZC74URJzKtkh27MA
        JQCb8n/MHItHMICfK2fmc6D8bySeRzFG6w==
X-Google-Smtp-Source: ABdhPJyGa3DDzt7CAoLBTK37oU5Db6XWQNQxy+X+vN74nplOFl0M13XxUEvQB5JOKPVjrJt7L6HBGQ==
X-Received: by 2002:a05:620a:4108:: with SMTP id j8mr882890qko.131.1643514007777;
        Sat, 29 Jan 2022 19:40:07 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id l12sm4207982qtk.25.2022.01.29.19.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 19:40:06 -0800 (PST)
Message-ID: <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
Date:   Sat, 29 Jan 2022 22:40:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MRZyEwVq3lbW9Otr8cYDy7pf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MRZyEwVq3lbW9Otr8cYDy7pf
Content-Type: multipart/mixed; boundary="------------9R0WQB06qXIj0bYyjtKAQ77I";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>

--------------9R0WQB06qXIj0bYyjtKAQ77I
Content-Type: multipart/mixed; boundary="------------BOi4hxMK3aumvkUoIxQfuwDU"

--------------BOi4hxMK3aumvkUoIxQfuwDU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1/26/22 17:41, Paul Moore wrote:
> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
> <demiobenour@gmail.com> wrote:
>> On 1/25/22 17:27, Paul Moore wrote:
>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>> <demiobenour@gmail.com> wrote:
>>>>
>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELi=
nux
>>>> always allows too.  Furthermore, a failed FIOCLEX could result in a =
file
>>>> descriptor being leaked to a process that should not have access to =
it.
>>>>
>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>> ---
>>>>  security/selinux/hooks.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>
>>> I'm not convinced that these two ioctls should be exempt from SELinux=

>>> policy control, can you explain why allowing these ioctls with the
>>> file:ioctl permission is not sufficient for your use case?  Is it a
>>> matter of granularity?
>>
>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not jus=
t
>> files.  If I want to allow them with SELinux policy, I have to grant
>> *:ioctl to all processes and use xperm rules to determine what ioctls
>> are actually allowed.  That is incompatible with existing policies and=

>> needs frequent maintenance when new ioctls are added.
>>
>> Furthermore, these ioctls do not allow one to do anything that cannot
>> already be done by fcntl(F_SETFD), and (unless I have missed something=
)
>> SELinux unconditionally allows that.  Therefore, blocking these ioctls=

>> does not improve security, but does risk breaking userspace programs.
>> The risk is especially great because in the absence of SELinux, I
>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,=

>> a file descriptor can be leaked to a child process that should not hav=
e
>> access to it, but which SELinux allows access to.  Userspace
>> SELinux-naive sandboxes are one way this could happen.  Therefore,
>> blocking FIOCLEX may *create* a security issue, and it cannot solve on=
e.
>=20
> I can see you are frustrated with my initial take on this, but please
> understand that excluding an operation from the security policy is not
> something to take lightly and needs discussion.  I've added the
> SELinux refpolicy list to this thread as I believe their input would
> be helpful here.

Absolutely it is not something that should be taken lightly, though I
strongly believe it is correct in this case.  Is one of my assumptions
mistaken?

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------BOi4hxMK3aumvkUoIxQfuwDU
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------BOi4hxMK3aumvkUoIxQfuwDU--

--------------9R0WQB06qXIj0bYyjtKAQ77I--

--------------MRZyEwVq3lbW9Otr8cYDy7pf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmH2CJUACgkQsoi1X/+c
IsHbkxAAzWcvHC1yTM5dZ19VxWITnYkcZQWvxzHjQWieTzun4Im67UnQSYmtjGOO
Nds7rl+4R429G9leYx9gNHFcfT5gMeHXpvIbmL0C/UrwAjvWIB8Iaeig9tUuXnxa
Z0RlRmjVBOd6DqstB4Dn9k0ZkUNDOrPgUvYL2cnLisss2dnP6hO6+7Ddcyrq3n4A
RPl+lkzk6DioP8J4Ye54pcGczGM03vSz7+kaH71xpznnJNitbsrHRKQmleRw6FU+
wUneOzAxOsTgpTfXiea/QuNRLlRpH3UFBHucQTTgk30cy23dqLv/xsXrVVt2F0AJ
z7zyNu0/pXJNTbbR1O5lTXrynoU2VsL2tzYiMl/CU6H7hJeMIrk5WasEOWOvQDsw
YpVTE/xE4fmMMc6cKg2zVXb6ALc8Hh4OvL6SE9YP60T2ZAb91uXs8chXJnPmDiyx
4wQnQolyaTJey0TNCcWmRBKib+9qWocGO3U51vlq077encCBNZrxUKyCOOmNxhpu
e6ofBa2L68gQuPhBry0MtOKBIW4yuTLAwbVnmtV4XP9Kln9PVjtYEVOpfcZcWOFa
iku7QciRkBsPt6VpnA8W30xiuKu4wO0UaXZeKN82Qk8hBUYixW4e60sau1U2TfYg
G0UtLUA8bgEtQ1Nvy8UG7Qy8WG+2U6NMECcIs58llqqUq4NqaJo=
=DD2E
-----END PGP SIGNATURE-----

--------------MRZyEwVq3lbW9Otr8cYDy7pf--
