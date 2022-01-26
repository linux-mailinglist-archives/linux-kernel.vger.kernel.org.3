Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8349D25E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiAZTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiAZTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:11:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D376C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:11:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so5249571pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g6MK/TK9V/JsMbg6KA7Vzzf+vJx0UYLxOdyiVInOIu4=;
        b=PeG5RBqWvbBw2kchCn8oJAvldZRvSWRqZnC5dB2eq9VsnnGRH1pNI3XxFY2z9WaZNl
         EkUFqCXuEOvMFwIz5I9UmReFRI7rNAanKhVvWsithEswW8ykd1ZWlh3uPkhKC05LmolH
         Qtwz5OXU8q0BKiaEWs/Cz/H4Ycpa86rOBklLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6MK/TK9V/JsMbg6KA7Vzzf+vJx0UYLxOdyiVInOIu4=;
        b=Ivk2X7tmShQQA1Xv+swKAMNPN+dC2epYWcVMWT+gcDROK2w/LbJ31zUVJ0WOE3KMqd
         kkK4MqtNKAiPLkKM2XQ27U0BvFo3IQ6tmSCkz7CuMsBdUf5TEDsUdtY1H7TmBHvnlL81
         GPC1jwQtpUhvQq7vs96gPBJyJKKC4GGSzNpzHoTo40m0iJjRnI9LpiGJfgFr8p/ya9dW
         s8jLb0CAVijDSovy6mD9lamlTl5KRZD1vJ3ico1SRq8oiXaed8lxwqYm2qJkp5zCZOFS
         NikP7wnJstZV9EcxS8ihhlYC0G9h/6yJYnOQasOINis+Rvox76qe3GG6nPL8a8P1JAoO
         /+aw==
X-Gm-Message-State: AOAM533ITBcoxbZ3kNhPTmzrhbPQrQre2W12W+5INdQQmniORtdRFL2W
        WmdUMVDYET3TKZrjWsDk+ak4Fw==
X-Google-Smtp-Source: ABdhPJxZTidgdyVUPylsT3nAMV/NyqldqZzImpWbx0MEYsIs8Yea4EX35ZGWJmKRc1zggq03kP34ww==
X-Received: by 2002:a17:90a:c901:: with SMTP id v1mr10067555pjt.203.1643224313056;
        Wed, 26 Jan 2022 11:11:53 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 10sm2791338pfm.56.2022.01.26.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:11:52 -0800 (PST)
Date:   Wed, 26 Jan 2022 19:11:51 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     "Mr. Chromebox" <mrchromebox@gmail.com>,
        Benson Leung <bleung@google.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: Null pointer dereference in cros-ec-typec
Message-ID: <YfGc97nQfRQT+EOL@chromium.org>
References: <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
 <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
 <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
 <CAFTm+6BC--tNjbez_f_A_ckK7gjkbBMWHYSExxQcp9+u60Z2WQ@mail.gmail.com>
 <CACeCKaeAUy8JCO9hv7XjeQA_P_At9SN_Cuw2v=YD01gfwvGXFQ@mail.gmail.com>
 <20220119023752.ad34u6hgjpkpk4dw@eve>
 <CACeCKafA4eDNgEbACjorCHBdrLaG6YviRS+gA=Xr-XD+GVaxZw@mail.gmail.com>
 <CAFTm+6DMuxx_qiPEU4VwweZVvuFhReWTogYMychH1gXnn47xHw@mail.gmail.com>
 <20220119203243.3zh6mcb2fauczn5k@eve>
 <Yen1gP6XB6bRo7OW@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yen1gP6XB6bRo7OW@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Jan 20 23:51, Prashant Malani wrote:
> Hey Alyssa,
> 
> On Jan 19 20:32, Alyssa Ross wrote:
> > On Wed, Jan 19, 2022 at 12:44:06PM -0600, Mr. Chromebox wrote:
> > > On Wed, Jan 19, 2022 at 12:24 PM Prashant Malani <pmalani@chromium.org> wrote:
> > > >
> > > > Thanks Alyssa,
> > > >
> > > > It looks like the right fix here should go in coreboot.
> > > >
> > > > I'll wait for a response from Matt regarding whether those EC commands
> > > > are supported on the eve EC firmware image Mr.Chromebox releases.
> > >
> > > looking at Chrome-EC branch firmware-eve-9584.B,
> > >
> > > EC_CMD_GET_PD_PORT_CAPS is *not* supported
> > > EC_CMD_USB_PD_PORTS is supported
> > >
> > > no difference in this regard between my updated EC firmware and the
> > > latest stock EC firmware provided by Google for EVE
> > >
> > > > I have a fix but I can't test it since :
> > > > - I am not sure how the Mr.Chromebox eve BIOS is compiled.
> > >
> > > same build system as upstream coreboot
> > >
> > > > - I don't have an eve.
> > >
> > > me neither :)
> > 
> > I'd be more than happy to test Coreboot patches on my eve and report
> > back on anything that needs to be checked, if that helps?  I've built
> > and installed it from source before.
> 
> Yes, this would be very helpful! Here is the link:
> https://review.coreboot.org/c/coreboot/+/61262

To close the loop here, the above patch has been submitted successfully.

Additionally, I've also pushed another patch to the kernel driver [1]
which checks for the null pointer (for folks using older firmware).

Thanks all,

-Prashant

[1] https://lore.kernel.org/lkml/20220126190219.3095419-1-pmalani@chromium.org/
