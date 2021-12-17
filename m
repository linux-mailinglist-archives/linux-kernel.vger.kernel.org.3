Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0877947942E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhLQSmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhLQSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:42:42 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:42:42 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e136so9056780ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ID87xFF1ny0rLnoj6o/E96/XNAWF53PF2CEgRmDwQwI=;
        b=Tw0uaJnIHVUZPEGxonVzrc6/1BV/tKWS00U4oPPF5jDheVgFxHriJAmN1PbaMD93gW
         HbuL0hwocaYHScxww+hUIfWXVQoeb5ftv+RbdHU3o7KNVC2kvpF1pTvoW7xJfLloZn3M
         vsZMawdg4CDMKacTVY2Hn+UnG4TT402rCrPU+tJpZjM39IeaIN8fx0w9Gy485CQ7pd5k
         Ii2RqBoz0279ZFJIBLzCxWLiCVGG7CPu40FxaEBXN2sudwTitNcDTnBx0y2C9AF487Wo
         wyF/0YcFsA/cXgZNjm7uwVm8FbKIMr/ANRtJLQQLP3QXWgaFGMxo+TYpRpB6+q2pH3x9
         LNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ID87xFF1ny0rLnoj6o/E96/XNAWF53PF2CEgRmDwQwI=;
        b=RdmERq8L8sUO+tMkgHUbSfzU8mbqLIrjNz0aQgD6ok7tjx7Cm4PJsLog44YiDzGSB2
         IfD+lOydhaXP5ziSQOuQHkT6nnwMtlyQoNAGER6Fq69tq/S8fwzWp95Z5Srw5PQ5e5qm
         1BF//ra3nHeCjEmuxYlFd9A88j6NfvaYFTwSzxtm+IFwSxC2gvvdfeXhHBITMrA4NUkQ
         snY4/puSPg03VgZGljz3j9l2WS6MOiGot7OMn9fXdhbNxu8kG1Id+nUhrbUZzyiSv1/4
         3YYpgmepVqs2QhezmkYjOrKZaOVFyMs0riZYIqAlVSNouytLQo0hq0JIVVNaE489i4KS
         2K6Q==
X-Gm-Message-State: AOAM533sCC8Djj44xLw0Hf5IFOj0JGqTCi2bJJGUl5L5w0oPsAtc8QgP
        5goexNRpgjs4Sbgwi/8VjM0YjljCYBJpXXW2Ywc=
X-Google-Smtp-Source: ABdhPJwOggq37Z1jDxVsfM37Tp7rZJWzPeeUpZ8kNU1HHVqF6MbeC9XL/xzVPiWo/KOOjyc/qNsWOVZVvu1z2mxkXIo=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr6013454ybm.690.1639766561310;
 Fri, 17 Dec 2021 10:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20211217145544.341617-1-pgwipeout@gmail.com> <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
 <CAMdYzYq=2G1bvu9M_DR0vdQDtcvVBhQFRPTNKo1ySFrMZOk=jg@mail.gmail.com> <4d24cb08-0475-3a9d-1b73-24e465f34701@gmail.com>
In-Reply-To: <4d24cb08-0475-3a9d-1b73-24e465f34701@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 17 Dec 2021 13:42:29 -0500
Message-ID: <CAMdYzYrDp5zcRJ=TudtiAtviJVMyNmqB5TMNYZ=XN+mb3paSTQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: rk808: add reboot support to rk808.c
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:30 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 17.12.2021 21:16, Peter Geis =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> +                     break;
> >>> +             default:
> >>> +                     dev_info(&client->dev, "pmic controlled board r=
eset not supported\n");
>
> I'd change this dev_info to dev_dbg to not clutter KMSG.

I'd prefer to leave this as info, since the device is designated as
the system power controller but it is only capable of powering down
the system, not rebooting it.
But on second thought, anyone who's making these changes would be
investigating the driver anyway.
So I'll change it to dev_dbg.

>
> >> I'd set ret=3D0 explicitly here. Later on somebody may change the code=
 and
> >> ret won't be zero anymore, this is not an uncommon trouble in kernel.
> > It took me a moment to see the logic here, but I understand it now.
> >
>
> Could be even better to place the error message simply right after the
> register_restart_handler().

Good point, thanks
