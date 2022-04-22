Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9C50AD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443281AbiDVCOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443267AbiDVCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:14:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7AD3881;
        Thu, 21 Apr 2022 19:11:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so7249272iom.13;
        Thu, 21 Apr 2022 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=THB/rCWOGRRIRIhECHZDglj7Vx+NGfgUwYSBViBKwtg=;
        b=R6gjrq2icFejVNYcXyZKoqk7o7RMq25KWkGjFrJq0n6BTM4CiJY3gI4kLHwlYAOgpN
         zUuARqL8YHsBS5R5oIc1lcT2G8F5IbyMMxj+z9iiwLXG6azdXEyb8PhrCtgXrTcWVcB6
         exmEstTVrD1M3G600lKq4nt86MrSO+eo5UMi7xN37AezJoqLG9mxwF+Thbcr3xfgV0h+
         KdGn7vq3LKLgsuY4Pji6OmOyjs1big7nju4AoYGSb4/lYArlzGEYAf12wSe24nmzO6P7
         fS1SnxUusDfpPdXMBU9rnadro8eOB8NLd+dzYCKB3/SjW9+d8fJUHunIVjfuQgygQxAA
         AIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THB/rCWOGRRIRIhECHZDglj7Vx+NGfgUwYSBViBKwtg=;
        b=U+JjPIsXiK857R55RX+WCUgjls5oiXv3VQ1CwF2ZO0tubCNQWoMiPR+Ht4kTOcrJsa
         lTyGz0E3JtYs/VBRgmKiUEhYfhqt0KtZX+rq2n3/Wg/5gGM1SFB4Zsg24Skr5QaHDzR0
         0oJktE8Z8islNIi+Wo8QAiHL0XRWiG1IeNOB4kUZB2wAcvh38qQ3QQLvE+/SelD64qTz
         3M7By1MVnbLAe1OWRx5erWeYPNksEu7tGkdxslMJhKjyt9PTb7tUJ7cf8N3tjkbTNnmJ
         ku8joUVR4FaZ/ZmIhOrLXnsgVE7ZliW93106efTzkedbL6gxy2Dl/aXdmm8is2gZKkT6
         vbVg==
X-Gm-Message-State: AOAM5311gD8rBH66BUQ3kO7FXXEC8c/AVpsmAACRhTjDU7jluOYuKnYu
        7QDI+b3zB9U8QMhbWhRm4mho78/cpdKybwAq9SsQGwdmCuV9A1L6
X-Google-Smtp-Source: ABdhPJxep6RnbtTNtFPOqoRJAv+wWszzQRdMVGiABj0/cPlaniM4Blm9tZQMnu54F1vQAOLMau/jKbEU4cZfT05x3r8=
X-Received: by 2002:a05:6602:2f12:b0:654:b304:b016 with SMTP id
 q18-20020a0566022f1200b00654b304b016mr1079035iow.60.1650593466714; Thu, 21
 Apr 2022 19:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220412122524.26966-1-surong.pang@gmail.com> <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
In-Reply-To: <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
From:   surong pang <surong.pang@gmail.com>
Date:   Fri, 22 Apr 2022 10:10:55 +0800
Message-ID: <CAEDbmAT=fZ-kpn13sW4KjB9RuFb_6T4j_eripR54NZ3UciZfqA@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shared_hcd might be freed already here, but hcd should not be freed
here, because "usb_put_hcd(hcd)" is called later.

Mathias Nyman <mathias.nyman@linux.intel.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=BA=8C 22:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12.4.2022 15.25, Surong Pang wrote:
> > From: Surong Pang <surong.pang@unisoc.com>
> >
> > Let usb phy shutdown later in xhci_plat_remove function.
> > Some phy driver doesn't divide 3.0/2.0 very clear.
> > If calls usb_phy_shutdown earlier than usb_remove_hcd(hcd),
> > It will case 10s cmd timeout issue.
> >
> > Call usb phy shutdown later has better compatibility.
> >
> > Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.=
c
> > index 649ffd861b44..dc73a81cbe9b 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -390,7 +390,6 @@ static int xhci_plat_remove(struct platform_device =
*dev)
> >
> >       usb_remove_hcd(shared_hcd);
> >       xhci->shared_hcd =3D NULL;
> > -     usb_phy_shutdown(hcd->usb_phy);
> >
> >       usb_remove_hcd(hcd);
> >       usb_put_hcd(shared_hcd);
> > @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device =
*dev)
> >       clk_disable_unprepare(clk);
> >       clk_disable_unprepare(reg_clk);
> >       usb_put_hcd(hcd);
> > +     usb_phy_shutdown(hcd->usb_phy);
>
> hcd might be freed already here.
> maybe call usb_phy_shutdown(hcd->usb_phy) before usb_put_hcd(hcd)
>
> -Mathias
>
>
