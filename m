Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E582D5A19F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiHYUCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:02:37 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FAA6112B;
        Thu, 25 Aug 2022 13:02:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l5so11451867qvs.13;
        Thu, 25 Aug 2022 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3iiGSa3yxPg/OvH82LwoDWy5saZ3dFlwATIdzY8AOwA=;
        b=kBdqxyJMocrdpW29KsLwH9c7GMM0R18bL3lxqRpxkLqqZJvPNomrYPqMGFD/YoUq7h
         qff+9pIg8fXWsmdaIz0aZGeNzC8U95zBuadLACUhH45CiqDVg3j/qGz7cDXd+fq4wSeR
         Pe2S0ILeJRoGBu0uS4+/JI+NiFk9rjIlRu6b3JtcnouhEcxvo1lDGtW8xB8hRolO2UpK
         G6tMnYLLTbg8YqQD1mWDi0uFEnDdODZYxPys6mehxv/C4rRsQ7syjKDp1fI6l4p2ol9K
         tuI5GKQS7cP9NIdXkaFL2/8x2tR0EGNrAph7r7k9Gc55m3xY09HYNcU7xXjbvN1Pc2fT
         bKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3iiGSa3yxPg/OvH82LwoDWy5saZ3dFlwATIdzY8AOwA=;
        b=EKimSs6DciiKnMYQYWjvQ322WeomYBzeafNSZ0ZKCiCW2rXY/y0QJdC9M12x3T9k9Y
         VpTQUGr10csLDQjR1k0agkF0P5DZaT3JOdk0Qo+yEMyJ5fEOkNsF9FZba34jxlHy4AD/
         hoP7FonJwAHO866yXJcexfGoFeyg4J+tItcTCkpa+/WiUnjSRgt8JyUXcVtVEelt6oqG
         q5xDJBv3HLAgOPpUADmbF8se1sPsPvrjCB8/xIIeOPpd9xg2oOcySsVklYw7ihycI2k+
         NA/ea8eH7N0rW0+uCWoMZUbDaDpyhvPe+Yi8dQsiYlOiwzLTr7Xi2wU+/uu/71AJu2wd
         8fNA==
X-Gm-Message-State: ACgBeo1A8s46Ij58CU8oIJu8vH4lmm2ZSWgBucGqS7Ypl5R2h2OI1+zt
        o7uLs1uv2DUoxxq7YvuxS26JTLUoEc3YYecaFcve1Ps2/fo=
X-Google-Smtp-Source: AA6agR6bQFREHa+12QcRKY99/kXCXSBixummQ7F/I9U+de+i82EmIYofkoVcTRYkUnd3TKu0y4JT0jzp/ehI+gMSm2o=
X-Received: by 2002:ad4:4eaf:0:b0:496:ac46:2d9c with SMTP id
 ed15-20020ad44eaf000000b00496ac462d9cmr5174751qvb.82.1661457754084; Thu, 25
 Aug 2022 13:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com> <20220824104002.2749075-2-vincent.whitchurch@axis.com>
In-Reply-To: <20220824104002.2749075-2-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 23:01:58 +0300
Message-ID: <CAHp75Vf4C0hauoT7F26zS7815Cps=W3o1_HHmWKVbrUi90FcrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: mcp320x: use device managed functions
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>, axel.jonsson@axis.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Use devm_* functions in probe to remove some code and to make it easier
> to add further calls to the probe function.

...

> +       mutex_init(&adc->lock);

> +       return devm_iio_device_register(&spi->dev, indio_dev);

Do you still need to destroy the mutex? If so, you may not call devm_
variant of iio_device_register() or you have to wrap mutex_destroy()
accordingly.

-- 
With Best Regards,
Andy Shevchenko
