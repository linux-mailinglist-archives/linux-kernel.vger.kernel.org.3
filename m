Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6E495718
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378229AbiATXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiATXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:51:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C747C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:51:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e8so6805890plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sduWb0Nvw1COmM42DpEYFdXHLJwAxVfDURuvJPcjjFw=;
        b=kniFNKoNNXu9eWVpnbtx93A0MzPWJT6hbt3d4UWRU4OWNz+Qn0lYXdujM8WhKxNSvr
         4GxPEVkYiwWM6YrkJ5QTN2E++PNkC+ui1IsPnJae6Wrq3Ztiuu8/VA7r2QvrNGrbKUvG
         MI1JiFK5Px43H4sFwJHoc19LqXzC1/ZCYiY0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sduWb0Nvw1COmM42DpEYFdXHLJwAxVfDURuvJPcjjFw=;
        b=NpNUdfwy/qJHV97Bun2Mm5aqNeXSLl27p+4XxjE6ESYxoO/Wl8kYXUSTwJVyCExHaY
         iBQpopC+yaK9fOurQyEOkEpshJPH2MqTRfZbjxl1TTjlorugqUScDIZPMMgmUJwKLQAX
         DXasdXTJu+VPSX4IsaPeu9CsvVXuxxWNuzDjyAP6/gXkoLNnvbJd7IIvd5i/IlVM5L08
         8MscrFldUAuEYyIjPU0LHWsbBHyqr6KCSppKRFSZt4RckeLZuxCQ5ingsJw1L8ltPzxZ
         T/Xa08dxE3G12RKRShN081BsGGQjISuDg2jMER5UWWoa+G/uMWjYI+nXn3nrZ0aKgeHs
         rPEg==
X-Gm-Message-State: AOAM5301UkWPZagBuYvtIgvYPQRlgCAbk5R0ykLTHdytbUg/pPWOOHJR
        vVPfg65800xRHPmFdTnw8uR5rQ==
X-Google-Smtp-Source: ABdhPJxD3MZHTpebRE4rbKo051Sb/v5SH9SKLKZKOdb2Wf8HjSMD3gvOTO2vPy5Anz0xRSngsZJ5zw==
X-Received: by 2002:a17:90a:6b05:: with SMTP id v5mr13749120pjj.194.1642722690025;
        Thu, 20 Jan 2022 15:51:30 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w10sm3987765pfn.153.2022.01.20.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:51:29 -0800 (PST)
Date:   Thu, 20 Jan 2022 23:51:28 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     "Mr. Chromebox" <mrchromebox@gmail.com>,
        Benson Leung <bleung@google.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: Null pointer dereference in cros-ec-typec
Message-ID: <Yen1gP6XB6bRo7OW@chromium.org>
References: <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
 <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
 <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
 <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
 <CAFTm+6BC--tNjbez_f_A_ckK7gjkbBMWHYSExxQcp9+u60Z2WQ@mail.gmail.com>
 <CACeCKaeAUy8JCO9hv7XjeQA_P_At9SN_Cuw2v=YD01gfwvGXFQ@mail.gmail.com>
 <20220119023752.ad34u6hgjpkpk4dw@eve>
 <CACeCKafA4eDNgEbACjorCHBdrLaG6YviRS+gA=Xr-XD+GVaxZw@mail.gmail.com>
 <CAFTm+6DMuxx_qiPEU4VwweZVvuFhReWTogYMychH1gXnn47xHw@mail.gmail.com>
 <20220119203243.3zh6mcb2fauczn5k@eve>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119203243.3zh6mcb2fauczn5k@eve>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alyssa,

On Jan 19 20:32, Alyssa Ross wrote:
> On Wed, Jan 19, 2022 at 12:44:06PM -0600, Mr. Chromebox wrote:
> > On Wed, Jan 19, 2022 at 12:24 PM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > Thanks Alyssa,
> > >
> > > It looks like the right fix here should go in coreboot.
> > >
> > > I'll wait for a response from Matt regarding whether those EC commands
> > > are supported on the eve EC firmware image Mr.Chromebox releases.
> >
> > looking at Chrome-EC branch firmware-eve-9584.B,
> >
> > EC_CMD_GET_PD_PORT_CAPS is *not* supported
> > EC_CMD_USB_PD_PORTS is supported
> >
> > no difference in this regard between my updated EC firmware and the
> > latest stock EC firmware provided by Google for EVE
> >
> > > I have a fix but I can't test it since :
> > > - I am not sure how the Mr.Chromebox eve BIOS is compiled.
> >
> > same build system as upstream coreboot
> >
> > > - I don't have an eve.
> >
> > me neither :)
> 
> I'd be more than happy to test Coreboot patches on my eve and report
> back on anything that needs to be checked, if that helps?  I've built
> and installed it from source before.

Yes, this would be very helpful! Here is the link:
https://review.coreboot.org/c/coreboot/+/61262

Thanks a lot!

-Prashant

