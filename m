Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D554481133
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhL2JM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbhL2JMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:12:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE5C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:12:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso10891222pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65wZg+nw0EC2ckBgLxGJRnozKF0Neae8vMtlYlRMygs=;
        b=DrKcPO/ocB+rLxv+4dSB4M7wcl2pBRiXO9vd1Pp5gl+9uoESeNwpRZ/70nIdYHf0db
         R9Wqikl/hTkAXnKOQOGkFDT9hB7XmvCpKXHCoXxMFBLSlB0+L4heLdMx7lg2I2jPQ+28
         OfrxUGOJ+ZuHLKT/AoNgOVkTpepx8jPo7WIv+nvinWAxkWMoAbXHJ26AwbE8oHUXSTiq
         aSCIS/jJHn39bfslIj/sjwrvBp0Aj4MCENgB6vaaz5Bf3Bcf0stnWTl1zYztEol7E0Q+
         CvqWUsJfu1+/6+g2GSFCm2r6XKxnioUmuP7o2F72PpNchZUyqJmRMwrJrECY5/fF3PnJ
         gkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65wZg+nw0EC2ckBgLxGJRnozKF0Neae8vMtlYlRMygs=;
        b=FoXv3M+tr3lSpqtYz61X2rXgq+y+ngL2247B3wOArHY20Z9HSgaTmy1JUxAGZ6PvF2
         6xqcOyBSWng5MKdLyi6OSrb1ePT4iJs1+58QbVubZMBOA7jKhnKQCMDo51Ob3g7HxAS7
         bzZieHE22toT/kukBBb+p6bfR5IgZTlzUqr83Ez+rjHBzDIChPpvL+ylHsLwhiCpts74
         MsKsopWJBqd5gq8y7X+4BXteQzZ1xpYo+MtsHatj20KoZEWiBrUJOfueyP6wAjZpO5Mn
         X4gGZg+StX1VobDj74Uw69iTf7uo3yTH0+jloRcy0xeOJmAp5uKgqPfs/hMVoVh6r5xb
         zLqQ==
X-Gm-Message-State: AOAM533X1Wj0g/ihhxXxbAB1r36KrF9DMBW4FEVVd2l5fsDKWU9DJDVl
        1dbPvr5XY0b6Y9CF6JyaKlA5BPZXM3y++lvR4OhLBg==
X-Google-Smtp-Source: ABdhPJwMuiLZ5/tPHer3jJjlmoWxWSHkiXdBvpbwD5UqV2DkvU9or5gYR9apreOuMA2uiyYZRJfpftYRNTURxpxmUZA=
X-Received: by 2002:a17:902:9b93:b0:149:8ef6:f673 with SMTP id
 y19-20020a1709029b9300b001498ef6f673mr8246338plp.124.1640769143227; Wed, 29
 Dec 2021 01:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20211228060246.2958070-1-pumahsu@google.com> <YcrKNP4TRXB6nsCI@kroah.com>
 <CAGCq0Lb8ZoGpbkLNhXG=OyWgvz_Qn3ABmq_uvMPJdyEKygMH+Q@mail.gmail.com> <YcwclrVzEXRxgUFa@kroah.com>
In-Reply-To: <YcwclrVzEXRxgUFa@kroah.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 29 Dec 2021 17:11:47 +0800
Message-ID: <CAGCq0LbfWt2xTmRczhdZUXrwFTJdaMH3Zd-y4quqWi7kyaso6Q@mail.gmail.com>
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 4:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Wed, Dec 29, 2021 at 01:53:04PM +0800, Puma Hsu wrote:
> > This commit is not used to fix a specific commit. We find a condition
> > that when XHCI runs the resume process but the HCE flag is set, then
> > the Run/Stop bit of USBCMD cannot be set so that HC would not be
> > enabled. In fact, HC may already meet a problem at this moment.
> > Besides, in xHCI requirements specification revision 1.2, Table 5-21
> > BIT(12) claims that Software should re-initialize the xHC when HCE is
> > set. Therefore, I think this commit could be the error handling for
> > HCE.
>
> So this does not actually fix an issue that you have seen in any device
> or testing?  So it is not relevant for older kernels but just "nice to
> have"?
>
> How did you test this if you can not duplicate the problem?
>

Yes, we actually see that the HCE may be detected while running xhci_resume
on our product platform, so I'm able to verify this commit can fix
such a condition.
For older kernels, I'm not sure whether someone had ever met such issue, but I
believe the Run/Stop bit of USBCMD cannot be set once HCE is raised.

Thanks.
Puma Hsu

> thanks,
>
> greg k-h
