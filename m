Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD59749F0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbiA1CXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbiA1CXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:23:16 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B6C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:23:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i10so14274123ybt.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eZnlJSlBPw0a4/YSci8FWmERiqsXY6ici0KSijmpAw=;
        b=SKZmyCGsDIXgtr/fnOwVNDVgUma2QH1AyJ0h7xMpPArlqtIOURvn7flShTjE1iGcu8
         IbYih/8vGUNZoVoDiJfVUyrlekuQBqV0wxjhAuxx2rx2uBL/cjw9gaoCVKeLnYAnIUi5
         KrMxBy8Q/lf+9pzcCi/WzCWHjP7iea/rqkVsXVDNn9TJmkHowwb3duxIii2ue5uOzj/I
         ae6Jqx2VJuyey+wVeUXe2j3C6bOFmOXLUH7SYhTq1NC3+xZApwCWg0Ke/oc7YvrzxXpN
         MBgI5UL5+6NWgrW0Z6DyterNVKH4pmFcTSoW4koeso1fICJVcccUHLSF4vJByzHIloAV
         xSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eZnlJSlBPw0a4/YSci8FWmERiqsXY6ici0KSijmpAw=;
        b=RS5CT0Vr9wzJQLw+4slDltp1CSnC46xuRp4EVsEROZiJrbYUPzx0Y9zfmQs0YycQbE
         jlk7+17lJOGHU1Qr2uYG49OGrWgSMpvAVeJR/x5nvIqgZnJm+y3AqnuOlkT2JThasMq3
         mwpxO6X5Hn0OCZel3F/Re41DoQYZzoZSx+Iwv8R521br+2ai7AHgiDqhgYuO6m8x1YB3
         Zn4j/wr39bKI0Y+mu62ce8kcj8xSsdG3PIWaZwVp5W0PUn0k3AQMhcOThGhq4gkgJmSA
         j2Leq5fBQdp+01FarhfJMgfnhq+vnn5hLlAlPrh9Ht65WEw1M1f54MfsAs05pOg688WC
         m1Fg==
X-Gm-Message-State: AOAM532SQPb4x+5wXqU4gvSWH/bPvsbKZUktBANyJbz2k19H9nTUQxdz
        TXd9wgRRk2/7/Vi/KiCO60YCCDTIcn47ETHI1e63Jw==
X-Google-Smtp-Source: ABdhPJwVsfm97uUyp7RZ7RqMo7z8ka9Nyo4Q+8eVv/l89S8ziWJdQaM0yi+i0V/EltvSSqVOkELH6MK43HDGjAaqoxc=
X-Received: by 2002:a25:d2cb:: with SMTP id j194mr9481633ybg.277.1643336594537;
 Thu, 27 Jan 2022 18:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com> <20220127182219.1da582f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220127182219.1da582f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jan 2022 18:23:03 -0800
Message-ID: <CANn89i+k4tiyQtb6fh8USDjhZGVwdx1puh8cr9NcDQECbvJvdg@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 28 Jan 2022 03:14:14 +0100 Jann Horn wrote:
> > Oh. Whoops. That's what I get for only testing without CONFIG_PCPU_DEV_REFCNT...
> >
> > I guess a better place to put the new check would be directly after
> > checking for "dev->reg_state == NETREG_UNREGISTERING"? Like this?
>
> Possibly a very silly suggestion but perhaps we should set
> the pointer to NULL for the pcpu case and let it crash?

It is already set to 0
