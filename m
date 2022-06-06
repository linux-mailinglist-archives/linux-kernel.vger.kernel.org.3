Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE153E6F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiFFOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiFFOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:10:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1325590;
        Mon,  6 Jun 2022 07:10:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd25so19011838edb.3;
        Mon, 06 Jun 2022 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FzjA3O/a7rMXwWvrBiZXtQGHAjzdhILvDzu+Ghq0zf8=;
        b=YIXUXa1kcMVfU98TcAIoBZLwFx+/N73w0XQw5zugvA10mCe3uTwo6Pp1K5Km01k8kB
         E3R6YM3l/5m3RJwKZ9Jqddpcg1OQkAWztgoHj1jFJetScOb9E02a8KdEypVuhv8HsZse
         MLqesZpiGFwsgur3x/N8c1qyyshGQB71pzecbbCaDLSrmPtmT7hPNaf53MPbdLP3XTPS
         1tOf8wZ3SMyxeWsHjNFthpQlGjwQhqEWPwvWUEQ0VTK/W960HU0695mqdQVXK0ntmSXc
         077Q4sdNgpRoQaRUEMRSk50AJtVTsAZPx4nZzlHb8RzxcRKc88qxEZgg6iwjs3BDUtNP
         B88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FzjA3O/a7rMXwWvrBiZXtQGHAjzdhILvDzu+Ghq0zf8=;
        b=bixi+j+klvrnXPIw9lpTP0ypb7LrChQorUqmPGWroqs1hf5Q5n4GTtov8fXpzDG6eL
         JzxVFa24CvTfCMn42od2/LVqUyiPWiJDQzeQXgWwlPF4PaakfUCSfJzwqUTc6ZX7lgIF
         rI9MvmDUX4LXMf0dX0EPNsl7U5fAPhnRT54B/qcDefXo9/BjOsAvNZYGlOYne+OZrpra
         LJ5krJdz8bJ5gpOvjoR+4B0MSaDMBx8u7QgVq495h8lkFVpUo/Q9WPYQQmfUEPBym0Ps
         7H9sR2uAzGq0Hsa1GIMREUa+Og1VDkknjzGt4JS39IGe4cL/h4iYZ6wpeRDYHHwMd8TB
         QJ0g==
X-Gm-Message-State: AOAM532cS40t/XXHlYo6fNIxZJxTgvCVtJPjUZSkKxZYiI9xQQ43KZdU
        MBBZP2ouzf1W7252E3r7De5FGkxaFnf64TSf/Vg=
X-Google-Smtp-Source: ABdhPJy/WfLBuUZM/jaM4TSbYSVcUIAsMT8S16IbN61ZKvZvl9SpTq/QCZSMUpZiOXatrQSV8GEUszaB4j3ZQIPOmeg=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr27266018edr.209.1654524613831; Mon, 06
 Jun 2022 07:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
In-Reply-To: <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:09:37 +0200
Message-ID: <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 6 Jun 2022, Ilpo J=C3=A4rvinen wrote:

...

> > Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250=
")
> > Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@li=
nux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@penugtronix.de>
>
> It seems that Uwe managed to mistype his email for the A-by which I just
> happily copy-pasted.
>
> Greg, please let me know if you want me to resend the series (or if you
> will just change it on the fly while applying).

I believe Greg doesn't handle patches on the fly, hence resend.
But more importantly I do not see the reason for the Acked-by tag when
SoB of the same person is present.


--=20
With Best Regards,
Andy Shevchenko
