Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F857FBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGYIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiGYIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:47:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191FBC8A;
        Mon, 25 Jul 2022 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658738851; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPQel/35hWIJPM94sA5/FSXttvqtiNGBtFglYvAjWfM=;
        b=tHujnarTp1a2IeCxqv7V7p0ZYM+XAQkUf6h2bzPhZAXtGabexkpEqtJIk3riIG+KD72GCt
        rfgngCkeMVeNIGR86FW8u0m95+M2aZUF7ZmSCzmZir9XhlmQkEMozE8c4Y/XCjH3vb4sMf
        UOQU8nHSOqTI2TQ70ZGL4h88/sbskZg=
Date:   Mon, 25 Jul 2022 09:47:20 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     Arnd Bergmann <arnd@arndb.de>, Ren Zhijie <renzhijie2@huawei.com>
Cc:     stanley.chu@mediatek.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-Id: <W2JKFR.Y0JWFHU8ZIJU3@crapouillou.net>
In-Reply-To: <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
References: <20220704025632.235968-1-renzhijie2@huawei.com>
        <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
        <df9909dc-3303-808e-575a-47190f636279@huawei.com>
        <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
        <af043109-c101-a147-707b-82e79469ae73@huawei.com>
        <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Le lun., juil. 25 2022 at 08:34:32 +0200, Arnd Bergmann <arnd@arndb.de>=20
a =C3=A9crit :
> On Mon, Jul 25, 2022 at 5:38 AM Ren Zhijie <renzhijie2@huawei.com>=20
> wrote:
>>  =E5=9C=A8 2022/7/13 16:48, Arnd Bergmann =E5=86=99=E9=81=93:
>>=20
>>  I try to use the new marcos SYSTEM_SLEEP_PM_OPS and RUNTIME_PM_OPS=20
>> to
>>  replace the old ones, and remove #ifdef around the declarations in=20
>> the
>>  header, my local changes attach below.
>>=20
>>  But it seems  that doesn't work, which has ld errors:
>>=20
>>  aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
>>  aarch64-linux-gnu-ld: Unexpected run-time procedure linkages=20
>> detected!
>>  drivers/ufs/host/ufs-mediatek.o: In function=20
>> `ufs_mtk_runtime_resume':
>>  ufs-mediatek.c:(.text+0x1d0c): undefined reference to
>>  `ufshcd_runtime_resume'
>>  drivers/ufs/host/ufs-mediatek.o: In function=20
>> `ufs_mtk_runtime_suspend':
>>  ufs-mediatek.c:(.text+0x1d64): undefined reference to
>>  `ufshcd_runtime_suspend'
>>  Makefile:1255: recipe for target 'vmlinux' failed
>>  make: *** [vmlinux] Error 1
>>=20
>>  (CONFIG_PM and CONFIG_PM_SLEEP are both not set, and
>>=20
>=20
> It appears that there is a mistake in the RUNTIME_PM_OPS()
> macro definition, can you try this patch on top?
>=20
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 871c9c49ec9d..84592229d754 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -334,9 +334,9 @@ struct dev_pm_ops {
>         .restore_noirq =3D pm_sleep_ptr(resume_fn),
>=20
>  #define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -       .runtime_suspend =3D suspend_fn, \
> -       .runtime_resume =3D resume_fn, \
> -       .runtime_idle =3D idle_fn,
> +       .runtime_suspend =3D pm_ptr(suspend_fn), \
> +       .runtime_resume =3D pm_ptr(resume_fn), \
> +       .runtime_idle =3D pm_ptr(idle_fn),

Not a mistake, the pm_ptr() macros are not needed here, because the=20
dev_pm_ops pointer must always be wrapped with pm_ptr().

The proper fix is:

-  .pm     =3D &ufs_mtk_pm_ops,
+  .pm     =3D pm_ptr(&ufs_mtk_pm_ops),

Cheers,
-Paul

>=20
>  #ifdef CONFIG_PM_SLEEP
>  #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>=20
> Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate
> old ones") introduced all the macros with the intent of using pm_ptr()
> and pm_sleep_ptr() in them, and I think Paul accidentally forgot to=20
> add
> those in this instance.
>=20
>        Arnd


