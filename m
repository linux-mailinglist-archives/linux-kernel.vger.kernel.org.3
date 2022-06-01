Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7B539FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiFAIrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiFAIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:47:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF11E000;
        Wed,  1 Jun 2022 01:47:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ew15so701042qtb.2;
        Wed, 01 Jun 2022 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=bbRiNCiHwnBpXhjnGkgwxB7hILOKq6DshojP9BG0mMo=;
        b=DR4rwn7OZGdRXagrzZInNyKcsIhuf9Zt0NlJ7IJ20AAmegUqU3h5EGOFUXi2y5uPJA
         Fi9OuivSqdnl9r0RQPeEn7PY3K/iOiKp3juSJH9F2yDvbLcej17/akXoWib85oDo3HkF
         JkfEG3L9NXLd+aq1S9AgRRGpyzcCan63+W4f9qw9/hjDorHBJLyvmITrAZtK+qUPADjz
         EHk6PNonmg085IVUkbppW+MLtvQZFFb0f0Qq79P2G7HIR52JryceJKAkRpOOXzSXE2gn
         LciXKhQWcoLr1HLpjGxjJcU1AWuh89QN2kYhQXmo6/zSS80YwGCbWeLoPkfhs1tOAzma
         PR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=bbRiNCiHwnBpXhjnGkgwxB7hILOKq6DshojP9BG0mMo=;
        b=BYzYiBL11EW2vo/HKYCUfwjGODVqGyHW5pkXmMy7USvIKbIwqlN1gRcVtUhjP4jcYW
         qYbvzPnOAn9yTFSP9nxieesz0+2+MY1ABgNW+1VmoDL+UjMwZjgBB3vzIGruKVfBlrCX
         VoNu1ax0hSMjOhsH3Yw8yvA7en36Z3fBRkF9aLZardLqDvvEgNRkj3eFFTa5hq6RCTOP
         RcBqOZ+ZMhTC3D4BwUsOb2s/SA1pvglr4+6o4DPlxbRazyf5OAI/11VzRvvJD01DXMRp
         lUD1Md1BKosfy0hDSn4dKo/Azhqhs6FTgyOiGDks5YI868Fz/5vgl7BFi24RUwbJQNKn
         7AWQ==
X-Gm-Message-State: AOAM530cmbmPwe1VCAxfxT6Wk6s2pU19j7E8wsw8vjg3zjiIlfQxndLx
        FdNx+NFoR90PzBoqMr8Kov6acGaHQLY0I/nX
X-Google-Smtp-Source: ABdhPJwyVrlO2tcC2pWgIzxIdlmLbNMtv0bP3vyfdnm1qOe3QzAy4nHsd6odRByqCkcf6xK0GuQTxw==
X-Received: by 2002:a05:622a:44:b0:2f9:2134:442 with SMTP id y4-20020a05622a004400b002f921340442mr44896146qtw.339.1654073222045;
        Wed, 01 Jun 2022 01:47:02 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:1900:8f43:42cb:e8c8:c65c? (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id c8-20020ac84e08000000b00304b7a2fa13sm767177qtw.27.2022.06.01.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:47:01 -0700 (PDT)
Message-ID: <786db9cf74473caef10dcea79975716b5516f47e.camel@gmail.com>
Subject: Re: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Jun 2022 10:47:54 +0200
In-Reply-To: <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
         <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-31 at 18:57 +0000, Dmitry Rokosov wrote:
> Hi Jonathan,
>=20
> I have one question about a cases when trigger owner is builtin
> module.
> In the such cases trig->owner =3D=3D null, because THIS_MODULE equals to
> null. How do you think, should we take into account such situations?
>=20
> IMHO we have to take in and save this information to trig_info during
> trigger allocation call. For example we can check THIS_MODULE from
> the

Hmmm, If we were to do something during iio_trigger_alloc(), we would
rather assign already THIS_MODULE to owner and we would not need this
WARN(). I mean, if someone calls iio_trigger_get() before allocating
it, it will have bigger problems :).

I think this could actually be something reasonable...

- Nuno S=C3=A1
>=20

