Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242A655FBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiF2JVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiF2JVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:21:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140F8369CF;
        Wed, 29 Jun 2022 02:21:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p136so20650045ybg.4;
        Wed, 29 Jun 2022 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eh9/8QN0XyfFrvsob3PxLqr+FKeuVvmGbb+SLnFK1w8=;
        b=PPWbglVheR1zvwyNWD8rSPW6EbKmdZgAavX9onplBeIgwxs723trIMU7z3LDmN9k29
         uh3RckB+t6+3c4qyCYxaWFO/sR8VOrxJw8F2hGqyAcCiBwlElhON9/cAYSrHVAa9JPqL
         7NkGvNUuSztlynTWjIzgrsY1a20qxeHk1H+AIV4ZkGAXGaXnulfCHsmxuxzDmhEZKTPS
         y+WuFTLQdRwE3Q+So0fO0WmkJpJ48rFlC8moc57ZG0AJQ+wTfPN3dMANkMqDH81GsgiC
         OkkXsg2EYLgPeoGGPx4MBqqhELE9UEK3Z1Y6KZaQkKSbbdruOXBMD3viMugUd/MArqaS
         1puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eh9/8QN0XyfFrvsob3PxLqr+FKeuVvmGbb+SLnFK1w8=;
        b=wxCVu1eUSFvkm12yBQlB7/h1wXCPCySEgMvjsLzbg1D0IkPKw1kG3Pq/rZ3yUsdURn
         lYjTNHCMmY0088QmAgFf16Vhgh9xV+3xVeszv2K4e7Xft9CXUO3xtFzH5ixsVHwcHbz0
         QauEx/wCaQncT+o+HA1KpzzEhMXj8YVJ6vIyhgnfzhCf21Q1XWsvKTOOazlw8HygsgmD
         zXi7gDGgwmYiIsg9IrcHw78RlV6BM6MQsrufMUyyZhGa9p53Vm4PvVNf4xbfqQt/m1+a
         XxuID4GcORALf0lOwez4s4Yix5dd0wHUlTNyB8/53suXG9npvU/C9UpG3+CQQ+h5IdKy
         hDig==
X-Gm-Message-State: AJIora+u2TKAtyVwhyMtWygxKC2dcclxo3qXAj739vYGJ53CUNGzO2Uf
        rY+ynB46HmxicQXdSM9dV0Aj1rR2SnyrUziQI9hJALhKcVkdNw==
X-Google-Smtp-Source: AGRyM1uS+cvIcNrFFvfdfOeCNdpGq8GX+n4BbHmYy6esu6LUeW4Sa8uIybAYqDBzFNJslfFaHj0xSak/OZIgcDW4t74=
X-Received: by 2002:a25:b2a8:0:b0:66c:8110:3331 with SMTP id
 k40-20020a25b2a8000000b0066c81103331mr2388431ybj.460.1656494506281; Wed, 29
 Jun 2022 02:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
 <Yrt6FVHilUuoPrnL@smile.fi.intel.com> <CAPUE2ut2+FwHHV=YxoqExet7m1R9Odji23DVB5zrGzCLgxzNdQ@mail.gmail.com>
In-Reply-To: <CAPUE2ut2+FwHHV=YxoqExet7m1R9Odji23DVB5zrGzCLgxzNdQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:21:07 +0200
Message-ID: <CAHp75Ve1rLvjzmPjOxCjA61A1hjXUpVZi=42+SjARw+t58gDcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: proximity: sx_common: Don't use IIO device
 for properties
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 1:41 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> On Tue, Jun 28, 2022 at 3:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Jun 15, 2022 at 02:47:45PM +0300, Andy Shevchenko wrote:
> > > It's not correct to use artificial device created by IIO core to
> > > retrieve device properties. Even ->get_default_reg() callback
> > > takes a simple struct device pointer which suggests it wants to
> > > operate on the real device.
> > >
> > > Correct this by replacing pointer to IIO device by a real device
> > > pointer in the caller of ->get_default_reg().
> >
> > Gwendal, any comments on this version?
> We can also replace '&indio_dev->dev' with 'dev' when setting
> ACPI_COMPANION_SET() in the probe routine.

It would make no sense, IIUC. In any case, the second patch in the
series, which was the same in v1 removes that completely.

> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
