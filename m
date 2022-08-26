Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F535A2BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbiHZP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiHZP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:58:38 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F0D2757;
        Fri, 26 Aug 2022 08:58:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d1so1407027qvs.0;
        Fri, 26 Aug 2022 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=I89+GtdLDYu5YcLNj7x61zy5ozsOEOzUCHwapHGrE8s=;
        b=ddFmSMFvEgmn1bwh7eeNd27c1S1/Oc5AEESAdl3cq89wkX6w5+tPbhoVOexEVaqP9Y
         Vcfk8+hrmPpmKDI2CwOVy8fr23d0a9GNTtx4eRTUzzmNYEHogvbO0Br8z9skAL855Qx2
         2NxRd0cfVreTyJeRhNwn9uvAxUak7dM8HqvYuVJLrv0ho0TSpmbh6AfpSC+m00fOzfIm
         7XLyWbCWlZ3MYjHBwYnW2+bLtjjZ8QGR7beX0/TBrkv5YjFhp8Q+WAtbp4j1Fh1Pu9AN
         QkUb+R22KHC7Fk9GAHLvakISI0mnGHhStAEM3WHZZsojCtU4zaIR2ozl0z9FKwuUiu50
         lAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=I89+GtdLDYu5YcLNj7x61zy5ozsOEOzUCHwapHGrE8s=;
        b=Askbl3M4PPRaqgqhjLah3eJH6Ee4PLK8AwUIi84IBJ0oUopZyBG0IrAjxfmDjqbyek
         mAldhFL8wjUElmZ/oqnknoRxv4PutNZ5jSGN2cNnBdqqu5JhCUY+74SpfNxOCiU1v6Sw
         e30sXiCLDBCp+jiLxq6teMjws/QYJ9AKAQw11Z12ySrezHyYna4DFUfJgmXeDDv6rioC
         er4XbIv7TYK2Lj6Xejibajgexuew60fMhRDrAn99+D9KdHD53Fz5tLmoqXjWXpG5Rltp
         DXrwTFCVZbc1riQos5PaiOHA7v2DIZcYlcy2G6pIFeusJdmUwJMjcnnNTcjrClPAE+3A
         TU7A==
X-Gm-Message-State: ACgBeo3xhhyn+64cRpAWCJtVXgxO3ebKULsMhcACioViE1ekWvqzj/Z+
        1d49nfgeXRbXy1i0P+rrrHQIdRi0HqyUQ34VpANRJlLTTD8=
X-Google-Smtp-Source: AA6agR7UTNfn0qX9Vr3FvvvicI1wC35JOdJoJRLRjt9iQChk7kP4djaxDeR+rVHBCUgOuO4Oh4zGF8z7OTmsA1J8YAI=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr211343qvb.97.1661529516950; Fri, 26 Aug
 2022 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:58:01 +0300
Message-ID: <CAHp75VdyK5FsWbeuP2BTbuqb5NY7bSvoogiUnORjQ62tEigXVg@mail.gmail.com>
Subject: Re: [PATCH 0/5] serial: Remove custom frame size calculation
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 11:58 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> A few drivers still calculate number of frame bits on their own. As core
> can do that for them these days, take advantage of core's capabilities.

For non-commented patches:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

With small style things addressed as suggested, you may spread the tag
to them as well.

> Ilpo J=C3=A4rvinen (5):
>   serial: ucc_uart: Remove custom frame size calculation
>   serial: cpm_uart: Remove custom frame size calculation
>   serial: fsl_lpuart: Remove custom frame size calculation
>   serial: sunsab: Remove frame size calculation dead-code
>   serial: tegra: Remove custom frame size calculation
>
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 28 ++++++---------------
>  drivers/tty/serial/fsl_lpuart.c             | 10 +++-----
>  drivers/tty/serial/serial-tegra.c           | 12 +++------
>  drivers/tty/serial/sunsab.c                 | 20 ++++++---------
>  drivers/tty/serial/ucc_uart.c               | 15 +----------
>  5 files changed, 22 insertions(+), 63 deletions(-)
>
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
