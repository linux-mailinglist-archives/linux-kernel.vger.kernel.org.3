Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008C4EE9FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbiDAIwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344218AbiDAIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:52:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A91F9759
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:50:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x34so2121450ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yzp7XklFa0s/0oycQPM1J6b4yVmYoXc9dppD9B4NryU=;
        b=emw3hH085ajeTdirCnNqAFdkL0hY86xj44t6ZKZ9GH8sEf+9THEXOQHq+eXQaYz5n+
         8RCzrAO2UDMwmjwZ9AHQoQCteTjBaKoefNB8SfIBzMhfv76pQ+rFGSyvSVyZZ7RqMxRN
         aa87iy9pnxLjVeCrooS6GmDOHv0xtWMxt3cpc57H7UyC0S9G0Z5cIqhP5k96hMZ9mlbm
         rrVnTBR5VG77OzTYk6hzGejtSG0eF1dGq1fvN/cy8f2s1pMR/mYr6E6W0+XnLs5UR8+N
         mSAbMdyG6gwPwmsz//mO5pI5kKKm7WckEaqADuc9iY3R5ccjQPZyNZGaGjq+KkyfcdZ8
         0gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yzp7XklFa0s/0oycQPM1J6b4yVmYoXc9dppD9B4NryU=;
        b=5gN3Z1IEbbZbgzOwXYMu9y5L9M4GUN+UKDp9vK8GwZbxaTFL41H3Wp7MiMLQXHnF27
         eEpBZCGqmS5DBlQx5F3N0efMknohQpUVrnlGX7WBPLOQYyCplR40N6XdRR62rs42hHNb
         XhkQN7IcG6UCLdIoCPUkV2xYENNs8s9TP2uA7d9BbYdz3NDbxiUgpDjCavSG2yPy54Kk
         yA65/ZkAAQNZXW2QLjHFm4ERvEvEk38WTUch9SQBcuqjwAK/xP2g10kjhQBg9gRnh60V
         Uh+87Z1ZqXf36LOt0c/XTzgXKd0ZrhjG4Qa/e0hkH8/pm/rkJ/Uct7YUuAsGr6d9u1Ms
         yGWg==
X-Gm-Message-State: AOAM531shpIRwQOjrhNhi1puWhMXdNt60oaIdI9h8ymkiceTCvV7/EEk
        h2+zuj8wsFQLY8Es5VjEsCE=
X-Google-Smtp-Source: ABdhPJwxVxK2VfDCfaiN2G4yfQZuyTX4zrkeFaRIy1APN7uYkGbfC09j/FxcmrakxwTOHd41ljkB7Q==
X-Received: by 2002:a05:6402:1293:b0:418:fe9d:99c3 with SMTP id w19-20020a056402129300b00418fe9d99c3mr20169804edv.146.1648803053497;
        Fri, 01 Apr 2022 01:50:53 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm911540edt.70.2022.04.01.01.50.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 01:50:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220401075711.GA31912@louislifei-OptiPlex-7050>
Date:   Fri, 1 Apr 2022 10:50:51 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>, h.j.bos@vu.nl
Content-Transfer-Encoding: quoted-printable
Message-Id: <65660B0C-8888-4283-80E4-D1A334EEF166@gmail.com>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
 <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
 <20220401011533.GA29696@louislifei-OptiPlex-7050>
 <F54F358F-FFBC-4D6D-AB5C-9BC4A617C9BF@gmail.com>
 <20220401035742.GA31162@louislifei-OptiPlex-7050>
 <CE06BFFA-93CA-4E25-AB63-524C3F293556@gmail.com>
 <20220401075711.GA31912@louislifei-OptiPlex-7050>
To:     Li Fei1 <fei1.li@intel.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1. Apr 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>=20
> On Fri, Apr 01, 2022 at 09:16:48AM +0200, Jakob Koschel wrote:
>>=20
>>=20
>>> On 1. Apr 2022, at 05:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>=20
>>> On Fri, Apr 01, 2022 at 05:22:36AM +0200, Jakob Koschel wrote:
>>>>=20
>>>>> On 1. Apr 2022, at 03:15, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>=20
>>>>> On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
>>>>>>=20
>>>>>>> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>>>=20
>>>>>>> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
>>>>>>>> The condition retry =3D=3D 0 is theoretically possible even if =
'client'
>>>>>>>> does not point to a valid element because no break was hit.
>>>>>>>>=20
>>>>>>>> To only execute the dev_warn if actually a break within the =
loop was
>>>>>>>> hit, a separate variable is used that is only set if it is =
ensured to
>>>>>>>> point to a valid client struct.
>>>>>>>>=20
>>>>>>> Hi Koschel
>>>>>>>=20
>>>>>>> Thanks for you to help us to try to improve the code. Maybe you =
don't get the point.
>>>>>>> The dev_warn should only been called when has_pending =3D true =
&& retry =3D=3D 0
>>>>>>=20
>>>>>> Maybe I don't understand but looking isolated at this function I =
could see a way to call
>>>>>> the dev_warn() with has_pending =3D false && retry =3D=3D 0.
>>>>> Yes, even has_pending =3D true && retry =3D=3D 0 at the beginning, =
we could not make sure
>>>>> has_pending is true after schedule_timeout_interruptible and we =
even didn't check
>>>>> there're other pending client on the ioreq_clients (because we =
can't make sure
>>>>> when we dev_warn this clent is still pending). So we just use =
dev_warn not higher log level.
>>>>=20
>>>> I'm sorry, I don't quite understand what you mean by that.
>>>> Do you agree that has_pending =3D false && retry =3D=3D 0 is =
possible when calling the dev_warn()
>>>> or not?
>>>>=20
>>> Yes, so what ? It just a hint there may have pending request.
>>=20
>> if has_pending =3D=3D false && retry =3D=3D 0 when calling dev_warn() =
there are very clear
>> dependencies met:
>>=20
>> * has_pending =3D=3D false means that the list_for_each_entry() macro =
it *not* exit early.
>> * since list_for_each_entry() did *not* exit early, client will not =
hold a valid list entry
>> * using client->name is not safe and will not point to a valid string =
(perhaps not even an address)
> So you'd better to check when the client in ioreq_clients would been =
destroyed, right ?

I'm afraid I don't know exactly what you mean here.

More specifically:
to check what? and I'm also not sure what you mean with "when client in =
ioreq_clients would been destroyed".

Actually thinking about it more the check should be

	if (client && retry =3D=3D 0)

to be correct.

if has_pending =3D=3D false I read the code as if no client was found =
that has a pending request=20
so I don't follow how:

	"%s cannot flush pending request!\n", client->name);

can be valid since no client has a pending request.

>=20
>>=20
>> I'm *only* talking about the case where has_pending =3D=3D false, in =
case that's not clear.
>>=20
>>=20
>>> Even retry =3D=3D 0 && has_pending =3D true,
>>> When we call dev_warn, the clent may not is pending.
>>>=20
>>>=20
>>>>>>=20
>>>>>>> 		list_for_each_entry(client, &vm->ioreq_clients, =
list) {
>>>>>>> 			has_pending =3D =
has_pending_request(client);
>>>>>>> 			if (has_pending)
>>>>>>> 		}
>>>>>>> 		spin_unlock_bh(&vm->ioreq_clients_lock);
>>>>>>=20
>>>>>> imagine has_pending =3D=3D false && retry =3D=3D 1 here, then =
client will not hold a valid list entry.
>>>>> What do you mean "client will not hold a valid list entry" ?=20
>>>>=20
>>>> Imagine a very simple example:
>>>>=20
>>>> 	struct acrn_ioreq_client *client;
>>>> 	list_for_each_entry(client, &vm->ioreq_clients, list) {
>>>> 		continue;
>>>> 	}
>>>>=20
>>>> 	dev_warn(acrn_dev.this_device,
>>>> 		 "%s cannot flush pending request!\n", client->name); /* =
NOT GOOD */
>>>>=20
>>> If there're pending request, we would call schedule to schedule out =
then schedule back
>>> to check the list from the beginning. If there's no pending client, =
we point to the last
>>> client and break out the while loop.
>>>=20
>>> The code doesn't want to find the pending client and break out the =
while loop and call
>>> dev_warn. Please see the function comment.
>>>=20
>>>=20
>>>>=20
>>>> Since there is no break for the list_for_each_entry() iterator to =
return early,
>>>> client *cannot* be a valid entry of the list. In fact if you look =
at the list_for_each_entry()
>>>> macro, it will be an 'bogus' pointer, pointing somewhere into 'vm'.
>>>> Essentially before the terminating condition of the list traversal =
the following code is called:
>>>>=20
>>>> 	list_entry(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);
>>>>=20
>>>> resulting in a:
>>>>=20
>>>> 	container_of(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);
>>>>=20
>>>> &vm->ioreq_clients however is not contained in a struct =
acrn_ioreq_client, making
>>>> this call compute an invalid pointer.
>>>> Therefore using 'client' as in the example above (e.g. =
client->name) after the loop is
>>>> not safe. Since the loop can never return early in the simple =
example above it will
>>>> always break. On other cases (the one we are discussing here) there =
might be a chance that
>>>> there is one code path (in theory) where the loop did not exit =
early and 'client'
>>>> holds that 'invalid entry'.
>>>>=20
>>>> This would be the case with has_pending =3D false && retry =3D=3D =
0.
>>>>=20
>>>> I hope this makes sense.
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> 		if (has_pending)
>>>>>>> 			schedule_timeout_interruptible(HZ / =
100);
>>>>>>> 	} while (has_pending && --retry > 0);
>>>>>>=20
>>>>>> since has_pending && --retry > 0 is no longer true the loop =
stops.
>>>>>>=20
>>>>>>> 	if (retry =3D=3D 0)
>>>>>>> 		dev_warn(acrn_dev.this_device,
>>>>>>> 			 "%s cannot flush pending request!\n", =
client->name);
>>>>>> client->name is accessed since retry =3D=3D 0 now, but client is =
not a valid struct ending up
>>>>>> in a type confusion.
>>>>>>=20
>>>>>>>=20
>>>>>>> If retry > 0 and has_pending is true, we would call =
schedule_timeout_interruptible
>>>>>>> to schedule out to wait all the pending I/O requests would been =
completed.
>>>>>>>=20
>>>>>>> Thanks.
>>>>>>=20
>>>>>> Again, I'm not sure if this is realistically possible. I'm trying =
to remove
>>>>>> any use of the list iterator after the loop to make such =
potentially issues detectable
>>>>> You may think we still in the loop (could we ?), even that we =
didn't write the list iterator then.
>>>>=20
>>>> I'm not exactly sure which loop you are referring to but no, I =
don't think we are still in
>>>> the do while loop.
>>>>=20
>>>> The only thing we know after the do while loop is that: =
!has_pending || retry =3D=3D 0
>>>> And iff has_pending && retry =3D=3D 0, then we shouldn't call the =
dev_warn().
>>>>=20
>>>>>> at compile time instead of relying on certain (difficult to =
maintain) conditions to be met
>>>>>> to avoid the type confusion.
>>>>>>=20
>>>>>> Thanks,
>>>>>> Jakob
>>>>=20
>>>> 	Jakob
>>=20
>> 	Jakob

