Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACAF4DC1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiCQIyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiCQIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199D5A76E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647507201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFfTJdqSsa1NG+Ra/FukB6NKy0iv2m8HqzphlwyuIMY=;
        b=dRqHieE36AdpyjJ06J2YQrfL2KNP0gjmpudqo/wsH+gUKwh9eh5DmyHmsA9gQRMFo2S85v
        Ivnu54o+zwLtc7hRifDzhflFF5lwb+c8Gud1A2vxG2ifS/vy4lfj25tNXDexZ7c2WZKkuk
        osCG+miCztqKwKiaiOKPjLG5c88IyCI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-r7NYHJZ1MfmrvnKC6-jLGg-1; Thu, 17 Mar 2022 04:53:20 -0400
X-MC-Unique: r7NYHJZ1MfmrvnKC6-jLGg-1
Received: by mail-lj1-f197.google.com with SMTP id h21-20020a05651c125500b002464536cf4eso1827585ljh.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFfTJdqSsa1NG+Ra/FukB6NKy0iv2m8HqzphlwyuIMY=;
        b=EG3lAbD8pWK8tw2L1jE24z1uJg+9Iffc11QdnElR6se6qFzMuWTOyH6b8NQcGqHNiy
         cy9DjPmnhkeuDcEsQ2DBTazwQi/2KRO5Dm6Mwq8V5x9BAofdsqxf8qannsQSA5BpNu/u
         3DfbV7EC7bC+aE3WoYjlIuzn+AiPogpwvbD6N2mQGDD+jcvSIYL2hQlxl3AKkP8Dg9Dp
         G+2hIiSmploH9T+HK2R+361cJjv0wi8FpYVDavCDeZLcPQp2/kzPQ6CZ9SeMCDwFmqT3
         Hor2cuX5KTTsAiSMCdChGeZXHqACzTT8yshgt4DazaF3rkGaGEdqajcRs7ssHIctadkn
         x/mA==
X-Gm-Message-State: AOAM5311xafiJBztd+QMVjQ2u6pQfrgOA+dtD0YFsYOuW7/JLoSNa0N4
        81kZg/dM/DZ/IngBUyrklSo2v62Kpjj3WkNTcZOLbunKkwc5o5rfH3Z94XTxkVLv3ea46lMC5SJ
        KfGT+iwEEr/0LQGQQvfjcQzCWKSa5+VZHoKXyNJYT
X-Received: by 2002:a2e:9dcf:0:b0:247:f8eb:90d5 with SMTP id x15-20020a2e9dcf000000b00247f8eb90d5mr2171007ljj.23.1647507198401;
        Thu, 17 Mar 2022 01:53:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNbwp6tqy+HcMHGRBfqOz/Srxy4fE5I30SgISlwUiwMSrU46WrhElns8Rx+/WjzuJGzZtPGGRI1b5zx3gbtI0=
X-Received: by 2002:a2e:9dcf:0:b0:247:f8eb:90d5 with SMTP id
 x15-20020a2e9dcf000000b00247f8eb90d5mr2170987ljj.23.1647507198111; Thu, 17
 Mar 2022 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220317075713.10633-1-hpa@redhat.com> <YjLxFuRXKzg3m9HH@paasikivi.fi.intel.com>
In-Reply-To: <YjLxFuRXKzg3m9HH@paasikivi.fi.intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Thu, 17 Mar 2022 16:53:07 +0800
Message-ID: <CAEth8oHqSS7EsPofmERRB=pmtS8YPP+MeM6fMG6tJT2z_qChxA@mail.gmail.com>
Subject: Re: [PATCH v4] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Mar 17, 2022 at 4:28 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Thu, Mar 17, 2022 at 03:57:13PM +0800, Kate Hsuan wrote:
> > For the AF configuration, if the rightmost stripe is used, the AF scene
> > will be at the incorrect location of the sensor.
> >
> > The AF coordinate may be set to the right part of the sensor. This
> > configuration would lead to x_start being greater than the
> > down_scaled_stripes offset and the leftmost stripe would be disabled
> > and only the rightmost stripe is used to control the AF coordinate. If
> > the x_start doesn't perform any adjustments, the AF coordinate will be
> > at the wrong place of the sensor since down_scaled_stripes offset
> > would be the new zero of the coordinate system.
> >
> > In this patch, if only the rightmost stripe is used, x_start should
> > minus down_scaled_stripes offset to maintain its correctness of AF
> > scene coordinate.
> >
> > Changes in v2:
> > 1. Remove the setting of the first stripe.
> >
> > Changes in v4:
> > 1. x_start is estimated based on the method for both stripes are enabled.
> > 2. x_end is estimated based on the width.
>
> Please put the changelog before '---' line. I've removed it from the commit
> message this time.
>
> --
> Sakari Ailus
>

Okay, I got it.

Thank you.

-- 
BR,
Kate

