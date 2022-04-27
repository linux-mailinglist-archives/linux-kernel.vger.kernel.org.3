Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8FC511DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbiD0RGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbiD0RGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:06:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB13261F;
        Wed, 27 Apr 2022 10:03:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j8so2071246pll.11;
        Wed, 27 Apr 2022 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIkG1owri2/UiQ/Mf5UXTc76P7ZxIGFTFq3OK8sBZu4=;
        b=AvMuJ9fS5bJaug0ZRaCzA8F4guuIeDepi34YDnk3QFSk5o3cTRMNXRVPbY3k43sbF5
         yy5zeV54cBZ6Ws3/LwMqi8uMVzbQrset1ZjuItQz6Eu1KmV0I/yCz4ecDUbhcm0QEAGQ
         O3crS9IRJzqEU8X1K6yNkrcimKeYULah3a96A/VuGpjaJXjXuKlK8I3xmJOCZnkPqFDt
         AMf4/BBvm0fobFaAtASF5Q8EqFzEWc4AEK+yF0abBN0REZ+Fj8LpEOMJybWvb80JDQSL
         mNzhuTzpgwA36FynG6RsYuyB1KJXNZLTvta8ZiReASWgnuN7AQc4z8TsphC41nVov7de
         wqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIkG1owri2/UiQ/Mf5UXTc76P7ZxIGFTFq3OK8sBZu4=;
        b=AXO69hLLsyM+cqRcVzDyeLtSaAQd/bL4bhnLYtnMRW+X76Jh0/a/qT++oK6wsj/H2u
         xTqmB691k9RDnRKDFPWlKWskz8W6kvb/JVP7z4/x9blo5boIALLDtMZqNjXiYz2fYU6B
         +AkRiWbtbWbOH4Ke6yzMbJNt6OyMQGKENyTbO2uzocYYTEAYsZ044Jo6Ktmzcnk2VbPF
         CEOELOsRaXjszxQ3MZvmvq15zPxX/3+4CuYNmbBRUNnsBinnPsYvJjKXka7VivZoLb45
         W6vBiZAAV/Gd1iPuHhBn4DW2xdcyDDCHSKtZC8rVWaZW6ROxlSTDw3p8YTFHTLNZjF6S
         4S+w==
X-Gm-Message-State: AOAM532JyZ3IaT9uriBTCj982IixjYCd9GP9LCPV/N1ywkw/xM+zEpTU
        X3JC5CJG1vXftDZrTbqAtd/UBykuy2T1AOmiDzgiEXOXhwS8PA==
X-Google-Smtp-Source: ABdhPJy8Fa5KsCVoC4dcvOY6EGXvNPIqRb8MLp0LL/91ONioAqdczDdXwmS1xPVQ20P7Y7aQogtBpKTG1igavRrCbxc=
X-Received: by 2002:a17:90a:730c:b0:1da:4630:518e with SMTP id
 m12-20020a17090a730c00b001da4630518emr3243604pjk.239.1651079013835; Wed, 27
 Apr 2022 10:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220427163525.1129887-1-Frank.Li@nxp.com> <Yml16DvnUR/tJSCO@kroah.com>
In-Reply-To: <Yml16DvnUR/tJSCO@kroah.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 27 Apr 2022 12:03:22 -0500
Message-ID: <CAHrpEqQzBpNej+z6Td-snWtP1OqE8u_DAB6jAs-KAUBHmKcYkg@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, Jun Li <jun.li@nxp.com>,
        kernel list <linux-kernel@vger.kernel.org>
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

On Wed, Apr 27, 2022 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 27, 2022 at 11:35:25AM -0500, Frank Li wrote:
> > Some devices have USB compositions which may require multiple endpoints.
> > To get better performance, need bigger CDNS3_EP_BUF_SIZE.
> >
> > But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
> > multiple endpoints.
> >
> > By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
> >
> > Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
> > Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
> > ecnds3_device:ep_iso_burst
> >
> > Using a simple algorithm to calculate ep_buf_size.
> > ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
> > 1).
> >
> > Test at 8qxp:
> >
> >       Gadget                  ep_buf_size
> >
> >       RNDIS:                          5
> >       RNDIS+ACM:                      3
> >       Mass Storage + NCM + ACM        2
> >
> > Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
> > exceed FIFO memory.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2:
> >  Add safe check for mult, buffering and maxburst
>
> that's nice, but this is v8, not v2?

Sorry, It should be v2. I made a mistake with the title.

>
> confused,
>
> greg k-h
