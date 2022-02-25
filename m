Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA34C4CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiBYRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBYRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:55:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885A2023BD;
        Fri, 25 Feb 2022 09:55:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so7459263ybu.0;
        Fri, 25 Feb 2022 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL3+gq5rRrQls4oOT5mVDFvzVfzctMAE8XSq+K4a63M=;
        b=KsYxOpgIWN6IDwup3ypMUbXh+wW6AJ35cHgHYzvn+tAX4cDvlPL81+JVb+/kgoKLC8
         fk4aHAa1RpNzeUq56hJU4o1VAG2kHnVBDnuKncwTWp0CqgnEdBYI2HnxiDjVCrajIl4J
         QognCmryARR4V2jOf7jq7Vvdgv3kamJdq4gqU7q5Yq77Dn+X5YKs8IH7k63I1GB/E1wp
         tFUhUL3/wiBpzNJwWxbPJcpAR1j1dqiEFdiFLiX1KwaRzNAGqf45eAuzlAyQV+3Uwxg3
         i1BO32oc8aDjxz/KryfrDIcmnigwFdzFOclca79uNO/DQUOWc86d/e+xjO3TO/i3qUjb
         x3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL3+gq5rRrQls4oOT5mVDFvzVfzctMAE8XSq+K4a63M=;
        b=EI0ywDASrQZQyVUUCppurLfBQ62TLmkHSOafVWUs/VA92opGrvwST+p734Bs8/Efn7
         rSLcty2o4hO73GMQ5vZxLsXfkA9qmwnoO/Sg4J/l365oQer2Skg1yAECZcj9eU96CbDh
         2/b2b54ThpqLarns0lzM+Az9UKDnbTZXVeEHxIi3k0rcWb7yvsMQRVYPD3MsrhArNruq
         Xjk0lE5mWnbtmNGU5dImU1EQd6/iSjaHE8xLxqlWAfVFflm+d3yWg7EPEYk00ECMTiIl
         KzOyVIsiSa0b8lHsarMYAVj9l2TAEC02skXbuXxNe3Idk4N65Y8YMTA06ehY7P+9a8n8
         Pqsw==
X-Gm-Message-State: AOAM5322EPuu8+RKHcpEL+F8l4r2kIy/3MQ3YTw0VfV6DLlxYhoe+mcG
        0VRKM2Cjg1JZ+PKRuTEv0GuuTShwIHXOSPjdKjlDp9FyK84=
X-Google-Smtp-Source: ABdhPJwkgt4bvz9+XRFk0hwjy2XhoTLnHOdxNMkUuEz2T+/dbutGG1n3DqLl3nsa4UM6TNIuTMSJx2k6bkonxUMEWZ0=
X-Received: by 2002:a25:8490:0:b0:624:5f70:142a with SMTP id
 v16-20020a258490000000b006245f70142amr8292063ybk.173.1645811720591; Fri, 25
 Feb 2022 09:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20220225145432.422130-1-pgwipeout@gmail.com> <20220225145432.422130-5-pgwipeout@gmail.com>
 <20220225171601.GF13801@jackp-linux.qualcomm.com>
In-Reply-To: <20220225171601.GF13801@jackp-linux.qualcomm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 25 Feb 2022 12:55:09 -0500
Message-ID: <CAMdYzYpgECcG55pGFNrNDmhGZuuY19VOBK4uBZQQ0JSc0xu+1Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] usb: dwc3: core: do not use 3.0 clock when
 operating in 2.0 mode
To:     Jack Pham <quic_jackp@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Yang <yangbin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

On Fri, Feb 25, 2022 at 12:16 PM Jack Pham <quic_jackp@quicinc.com> wrote:
>
> +Thinh
>
> Hi Peter,
>
> On Fri, Feb 25, 2022 at 09:54:27AM -0500, Peter Geis wrote:
> > From: Bin Yang <yangbin@rock-chips.com>
> >
> > In the 3.0 device core, if the core is programmed to operate in
> > 2.0 only, then setting the GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK makes
> > the internal 2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe)
> > clock. Enabling this feature allows the pipe3 clock to be not-running
> > when forcibly operating in 2.0 device mode.
> >
> > Signed-off-by: Bin Yang <yangbin@rock-chips.com>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 4 ++++
> >  drivers/usb/dwc3/core.h | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 18adddfba3da..032d40794fae 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1167,6 +1167,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >               if (dwc->parkmode_disable_ss_quirk)
> >                       reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
> >
> > +             if (dwc->maximum_speed == USB_SPEED_HIGH ||
> > +                 dwc->maximum_speed == USB_SPEED_FULL)
> > +                     reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
> > +
>
> I doubt this is applicable to all revisions of the DWC_usb3x IP cores?
> For instance in the programming guide for DWC_usb31 1.90a bit 26 of
> GUCTL1 is 'Reserved'.  While I do see it in the DWC_usb3 databook,
> table 4-8 entry "Remove pipe_clk mux for 2.0 mode?" mentions this
> feature was only added in v2.90a.

I was wondering about that, thanks for confirming for me.
Is it possible to get a copy of this programming guide or is it closed?

>
> So this setting at least needs a revision check to make sure we're not
> causing unexpected behavior.  Something like
>
>         DWC3_VER_IS_WITHIN(DWC3, 290A, ANY)

Will do, I appreciate it.

>
> Jack
>
> >               dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
> >       }
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index eb9c1efced05..ea3ca04406bb 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -259,6 +259,7 @@
> >  /* Global User Control 1 Register */
> >  #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT    BIT(31)
> >  #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS   BIT(28)
> > +#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK      BIT(26)
> >  #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW                BIT(24)
> >  #define DWC3_GUCTL1_PARKMODE_DISABLE_SS              BIT(17)
> >
> > --
> > 2.25.1
> >
