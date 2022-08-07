Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB158BBBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiHGQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiHGQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:01:44 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37499FF7;
        Sun,  7 Aug 2022 09:01:41 -0700 (PDT)
Date:   Sun, 07 Aug 2022 16:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1659888099; x=1660147299;
        bh=E97y01Qgk0NfD6wZHnPXassl6h4rNnG16nJI4wW+NRo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ZkIc6m0+x/UKjButZsnHohuBXNA9X/KmRuQoAyH7XPiip7z6QsUyvnULofhrYrnY5
         5KlIhBRSYjt+7e9ZLYfTe7o95BbEMyrYTQ+Bq9KOpLsYlGvRARy24Ow+X/SVko6VD4
         ZElgqpItqi1lpV5tKX+WfKl32CdVlWvsG8CHJwxg=
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 1/3] input: add event codes for user programmable switch events
Message-ID: <4067646c-36d2-7c05-1bdd-955f8fc69924@connolly.tech>
In-Reply-To: <Yr4timTL6mBlik0m@builder.lan>
References: <20220516142158.1612109-1-caleb@connolly.tech> <Yr4timTL6mBlik0m@builder.lan>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2022 00:11, Bjorn Andersson wrote:
> On Mon 16 May 09:22 CDT 2022, Caleb Connolly wrote:
>
>> Add SW_PROG{1,2,3,4} for device switches which are handled by userspace.
>>
>> This can be used for devices with "generic" switches which are intended
>> to be user-programmable, for example OnePlus phones contain a tri-state
>> key which can be used for switching between mute/vibrate/ring, or
>> programmed by the user to perform any arbitrary actions.
>>
>> These are analogous to the keys KEY_PROG{1,2,3,4} found on some
>> keyboards.
>>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>
> This looks reasonable to me.
>
> Dmitry, what do you think?
Any chance someone could take a look at this? (Sorry I really should have b=
umped
this a few weeks ago).
>
> Regards,
> Bjorn
>
>> ---
>> See the next patch in this series for an example usecase.
>> ---
>>   include/linux/mod_devicetable.h        | 2 +-
>>   include/uapi/linux/input-event-codes.h | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicet=
able.h
>> index 5da5d990ff58..45364fbeaaf7 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -326,7 +326,7 @@ struct pcmcia_device_id {
>>   #define INPUT_DEVICE_ID_LED_MAX=09=090x0f
>>   #define INPUT_DEVICE_ID_SND_MAX=09=090x07
>>   #define INPUT_DEVICE_ID_FF_MAX=09=090x7f
>> -#define INPUT_DEVICE_ID_SW_MAX=09=090x10
>> +#define INPUT_DEVICE_ID_SW_MAX=09=090x14
>>   #define INPUT_DEVICE_ID_PROP_MAX=090x1f
>>
>>   #define INPUT_DEVICE_ID_MATCH_BUS=091
>> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux=
/input-event-codes.h
>> index dff8e7f17074..339153886a13 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -917,7 +917,11 @@
>>   #define SW_MUTE_DEVICE=09=090x0e  /* set =3D device disabled */
>>   #define SW_PEN_INSERTED=09=090x0f  /* set =3D pen inserted */
>>   #define SW_MACHINE_COVER=090x10  /* set =3D cover closed */
>> -#define SW_MAX=09=09=090x10
>> +#define SW_PROG1=09=090x11  /* set =3D program 1 (user defined) */
>> +#define SW_PROG2=09=090x12  /* set =3D program 2 (user defined) */
>> +#define SW_PROG3=09=090x13  /* set =3D program 3 (user defined) */
>> +#define SW_PROG4=09=090x14  /* set =3D program 4 (user defined) */
>> +#define SW_MAX=09=09=090x14
>>   #define SW_CNT=09=09=09(SW_MAX+1)
>>
>>   /*
>> --
>> 2.36.1
>>
>>

--
Kind Regards,
Caleb

