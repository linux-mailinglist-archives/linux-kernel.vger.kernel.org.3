Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336459BC44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiHVJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiHVJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:03:28 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B882184;
        Mon, 22 Aug 2022 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1661158992; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BpMnlAU7QlyBal9Ml6AXqdPCMk964dk628E6HF4/7I=;
        b=z5Yz2KFwTThKueUxoAnnOk9yOk04UN7nLhbmXbIlW1warVc0D4xrttnlNAVSk7baD7iFR7
        0ZSbxN00/MxyG6lohewdN29dLIRtLhxOqdNguvecWRD1jqUU1X4+lOdAhSzi2UuKMjcMz8
        HCM10Rx9l1Sy//CbEj0YO/PDdxmxv6M=
Date:   Mon, 22 Aug 2022 11:03:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/4] input: joystick: Fix buffer data parsing
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Message-Id: <3HE0HR.IPKJTTCKEJUA1@crapouillou.net>
In-Reply-To: <20220819185339.7f488ad8@jic23-huawei>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-5-contact@artur-rojek.eu>
        <20220819185339.7f488ad8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Le ven., ao=FBt 19 2022 at 18:53:39 +0100, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> On Wed, 17 Aug 2022 12:56:43 +0200
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
>>  Don't try to access buffer data of a channel by its scan index.=20
>> Instead,
>>  use the newly introduced `iio_find_channel_offset_in_buffer` to get=20
>> the
>>  correct data offset.
>>=20
>>  The scan index of a channel does not represent its position in a=20
>> buffer,
>>  as the buffer will contain data for enabled channels only, affecting
>>  data offsets and alignment.
>>=20
>>  Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick=20
>> driver.")
>>  Reported-by: Chris Morgan <macromorgan@hotmail.com>
>>  Tested-by: Paul Cercueil <paul@crapouillou.net>
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   drivers/input/joystick/adc-joystick.c | 26=20
>> +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>=20
>>  diff --git a/drivers/input/joystick/adc-joystick.c=20
>> b/drivers/input/joystick/adc-joystick.c
>>  index c0deff5d4282..aed853ebe1d1 100644
>>  --- a/drivers/input/joystick/adc-joystick.c
>>  +++ b/drivers/input/joystick/adc-joystick.c
>>  @@ -6,6 +6,7 @@
>>   #include <linux/ctype.h>
>>   #include <linux/input.h>
>>   #include <linux/iio/iio.h>
>>  +#include <linux/iio/buffer.h>
>>   #include <linux/iio/consumer.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>>  @@ -46,36 +47,43 @@ static void adc_joystick_poll(struct input_dev=20
>> *input)
>>   static int adc_joystick_handle(const void *data, void *private)
>>   {
>>   	struct adc_joystick *joy =3D private;
>>  +	struct iio_buffer *buffer;
>>   	enum iio_endian endianness;
>>  -	int bytes, msb, val, idx, i;
>>  -	const u16 *data_u16;
>>  +	int bytes, msb, val, off;
>>  +	const u8 *chan_data;
>>  +	unsigned int i;
>>   	bool sign;
>>=20
>>   	bytes =3D joy->chans[0].channel->scan_type.storagebits >> 3;
>>=20
>>   	for (i =3D 0; i < joy->num_chans; ++i) {
>>  -		idx =3D joy->chans[i].channel->scan_index;
>>   		endianness =3D joy->chans[i].channel->scan_type.endianness;
>>   		msb =3D joy->chans[i].channel->scan_type.realbits - 1;
>>   		sign =3D tolower(joy->chans[i].channel->scan_type.sign) =3D=3D 's';
>>  +		buffer =3D iio_channel_cb_get_iio_buffer(joy->buffer);
>>  +		off =3D iio_find_channel_offset_in_buffer(joy->chans[i].indio_dev,
>>  +							joy->chans[i].channel,
>>  +							buffer);
>=20
> With this call replaced with one that instead uses
>=20
> 		off =3D iio_find_channel_offset_in_buffer(joy->chans, i);
>=20
> which I'm fairly sure is enough via the info in chans[x]->channel to=20
> establish this offset.
>=20
> All is good, though you should probably cache it as doing that maths=20
> every
> time seems excessive.
>=20
>=20
>>  +		if (off < 0)
>>  +			return off;
>>  +
>>  +		chan_data =3D (const u8 *)data + off;
>>=20
>>   		switch (bytes) {
>>   		case 1:
>>  -			val =3D ((const u8 *)data)[idx];
>>  +			val =3D *chan_data;
>>   			break;
>>   		case 2:
>>  -			data_u16 =3D (const u16 *)data + idx;
>>  -
>>   			/*
>>   			 * Data is aligned to the sample size by IIO core.
>>   			 * Call `get_unaligned_xe16` to hide type casting.
>>   			 */
>>   			if (endianness =3D=3D IIO_BE)
>>  -				val =3D get_unaligned_be16(data_u16);
>>  +				val =3D get_unaligned_be16(chan_data);
>=20
> I obviously missed this previously but these are aligned so we don't=20
> need the
> unaligned form.

Yes, the comment above says that it's used to hide type casting.

Cheers,
-Paul

>>   			else if (endianness =3D=3D IIO_LE)
>>  -				val =3D get_unaligned_le16(data_u16);
>>  +				val =3D get_unaligned_le16(chan_data);
>>   			else /* IIO_CPU */
>>  -				val =3D *data_u16;
>>  +				val =3D *(const u16 *)chan_data;
>>   			break;
>>   		default:
>>   			return -EINVAL;
>=20


