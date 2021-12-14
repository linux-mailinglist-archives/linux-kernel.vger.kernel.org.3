Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45410473B72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhLNDUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:20:15 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40406
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231669AbhLNDUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:20:12 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5C03F3F205
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639452010;
        bh=8FZdDPbJvuDCvUbuvpPls49z7FqYcIY0iWn2oyHLKu4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=A2ENuQZwbmAQ3qQ+xpKCtn5icmdla3MOXGWyON9ixGzLEWNG5Z4xTARSI0RWPOuA2
         cUnA00HpbQzGU+Q090KGpL0/G7sOYivBBZjp3QwZ5Kx+FM/5VKSfN1cjxWWlKIViNO
         CLXo/sabnnnPOCx7wf9X4lyE5LOcnymHJ8cQa0bvsxxMloe5rHh7iqzRlTPAz2XiQ1
         B/zHPMYpPl+XmketKT3OxJw28M7U72DteF7jpLRfWCwiSUfFPY+UwEsWNAXQzincXB
         XuBv2rkwcVdfpncrKQGiVXxu2kbcF0vbIcnAkAEmJYHC4b4zOa+AKqGvr/+uRj2Hhs
         fzkWpYSk0fihw==
Received: by mail-ot1-f71.google.com with SMTP id f3-20020a9d6c03000000b0055c9d337de8so7356135otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FZdDPbJvuDCvUbuvpPls49z7FqYcIY0iWn2oyHLKu4=;
        b=7//BlZN0QduQSVkhNAGdGAECiGMpkm6n8OUzVdO+U5NnS1gYUL1mGqu9+TABRiNaSe
         gOGEvuVUltH+pCl7jDG2kQG071WqEGo4tgKPdf0Iootz8zbJDVYNkpkDJBA1PLN3uBjG
         IjamOFNXLFcwOuLlvQq6c/34dZ9/NQjLVB4K7SFOUZ6LlMm2Q2pA2DlA7dXt3flFrFDt
         yL1z2yPb5K0m8NmPU1/b9hKLJ2whGwOI31LgSM59kOJ7QD48axLWT2jsp/iMZ1WL5MFX
         Aa1V0RnpLd2AVdxraA7Dz/meFSvam8Gvbr+FKopBnVSko8xaPNaYN5sED5qdPo7xRCFl
         fnrw==
X-Gm-Message-State: AOAM5334laX1tjytLVgxSr1+NwxHjFMOnzJmq+droFxlWZdhfY21IvQZ
        ZnwpP7kFsv54Q+IAEhKdmAYcIAUxg8xFMuamdrlmJX/PpUOg/n/zEEyFkpshIT5cWZ9fhnStLEQ
        Flzh3JaLAeUZbIDBvP9KjYTWPNMk8wARS/E9d6Z/kD8sX8drZ+YVW5FuZVg==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr31976319oib.98.1639452008770;
        Mon, 13 Dec 2021 19:20:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZYy3vrJI5erZLzbK8j8AIuaUEm9zlOY5LI7xfy8mYTB10jRalX15dW1iBj7EEA3q4dqo9v+uUDoDxS9APxRc=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr31976296oib.98.1639452008405;
 Mon, 13 Dec 2021 19:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20211214024901.223603-1-kai.heng.feng@canonical.com> <cdf57476e4a544e09859029bf05142c0@realtek.com>
In-Reply-To: <cdf57476e4a544e09859029bf05142c0@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 14 Dec 2021 11:19:57 +0800
Message-ID: <CAAd53p4v+CkEz-qruFr1+-Xu+z=pn1nTic-Jhfa5LN+svc7U-Q@mail.gmail.com>
Subject: Re: [PATCH] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
To:     Pkshih <pkshih@realtek.com>
Cc:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jian-hong@endlessm.com" <jhp@endlessos.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:19 AM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Tuesday, December 14, 2021 10:49 AM
> > To: tony0620emma@gmail.com; Pkshih <pkshih@realtek.com>
> > Cc: jian-hong@endlessm.com; Kai-Heng Feng <kai.heng.feng@canonical.com>; Kalle Valo
> > <kvalo@codeaurora.org>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Brian
> > Norris <briannorris@chromium.org>; Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE
> >
> > Many Intel based platforms face system random freeze after commit
> > 9e2fd29864c5 ("rtw88: add napi support").
> >
> > The commit itself shouldn't be the culprit. My guess is that the 8821CE
> > only leaves ASPM L1 for a short period when IRQ is raised. Since IRQ is
> > masked during NAPI polling, the PCIe link stays at L1 and makes RX DMA
> > extremely slow. Eventually the RX ring becomes messed up:
> > [ 1133.194697] rtw_8821ce 0000:02:00.0: pci bus timeout, check dma status
> >
> > Since the 8821CE hardware may fail to leave ASPM L1, manually do it in
> > the driver to resolve the issue.
> >
> > Fixes: 9e2fd29864c5 ("rtw88: add napi support")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215131
> > BugLink: https://bugs.launchpad.net/bugs/1927808
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/pci.c | 74 ++++++++----------------
> >  drivers/net/wireless/realtek/rtw88/pci.h |  1 +
> >  2 files changed, 24 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> > index 3b367c9085eba..f09eb5e2437a9 100644
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -2,7 +2,6 @@
> >  /* Copyright(c) 2018-2019  Realtek Corporation
> >   */
> >
> > -#include <linux/dmi.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include "main.h"
> > @@ -16,10 +15,13 @@
> >
> >  static bool rtw_disable_msi;
> >  static bool rtw_pci_disable_aspm;
> > +static int rtw_rx_aspm;
>
> With your parameter description, rtw_rx_aspm = -1 by default.

Thanks for catching this, will send v2.

Kai-Heng

>
> >  module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
> >  module_param_named(disable_aspm, rtw_pci_disable_aspm, bool, 0644);
> > +module_param_named(rx_aspm, rtw_rx_aspm, int, 0444);
> >  MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
> >  MODULE_PARM_DESC(disable_aspm, "Set Y to disable PCI ASPM support");
> > +MODULE_PARM_DESC(rx_aspm, "Use PCIe ASPM for RX (0=disable, 1=enable, -1=default)");
>
>
> [...]
>
> --
> Ping-Ke
>
