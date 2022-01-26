Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53FE49D225
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiAZS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbiAZS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:58:10 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57154C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:58:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n17so766813iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wyngZyIrlUk01+iEOlsom8ih3d/SEkgg9mdbfxMjBKY=;
        b=nSPmP24HtC8iu/VFrAUpvAwud6+rPMJ5yo6pAqXOvx8fFTj3qP8h2gt4oObElaUDxR
         f3geinsOxRWyAkvxpMQMuC6w9f+VVqdUcLJZHjBFjS8O4FWjdtYWpO05/XfvZQ1jv+G6
         A12hipy+TxNMvNjpcKjyouHTj0MU3iYbtGCgzgZnzq95SFX3ybqPxkLD3yKVBLiK2qEW
         eVwkYkNemK6Lhy0uuo+/ByG56hxXfHg5XVTjDT2xeEb3pK9/lBCVknk3CHIW5uU/FGbj
         3khZbEz1vNmkBKlYExdxxnYFNA4GZWHVxRLE1jHfl8bYfTr0FSOIopw44OxnNB3UpTC0
         yajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wyngZyIrlUk01+iEOlsom8ih3d/SEkgg9mdbfxMjBKY=;
        b=z5oaukOodyPYZwmHInKfCIhn+UWY6wpB5BeVE7ZFUaONrZ4KPxeMEyvVwfb7QXzirA
         S1rMNMimMYXBQnIzBySQ6Ar1heHbGTHEtPlsmdeFDVCI7uWhqrXv/509rGnyGRL72YUs
         CFKeMtzmEB9tC6W2Qr+Nwg1ldTAVnM7ajic/579I+f3wqbvzlgbErVkw1wx2UeAVbEUC
         52F9EfJQNZT2jlAiKZZiUV7WzAi0hnv8sM89H4fnGzvyrF9ksTr38r5Dr+2dBfAUp9Ys
         9WL7WeGg5GPW+sWFB8pRX+sxRFQdDBEaC9A02y0rY4PNAJfDCBRIvrJ349RTwtcx3UYt
         zqMw==
X-Gm-Message-State: AOAM5331DxfN+EOz3XTRU+tNf7i26MFuQ5M5ZDSyxKXjQ+Ywq/Fq2ccS
        7uycDMmc1lYaC9zO9AiB2MdqdayEaPqIMBpP8xVzlBAkxk4=
X-Google-Smtp-Source: ABdhPJwtMLliBG3wT1Y/vWDYL0Er0UPdS0WQquBtClo6suuooJ1hlgFqLRErD+rAPDLXUnNKXmqNSNQM0vMBhinPeq0=
X-Received: by 2002:a05:6602:2d49:: with SMTP id d9mr14348785iow.64.1643223489670;
 Wed, 26 Jan 2022 10:58:09 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
 <cf6ac499-4190-cbe5-255c-f9edf07a4786@kaod.org>
In-Reply-To: <cf6ac499-4190-cbe5-255c-f9edf07a4786@kaod.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Jan 2022 19:57:58 +0100
Message-ID: <CANiq72mV3AzmBDVJM+tQriEoDu_9LFBrK_vR6GC4qEmLw0UepQ@mail.gmail.com>
Subject: Re: ppc: hard lockup / hang in v5.17-rc1 under QEMU
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 4:03 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Indeed. I could reproduce.

Thanks for the quick confirmation!

> Could you please send the QEMU command line and the full dmesg ? and
> possibly open an issue on :
>
>    https://gitlab.com/qemu-project/qemu/-/issues/
>
> I guess it's a QEMU modeling issue.

Of course -- done (details there):

    https://gitlab.com/qemu-project/qemu/-/issues/842

Cheers,
Miguel
