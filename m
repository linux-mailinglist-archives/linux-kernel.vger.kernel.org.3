Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42F258F612
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiHKC5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHKC5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:57:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61418883FB;
        Wed, 10 Aug 2022 19:57:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gk3so31149620ejb.8;
        Wed, 10 Aug 2022 19:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G86Am7xGIToyaZgK/6Sab+lZR8ERmbEP88Zj48JSJOo=;
        b=e401BypWBb9Uj3fapfDvFSIF9O4yrz1yM46IqgdveWnBegztl3dY7vk23S19OA8aIg
         dr/xV/5wqXXJdPpmXbPXNtiIskbqasRaSXQbXy48KFT5atvPF47rtykTDh9kVNjW6XIi
         kVXhuqJYvcuabql2Tj2JxAkdtrQQDMQxp8mTXkioiflvGknaORONFp0VgR8dNG+oC+kD
         74nNDESYPOu5RhPHETyd0UX29ynnwe5+nzIKvGbFFaoeWHfRPYtBeJ3J1vRZPcx0bab9
         pw/Ja7pYHsgbqAaZ/U4c7+p1LBhO96mBtxMVXkUK2sEDIuEhZfGVDA/GghsO2NXqtOOU
         CWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G86Am7xGIToyaZgK/6Sab+lZR8ERmbEP88Zj48JSJOo=;
        b=QlyFYkpT8MniWcDKV4AmeKJxIzHI4VPAcS+gdHdehP3SDI/G1jRpJ4Jp/Pm4LhOM1S
         t8dcKAShB0SRatHyLvBJQgMo3Ywp9ZjPk4W855uwa6svVtFOrVm5Q2mgK9ZVJXY8CTAU
         6Nrt0q53AQya5/LEr6KimU7KrFOIqW9wIQNEKM2iLPthF5QKT/r37HxmdPnTYAympCPQ
         fuzeKmwp/CZHlM0ZZUuJ7Sm9b24Ook9iv+eBiw1FGmkKo4MgqqeBMegr2d0osdDCOzMW
         vMezUssvclbCnbnUTbcX4/IzkooaMqFb6iM4mfNx/SzNkU7VXsOuDVCwJwObMbtI4abH
         H7lQ==
X-Gm-Message-State: ACgBeo1vi+5nHRwOsuX5vo7ekhOjuAip0jrpxC7P6XzZ/0SFRwDWFFMi
        VsoVs2tP+FysuIa5mkC2kCtR1oYwdi5+YiBvSfI=
X-Google-Smtp-Source: AA6agR43pYyUGN3beZhMeBiH2MZK8M8Mau0iR54OijLEETUOWNJm2EneLyt0CY6xYmlioMoJtjF3gx2sYBhrBEpDnDk=
X-Received: by 2002:a17:907:28c9:b0:730:c053:986f with SMTP id
 en9-20020a17090728c900b00730c053986fmr22195591ejc.194.1660186652989; Wed, 10
 Aug 2022 19:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220720072346.33511-1-dzm91@hust.edu.cn> <YuEu3mqTRCN9A5ig@kroah.com>
In-Reply-To: <YuEu3mqTRCN9A5ig@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 11 Aug 2022 10:56:17 +0800
Message-ID: <CAD-N9QXsQpFmLk-dfx6Y=Agtt1=7=Z5eP1RZTcTpgU9XK8NEDA@mail.gmail.com>
Subject: Re: [PATCH] usb: trancevibrator: simplify tv_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Jul 27, 2022 at 8:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 20, 2022 at 03:23:43PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The function tv_probe does not need to invoke kfree when the
> > allocation fails. So let's simplify the code of tv_probe.
> > Another change is to remove a redundant space.
>
> Those are two different things, please resend as a patch series of 2
> different patches.

Sure, I have sent the patch series.

>
> thanks,
>
> greg k-h
