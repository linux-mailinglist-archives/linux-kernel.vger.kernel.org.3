Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA54D231C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbiCHVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiCHVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:14:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7C32EC0;
        Tue,  8 Mar 2022 13:13:18 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a186so184010vsc.3;
        Tue, 08 Mar 2022 13:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFaXmSp0CUO3MUoxtONyEeHswEbCY1B/ujO2ak9ia2U=;
        b=iGcIaMfp4FsLPBTkkVEWgveu1ZKeaJGm6BV0qJRw/awR3InWaE/GhJaFZTGMfQ25en
         4ts4sXERNYWH61JPQsci41eJBRu7oml141O22s4Cvv5p7P6FK30dA65l1DWFEhHzOnuI
         FMLIQ8EeYAINY9ieXQsAOUxEbzJxGpf4helFl+EmaAagwzKO8deFyy2z63r9+H9xs0Fa
         sH9Er91VVabvh8kiweFm58a6Lr2k8JsQC6Eezx5hQwxf0kYykzxYCAXFZHNj+/58FLj3
         3JmHBdXja0SU8UCg/AC6lsHzh7+48cRqV3EoQC1C9DDLgJgaE/EGLvPdiQSArdb9MTxh
         pkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFaXmSp0CUO3MUoxtONyEeHswEbCY1B/ujO2ak9ia2U=;
        b=rntuuNCnQbhzOR+VsLzdmmqw30zQ/4IUbwz2Y/LGHFNHkBTBEFiYjjVW4SDAQhBqo6
         UX3+09JvG2WNbViFfItwuZL+ancNzC+t8ny0n7szT/Lz+fnx1IbIrgM7Yj1a2LUKQMSU
         jgBpeDwevKZG736LACK9M8ykeS+Hka3+/gUFeqwmJbY00xsQztJ0sSP9OTEKrBeaSClp
         9ojGOwcfID0vxwoziIy602PZ6JD1Kx+P1Rla2gUw9cOgrM869DWXvwjxGXT29wx/9q0o
         CPMtVOo31qTvCta0tzApVx8IhFIC2tyni2SmIeRp+t17BlCFSMFD9znAZEmPUPW4t04j
         No0w==
X-Gm-Message-State: AOAM533T+nOcPG9D1ujPmYPXO51WbmRI6L454Z1fWDl/6/jXXNBmu/15
        ykDJ4+w7sn6Zg24DfKfqnhrG5py5cdwtSc38l9s=
X-Google-Smtp-Source: ABdhPJzMtJBKG17xzLUgES2DvaoKKXyIpmlOJpBc3XIO6D0Xqvi6zQf+88WbQ68P2pGj0X13437J2h5rB634DOVQFak=
X-Received: by 2002:a05:6102:3f01:b0:320:678d:a18a with SMTP id
 k1-20020a0561023f0100b00320678da18amr8692190vsv.81.1646773997571; Tue, 08 Mar
 2022 13:13:17 -0800 (PST)
MIME-Version: 1.0
References: <YhmAAjNeTjiNoLlJ@google.com> <nycvar.YFH.7.76.2203011531370.11721@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2203011531370.11721@cbobk.fhfr.pm>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 8 Mar 2022 13:13:05 -0800
Message-ID: <CAKdAkRT+X1YXGqcLTvmEyyxrkozmakR=1y8Y4nfK5=G2UYFK_w@mail.gmail.com>
Subject: Re: [PATCH] HID: vivaldi: fix sysfs attributes leak
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Sean O'Brien" <seobrien@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

On Tue, Mar 1, 2022 at 6:31 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 25 Feb 2022, Dmitry Torokhov wrote:
>
> > The driver creates the top row map sysfs attribute in input_configured()
> > method; unfortunately we do not have a callback that is executed when HID
> > interface is unbound, thus we are leaking these sysfs attributes, for
> > example when device is disconnected.
> >
> > To fix it let's switch to managed version of adding sysfs attributes which
> > will ensure that they are destroyed when the driver is unbound.
> >
> > Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Compiled only.
> >
> >  drivers/hid/hid-vivaldi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
> > index efa6140915f4..42ceb2058a09 100644
> > --- a/drivers/hid/hid-vivaldi.c
> > +++ b/drivers/hid/hid-vivaldi.c
> > @@ -144,7 +144,7 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
> >  static int vivaldi_input_configured(struct hid_device *hdev,
> >                                   struct hid_input *hidinput)
> >  {
> > -     return sysfs_create_group(&hdev->dev.kobj, &input_attribute_group);
> > +     return devm_device_add_group(&hdev->dev, &input_attribute_group);
> >  }
> >
> >  static const struct hid_device_id vivaldi_table[] = {
>
> Applied, thanks Dmitry.

Jiri, are you planning to send this for 5.17 or 5.18?

Thanks.

-- 
Dmitry
