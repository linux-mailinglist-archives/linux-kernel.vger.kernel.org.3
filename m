Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87057FB37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiGYIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:25:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC236157;
        Mon, 25 Jul 2022 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658737480;
        bh=Q/fzEFlwcS/PYAbsBodtIxc86HI6kWU6z8JxCzps4eo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=haMhWUlCPSH5CFEkb0z9XyWjeCnaOXm7B0Gjp52g2V2KjksyrBJ0nx8UQPbs7OJ1g
         DS29IswjQ2h6ZFbmPiR8keX7HDDJNADZXCJ0m/CbQycVn3WGjVvwh5pG+ZmRyuhZHv
         vIq/xaXqGnMzT4ajuKB9or8374i45vckYEUKwPek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.140.141]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1oP04v0xDF-009CJD; Mon, 25
 Jul 2022 10:24:40 +0200
Message-ID: <1a640421-9b22-28a3-4712-714c4f12b9b2@gmx.de>
Date:   Mon, 25 Jul 2022 10:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fbdev: Make registered_fb[] private to fbmem.c
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org
References: <20220725075400.68478-1-javierm@redhat.com>
 <c06cccc7-9e7d-5659-c23d-40ca386574b0@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <c06cccc7-9e7d-5659-c23d-40ca386574b0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZjD4JArpyofLO9WHEqMo7VhreBlhRkiYZWwkzSJ3Pv2a4CUMFyH
 GpzCKg2poPDFbIftn7s2o5SN25CTaCkb9CJ9zhnYW2itdAoGH1OBhyAjghiSxr6IOIh/Oti
 8eEHUYQ+sKfYY7F0fp7JWhHUL8Ky+ZppQKYTk3pyTY/9vWpsoEQyDxtzGtLrhjNeiIaTYd0
 EWoBMPhLFis81KNIAv2mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DUwW8Qj4G4M=:rbDf/oYyOEYdx/kjrJdzjh
 aakadAtGrJJ/GrLKujso2nN1ycLy28ElhpfL7mCeCfxLdjLo4dQthoO9u8j8tfNQWhbdGXLqM
 8Ixx7v2Tt5Rdzc63KyupPoGyuwcUxdPBgbbKfYH4i1WgmXL4ElGxnPadr8NCS4jpZ+0zbdnKA
 MFYqqygzz4UbwC76HGPwlhjzohYkZnlUCqk3nmLLM0jeEiN3g4FahKeswfEe4KmqcAy8HbdBs
 l/jCv5L9sPDRYll0VIe3O7KHXpd05ezXfE3SENW/AwbJA0E6kaJa6rogLsv5MUgMKDcGxgftR
 XcRYM2kgqkDbAHRQolQjF0mnsw52b81I8D/vuWApPemCG74yL/vEdn7+IiNacTMA3IapOsKGD
 fNeU+LOwpoqE6fFaIlBsKhX3JL9z2AMprM209B1k4C6qHCWwbW2KCVBK6b2kFdaePjGmYZUf5
 DIoUgJnbtmn8gR+HFPxo3KX1/5Ish/uMJKObGkBZeD9WV2j3fm/8tlXhYbSd0L77FG9spUsfi
 eunv3i1ws7IQM9YWZbdR/CEnUjfCoDpfi8mBtXglfc1O0MkGQ2D01tuwoyKO8reMVVBdDKMJY
 HRVUEtPzdh8SRVOUm2qjABmwPaoOfXgoh8MpJvJ954KPa38VVIxpGaR0eTm+Tr2+c3TVkWf8V
 U4HQ200lja4Qf8/FXH3vUCIN9PmEOwRzZRIOoXcgd2K2igDNJnH6Ho0gdpIvyN3UKaR8yyzJC
 pjbx14nfHISOJIsDqCRpHYHhpHCAFDDMYfrGxEqUYZ4ZY3rA7nHFlJb3D8TqNXO9qA1zelo06
 nlZI/QAF8aMBT+KiHSx+Dy9QJDQiYK8d7E5VZ6brncCBYgHN2Y9ifKVKt4nwibK1bJo4jLXZe
 xj2WGXt5Nv37EdkfFfTMIemj8OfjPJ10lJi2lpmkwEEQkILRe9D/V/nZDjwWHviB3MlK8BKOr
 0SbUE1KnidP/jg1mlhk7yfAFrp0BEDheR7x/a0OK6xLhshBAmanms2Lq/jCy4ZLbqa6DtL/L+
 PFNW335uVyXxwxUKNkG0vLTv4nUnfYhWDit2Di2qDnw5BLFcV+SU+RLr8jZEJRlYPdIDaoSmn
 OLDxm1sKFNQuctnCqQrwsiTFICrPDrmek+vHWmbsq3yT76Fi5IOTbn+zA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 09:55, Thomas Zimmermann wrote:
> Hi
>
> Am 25.07.22 um 09:54 schrieb Javier Martinez Canillas:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> No driver access this anymore, except for the olpc dcon fbdev driver bu=
t
>> that has been marked as broken anyways by commit de0952f267ff ("staging=
:
>> olpc_dcon: mark driver as broken").
>>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Helge Deller <deller@gmx.de>

Helge

>
> Best regards
> Thomas
>
>> ---
>>
>> =C2=A0 drivers/video/fbdev/core/fbmem.c | 6 +++---
>> =C2=A0 include/linux/fb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ------
>> =C2=A0 2 files changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/cor=
e/fbmem.c
>> index 6ae1c5fa19f9..1e70d8c67653 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -51,10 +51,10 @@
>> =C2=A0 static DEFINE_MUTEX(registration_lock);
>> =C2=A0 =C2=A0 struct fb_info *registered_fb[FB_MAX] __read_mostly;
>> -EXPORT_SYMBOL(registered_fb);
>> -
>> =C2=A0 int num_registered_fb __read_mostly;
>> -EXPORT_SYMBOL(num_registered_fb);
>> +#define for_each_registered_fb(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < FB_MAX; i++)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!registered_fb[i]) {} e=
lse
>> =C2=A0 =C2=A0 bool fb_center_logo __read_mostly;
>> =C2=A0 diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 453c3b2b6b8e..0aff76bcbb00 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -627,16 +627,10 @@ extern int fb_get_color_depth(struct fb_var_scree=
ninfo *var,
>> =C2=A0 extern int fb_get_options(const char *name, char **option);
>> =C2=A0 extern int fb_new_modelist(struct fb_info *info);
>> =C2=A0 -extern struct fb_info *registered_fb[FB_MAX];
>> -extern int num_registered_fb;
>> =C2=A0 extern bool fb_center_logo;
>> =C2=A0 extern int fb_logo_count;
>> =C2=A0 extern struct class *fb_class;
>> =C2=A0 -#define for_each_registered_fb(i)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < FB_MAX; i++)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!registered_fb[i]) {} e=
lse
>> -
>> =C2=A0 static inline void lock_fb_info(struct fb_info *info)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&info->lock);
>

