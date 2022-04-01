Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670474EE8FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiDAHSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbiDAHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:18:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05C25CBB4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:16:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h1so1912476edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MoQJAWCb5O8HKuXjQ/8E9dXCWuJaKjECxVHKf1aQxtM=;
        b=ptI2bnlTSLxejlaqrsccAxhjPJBWqtTQx37/Xejrte2+YFrPHAhgQS3HHSbWub0ZTi
         GnH24gT/A2bx/cfmYCeJwBEyUuw+r6Xgz1J5lk6iGN6B1/MBIiBFwGnjN7TbFIudVGfk
         18LOO9nz91Z1MSP76cXXHiKr35d0VEWOfxmBnSDAM3niOomosBZ10n0zwTum0PyHezpY
         ajoMICOEw9XJbh8buuVNnp6V0kvix6SxBpjjcqb06eZPhhs117+795ZUIIyWPjeWDqsz
         PpRWg1lpwjk6FQPDJ/XA8K3z9W+9CW3mD0C1sEyK8eSQ5bQmtqJdC+7LD5aE8+3ItLKy
         MgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MoQJAWCb5O8HKuXjQ/8E9dXCWuJaKjECxVHKf1aQxtM=;
        b=JAZ1OuWuGuLBn25TdgdxbF1mOJBV9IPsTn26iNSq7Br0SHMeTSjNZfqzId8pPsgxep
         1rfixjUo+s1aeaha2+jeoyR+i6GPOUw6uprfqz9t8sbaICa7p5z2PqjXM0su+crXoU6Q
         S1Xfsmmi4ZybepK/eETXPckDqnSj9MX4p6m+hkZ/bUGsrx3vtysxHRDPI/p1FdiBnf2e
         bCzNluKw2xggz1BqA5SveGku7VVjAafd68B93l9hFa0ncgY/g0Y0vACisCX9PjFOs4eT
         qAG/I16jCpTuNpiWLjMdUfIxKkU0WRYTmQmd3vmlPQymcehy+wAmPA1aPzQ7myYbAyW0
         qdKA==
X-Gm-Message-State: AOAM533OjRnBkQbbV12dg+HbfQg/vMs1qlIojObOAxjtEiVbN8TSx1YE
        ilFdIbFtKV1t2LWnA3njCU0=
X-Google-Smtp-Source: ABdhPJx1dYDEnnliev//mBN6VmW9xDfnmAP07hN2MxONU8QwngdpGSTWn6Q6fcthoaMi8aa3jNByUg==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr19817208edt.359.1648797409996;
        Fri, 01 Apr 2022 00:16:49 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id au22-20020a170907093600b006e4ad0bf8f7sm697549ejc.91.2022.04.01.00.16.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 00:16:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220401035742.GA31162@louislifei-OptiPlex-7050>
Date:   Fri, 1 Apr 2022 09:16:48 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rppt@kernel.org, bjohannesmeyer@gmail.com, c.giuffrida@vu.nl,
        h.j.bos@vu.nl
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE06BFFA-93CA-4E25-AB63-524C3F293556@gmail.com>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
 <20220330075742.GA22544@louislifei-OptiPlex-7050>
 <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
 <20220401011533.GA29696@louislifei-OptiPlex-7050>
 <F54F358F-FFBC-4D6D-AB5C-9BC4A617C9BF@gmail.com>
 <20220401035742.GA31162@louislifei-OptiPlex-7050>
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



> On 1. Apr 2022, at 05:57, Li Fei1 <fei1.li@intel.com> wrote:
>=20
> On Fri, Apr 01, 2022 at 05:22:36AM +0200, Jakob Koschel wrote:
>>=20
>>> On 1. Apr 2022, at 03:15, Li Fei1 <fei1.li@intel.com> wrote:
>>>=20
>>> On Thu, Mar 31, 2022 at 01:20:50PM +0200, Jakob Koschel wrote:
>>>>=20
>>>>> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>>>>>=20
>>>>> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
>>>>>> The condition retry =3D=3D 0 is theoretically possible even if =
'client'
>>>>>> does not point to a valid element because no break was hit.
>>>>>>=20
>>>>>> To only execute the dev_warn if actually a break within the loop =
was
>>>>>> hit, a separate variable is used that is only set if it is =
ensured to
>>>>>> point to a valid client struct.
>>>>>>=20
>>>>> Hi Koschel
>>>>>=20
>>>>> Thanks for you to help us to try to improve the code. Maybe you =
don't get the point.
>>>>> The dev_warn should only been called when has_pending =3D true && =
retry =3D=3D 0
>>>>=20
>>>> Maybe I don't understand but looking isolated at this function I =
could see a way to call
>>>> the dev_warn() with has_pending =3D false && retry =3D=3D 0.
>>> Yes, even has_pending =3D true && retry =3D=3D 0 at the beginning, =
we could not make sure
>>> has_pending is true after schedule_timeout_interruptible and we even =
didn't check
>>> there're other pending client on the ioreq_clients (because we can't =
make sure
>>> when we dev_warn this clent is still pending). So we just use =
dev_warn not higher log level.
>>=20
>> I'm sorry, I don't quite understand what you mean by that.
>> Do you agree that has_pending =3D false && retry =3D=3D 0 is possible =
when calling the dev_warn()
>> or not?
>>=20
> Yes, so what ? It just a hint there may have pending request.

if has_pending =3D=3D false && retry =3D=3D 0 when calling dev_warn() =
there are very clear
dependencies met:

* has_pending =3D=3D false means that the list_for_each_entry() macro it =
*not* exit early.
* since list_for_each_entry() did *not* exit early, client will not hold =
a valid list entry
* using client->name is not safe and will not point to a valid string =
(perhaps not even an address)

I'm *only* talking about the case where has_pending =3D=3D false, in =
case that's not clear.


> Even retry =3D=3D 0 && has_pending =3D true,
> When we call dev_warn, the clent may not is pending.
>=20
>=20
>>>>=20
>>>>> 		list_for_each_entry(client, &vm->ioreq_clients, list) {
>>>>> 			has_pending =3D has_pending_request(client);
>>>>> 			if (has_pending)
>>>>> 		}
>>>>> 		spin_unlock_bh(&vm->ioreq_clients_lock);
>>>>=20
>>>> imagine has_pending =3D=3D false && retry =3D=3D 1 here, then =
client will not hold a valid list entry.
>>> What do you mean "client will not hold a valid list entry" ?=20
>>=20
>> Imagine a very simple example:
>>=20
>> 	struct acrn_ioreq_client *client;
>> 	list_for_each_entry(client, &vm->ioreq_clients, list) {
>> 		continue;
>> 	}
>>=20
>> 	dev_warn(acrn_dev.this_device,
>> 		 "%s cannot flush pending request!\n", client->name); /* =
NOT GOOD */
>>=20
> If there're pending request, we would call schedule to schedule out =
then schedule back
> to check the list from the beginning. If there's no pending client, we =
point to the last
> client and break out the while loop.
>=20
> The code doesn't want to find the pending client and break out the =
while loop and call
> dev_warn. Please see the function comment.
>=20
>=20
>>=20
>> Since there is no break for the list_for_each_entry() iterator to =
return early,
>> client *cannot* be a valid entry of the list. In fact if you look at =
the list_for_each_entry()
>> macro, it will be an 'bogus' pointer, pointing somewhere into 'vm'.
>> Essentially before the terminating condition of the list traversal =
the following code is called:
>>=20
>> 	list_entry(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);
>>=20
>> resulting in a:
>>=20
>> 	container_of(&vm->ioreq_clients, struct acrn_ioreq_client *, =
list);
>>=20
>> &vm->ioreq_clients however is not contained in a struct =
acrn_ioreq_client, making
>> this call compute an invalid pointer.
>> Therefore using 'client' as in the example above (e.g. client->name) =
after the loop is
>> not safe. Since the loop can never return early in the simple example =
above it will
>> always break. On other cases (the one we are discussing here) there =
might be a chance that
>> there is one code path (in theory) where the loop did not exit early =
and 'client'
>> holds that 'invalid entry'.
>>=20
>> This would be the case with has_pending =3D false && retry =3D=3D 0.
>>=20
>> I hope this makes sense.
>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>> 		if (has_pending)
>>>>> 			schedule_timeout_interruptible(HZ / 100);
>>>>> 	} while (has_pending && --retry > 0);
>>>>=20
>>>> since has_pending && --retry > 0 is no longer true the loop stops.
>>>>=20
>>>>> 	if (retry =3D=3D 0)
>>>>> 		dev_warn(acrn_dev.this_device,
>>>>> 			 "%s cannot flush pending request!\n", =
client->name);
>>>> client->name is accessed since retry =3D=3D 0 now, but client is =
not a valid struct ending up
>>>> in a type confusion.
>>>>=20
>>>>>=20
>>>>> If retry > 0 and has_pending is true, we would call =
schedule_timeout_interruptible
>>>>> to schedule out to wait all the pending I/O requests would been =
completed.
>>>>>=20
>>>>> Thanks.
>>>>=20
>>>> Again, I'm not sure if this is realistically possible. I'm trying =
to remove
>>>> any use of the list iterator after the loop to make such =
potentially issues detectable
>>> You may think we still in the loop (could we ?), even that we didn't =
write the list iterator then.
>>=20
>> I'm not exactly sure which loop you are referring to but no, I don't =
think we are still in
>> the do while loop.
>>=20
>> The only thing we know after the do while loop is that: !has_pending =
|| retry =3D=3D 0
>> And iff has_pending && retry =3D=3D 0, then we shouldn't call the =
dev_warn().
>>=20
>>>> at compile time instead of relying on certain (difficult to =
maintain) conditions to be met
>>>> to avoid the type confusion.
>>>>=20
>>>> Thanks,
>>>> Jakob
>>=20
>> 	Jakob

	Jakob

