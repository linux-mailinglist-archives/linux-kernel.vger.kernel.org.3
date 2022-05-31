Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420D5399F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiEaXNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348627AbiEaXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:13:44 -0400
Received: from mail.boiledscript.com (unknown [192.151.158.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD28FFB0;
        Tue, 31 May 2022 16:13:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultrarare.space;
        s=dkim; t=1654038819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8+otB8HQmu22M9qX58h4v8TTVeYcawnMe3GvLJCU0yQ=;
        b=FgYENTxIGpil76rfAy5ADJyQafsweZFOiZNyB4eijna2xg4tEuzBDonWMqFtmsc1w/TW0h
        WzpUiuFBItBzCeW0wYGfLWIdJt0c/Y7PENsN/m0xjnQ+XUef93XMacjgl4zSyi9orHobJz
        tplEEvZ3wjuArjMXbHkxJuskIc4BSBpmxsrGPb7Ei5FDHRMc+CFTJRCkpyrOZsdWazxS0k
        Wg29apQ8GQt1lSNhnBrMlUUN2lggLVMGc6xwRlGVbwSU+kJlDYQ2SEpKeLf8dknTibf2H/
        CZ+g73C81CbbpuMjwC724aRNBsgj3vqVudVbb+NIzxhSSiukCj1fvvMXMq0fow==
Date:   Tue, 31 May 2022 23:13:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   hako@ultrarare.space
Message-ID: <7f67ac07b8bd37d5817cd151674cc6b0@ultrarare.space>
Subject: Re: [PATCH v2] HID: apple: Workaround for non-Apple keyboards
To:     "Bryan Cain" <bryancain3@gmail.com>
Cc:     "=?utf-8?B?Sm9zw6kgRXhww7NzaXRv?=" <jose.exposito89@gmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20220529180230.17e9a0f9@ultrarare.space>
 <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space>
 <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space>
 <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary>
 <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
X-Spamd-Bar: +
Authentication-Results: mail.boiledscript.com;
        auth=pass smtp.mailfrom=hako@ultrarare.space
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:20 AM Jos=C3=A9 Exp=C3=B3sito wrote:

> +struct apple_non_apple_keyboard {
> + char *name;
> +};
> +
> struct apple_sc_backlight {
> struct led_classdev cdev;
> struct hid_device *hdev;
> @@ -313,6 +317,29 @@ static const struct apple_key_translation swapped_=
fn_leftctrl_keys[] =3D {
> { }
> };
>=20
>=20+static const struct apple_non_apple_keyboard non_apple_keyboards[] =
=3D {
> + { "SONiX USB DEVICE" },
> + { "Keychron" },
> + { }
>=20
>=20Could the "non_apple && strlen(non_apple)" check be avoided by removi=
ng
> this empty item?

Hi Jose,
If there's a chance that the device name is an empty string? In such case=
 the
strlen should be preserved.

> +};
> +
> +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> +{
> + unsigned long i;
> + unsigned long non_apple_total =3D sizeof(non_apple_keyboards) /
> + sizeof(struct apple_non_apple_keyboard);
>=20
>=20Here you coud take advantage of the "ARRAY_SIZE" macro:
>=20
>=20https://kernelnewbies.org/MagicMacros
>=20
>=20It'll also allow you to use an int. Something similar to:
>=20
>=20int i;
>=20
>=20for (i =3D 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
> [...]

Thanks for the information!

> @@ -667,11 +694,12 @@ static int apple_input_configured(struct hid_devi=
ce *hdev,
> if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
> hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disa=
bling Fn key handling\n");
> asc->quirks &=3D ~APPLE_HAS_FN;
> - }
>=20
>=20- if (strncmp(hdev->name, "Keychron", 8) =3D=3D 0) {
> - hid_info(hdev, "Keychron keyboard detected; function keys will defaul=
t to fnmode=3D2 behavior\n");
> - asc->quirks |=3D APPLE_IS_KEYCHRON;
> + if (apple_is_non_apple_keyboard(hdev)) {
> + hid_info(hdev,
> + "Non-apple keyboard detected; function keys will default to fnmode=3D=
2 behavior\n");
>=20
>=20Checkpatch nitpick:
>=20
>=20CHECK: Alignment should match open parenthesis
> FILE: drivers/hid/hid-apple.c:700:
> hid_info(hdev,
> "Non-apple keyboard detected; function keys will default to fnmode=3D2 =
behavior\n");
>=20
>=20It suggest to add an extra space before "Non-apple ...".
>=20
>=20In case you don't know the tool, it helps to find style errors, I
> usually run it like:
>=20
>=20$ ./scripts/checkpatch.pl --strict --codespell --git HEAD-1
>=20
>=20+ asc->quirks |=3D APPLE_IS_NON_APPLE;
> + }
>=20
>=20This slightly changes the behaviour from the previous patch.
> Previously, the APPLE_IS_NON_APPLE quirk was set even if APPLE_HAS_FN
> was not present. Now the condition is nested.
>=20
>=20I'm not saying it is wrong (I don't have the required hardware to tes=
t
> it), I'm just pointing it out in case it was an accidental change.
> Bryan, should be able to confirm if it works with his keyboard.

Thanks again!

On Tue, 31 May 2022 13:50:30 -0600 Bryan Cain wrote:

> I haven't tested it, but I can tell from reading the patch that it will=
 break
> compatibility with Keychron keyboards like mine, precisely because of t=
he
> nesting.
>=20
>=20The biggest reason that my Keychron patch was needed at all was that =
Keychron
> devices advertise the Fn key, and thus don't hit the first clone check =
since
> asc->fn_found is actually true for them. So nesting the check for the K=
eychron
> manufacturer/product name inside of that check won't work.
>=20
>=20To tell the truth, I'm still a bit confused about the precise behavio=
r of the
> Sonix firmware that this patch is made to work around. If it's not adve=
rtising
> an Apple-style Fn key, why isn't the existing behavior of disabling Fn-=
key
> handling enough to make it work? The fnmode parameter is ignored entire=
ly
> when APPLE_HAS_FN isn't set, so it's hard to imagine that the change to=
 fnmode
> behavior would even do anything in that case.

Hi Bryan,
Sorry for my inconsiderateness...

It advertises such function:
- FN Function Keys Make Control easily.
FN+F1:My Computer
FN+F2:Browser
FN+F3:Email
...

I made a vital mistake by not properly checking the patch before sending,
that's totally my fault.

Sorry again for the mess I made.

Best wishes,
Chain
