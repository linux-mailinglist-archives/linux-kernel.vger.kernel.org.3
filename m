Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC0489F50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiAJShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiAJShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:37:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A98C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:37:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o3so3105599pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Hi2/dKdcHfxH+8UYhQGi74UdVYmwtbyuozeSOFYe8k=;
        b=eP02gSclZ1iYq1kngZ7xfpvBpR45ZJMJYZNDjFtQuAaVQF+ZrRLna3dGd5/A4W4thj
         h8U6HaB5bbd2X4ZE2FC7eTdoB7rDx0PRK34Ecx0UlapOgUqqO6easYYWSm7+YarJ4TIk
         Lfk7+fheoscE+XtPHoqAkhAS9hBit5DrtbGSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Hi2/dKdcHfxH+8UYhQGi74UdVYmwtbyuozeSOFYe8k=;
        b=7FFX+b5trUnEpw4OML+SLf9DqTzPyCXL8yR2j01/BqXbV9zZyFeW7nvSHePcgR1oeU
         eDbosKFVZ6+i/LHYFOlF/7dMXK91bbUpOmH3wwfjCtJ+Gn634P6CPKrPCcgZBzUbZFr+
         GiovubQV8njXC5d9HgPawELa/1Q4721pMwY5yICtg34noTGdrqr3k4ldCj0B/0ObxsL0
         +lwnw6rTr0patB3xyYcvOxPiypZLmmR4/UWwoHn1Ec+Z2L4mH7COvrhoiJEmuK59yj5r
         1VDTiG56ulQ7/PciYPN8q3gvWuVohTw5p4Nz70QEqXm1ESCbrtLKsZhe8l24ps0T7c7U
         wBXQ==
X-Gm-Message-State: AOAM530MIxUe4vbgIpKrUA3BPPYdfU61kLdSST00oG4qC6wVqrrVwELw
        KeMzD+FlizsqpGjV1OsxfmNVgA==
X-Google-Smtp-Source: ABdhPJzKY0SUXiFixCfF+14pPi1rIt14NgPX7LKLQbIjGeN+1a1GAVzoI5mx06ugJAXJTxxs+26HUQ==
X-Received: by 2002:a17:902:d903:b0:14a:44a0:a6be with SMTP id c3-20020a170902d90300b0014a44a0a6bemr939625plz.12.1641839841169;
        Mon, 10 Jan 2022 10:37:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:470e:3451:3aa4:4b43])
        by smtp.gmail.com with UTF8SMTPSA id f7sm1368070pfc.206.2022.01.10.10.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:37:20 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:37:18 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 2/2] rpmsg: char: Fix race between the release of
 rpmsg_eptdev and cdev
Message-ID: <Ydx83gmXczpItp81@google.com>
References: <20220110091228.v5.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <20220110091228.v5.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
 <Ydx4tAHSfVyz2yAX@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ydx4tAHSfVyz2yAX@ripper>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:19:32AM -0800, Bjorn Andersson wrote:
> On Mon 10 Jan 09:12 PST 2022, Matthias Kaehlcke wrote:
> 
> > struct rpmsg_eptdev contains a struct cdev. The current code frees
> > the rpmsg_eptdev struct in rpmsg_eptdev_destroy(), but the cdev is
> > a managed object, therefore its release is not predictable and the
> > rpmsg_eptdev could be freed before the cdev is entirely released.
> > 
> > The cdev_device_add/del() API was created to address this issue
> > (see commit 233ed09d7fda), use it instead of cdev add/del().
> > 
> > Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v5:
> > - patch added to the series
> > 
> >  drivers/rpmsg/rpmsg_char.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > index ba85f5d11960..5bc1e6017587 100644
> > --- a/drivers/rpmsg/rpmsg_char.c
> > +++ b/drivers/rpmsg/rpmsg_char.c
> 
> There's a cdev_del() in rpmsg_eptdev_release_device() that I think needs
> to go as well, in line with patch 1.

Good catch, thanks, will fix.
