Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85A25A1CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiHYWnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiHYWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:43:16 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F658C697B;
        Thu, 25 Aug 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1661467382; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OII/Vgrcto9gF5T2aXWnO39LnbEUOadKIRjVC5jUIEA=;
        b=HL/61vOdlWAJiHypxiXdSB+RmSt6GWVztDK+5iP5e4cr46FlPjgcyScT6k1BVFxUeiT9I0
        j9qNzI5nNqFzLU/ZJ8lFBzuNzyB+wXRxkX1zQcdeV2RH94m9p6Ox46EVwgP9EyUnxBdAi5
        1RmvlFp20qg2qJ13GQmgjhyIvQSFuy8=
Date:   Thu, 25 Aug 2022 23:42:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-Id: <HF07HR.3A0DTIDT17IF1@crapouillou.net>
In-Reply-To: <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Le mar., ao=FBt 23 2022 at 19:47:57 +0200, Rafael J. Wysocki=20
<rafael@kernel.org> a =E9crit :
> On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was not used=20
>> anywhere
>>  outside pm.h and pm_runtime.h, so it is safe to update it.
>>=20
>>  Before, this macro would take a few parameters to be used as sleep=20
>> and
>>  runtime callbacks. This made it unsuitable to use with different
>>  callbacks, for instance the "noirq" ones.
>>=20
>>  It is now semantically different: instead of creating a=20
>> conditionally
>>  exported dev_pm_ops structure, it only contains part of the=20
>> definition.
>>=20
>>  This macro should however never be used directly (hence the trailing
>>  underscore). Instead, the following four macros are provided:
>>  - EXPORT_DEV_PM_OPS(name)
>>  - EXPORT_GPL_DEV_PM_OPS(name)
>>  - EXPORT_NS_DEV_PM_OPS(name, ns)
>>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
>>=20
>>  For instance, it is now possible to conditionally export noirq
>>  suspend/resume PM functions like this:
>>=20
>>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
>>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
>>  };
>>=20
>>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
>>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these new=20
>> macros.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> or please let me know if you need me to pick up this one.

Could you pick this one up then, and make a branch for Jonathan?

Cheers,
-Paul

>=20
>>  ---
>>  Cc: Jonathan Cameron <jic23@kernel.org>
>>  Cc: Rafael J. Wysocki <rafael@kernel.org>
>>  Cc: linux-pm <linux-pm@vger.kernel.org>
>>=20
>>   include/linux/pm.h         | 37=20
>> +++++++++++++++++++++++--------------
>>   include/linux/pm_runtime.h | 20 ++++++++++++--------
>>   2 files changed, 35 insertions(+), 22 deletions(-)
>>=20
>>  diff --git a/include/linux/pm.h b/include/linux/pm.h
>>  index 871c9c49ec9d..93cd34f00822 100644
>>  --- a/include/linux/pm.h
>>  +++ b/include/linux/pm.h
>>  @@ -375,19 +375,20 @@ const struct dev_pm_ops name =3D { \
>>   }
>>=20
>>   #ifdef CONFIG_PM
>>  -#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> runtime_suspend_fn, \
>>  -                          runtime_resume_fn, idle_fn, sec, ns)    =20
>>     \
>>  -       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> runtime_suspend_fn, \
>>  -                          runtime_resume_fn, idle_fn); \
>>  -       __EXPORT_SYMBOL(name, sec, ns)
>>  +#define _EXPORT_DEV_PM_OPS(name, sec, ns)                         =20
>>     \
>>  +       const struct dev_pm_ops name;                              =20
>>     \
>>  +       __EXPORT_SYMBOL(name, sec, ns);                            =20
>>     \
>>  +       const struct dev_pm_ops name
>>   #else
>>  -#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> runtime_suspend_fn, \
>>  -                          runtime_resume_fn, idle_fn, sec, ns) \
>>  -static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name,=20
>> suspend_fn, \
>>  -                                        resume_fn,=20
>> runtime_suspend_fn, \
>>  -                                        runtime_resume_fn, idle_fn)
>>  +#define _EXPORT_DEV_PM_OPS(name, sec, ns)                         =20
>>     \
>>  +       static __maybe_unused const struct dev_pm_ops=20
>> __static_##name
>>   #endif
>>=20
>>  +#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
>>  +#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name,=20
>> "_gpl", "")
>>  +#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name,=20
>> "", #ns)
>>  +#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns)=20
>> _EXPORT_DEV_PM_OPS(name, "_gpl", #ns)
>>  +
>>   /*
>>    * Use this if you want to use the same suspend and resume=20
>> callbacks for suspend
>>    * to RAM and hibernation.
>>  @@ -399,13 +400,21 @@ static __maybe_unused=20
>> _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
>>          _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL,=20
>> NULL)
>>=20
>>   #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL,=20
>> NULL, "", "")
>>  +       EXPORT_DEV_PM_OPS(name) =3D { \
>>  +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +       }
>>   #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL,=20
>> NULL, "_gpl", "")
>>  +       EXPORT_GPL_DEV_PM_OPS(name) =3D { \
>>  +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +       }
>>   #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> ns)   \
>>  -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL,=20
>> NULL, "", #ns)
>>  +       EXPORT_NS_DEV_PM_OPS(name, ns) =3D { \
>>  +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +       }
>>   #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn,=20
>> resume_fn, ns)       \
>>  -       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL,=20
>> NULL, "_gpl", #ns)
>>  +       EXPORT_NS_GPL_DEV_PM_OPS(name, ns) =3D { \
>>  +               SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +       }
>>=20
>>   /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>>   #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>>  index 9e4d056967c6..ba2077d9e366 100644
>>  --- a/include/linux/pm_runtime.h
>>  +++ b/include/linux/pm_runtime.h
>>  @@ -40,17 +40,21 @@
>>                             resume_fn, idle_fn)
>>=20
>>   #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> idle_fn) \
>>  -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend,=20
>> pm_runtime_force_resume, \
>>  -                          suspend_fn, resume_fn, idle_fn, "", "")
>>  +       EXPORT_DEV_PM_OPS(name) =3D { \
>>  +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>>  +       }
>>   #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> idle_fn) \
>>  -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend,=20
>> pm_runtime_force_resume, \
>>  -                          suspend_fn, resume_fn, idle_fn, "_gpl",=20
>> "")
>>  +       EXPORT_GPL_DEV_PM_OPS(name) =3D { \
>>  +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>>  +       }
>>   #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
>> idle_fn, ns) \
>>  -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend,=20
>> pm_runtime_force_resume, \
>>  -                          suspend_fn, resume_fn, idle_fn, "", #ns)
>>  +       EXPORT_NS_DEV_PM_OPS(name, ns) =3D { \
>>  +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>>  +       }
>>   #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn,=20
>> resume_fn, idle_fn, ns) \
>>  -       _EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend,=20
>> pm_runtime_force_resume, \
>>  -                          suspend_fn, resume_fn, idle_fn, "_gpl",=20
>> #ns)
>>  +       EXPORT_NS_GPL_DEV_PM_OPS(name, ns) =3D { \
>>  +               RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>>  +       }
>>=20
>>   #ifdef CONFIG_PM
>>   extern struct workqueue_struct *pm_wq;
>>  --
>>  2.35.1
>>=20


