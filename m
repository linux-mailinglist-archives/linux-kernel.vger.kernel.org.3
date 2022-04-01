Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4B4EEA59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiDAJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiDAJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:26:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94190CFF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:24:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so4583494ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7FBsY/AL5iSNCXHieDtIPmEsnc1wtKjsa8pYvJMKlRc=;
        b=PEOqVOKeW0qKjAjdoUarAoBv1F3YuizIfbCJzkx3SVu3GQ8rJaS+66mVzTYkpRxsfR
         HOal5YxFSxJ/lx7ln3gYC9dNauMFTkiHEn3vLNm3lJ1rKutNuSYkqAz3kJWJAp1Qp6lc
         CfPhhR7xqze/DxGIkEQ7E9I45rIJqnDmFqzJkpKbsHUKwW7v8Kv7cxvRFDkLeqLg59dw
         sj28GxHPZ92443P52WE9+wRoCfx8t322fhmHH7tRNZai070ApBTR26/khk62N3DKGJ0o
         zlDhe4+puOLylrlx/c2PXx83Ro4SufzqUsmSmMJonYDXreT9xGi7U8/y7tBTE6xos6HE
         nA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7FBsY/AL5iSNCXHieDtIPmEsnc1wtKjsa8pYvJMKlRc=;
        b=vR4Y0jNw7L0gOT+kwBqXgmWL1WiWymeEeu9pLlqufb0FNCvNSiEiU97gzhdkalot2H
         y0QCx+XGd6gRkTpPhkn9UzQcfsY/UGnEmy95B2ud6Rd4yhrn99Kul8PahY9v5G7CQywP
         97GxABzKL929JdR9sNEREWd4+0aUMaLaFyRQUi3KcsAWRNbuK4LtT85lXhes+DOxUku9
         Q5d27ppCyJ97qSMJlrBPEwKH2SEbgjkkoOf4OdbZ2JcndYcXqXNKe9DNInnFPhptJLW7
         gNJ3RbASgo/lCVFL84SgrO+to7JxxAhMCvvp9uFaLlaZqLi/+H4VovZy1b/cwolrAL9z
         InJQ==
X-Gm-Message-State: AOAM531hDZ5zHLr2KVcgsi8nCq/bbB7QisWsHjbcmQhQ0hIIVZ+8IssL
        Vkyxs6qlayM2/DElCHI4lkI=
X-Google-Smtp-Source: ABdhPJwLldg6zS81A9dIANA2u9TPDPSpFOISbagR3YPeiBl/9F1JnaGpqqp5n3gX7lRoqGPlcL7+Nw==
X-Received: by 2002:a17:906:d41:b0:6ce:78b0:8113 with SMTP id r1-20020a1709060d4100b006ce78b08113mr8531287ejh.357.1648805084239;
        Fri, 01 Apr 2022 02:24:44 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm939744edt.94.2022.04.01.02.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 02:24:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220401091259.GA32221@louislifei-OptiPlex-7050>
Date:   Fri, 1 Apr 2022 11:24:43 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rppt@kernel.org, bjohannesmeyer@gmail.com, c.giuffrida@vu.nl,
        h.j.bos@vu.nl
Content-Transfer-Encoding: quoted-printable
Message-Id: <4198F3E8-7FBF-4A54-9AD3-C8599AA2702F@gmail.com>
References: <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
 <20220401011533.GA29696@louislifei-OptiPlex-7050>
 <F54F358F-FFBC-4D6D-AB5C-9BC4A617C9BF@gmail.com>
 <20220401035742.GA31162@louislifei-OptiPlex-7050>
 <CE06BFFA-93CA-4E25-AB63-524C3F293556@gmail.com>
 <20220401075711.GA31912@louislifei-OptiPlex-7050>
 <65660B0C-8888-4283-80E4-D1A334EEF166@gmail.com>
 <20220401090545.GA32168@louislifei-OptiPlex-7050>
 <0607BE1D-B2A6-4B93-9B4C-C04715B41E8C@gmail.com>
 <20220401091259.GA32221@louislifei-OptiPlex-7050>
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



> On 1. Apr 2022, at 11:12, Li Fei1 <fei1.li@intel.com> wrote:
>=20
> On Fri, Apr 01, 2022 at 11:08:02AM +0200, Jakob Koschel wrote:
>>=20
>>=20
>>> On 1. Apr 2022, at 11:05, Li Fei1 <fei1.li@intel.com> wrote:
>>>=20
>>> On Fri, Apr 01, 2022 at 10:50:51AM +0200, Jakob Koschel wrote:
>>>>=20
>>>>=20
>>>>> On 1. Apr 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>=20
>>>>> On Fri, Apr 01, 2022 at 09:16:48AM +0200, Jakob Koschel wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On 1. Apr 2022, at 05:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>>>=20
>>>>>>> On Fri, Apr 01, 2022 at 05:22:36AM +0200, Jakob Koschel wrote:
>>>>>>>>=20
>>>>>>>>> On 1. Apr 2022, at 03:15, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
>>>>>>>>>>=20
>>>>>>>>>>> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> =
wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel =
wrote:
>>>>>>>>>>>> The condition retry =3D=3D 0 is theoretically possible even =
if 'client'
>>>>>>>>>>>> does not point to a valid element because no break was hit.
>>>>>>>>>>>>=20
>>>>>>>>>>>> To only execute the dev_warn if actually a break within the =
loop was
>>>>>>>>>>>> hit, a separate variable is used that is only set if it is =
ensured to
>>>>>>>>>>>> point to a valid client struct.
>>>>>>>>>>>>=20
>>>>>>>>>>> Hi Koschel
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks for you to help us to try to improve the code. Maybe =
you don't get the point.
>>>>>>>>>>> The dev_warn should only been called when has_pending =3D =
true && retry =3D=3D 0
>>>>>>>>>>=20
>>>>>>>>>> Maybe I don't understand but looking isolated at this =
function I could see a way to call
>>>>>>>>>> the dev_warn() with has_pending =3D false && retry =3D=3D 0.
>>>>>>>>> Yes, even has_pending =3D true && retry =3D=3D 0 at the =
beginning, we could not make sure
>>>>>>>>> has_pending is true after schedule_timeout_interruptible and =
we even didn't check
>>>>>>>>> there're other pending client on the ioreq_clients (because we =
can't make sure
>>>>>>>>> when we dev_warn this clent is still pending). So we just use =
dev_warn not higher log level.
>>>>>>>>=20
>>>>>>>> I'm sorry, I don't quite understand what you mean by that.
>>>>>>>> Do you agree that has_pending =3D false && retry =3D=3D 0 is =
possible when calling the dev_warn()
>>>>>>>> or not?
>>>>>>>>=20
>>>>>>> Yes, so what ? It just a hint there may have pending request.
>>>>>>=20
>>>>>> if has_pending =3D=3D false && retry =3D=3D 0 when calling =
dev_warn() there are very clear
>>>>>> dependencies met:
>>>>>>=20
>>>>>> * has_pending =3D=3D false means that the list_for_each_entry() =
macro it *not* exit early.
>>>>>> * since list_for_each_entry() did *not* exit early, client will =
not hold a valid list entry
>>>>>> * using client->name is not safe and will not point to a valid =
string (perhaps not even an address)
>>>>> So you'd better to check when the client in ioreq_clients would =
been destroyed, right ?
>>>>=20
>>>> I'm afraid I don't know exactly what you mean here.
>>>>=20
>>>> More specifically:
>>>> to check what? and I'm also not sure what you mean with "when =
client in ioreq_clients would been destroyed".
>>>>=20
>>>> Actually thinking about it more the check should be
>>>>=20
>>>> 	if (client && retry =3D=3D 0)
>>>>=20
>>>> to be correct.
>>> The client in ioreq_clients would always been "valid" (here valid =
means the client struct would not
>>> been destroyed) when this function been called. That's guaranteed by =
the code logic.
>>=20
>> Now I'm very confused.
>> Didn't you say the dev_msg() can be called with has_pending =3D=3D =
false && retry =3D=3D 0?
>> Then the 'client' used in the dev_msg() cannot be valid.
> I think I would not reply you before you understand how ACRN ioreq =
works.

I've asked you before if dev_msg() can be called with such requirements. =
Here:

>> Do you agree that has_pending =3D false && retry =3D=3D 0 is possible =
when calling the dev_warn()
>> or not?
>>=20
> Yes, so what ? It just a hint there may have pending request.

I'm just making the point that in such a case 'client' cannot be valid. =
For that I don't
need to understand the entirety how ACRN ioreq. Hence I asked you that =
question.

If you can't keep this to an objective discussion I'll just leave it as =
is.

>=20
>>=20
>>>>=20
>>>> if has_pending =3D=3D false I read the code as if no client was =
found that has a pending request=20
>>>> so I don't follow how:
>>>>=20
>>>> 	"%s cannot flush pending request!\n", client->name);
>>>>=20
>>>> can be valid since no client has a pending request.
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> I'm *only* talking about the case where has_pending =3D=3D false, =
in case that's not clear.
>>>>>>=20
>>>>>>=20
>>>>>>> Even retry =3D=3D 0 && has_pending =3D true,
>>>>>>> When we call dev_warn, the clent may not is pending.
>>>>>>>=20
>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> 		list_for_each_entry(client, &vm->ioreq_clients, =
list) {
>>>>>>>>>>> 			has_pending =3D =
has_pending_request(client);
>>>>>>>>>>> 			if (has_pending)
>>>>>>>>>>> 		}
>>>>>>>>>>> 		spin_unlock_bh(&vm->ioreq_clients_lock);
>>>>>>>>>>=20
>>>>>>>>>> imagine has_pending =3D=3D false && retry =3D=3D 1 here, then =
client will not hold a valid list entry.
>>>>>>>>> What do you mean "client will not hold a valid list entry" ?=20=

>>>>>>>>=20
>>>>>>>> Imagine a very simple example:
>>>>>>>>=20
>>>>>>>> 	struct acrn_ioreq_client *client;
>>>>>>>> 	list_for_each_entry(client, &vm->ioreq_clients, list) {
>>>>>>>> 		continue;
>>>>>>>> 	}
>>>>>>>>=20
>>>>>>>> 	dev_warn(acrn_dev.this_device,
>>>>>>>> 		 "%s cannot flush pending request!\n", =
client->name); /* NOT GOOD */
>>>>>>>>=20
>>>>>>> If there're pending request, we would call schedule to schedule =
out then schedule back
>>>>>>> to check the list from the beginning. If there's no pending =
client, we point to the last
>>>>>>> client and break out the while loop.
>>>>>>>=20
>>>>>>> The code doesn't want to find the pending client and break out =
the while loop and call
>>>>>>> dev_warn. Please see the function comment.
>>>>>>>=20
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Since there is no break for the list_for_each_entry() iterator =
to return early,
>>>>>>>> client *cannot* be a valid entry of the list. In fact if you =
look at the list_for_each_entry()
>>>>>>>> macro, it will be an 'bogus' pointer, pointing somewhere into =
'vm'.
>>>>>>>> Essentially before the terminating condition of the list =
traversal the following code is called:
>>>>>>>>=20
>>>>>>>> 	list_entry(&vm->ioreq_clients, struct acrn_ioreq_client =
*, list);
>>>>>>>>=20
>>>>>>>> resulting in a:
>>>>>>>>=20
>>>>>>>> 	container_of(&vm->ioreq_clients, struct =
acrn_ioreq_client *, list);
>>>>>>>>=20
>>>>>>>> &vm->ioreq_clients however is not contained in a struct =
acrn_ioreq_client, making
>>>>>>>> this call compute an invalid pointer.
>>>>>>>> Therefore using 'client' as in the example above (e.g. =
client->name) after the loop is
>>>>>>>> not safe. Since the loop can never return early in the simple =
example above it will
>>>>>>>> always break. On other cases (the one we are discussing here) =
there might be a chance that
>>>>>>>> there is one code path (in theory) where the loop did not exit =
early and 'client'
>>>>>>>> holds that 'invalid entry'.
>>>>>>>>=20
>>>>>>>> This would be the case with has_pending =3D false && retry =3D=3D=
 0.
>>>>>>>>=20
>>>>>>>> I hope this makes sense.
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> 		if (has_pending)
>>>>>>>>>>> 			schedule_timeout_interruptible(HZ / =
100);
>>>>>>>>>>> 	} while (has_pending && --retry > 0);
>>>>>>>>>>=20
>>>>>>>>>> since has_pending && --retry > 0 is no longer true the loop =
stops.
>>>>>>>>>>=20
>>>>>>>>>>> 	if (retry =3D=3D 0)
>>>>>>>>>>> 		dev_warn(acrn_dev.this_device,
>>>>>>>>>>> 			 "%s cannot flush pending request!\n", =
client->name);
>>>>>>>>>> client->name is accessed since retry =3D=3D 0 now, but client =
is not a valid struct ending up
>>>>>>>>>> in a type confusion.
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> If retry > 0 and has_pending is true, we would call =
schedule_timeout_interruptible
>>>>>>>>>>> to schedule out to wait all the pending I/O requests would =
been completed.
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks.
>>>>>>>>>>=20
>>>>>>>>>> Again, I'm not sure if this is realistically possible. I'm =
trying to remove
>>>>>>>>>> any use of the list iterator after the loop to make such =
potentially issues detectable
>>>>>>>>> You may think we still in the loop (could we ?), even that we =
didn't write the list iterator then.
>>>>>>>>=20
>>>>>>>> I'm not exactly sure which loop you are referring to but no, I =
don't think we are still in
>>>>>>>> the do while loop.
>>>>>>>>=20
>>>>>>>> The only thing we know after the do while loop is that: =
!has_pending || retry =3D=3D 0
>>>>>>>> And iff has_pending && retry =3D=3D 0, then we shouldn't call =
the dev_warn().
>>>>>>>>=20
>>>>>>>>>> at compile time instead of relying on certain (difficult to =
maintain) conditions to be met
>>>>>>>>>> to avoid the type confusion.
>>>>>>>>>>=20
>>>>>>>>>> Thanks,
>>>>>>>>>> Jakob
>>>>>>>>=20
>>>>>>>> 	Jakob
>>>>>>=20
>>>>>> 	Jakob

