Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED984BFF30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiBVQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiBVQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:48:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24715F098
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:48:16 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d3so13078173ilr.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pkK4qJ0A4iT1fXg1hMke6gUjeb+Wr6KZoA8F11noe4=;
        b=jXtplNS3u8J6EK17FJNkTJvli8IdeWDGP5f1vhV0YYJZwfGQMn85AweYZJ++/4911h
         6THEu/gQ1R+nWijMkD6+VHzxm6Iu6yvq8W/r6C8HgfpHTdq0bKxYpn6A2u67VpCztwE1
         mxAQamon7VerdSUFfZXyzEigxDJOO0i24QQXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pkK4qJ0A4iT1fXg1hMke6gUjeb+Wr6KZoA8F11noe4=;
        b=Z+GPV0DYmJQHVYqerSEyUcJKo/4LWC4krWkDMqe+sT9oaVXxGDVeC83ouG7Eu31Vgn
         C8E4epVqMv9AmKVioufVRq1UUB5anlJAYxfGQ0eUHxQ7c2RKPmn0DR0XtfE/4SbYZU/G
         7aorZVxy9KHiZ4wMNjK+rDZzgNwZ6d8XSezNCHtTikLmfMOAzGtvxNkBvIw39kU7Nozn
         26ATnBrl0gLWqYpgyIaSDexg/UpFqkT/xtDByGyF5PfqAPhgctLtuQzGowVoSl/FNLbB
         LBrOi7hDCD7p0nRreZQAPXYbVokOHuv6IwVofjtq0NOQXJlfzvZ+8uPzJLNcQ4Am3Jx5
         6RqA==
X-Gm-Message-State: AOAM530JZ/5PchuXWPGiskZW8CQWXprF4Ydg2Q17FFOne/QhYNIj5LPg
        ENBBgd8fozLWIEejdmbm8Cw0JloF8Ak1NA==
X-Google-Smtp-Source: ABdhPJxLMrcVNUq/UgJNDU6YtiqDpIuwJ7KRtrGr+ck69lQVejkgg5tx3UGHJ64QYV74/g+BVYSibg==
X-Received: by 2002:a05:6e02:1d86:b0:2bd:ef9f:cfa6 with SMTP id h6-20020a056e021d8600b002bdef9fcfa6mr20694464ila.314.1645548495866;
        Tue, 22 Feb 2022 08:48:15 -0800 (PST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id t195sm11603227iof.47.2022.02.22.08.48.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 08:48:15 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id f14so13206480ioz.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:48:15 -0800 (PST)
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id
 t9-20020a056602140900b005e70487133cmr20037198iov.196.1645548494585; Tue, 22
 Feb 2022 08:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
 <CAD=FV=U0-W_H=-u-GDc5GYm8GHSix0F1dKF+3eMNixP30fhtrQ@mail.gmail.com>
In-Reply-To: <CAD=FV=U0-W_H=-u-GDc5GYm8GHSix0F1dKF+3eMNixP30fhtrQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 08:48:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjWzyQ5mQ1cPK5qg6xZhXoBkomsuAgTWJRryxMR_wVcQ@mail.gmail.com>
Message-ID: <CAD=FV=XjWzyQ5mQ1cPK5qg6xZhXoBkomsuAgTWJRryxMR_wVcQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: qfprom: Increase fuse blow timeout to prevent
 write fail.
To:     Knox Chiou <knoxchiou@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas

On Fri, Jan 7, 2022 at 6:57 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jan 6, 2022 at 6:31 PM Knox Chiou <knoxchiou@chromium.org> wrote:
> >
> > sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
> > Current timeout is simply too low. Since blowing fuses is a
> > very rare operation, so the risk associated with overestimating this
> > number is low.
> > Increase fuse blow timeout from 1ms to 10ms.
> >
> > Signed-off-by: Knox Chiou <knoxchiou@chromium.org>
> > ---
> >
> >  drivers/nvmem/qfprom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Slight nit that ${SUBJECT} for patches usually doesn't end with a
> period. Presumably if Srinivas cares he can fix it while applying.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I noticed that this patch still isn't in linux-next. Did it get lost,
or are you waiting for anything additional before applying?

Thanks!

-Doug
