Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA16350D668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiDYA4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiDYA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:56:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444492AE33;
        Sun, 24 Apr 2022 17:53:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m128so6450814ybm.5;
        Sun, 24 Apr 2022 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZQ3FMYUd+p/inKfEtNk7azbI0rl4BBbugTy82Pulbk=;
        b=mbKKUDoML1MgFijTXSdszOCRfm204iehbQFamK9YL4OyLefmNETkuWOTg/55yhQZlz
         MOXMOrlZT7yx0AgHeBMIlQbduznxpKMqwxqmgvRzZetaFQHTAPPoo/pZWUrGabIepYbj
         JR0lGeXqIslccK99hoTJR3G5DVavQ6KkAd46lsjJInfLmzO6+Nb/pl41I07ixAnWMjtu
         z0J32fG2tMN9h7rP7mvXPAqxLf4+BRcgSvBqmeK/zxynEiOt8QzAriq5EP5+CZn22PxS
         hhgnDqpPdVJC2bmeKKk2qJc/QoY/LXU7f8cOzZrS8/CdnBPn+hKPUnt0a4xDS9gIaJCg
         TG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZQ3FMYUd+p/inKfEtNk7azbI0rl4BBbugTy82Pulbk=;
        b=APEwmD9HKRw4UJqRb4yNKqRynHVTOWEPy324MdnGVQGv7ldJFSpCMTrr7XExOz3Eke
         U3GdVecbjrwob6WE7Saw03NlLKmoK5aTaydMTaDsee+NG1wVyPHL7Qm4G0ZWJ3geXl07
         7tzSc/65EkNQUdv1UA5ePVfU2OWLPjJmzXQZg6xUVF9ahmaQSRrH4uJ0mj154KN1Tg+t
         Iq4ECC4sAtc5ZCOEOnUAaifF0YcN96CWA0VAWsnpNROGJaVuUIs8k8tKAjkGLWMk3Lqq
         6KhLqcu40RzJlcibqCzxefC615ZHWKT1aLPbuwrD26FztIdUR4GgpAK8n922PAVwSlyw
         D2eA==
X-Gm-Message-State: AOAM530AHadXLUU4TbPedatbV1sbUhtfMXIgcTYoX9Lh6u1E7R4XpP8u
        Ng2eNGtEWL1LNERExviwJZuawOy8JdVLOOmOzyE=
X-Google-Smtp-Source: ABdhPJw9e1BG4zkQJcj7cJbfdiKChlhybqzcCD3J0heWIWKkippV6yvT97DgC67kxkdfxYrYsFP+8++rsK102W9Yy3k=
X-Received: by 2002:a25:3a06:0:b0:641:cbcd:73b2 with SMTP id
 h6-20020a253a06000000b00641cbcd73b2mr14691974yba.64.1650848013511; Sun, 24
 Apr 2022 17:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220414094945.457500-1-benchuanggli@gmail.com> <CAPDyKFo2YhqgEStGcQb0ZWcuhrUcGeamgHk1Hov6_DzS=TNe3A@mail.gmail.com>
In-Reply-To: <CAPDyKFo2YhqgEStGcQb0ZWcuhrUcGeamgHk1Hov6_DzS=TNe3A@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 25 Apr 2022 08:53:22 +0800
Message-ID: <CACT4zj9rRmwPBTg6GE1qd_F_sUuaJeQbB4U3K0h24jWKe8oRWQ@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: A workaround to allow GL9755
 to enter ASPM L1.2
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 14 Apr 2022 at 11:49, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > When GL9755 enters ASPM L1 sub-states, it will stay at L1.1 and will not
> > enter L1.2. The workaround is to toggle PM state to allow GL9755 to enter
> > ASPM L1.2.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> This didn't apply cleanly, I fixed it up this time. So, applied for
> next, thanks!
>
> Kind regards
> Uffe

I forgot to rebase to v5.18rc. I will pay more attention next time. Thank you.

Best regards,
Ben

>
>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 97035d77c18c..52230857388f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -137,6 +137,9 @@
> >  #define PCI_GLI_9755_SerDes  0x70
> >  #define PCI_GLI_9755_SCP_DIS   BIT(19)
> >
> > +#define PCI_GLI_9755_PM_CTRL     0xFC
> > +#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -597,6 +600,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
> >                             GLI_9755_CFG2_L1DLY_VALUE);
> >         pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
> >
> > +       /* toggle PM state to allow GL9755 to enter ASPM L1.2 */
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
> > +       value |= PCI_GLI_9755_PM_STATE;
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > +       value &= ~PCI_GLI_9755_PM_STATE;
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > +
> >         gl9755_wt_off(pdev);
> >  }
> >
> > --
> > 2.35.1
> >
