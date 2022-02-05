Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF44AA910
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379946AbiBENON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiBENOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:14:11 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F6C061346;
        Sat,  5 Feb 2022 05:14:10 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id x5so8096868qtw.10;
        Sat, 05 Feb 2022 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=WB5wLGbvwgP2FSnj6MKVGHrU+EU4Jhs6mbfln1sSCtE=;
        b=YWnUvjB7mnRmZWmhMmW4hSBHaaQE6p70mY8of5d4DrGMwtEtvO4Rvp6KYJoiUGbMUr
         B0DzBv1ZMeyx4PTJK7F8zIsf00cP+WCU2Pe4uOls+BXXve6riU//K9OOLJWD+iX8OhfY
         IH3UF2ndbATUvoEtDogb4Se9c3zbmxffZxhYg2KnI3GmH55xeNg+WyQrRxzfIm65rlCC
         MVrMLJtXErQlBsZtSE0TgtuMNAfcZ5/5Trad9ENEAx9AIofGTDCQjFnlZ+solJ0J2ZAe
         xRABNQcqnOqfGC0BNYjbQymnG6JDEKnSRba38ieoW3N9Mtb4GwU4OHoBCgkLGQvZcR0U
         HOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=WB5wLGbvwgP2FSnj6MKVGHrU+EU4Jhs6mbfln1sSCtE=;
        b=DSDMrnFsdi1rx66VGIbRikAUi+6XUTZu4deS+vXseEDDIYQEBeEFoQEy8CzlY98VpK
         Gr05zCN3/Bx8E/Jo+Zw/34UaOXNQnFCTWw9RX0Jtw+hZ5sdH7wdbHS4OpIpXeozc9m69
         nU339+lMZB0Z9xhHpPG+gkbQVE7Hx6ezb4V/rutoRi5r4ImrzVnzke8hS3LVCKIeYEqF
         FrxhaTu8zvZCN+Xf1tIzpsYCcqZkMKk9VENQi90SEhB9PyUiHFXnz0o0fxROnDssXaTK
         ClJHT6k7nhwSpJV9jtA2kJYiBw+JhBnCdPnbY35pmzpPgESxhFzYE18ytxs+qaKW+llt
         1o0A==
X-Gm-Message-State: AOAM530BqnsGSD/gJsfbi8lLsiDBo+MQ9hJhmlznVMeSY69U09jiucCC
        gEn7Q0sOLX+pj0mhiCxQ4y0=
X-Google-Smtp-Source: ABdhPJyYkyAhnrlWU/0HLkYCmmbAgONDHkFtxpG6X+8A9HSknPV5x98U7ax1Pqo70xDEPvFKYA9FmA==
X-Received: by 2002:ac8:7f82:: with SMTP id z2mr2441833qtj.591.1644066849763;
        Sat, 05 Feb 2022 05:14:09 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id d6sm2796808qtb.55.2022.02.05.05.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 05:14:08 -0800 (PST)
Message-ID: <4e91ecbb-4e40-8940-4f58-46e4e9cb20f6@gmail.com>
Date:   Sat, 5 Feb 2022 08:13:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Content-Language: en-US
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl>
From:   Demi Marie Obenour <demiobenour@gmail.com>
In-Reply-To: <875ypt5zmz.fsf@defensec.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pM20j06OtWk1TPiE0T20aZvG"
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
--------------pM20j06OtWk1TPiE0T20aZvG
Content-Type: multipart/mixed; boundary="------------eSWZw9wJyLfKkliFa8xC7Iyv";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Dominick Grift <dominick.grift@defensec.nl>,
 Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <4e91ecbb-4e40-8940-4f58-46e4e9cb20f6@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl>
In-Reply-To: <875ypt5zmz.fsf@defensec.nl>

--------------eSWZw9wJyLfKkliFa8xC7Iyv
Content-Type: multipart/mixed; boundary="------------NekUK0wi6SQVoistnjgDEnzR"

--------------NekUK0wi6SQVoistnjgDEnzR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/5/22 06:19, Dominick Grift wrote:
> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
>=20
>> On 2/3/2022 18:44, Paul Moore wrote:
>>> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.=
com> wrote:
>>>> On 2/1/22 12:26, Paul Moore wrote:
>>>>> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
>>>>> <demiobenour@gmail.com> wrote:
>>>>>> On 1/26/22 17:41, Paul Moore wrote:
>>>>>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>> On 1/25/22 17:27, Paul Moore wrote:
>>>>>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), whic=
h SELinux
>>>>>>>>>> always allows too.  Furthermore, a failed FIOCLEX could result=
 in a file
>>>>>>>>>> descriptor being leaked to a process that should not have acce=
ss to it.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>   security/selinux/hooks.c | 5 +++++
>>>>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>>>
>>>>>>>>> I'm not convinced that these two ioctls should be exempt from S=
ELinux
>>>>>>>>> policy control, can you explain why allowing these ioctls with =
the
>>>>>>>>> file:ioctl permission is not sufficient for your use case?  Is =
it a
>>>>>>>>> matter of granularity?
>>>>>>>>
>>>>>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, n=
ot just
>>>>>>>> files.  If I want to allow them with SELinux policy, I have to g=
rant
>>>>>>>> *:ioctl to all processes and use xperm rules to determine what i=
octls
>>>>>>>> are actually allowed.  That is incompatible with existing polici=
es and
>>>>>>>> needs frequent maintenance when new ioctls are added.
>>>>>>>>
>>>>>>>> Furthermore, these ioctls do not allow one to do anything that c=
annot
>>>>>>>> already be done by fcntl(F_SETFD), and (unless I have missed som=
ething)
>>>>>>>> SELinux unconditionally allows that.  Therefore, blocking these =
ioctls
>>>>>>>> does not improve security, but does risk breaking userspace prog=
rams.
>>>>>>>> The risk is especially great because in the absence of SELinux, =
I
>>>>>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspac=
e
>>>>>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ig=
nored,
>>>>>>>> a file descriptor can be leaked to a child process that should n=
ot have
>>>>>>>> access to it, but which SELinux allows access to.  Userspace
>>>>>>>> SELinux-naive sandboxes are one way this could happen.  Therefor=
e,
>>>>>>>> blocking FIOCLEX may *create* a security issue, and it cannot so=
lve one.
>>>>>>>
>>>>>>> I can see you are frustrated with my initial take on this, but pl=
ease
>>>>>>> understand that excluding an operation from the security policy i=
s not
>>>>>>> something to take lightly and needs discussion.  I've added the
>>>>>>> SELinux refpolicy list to this thread as I believe their input wo=
uld
>>>>>>> be helpful here.
>>>>>>
>>>>>> Absolutely it is not something that should be taken lightly, thoug=
h I
>>>>>> strongly believe it is correct in this case.  Is one of my assumpt=
ions
>>>>>> mistaken?
>>>>>
>>>>> My concern is that there is a distro/admin somewhere which is relyi=
ng
>>>>> on their SELinux policy enforcing access controls on these ioctls a=
nd
>>>>> removing these controls would cause them a regression.
>>>>
>>>> I obviously do not have visibility into all systems, but I suspect t=
hat
>>>> nobody is actually relying on this.  Setting and clearing CLOEXEC vi=
a
>>>> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
>>>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
>>>> blocked by seccomp or another LSM.  Clearing close-on-exec can also =
be
>>>> implemented with dup2(), and setting it can be implemented with dup3=
()
>>>> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believ=
e
>>>> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-worl=
d
>>>> problems, and that it is highly unlikely that anyone is relying on t=
he
>>>> current behavior.
>>> I understand your point, but I remain concerned about making a
>>> kernel
>>> change for something that can be addressed via policy.  I'm also
>>> concerned that in the nine days this thread has been on both the mail=

>>> SELinux developers and refpolicy lists no one other than you and I
>>> have commented on this patch.  In order to consider this patch
>>> further, I'm going to need to see comments from others, preferably
>>> those with a background in supporting SELinux policy.
>>> Also, while I'm sure you are already well aware of this, I think it
>>> is
>>> worth mentioning that SELinux does apply access controls when file
>>> descriptors are inherited across an exec() boundary.
>>
>>
>> I don't have a strong opinion either way.  If one were to allow this
>> using a policy rule, it would result in a major policy breakage.  The =

>> rule would turn on extended perm checks across the entire system,
>> which the SELinux Reference Policy isn't written for.  I can't speak
>> to the Android policy, but I would imagine it would be the similar
>> problem there too.
>=20
> Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
> xperm checks across the entire system.
>=20
> If i am not mistaken it will turn on xperm checks only for the
> operations that have the same source and target/target class.

Correct, but to emulate my patch one would need to use xperm rules
for all source and target classes.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------NekUK0wi6SQVoistnjgDEnzR
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3Dx+Ro
-----END PGP PUBLIC KEY BLOCK-----

--------------NekUK0wi6SQVoistnjgDEnzR--

--------------eSWZw9wJyLfKkliFa8xC7Iyv--

--------------pM20j06OtWk1TPiE0T20aZvG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmH+eBsACgkQsoi1X/+c
IsGB4BAAruLzJZMLElQzhCTNbLlgGnAeK6FZ3dvk7APEkRpOAxGX4q2LZ7B71DrZ
0vikMQ6ITnNdGczgQY3BopOx3MI2r4Moqi4NgZNWYQmFLt/LYYSfsah7yA7URm7Z
1hx7lkYiRC78gWqeY9f/kUeVRVu3IEdG8ETQ9BhDH0DTVsjT29lFZoT7xGmL8F27
h/5dTBiby791Lm1C2+DiyiW735GscZslWr7qBQ21sHJYUtnPhsoalCF1R2yr9HrL
HvO+S1h5q/tS5hrOwlMSt309GVpk4ScfxnCUpOYpCLTbHVu2Uj1TM41AKBBKMp52
Qdo41qvC1YI94Nbz3dBPXGLYDnPXL/X2Grc9EDFWhDBbBr85X78gST7fHOacJebj
t4Sepw7N2f1S4rvbm56dARuld5S8NBy4QYEtDNxAlVeuHoa/lyuZ1TPF+qgt3Ikq
HGJ153Bxcu2Dwd1yu3EDRif6uilspQZivJvEjJepIV8FmGNyih/bxU015gk7t+Bo
5rKYlOXodWfcfNKJCwZZPUD6ytXE1I2Ah8+Tjp5LYQN359srKeQvad+E+TiFit6W
O/Xy9LN7zA6MInRpvTuw7EMDagKQ2dSzvnhYUSu+fXm/gramxpt7z4CXpNOl3WVR
gCBl+Sz7t6QIAVnHRbTHRE3y4ii4gmQUj9/Yv/vHhpVdD5a2ix8=
=aNe1
-----END PGP SIGNATURE-----

--------------pM20j06OtWk1TPiE0T20aZvG--
