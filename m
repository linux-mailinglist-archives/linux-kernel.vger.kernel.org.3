Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842184EEE9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiDAN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiDAN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:57:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0C1DC985;
        Fri,  1 Apr 2022 06:55:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lr4so5968622ejb.11;
        Fri, 01 Apr 2022 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p3P1QxNSvNFi/Xhftp0DPxXtemptZBUwlKISHBBOqG8=;
        b=W53hTvmT9kUY5y0yoXxrsD36TOw6zVOXu3BWlp2GVykG8rOvMDzf6iQj9+J20IPrRQ
         uQU+54OecOjhL27WAsf6qMALNtMDvzLy56hBISGNCnrpFHgUsqRmH2qEhzYveiVZ/99p
         gqt8rBkMIqzDnJs0QJxeRBHEjLNfnRA/OFj7Y7LGzgaTBIk4HCcJOchMobDqc9vY8jyJ
         13YFpLfLKk9eFn+6t9IjBQa8I+l8iXxAKGjdGbck/PFZ7gBDA6dJJD2lrForq2UYJ8BC
         6UrZxEeFQERX+dMSXxn/uI7WhAAXXosAgDIIs8+HwJdMekwDutn6BAD4VkKcyXZeTaJG
         ETvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p3P1QxNSvNFi/Xhftp0DPxXtemptZBUwlKISHBBOqG8=;
        b=z4MdTJ8ceRqC+Q2Mm4t68rWjw+7iBbdnshzD33b5sXf5HL8r/B+s25hDuygYtJ2X8M
         vb9UTQJcD8L/IEHf8AnPhRO5P5xb2nOwZv25b6seNYzK2dtbDjDDGVYpobiS2TIWL7Ce
         jdtDdReLL/PxU2Sop1rGtm48wM24M/EVL+wjVxZgwlFKB5ls41qBkhjUC9WApIBT6Ejs
         fVewN0Fg9pzt+Pi4VDl8iA/U9y86X+X9VOz+he2bAdEsehCHHrLZLAT6bjLtC486Gk94
         /2clCTtrUX0DGeijo0vR5ti3TsvLQ35Kfp8Nqqm5ldVZUki84uQcwQVJaGIn8zU9bhBS
         IgjA==
X-Gm-Message-State: AOAM5304fG9Byl1n70KptnY03/9dltPK1n4/tnjnuNqNJDeiTGl2CTBG
        aqMmS0vx2N5YhX3RWpvDy40=
X-Google-Smtp-Source: ABdhPJy3VDSxT0/EAHD21emIaMJg2Y1ayVaZNTS9dX3W2FnUIEGH6BGZTU1f7XpfzWPuxn5UvbTVmg==
X-Received: by 2002:a17:907:72c4:b0:6df:917c:df6f with SMTP id du4-20020a17090772c400b006df917cdf6fmr9470466ejc.120.1648821322418;
        Fri, 01 Apr 2022 06:55:22 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm1056848ejc.42.2022.04.01.06.55.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 06:55:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <PH0PR03MB6786326401D38B60141CAC9799E09@PH0PR03MB6786.namprd03.prod.outlook.com>
Date:   Fri, 1 Apr 2022 15:55:20 +0200
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80A5A418-FBBE-47BF-ACFF-0470027875F6@gmail.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
 <PH0PR03MB6786326401D38B60141CAC9799E09@PH0PR03MB6786.namprd03.prod.outlook.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
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



> On 1. Apr 2022, at 14:40, Sa, Nuno <Nuno.Sa@analog.com> wrote:
>=20
> Hi Jakob,
>=20
>> -----Original Message-----
>> From: Jakob Koschel <jakobkoschel@gmail.com>
>> Sent: Friday, April 1, 2022 1:07 AM
>> To: Jonathan Cameron <jic23@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Dan Carpenter
>> <dan.carpenter@oracle.com>; Jakob Koschel
>> <jakobkoschel@gmail.com>; linux-iio@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Mike Rapoport <rppt@kernel.org>; Brian
>> Johannesmeyer <bjohannesmeyer@gmail.com>; Cristiano Giuffrida
>> <c.giuffrida@vu.nl>; Bos, H.J. <h.j.bos@vu.nl>
>> Subject: [PATCH 1/3] iio: buffer: remove usage of list iterator =
variable
>> for list_for_each_entry_continue_reverse()
>>=20
>> [External]
>>=20
>> In preparation to limit the scope of the list iterator variable to =
the
>> list traversal loop, use a dedicated pointer to iterate through the
>> list [1].
>>=20
>> Since that variable should not be used past the loop iteration, a
>> separate variable is used to 'remember the current location within =
the
>> loop'.
>>=20
>> To either continue iterating from that position or start a new
>> iteration (if the previous iteration was complete) =
list_prepare_entry()
>> is used.
>>=20
>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/CAHk-
>> =3DwgRr_D8CB-D9Kg-
>> c=3DEHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/__;!!A3Ni8CS0y
>> 2Y!q8llw5UCaMIsAU7tPtPDhwVor0wy032I7FJHv0VxBZksNuRJF04HjWe
>> 0XYG7OQ$  [1]
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/iio/industrialio-buffer.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/iio/industrialio-buffer.c =
b/drivers/iio/industrialio-
>> buffer.c
>> index 208b5193c621..151a77c2affd 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -1059,7 +1059,7 @@ static int iio_enable_buffers(struct iio_dev
>> *indio_dev,
>> 	struct iio_device_config *config)
>> {
>> 	struct iio_dev_opaque *iio_dev_opaque =3D
>> to_iio_dev_opaque(indio_dev);
>> -	struct iio_buffer *buffer;
>> +	struct iio_buffer *buffer, *tmp =3D NULL;
>> 	int ret;
>>=20
>> 	indio_dev->active_scan_mask =3D config->scan_mask;
>> @@ -1097,8 +1097,10 @@ static int iio_enable_buffers(struct iio_dev
>> *indio_dev,
>>=20
>> 	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list,
>> buffer_list) {
>> 		ret =3D iio_buffer_enable(buffer, indio_dev);
>> -		if (ret)
>> +		if (ret) {
>> +			tmp =3D buffer;
>> 			goto err_disable_buffers;
>> +		}
>> 	}
>>=20
>> 	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
>> @@ -1125,6 +1127,7 @@ static int iio_enable_buffers(struct iio_dev
>> *indio_dev,
>> 					     indio_dev->pollfunc);
>> 	}
>> err_disable_buffers:
>> +	buffer =3D list_prepare_entry(tmp, &iio_dev_opaque-
>>> buffer_list, buffer_list);
>=20
> Ok, it's Friday so I might be seeing ghosts... But looking at =
'list_prepare_entry()'...
> If tmp !=3D NULL, then all goes well but if tmp =3D=3D NULL, then we =
get
>=20
> list_entry(&iio_dev_opaque->buffer_list, struct iio_buffer, =
buffer_list) which
> would require 'struct iio_dev_opaque'. It looks like like =
'list_prepare_entry()'
> assumes that pos and head are of the same type...=20
>=20
> Am I missing something?

The list iterators are weird in this perspective...

If you look at the original code, list_for_each_entry_continue_reverse() =
is called on 'buffer'.

'buffer' would be a valid struct element of &iio_dev_opaque->buffer_list =
if the break is hit,
but if no break is hit in the earlier list_for_each_entry() buffer is =
not a valid entry.

Before the terminating condition of list_for_each_entry() is met, it =
essentially does:

	buffer =3D list_entry(&iio_dev_opaque->buffer_list, =
typeof(*buffer), buffer_list);

the buffer returned here is not a valid pointer to struct however.
But since list_for_each_entry_continue_reverse() immediately calls =
list_prev_entry(buffer, buffer_list)
on it you end up with the last entry of the list again and start =
iterating with that one.

It's a very weird design choice but since =
list_for_each_entry_continue_reverse() expects
a pointer to the element struct and not the list_head struct, you need =
to pass in this 'bogus'
pointer if you want it to start on the head element.


Keep in mind that the code here is just a more explicit version of this =
'type confusion' whereas
with the original code it was just hidden within the =
list_for_each_entry() macro and far less obvious.
The functionality is exactly the same.

PS: list_prepare_entry() was made for this use case, so basically it is =
expected to craft this bogus pointer from
the head if pos =3D=3D NULL.

>=20
> - Nuno S=C3=A1

Thanks,
Jakob

