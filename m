Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67A4EE6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiDADYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiDADY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:24:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD425E310
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:22:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so1411531eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdauwCHmvbbvImMgP4K9wRmxt+jBRFf1cw9qB07n2kA=;
        b=FP+aiRHeVmO30anLjOmrxa48MfTrIkItmMOH8SSeAclp1WT+WOtFTwGXAOnKsGH9Er
         Hs3WsVAWpshoNIme1hJp70KrDKqQdwxrOCGLe/++IBVU13Gi1wC0L/s4KRb/RvbyOtz0
         J6pM5wfO72LWIv53FjaEcpkR8JavUiQvMi6TUdUP8+ltUq1lCCb1DS83NDIAH+wrmJc+
         w4EI8PigFKOWKQcimuKbXcBoLLO4gWeuzdhzGkIR7rsPoor2NUJZLGanCSeOFeBcMO9I
         6ozUiDC0abTaQyvx+QScQ+VeTvPzOJX7jGdB03If+iPoCd0RV/FNjKaUMhdJuqGbyDpD
         b1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdauwCHmvbbvImMgP4K9wRmxt+jBRFf1cw9qB07n2kA=;
        b=qBCN9jd9lK8kaokV+2St+kApMmvenR+1V7b+Um0zEvtJcvNhbutxVnVNJ5v1GAGmj2
         vPTukkmEBN97C6Ql/O8kGQaQMD2/DzWAu6Ud5eW8FQmEaxvYzWK4obsIma+wd6LBuTiM
         XnMQpZ2FvIEsD9gnW+u93yIUC6AIPz7KoSYrxlOwnxUCrrA+rWzZqdWJ7+dh6qLtLKjr
         ZHUKu63CVHW0HlG7T0QxPygRXMrddVL0EqLbEKMHykiT8ld3amtNAyGU53Tx37SjqlKb
         LmTbqkWJmuT31YGqXEALLrGV3mSihhlqMbQ8eVOjznTVl76bTrRSQ1MlQabcSAZHK53O
         1GzQ==
X-Gm-Message-State: AOAM533IyiwBMjfWs2pCdEdIEetxy6Hjx3Kx0S+AJCYsmP2Ugrw4gED2
        k+soG2vxdU5t3Y8GgCVwn2E=
X-Google-Smtp-Source: ABdhPJx9LKpDuOjtyECXrBpTU7ySJHLKMGTdwL/xuQyDw85XjHmtkA5kUiiCOgOmwx9jDjZOKJGEkA==
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id f20-20020a056402005400b004199b58e305mr19115464edu.158.1648783358200;
        Thu, 31 Mar 2022 20:22:38 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm597980edw.75.2022.03.31.20.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 20:22:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220401011533.GA29696@louislifei-OptiPlex-7050>
Date:   Fri, 1 Apr 2022 05:22:36 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>, h.j.bos@vu.nl
Content-Transfer-Encoding: quoted-printable
Message-Id: <F54F358F-FFBC-4D6D-AB5C-9BC4A617C9BF@gmail.com>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
 <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
 <20220401011533.GA29696@louislifei-OptiPlex-7050>
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


> On 1. Apr 2022, at 03:15, Li Fei1 <fei1.li@intel.com> wrote:
>=20
> On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
>>=20
>>> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>=20
>>> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
>>>> The condition retry =3D=3D 0 is theoretically possible even if =
'client'
>>>> does not point to a valid element because no break was hit.
>>>>=20
>>>> To only execute the dev_warn if actually a break within the loop =
was
>>>> hit, a separate variable is used that is only set if it is ensured =
to
>>>> point to a valid client struct.
>>>>=20
>>> Hi Koschel
>>>=20
>>> Thanks for you to help us to try to improve the code. Maybe you =
don't get the point.
>>> The dev_warn should only been called when has_pending =3D true && =
retry =3D=3D 0
>>=20
>> Maybe I don't understand but looking isolated at this function I =
could see a way to call
>> the dev_warn() with has_pending =3D false && retry =3D=3D 0.
> Yes, even has_pending =3D true && retry =3D=3D 0 at the beginning, we =
could not make sure
> has_pending is true after schedule_timeout_interruptible and we even =
didn't check
> there're other pending client on the ioreq_clients (because we can't =
make sure
> when we dev_warn this clent is still pending). So we just use dev_warn =
not higher log level.

I'm sorry, I don't quite understand what you mean by that.
Do you agree that has_pending =3D false && retry =3D=3D 0 is possible =
when calling the dev_warn()
or not?

>>=20
>>> 		list_for_each_entry(client, &vm->ioreq_clients, list) {
>>> 			has_pending =3D has_pending_request(client);
>>> 			if (has_pending)
>>> 		}
>>> 		spin_unlock_bh(&vm->ioreq_clients_lock);
>>=20
>> imagine has_pending =3D=3D false && retry =3D=3D 1 here, then client =
will not hold a valid list entry.
> What do you mean "client will not hold a valid list entry" ?=20

Imagine a very simple example:

	struct acrn_ioreq_client *client;
	list_for_each_entry(client, &vm->ioreq_clients, list) {
		continue;
	}

	dev_warn(acrn_dev.this_device,
		 "%s cannot flush pending request!\n", client->name); /* =
NOT GOOD */


Since there is no break for the list_for_each_entry() iterator to return =
early,
client *cannot* be a valid entry of the list. In fact if you look at the =
list_for_each_entry()
macro, it will be an 'bogus' pointer, pointing somewhere into 'vm'.
Essentially before the terminating condition of the list traversal the =
following code is called:

	list_entry(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);

resulting in a:

	container_of(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);

&vm->ioreq_clients however is not contained in a struct =
acrn_ioreq_client, making
this call compute an invalid pointer.
Therefore using 'client' as in the example above (e.g. client->name) =
after the loop is
not safe. Since the loop can never return early in the simple example =
above it will
always break. On other cases (the one we are discussing here) there =
might be a chance that
there is one code path (in theory) where the loop did not exit early and =
'client'
holds that 'invalid entry'.

This would be the case with has_pending =3D false && retry =3D=3D 0.

I hope this makes sense.

>=20
>>=20
>>>=20
>>> 		if (has_pending)
>>> 			schedule_timeout_interruptible(HZ / 100);
>>> 	} while (has_pending && --retry > 0);
>>=20
>> since has_pending && --retry > 0 is no longer true the loop stops.
>>=20
>>> 	if (retry =3D=3D 0)
>>> 		dev_warn(acrn_dev.this_device,
>>> 			 "%s cannot flush pending request!\n", =
client->name);
>> client->name is accessed since retry =3D=3D 0 now, but client is not =
a valid struct ending up
>> in a type confusion.
>>=20
>>>=20
>>> If retry > 0 and has_pending is true, we would call =
schedule_timeout_interruptible
>>> to schedule out to wait all the pending I/O requests would been =
completed.
>>>=20
>>> Thanks.
>>=20
>> Again, I'm not sure if this is realistically possible. I'm trying to =
remove
>> any use of the list iterator after the loop to make such potentially =
issues detectable
> You may think we still in the loop (could we ?), even that we didn't =
write the list iterator then.

I'm not exactly sure which loop you are referring to but no, I don't =
think we are still in
the do while loop.

The only thing we know after the do while loop is that: !has_pending || =
retry =3D=3D 0
And iff has_pending && retry =3D=3D 0, then we shouldn't call the =
dev_warn().

>> at compile time instead of relying on certain (difficult to maintain) =
conditions to be met
>> to avoid the type confusion.
>>=20
>> Thanks,
>> Jakob

	Jakob

