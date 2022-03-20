Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326A4E1A57
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiCTGOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbiCTGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:14:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B6FE9CB0;
        Sat, 19 Mar 2022 23:12:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy13so24262484ejb.2;
        Sat, 19 Mar 2022 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AOf15Uifu6mNC41PoBAC4RTkLBaEgYGDLYzJh3J5xkA=;
        b=jsSu1SOezKFKyDYcFs9V3J+Bi6K7i9oIe2RZpQ2UrJNtFPQIfaXAtLpKE0GpZFg4jO
         IXktysanjYGn9lOpzf11f0pQMHHFW8IxT5PZvJgkOalbDRUqZ1aQfkX2lRNxcl65zrfz
         L+zpetp7fAQErpEbXHmeO1LTjekUNUskdFsa2bDKLBltURYrRa7xkhnHIqs+ruj6gmX0
         i+CuqJFfe9ZdlKh/sOa8H5WIzb19aJxymrNJYwk3yiruOGOGpafV5K5opnJ9MMNe9WuF
         Gyf7at/+uY+fvpwP75jg069ETAatN63i6jguBY9IV3y/Dc0/Sdl61c8iIh/0/YfLfjiR
         M5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AOf15Uifu6mNC41PoBAC4RTkLBaEgYGDLYzJh3J5xkA=;
        b=LFAcHBT26RAU/czzHBsMm4Zn51QrQu2Qkwr3TSTldJsyHpLWIqnkL+Y3zxVxL6egWk
         m/sRDMDq0j81Vb/Sv0tlVEfxcCGN7iITBUT07c+BIa4/uX5nMB8GiMpx5qjP04lvtBFK
         z3EKz2/4d1Lc8L/DJi59to0ampr6DT0JrOIfkfkDb9pi9Cc6u7n3+xCnkzvx4afu4WrH
         ywZCHH0ql2eNzgOWq8zZPqeieq7HsFcTM/oCBkP6ewSA7YeSo469RdhvEycVzWGQjCU8
         J1m0NoCMVT2C0q9ihDB4/UO96ExXaPOw9Ycl3oXkfaLFolNDixgbq4UPAM9yC3aATPPA
         mM9A==
X-Gm-Message-State: AOAM532iJ1CC0f43K+pfwXb+L5WgPFOZJSeI+c3ax7FjQGAsouMF7LM9
        BrRtgYMbld42K7Wdudzymwo=
X-Google-Smtp-Source: ABdhPJynmNBiTeobfKVqqsa6B2BrvQFCWf2wAmIK8GGVZPpbkmJJhOHqGht/Evk6zyM0KaMpIANRbg==
X-Received: by 2002:a17:906:6a13:b0:6db:ab28:9f00 with SMTP id qw19-20020a1709066a1300b006dbab289f00mr15624102ejc.296.1647756756285;
        Sat, 19 Mar 2022 23:12:36 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm105086edc.17.2022.03.19.23.12.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Mar 2022 23:12:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] saa7134: fix incorrect check to determine if no element
 is found in list
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220320025718.10053-1-xiam0nd.tong@gmail.com>
Date:   Sun, 20 Mar 2022 07:12:33 +0100
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        yangyingliang@huawei.com, akpm@osdl.org, v4l@cerqueira.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86AD565C-ADD2-4000-BF99-487EF9FCDB2F@gmail.com>
References: <20220320025718.10053-1-xiam0nd.tong@gmail.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20. Mar 2022, at 03:57, Xiaomeng Tong <xiam0nd.tong@gmail.com> =
wrote:
>=20
> The bug is here: "if (dev =3D=3D NULL)".
>=20
> The list iterator value will *always* be set and non-NULL by
> list_for_each_entry(), so it is incorrect to assume that the iterator
> value will be NULL if the list is empty or no element is found in =
list.
>=20
> Use a new value 'iter' as the list iterator, while use the old value
> 'req' as a dedicated pointer to point to the found element, which
> 1. can fix this bug, due to now 'req' is NULL only if it's not found.
> 2. do not need to change all the uses of 'req' after the loop.
> 3. can also limit the scope of the list iterator 'iter' *only inside*
>   the traversal loop by simply declaring 'iter' inside the loop in the
>   future, as usage of the iterator outside of the list_for_each_entry
>   is considered harmful. https://lkml.org/lkml/2022/2/17/1032
>=20
> Fixes: 4aabf6331f89c ("[PATCH] v4l: (951) Make saa7134-oss as a =
stand-alone module")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
> drivers/media/pci/saa7134/saa7134-alsa.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c =
b/drivers/media/pci/saa7134/saa7134-alsa.c
> index fb24d2ed3621..4955f7e7c5bf 100644
> --- a/drivers/media/pci/saa7134/saa7134-alsa.c
> +++ b/drivers/media/pci/saa7134/saa7134-alsa.c
> @@ -1215,18 +1215,21 @@ static int alsa_device_exit(struct saa7134_dev =
*dev)
> static int saa7134_alsa_init(void)
> {
> 	struct saa7134_dev *dev =3D NULL;
> +	struct saa7134_dev *iter;
>=20
> 	saa7134_dmasound_init =3D alsa_device_init;
> 	saa7134_dmasound_exit =3D alsa_device_exit;
>=20
> 	pr_info("saa7134 ALSA driver for DMA sound loaded\n");
>=20
> -	list_for_each_entry(dev, &saa7134_devlist, devlist) {
> -		if (dev->pci->device =3D=3D =
PCI_DEVICE_ID_PHILIPS_SAA7130)
> +	list_for_each_entry(iter, &saa7134_devlist, devlist) {
> +		dev =3D iter;
> +
> +		if (iter->pci->device =3D=3D =
PCI_DEVICE_ID_PHILIPS_SAA7130)
> 			pr_info("%s/alsa: %s doesn't support digital =
audio\n",
> -				dev->name, =
saa7134_boards[dev->board].name);
> +				iter->name, =
saa7134_boards[iter->board].name);
> 		else
> -			alsa_device_init(dev);
> +			alsa_device_init(iter);
> 	}
>=20
> 	if (dev =3D=3D NULL)

I could be wrong, but judging from the printed message "saa7134 ALSA: no =
saa7134 cards found"
and how the code is structured, I got the impression that the intention =
for this code was
to only execute if the list is empty.=20

There is no break or anything so it's not looking for a specific =
element.

It might make more sense to simply replace this check with:
	if (list_empty(&saa7134_devlist))

> --=20
> 2.17.1
>=20

	Jakob

