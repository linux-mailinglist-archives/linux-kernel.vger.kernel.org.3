Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE56F599922
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348243AbiHSJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbiHSJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:58:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADB52479;
        Fri, 19 Aug 2022 02:58:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h27so2914512qkk.9;
        Fri, 19 Aug 2022 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FVAAlRtBOaHGmapqyqUoUe+9q/YeeMg/t5lfvLvs9nk=;
        b=PePfK8oKU1V5oOAoCXeRxduRlABC1sSedAhdReOpRLsKI1A9FY/0cLo0lEkd17DlLV
         lgZXOv0qO1E1Gi0ekrmCoTV4mTw59cDAeweIC54HCv8OOCLLt/jE9Cg9WH1B+3zw5CYT
         3DdIYxapUjmocouIHOBXPSvT8JIofmeFKTYqhNHfvKPzCk/kLD7aJpBahOIBqXMcBbAK
         Nz1MpvnJJ74JhbF8z6mS2tPYNfgaj+19+5ejNHh635Jq5YF8b0SikhQsG8EtjWw76qXC
         JyNfCpuhYjHLl3RGQ24rbVV/JIBsNaekwtIMrM5Kgx5QsA1nctsX2Ngy69S2FZormzzC
         3iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FVAAlRtBOaHGmapqyqUoUe+9q/YeeMg/t5lfvLvs9nk=;
        b=VX7TQg+bnpek9LUvOa9StdoxabZjOzYlIbFvsxVtzh8C92zoEn8rtNEe1I4rUxW9K3
         jLZif18aWC7SNEEE629dLm3LFlxJ7FfpzZkqc8Cg/maxiEnxw58ZysBxLZWf1pA4We2K
         Bkfx2bxpkuxvbGZRaRdhLb3Yv2mRz+ZAOkwbeHyvI2DfWe0L16Y+YX2quh65knfyuoUC
         01jk9ipMsIyxQaB3JQFv0Nb0feLELsmumJ3I8TJIdLcynRvmgGK/5xhSbiQXdBzzAu16
         zwTT/QGNdw9tv9A7NjMgiMawWfl6mnwG9KMS+ZSmahW/SxAinRKLee+mWfwQX14AzYTZ
         We1Q==
X-Gm-Message-State: ACgBeo0BYMtdbjqDJsYAqVuuI0zwhzXwhHFOezYwNt4tocpzjkNiU19n
        AQT9hMQlz8E7TCSsH4EkSEwF59zomP6Nmpm0kAIVzClrT//0GQ==
X-Google-Smtp-Source: AA6agR6Dvrer/bw7qA99DV3A+zOlhgEeml7ffI+8VhsBjuIJSKH12U+8wXbnvtLTi6i1DmeptZLrcudFzjLLM3fK+8c=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr4898726qkp.504.1660903131083; Fri, 19
 Aug 2022 02:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220818232040.GA3505561@roeck-us.net> <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
In-Reply-To: <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:58:14 +0300
Message-ID: <CAHp75VcbFp8sefdn+UPZSNyP70gh4p+rg4ztwvJ99d1vp7vYSw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Aug 19, 2022 at 12:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Aug 19, 2022 at 2:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sat, Aug 06, 2022 at 06:25:15PM +0300, Andy Shevchenko wrote:
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> > >
> > > Add mod_devicetable.h include.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> > I had another look at this patch. A substantial part of the changes
> > is because device properties don't support of_property_read_u32_index()=
,
> > reworking the code to use device_property_read_u32_array() instead.
> > Sorry, I don't like it, it results in a substantial number of unnecessa=
ry
> > changes. Device properties should support the equivalent of
> > of_property_read_u32_index() instead to simplify conversions.
>
> Not all (device property) providers can have such API available. Are
> you suggesting to
>  a) alloc memory for entire array;
>  b) cache one for a given index;
>  c) free a memory;
>  d) loop as many times as index op is called.
>
> Sorry, this is way too far and non-optimal in comparison to the
> substantial number of unnecessary changes (two or three small
> refactorings?).
>
> Another way is to provide a pwm-fan-acpi, which will be the copy of
> the driver after this patch is applied. I don't think it's a very
> bright idea either.

That said, I will split a change for PWM cleaning up series and leave
the rest on the hwmon maintainers to reconsider.

--=20
With Best Regards,
Andy Shevchenko
