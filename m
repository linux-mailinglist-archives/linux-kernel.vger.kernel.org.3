Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAD56155B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiF3IoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiF3IoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:44:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAC1AF29;
        Thu, 30 Jun 2022 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656578656; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HyTVBLAUfpwlyXYrVPEtcPS7gJ1O8fJkaJWfQT+/QQ=;
        b=ccAzyIa2trLv5mLPWTwyQSxfCZ/snogaVMnuutpQPPZrY745ccZqReeaPE1NahngbImc4t
        7xy7aRn8cNh2QGYIiWYmUHyNufoE3ZGyP/Iqy4EEU26zBWf7VJHgRdktXI0EjHsuXEIO0n
        GxpQ1n+TRk6tDIopXVH9aKrDgnpqEBw=
Date:   Thu, 30 Jun 2022 09:44:07 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
To:     Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Message-Id: <J98AER.7ZO6O9DK05IM1@crapouillou.net>
In-Reply-To: <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
References: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com>
        <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
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

Hi Ilpo,

Le jeu., juin 30 2022 at 10:41:40 +0300, Ilpo J=E4rvinen=20
<ilpo.jarvinen@linux.intel.com> a =E9crit :
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
>=20
>>  Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting=20
>> dw8250_pm_ops
>>  to use new PM macros.
>>=20
>>  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Not directily related to the patch itself but do you have any idea why
> 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
> didn't wrap RUNTIME_PM_OPS() pointers with pm_ptr()? I'm asking this
> because in SET_RUNTIME_PM_OPS() the callbacks are only created with
> #ifdef CONFIG_PM so I'd have expected RUNTIME_PM_OPS() to maintain=20
> that
> behavior but it didn't? Was it just an oversight that should be fixed?

The RUNTIME_PM_OPS() does not wrap pointers with pm_ptr(), because the=20
pointer to the dev_pm_ops should only ever be used wrapped with=20
pm_ptr() or pm_sleep_ptr().

Which is not done here.

Andy:
The deference of dw8250_pm_ops should be pm_ptr(&dw8250_pm_ops). If you=20
only had system suspend/resume functions, you'd use pm_sleep_ptr()=20
there.

Cheers,
-Paul

> --
>  i.
>=20
>>  ---
>>   drivers/tty/serial/8250/8250_dw.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>=20
>>  diff --git a/drivers/tty/serial/8250/8250_dw.c=20
>> b/drivers/tty/serial/8250/8250_dw.c
>>  index f71428c85562..adcc869352b1 100644
>>  --- a/drivers/tty/serial/8250/8250_dw.c
>>  +++ b/drivers/tty/serial/8250/8250_dw.c
>>  @@ -691,7 +691,6 @@ static int dw8250_remove(struct platform_device=20
>> *pdev)
>>   	return 0;
>>   }
>>=20
>>  -#ifdef CONFIG_PM_SLEEP
>>   static int dw8250_suspend(struct device *dev)
>>   {
>>   	struct dw8250_data *data =3D dev_get_drvdata(dev);
>>  @@ -709,9 +708,7 @@ static int dw8250_resume(struct device *dev)
>>=20
>>   	return 0;
>>   }
>>  -#endif /* CONFIG_PM_SLEEP */
>>=20
>>  -#ifdef CONFIG_PM
>>   static int dw8250_runtime_suspend(struct device *dev)
>>   {
>>   	struct dw8250_data *data =3D dev_get_drvdata(dev);
>>  @@ -733,11 +730,10 @@ static int dw8250_runtime_resume(struct=20
>> device *dev)
>>=20
>>   	return 0;
>>   }
>>  -#endif
>>=20
>>   static const struct dev_pm_ops dw8250_pm_ops =3D {
>>  -	SET_SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
>>  -	SET_RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume,=20
>> NULL)
>>  +	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
>>  +	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume,=20
>> NULL)
>>   };
>>=20
>>   static const struct dw8250_platform_data dw8250_dw_apb =3D {
>>=20


