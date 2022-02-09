Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5F4AFF35
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiBIVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:30:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiBIVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:30:55 -0500
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 13:30:57 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91593C0045A5;
        Wed,  9 Feb 2022 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644442254;
        bh=PGc0WNXFAjQvHZe7dxOMXdROYvVfqvz2T9AO1zIL3gw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PDtQWwyctpDBrDVOCU09BSHEpR/edHJq7+XIdipKCdxaKePhx8d4kNjPwm/XzoD6u
         QNheeLhJ8lcH1JSpxSFkfbxEy7w07NvODZRKdLWyiyA+sQDuF4WLsMDlKBhGhqyHi1
         CrmT8KkVRI4wW7tuRc2HBkWyzJiVqhPEEmtvUsTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.150.166]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1oKiFR1jsh-012mVq; Wed, 09
 Feb 2022 22:24:54 +0100
Message-ID: <2bfcb259-5f81-2110-2027-cc9e61d4d671@gmx.de>
Date:   Wed, 9 Feb 2022 22:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fbcon: use min() to make code cleaner
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>, cgel.zte@gmail.com
Cc:     linux-fbdev@vger.kernel.org, ducheng2@gmail.com,
        penguin-kernel@i-love.sakura.ne.jp, daniel.vetter@ffwll.ch,
        Zeal Robot <zealci@zte.com.cn>, deng.changcheng@zte.com.cn,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        cssk@net-c.es, geert@linux-m68k.org, svens@stackframe.org
References: <20220209084810.1561184-1-deng.changcheng@zte.com.cn>
 <YgQN4WXXjSHVDiBK@ravnborg.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <YgQN4WXXjSHVDiBK@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:42z7V6HGvHKO01ZXFESGhB6onaGQz+EgEZLEwRYRWfcGOdxRYLD
 9+oR0V3WTV7T8z04HfUEJ9krjI09hKpvIApkF/inaY+3VN8FhRS5T7xTc3/mbgWl46Jcw5a
 GDTLmkSaCOHMy9j+3jfEmdH51Jv17frlHfioXT30moKjj20PLKp7yzYo1xXVMfmltU4r5Qu
 NQbRHW/tJd8r4apj1Lv/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LFaBDnAjjgs=:oJutcP91/Ce8HMOT70PlNe
 5mWkxdJ0sC53Ee/E2BXhrPATJ4lMVtjeXJVZm8LXA4voUlemoev4jgRI1g9IZLI+glVLTlMvL
 cA6n2MgUqIZREBRmfyKfZW+S0v7aKvQkZK4Jl5L1BM0lWYisVa64xvpdraqfn3umMXmHk0ksP
 Fyi0Pfkg1gVxkYDNRUaZU6II2POCWTdqCEbfNhnZHHOEQejb+U3cIJfQJVOFj8HcuV702Yey+
 S+Mz56tkmsetWJaWQmltfuZHCu6XSsV/6XrKrMLnxhMp2Fu9aKwp6IDjhtEAoPAFqmJAO/U9T
 /tiKkOVAaJdmtVBVeaidWxF6A/JlA72cVOudo8zspWjLX4upPP75HcRc93ImeIHigh4Aa8uZQ
 Y96alAAg3oSLKpVEgf7MrNOkKdN0e+ov0TKimnpWRNda/81yUEX6+H4NZaW6BLUhVX7pwMNt/
 2ZGD54VDmviU0Ogy02GQOpBH5eWq7iuYr60XtkE7U0FvTuBoRBcP43yuX7KGcYHGpsR2zS3o0
 Lvgkfs9VRVgNjXcTuoMunbXFX8ADeiWnQHOJ7bJ6IK5ERYwun/byEgJv4m/+y33UY6mfLwPpq
 ypn1VJzMvaakK7SjHqEvVNRh1P/3+VvKIkKUqoVqdKjRJU4/oj5YdONnq12ycb4xWlx4E4TpN
 CFSsa3eNhBEm+/iEIRRdQbPnp44ZCLlOtjSfvixTg+HNMAdaMJN347PUaql/Kf+tRiDEbhnf1
 wKpq9JKw2id7vOinrsBJVgQvxEWiaRPrIR/lHLVixBTGerzF6UpqTS5o0NnZV4Tz3HfuixmOC
 Ol63MW2po2LnTF6fiAnk3lGhtr2/t2mqAtleP4xeyamjHPWWot8E+5sCOsimwEFCeQryZVEJd
 AhJGriZVy6aczmTdlpCZgXzaDdPyaVIDLG95KCccfoU51W9E3WaQ+6AMres7Qs+d7Iy1CorHT
 tEhtiSjY1Mi3eQ3+iY/QwOm8iTtIpIET5B0CskcISit3teKLkQsGsSGAJeycI11G5wTrY5fIb
 LaSNOjaBxZbcJMklNgJEiU4rZ7MGyVrkX/Vt7B33BTDB2aDpVk8J2O9BLJc13KIgc1V4s0kW9
 OwH2EiKUoksplc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 19:54, Sam Ravnborg wrote:
> On Wed, Feb 09, 2022 at 08:48:10AM +0000, cgel.zte@gmail.com wrote:
>> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>>
>> Use min() in order to make code cleaner.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> I had preferred in minmax.h was included, but it has an indirect include
> so shrug.
>
> I assume Daniel or Helge will pick it up.

Daniel has quite some upcoming changes to core/fbcon, so I prefer
that he takes it when he thinks it's the right time...

Helge

>
>> ---
>>  drivers/video/fbdev/core/fbcon.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/cor=
e/fbcon.c
>> index f36829eeb5a9..61171159fee2 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -602,7 +602,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, =
struct fb_info *info,
>>  		save =3D kmalloc(array3_size(logo_lines, new_cols, 2),
>>  			       GFP_KERNEL);
>>  		if (save) {
>> -			int i =3D cols < new_cols ? cols : new_cols;
>> +			int i =3D min(cols, new_cols);
>>  			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
>>  			r =3D q - step;
>>  			for (cnt =3D 0; cnt < logo_lines; cnt++, r +=3D i)
>> --
>> 2.25.1

