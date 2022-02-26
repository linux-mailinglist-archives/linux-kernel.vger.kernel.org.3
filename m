Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64FD4C5673
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiBZOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBZOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 09:14:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA8B267136;
        Sat, 26 Feb 2022 06:14:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so3389214wme.0;
        Sat, 26 Feb 2022 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:to:cc:subject:from:references:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5nTrGYHaMkCaADmgUeE9yrdGA/c3dVkjpOZFIfwPzX0=;
        b=BY4PWavxWOifcU+WfEmu5+Q9oKM+GulKK7bZczfu1ObH1TDtCf/n2PyAwubwta7cHL
         bVavzjzZNnJZay8q2Pm1xMu0oZpf+knqTfaoi3ZOwSpIJpMq9JotMeW8b+AgGe9osCTM
         Vxc9fedDFcfoHtWjs/oT9ZHGfuxl9fykFcRNm3HrhUNYek1wzBZzFABvQq33Adp8g+qz
         5rT8VgRqwsQ27XKyEYHImn25vmkF6h0OFi6K4Zdw6J/Vu1aMHb2BzHgUCm/SGRAhmMVI
         CcRojQ0EoxcRGr2ZktvzOUoAVSlHBiT87s4YPT9DZaXT1az0d4H5OoCNAHpdtmqlkR/k
         a4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:to:cc:subject:from:references:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=5nTrGYHaMkCaADmgUeE9yrdGA/c3dVkjpOZFIfwPzX0=;
        b=KmRBgZp2D2O7R/vQPC4x3glFcWJCocgZDgpIv+egZR0RPhO7Fgj3J6rFsSC0+dyvJ+
         +BTvDOL0S5nTyc9FM2m/2dyd30QyRmkjbiBABNRsXwZ5pcMKsoEQvCWIpkViSfKSuILZ
         wdQdI+de5cwb5OO4AZFQRXR3TwZ5DC2HAXZDxw4hO+WJuYwihvLkWvgh8R9JwECs0byy
         9J3wB8k3j1FxfsQZFgzZQ5+bqQ+qC4fvgqSukL2rLnRlPAsQMI0geNHKouyZJEPlSfQu
         OEjNIy2zt0EdbV1nlsA3kutygxqxVC31E6Cv0fc9/6osyM46xyo6AjNbciMQ0m65Ekrv
         J9uw==
X-Gm-Message-State: AOAM531XjzFlvpPA4N/XNsTfNnK16kHxjdhSbxWbjoxa4QLHqgiC5BMW
        8DmxKXxUDTAOXILMPsg3GCs=
X-Google-Smtp-Source: ABdhPJwImLJXdcOGttS9UiXdWyPvc9FHR/Nct//7KE+R+EzToewqDQxNU4P/TQXCz52W5WYynD41BA==
X-Received: by 2002:a05:600c:354e:b0:37c:815f:8a3f with SMTP id i14-20020a05600c354e00b0037c815f8a3fmr6695056wmq.15.1645884855485;
        Sat, 26 Feb 2022 06:14:15 -0800 (PST)
Received: from localhost ([2a02:169:1e9::acc])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm7783710wmq.35.2022.02.26.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 06:14:14 -0800 (PST)
Date:   Sat, 26 Feb 2022 15:14:14 +0100
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: hid-nintendo: check the return value of
 alloc_workqueue()
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20220225034110.13341-1-baijiaju1990@gmail.com>
In-Reply-To: <20220225034110.13341-1-baijiaju1990@gmail.com>
Message-Id: <1ZE3UIEB0O2B6.2GHX7WO8NQZUJ@homearch.localdomain>
User-Agent: mblaze/1.2-4-gbdaf293 (2022-01-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> The function alloc_workqueue() in nintendo_hid_probe() can fail, but
> there is no check of its return value. To fix this bug, its return value
> should be checked with new error handling code.
>=20
> Fixes: c4eae84feff3e ("HID: nintendo: add rumble support")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index b6a9a0f3966e..2204de889739 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2128,6 +2128,10 @@ static int nintendo_hid_probe(struct hid_device *h=
dev,
>  	spin_lock_init(&ctlr->lock);
>  	ctlr->rumble_queue =3D alloc_workqueue("hid-nintendo-rumble_wq",
>  					     WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
> +	if (!ctlr->rumble_queue) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
>  	INIT_WORK(&ctlr->rumble_worker, joycon_rumble_worker);
> =20
>  	ret =3D hid_parse(hdev);

LGTM!

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>


Cheers,

Silvan
