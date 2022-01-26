Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68CD49C05E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiAZA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiAZA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:58:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:58:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v123so26577098wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1ajyeCYIjo/oOGZ58msEWT7W8A+h5mfhGo1MjpnYCc=;
        b=tEQdphlxe+odqnIzx6L/54adIDb7Y88J3cFAPyU4CBb6Mn2JbQLTRU8X2AZphdzgXa
         O3WRyH5vc9hXD26sW4ciwRuy4LGKg+od+MHkWbNnR/ArxQiz9pNX4+/448mPIOtP4cpN
         Y/xHpuuQ9jSgkIoV79kUb2oIoXRn+IaZIXYiCFY40CRt+bhQYl1Cwqwc34B2tHOhuPsH
         /PDzikeC4QLWmD1kIb612oOppfKhGz0a5qvBKsaitoJxyiK4bqAkr7suPUc2f/6MDJJh
         BKLtzcSEIUUouJ+CvXOa7Frymd5xD0/yNUx0Ut4qWzkm4sYwqGOwnoUNiqrYvx77EhoT
         XbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1ajyeCYIjo/oOGZ58msEWT7W8A+h5mfhGo1MjpnYCc=;
        b=8FwfQqnkVAwP1Hes1UNSqkZgULsVl5LyJpsZga33wXGRI7Ny7sunu5JSVOxI4tCVWQ
         CqN3hZ+gsY8LUgMaAuQx0qzjWMbEeQK4edh52NLQBjAJFCLVtAAbOhyrjQzzujQ5w/BV
         ezcm5pdx0GUrDFJJB/Gqc0eu2Mu1iTsdKLxFlnh5jMIlGPE/UPDyaVafRRhoqnm0WTw/
         x8ly9qh0kJYqr96EsRiKmGYNlB0gCaaC+yAw6nfxbLs1hRoJzxuuTKFVjIROalvgJ92/
         ETSChvDPUKf5/Jl7Ze7qRvxP0xnt95aGBBS101OBEAWSrXtz7maI50l6rTICZ+cbdN8w
         FCRA==
X-Gm-Message-State: AOAM532rw/dSfQrHd4N7rr7ZadprwlGkgERaluyBGpFT7YmA3AiM5VE0
        ysHdVisf5YsO7GfEDmvp0a5aumZwtTHSxA==
X-Google-Smtp-Source: ABdhPJyM8U8iNqmQorj9ATdc/xVqC/YmwCvm7jdqJHdvBtXdXBQEFydhD/ABDzpLONM88tAmhdTabA==
X-Received: by 2002:a05:600c:1f15:: with SMTP id bd21mr5001978wmb.145.1643158697122;
        Tue, 25 Jan 2022 16:58:17 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k12sm17847963wrd.98.2022.01.25.16.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:58:14 -0800 (PST)
Date:   Wed, 26 Jan 2022 00:58:12 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from os_dep dir
Message-ID: <YfCcpHJlER2tLQ1o@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-6-phil@philpotter.co.uk>
 <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ddc4d7-e19f-7c9d-a4b7-4eb555830ea1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:48:32PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/25/22 01:44, Phillip Potter wrote:
> > Remove all DBG_88E calls from the os_dep directory, other than those in
> > os_dep/ioctl_linux.c, as this contains almost 200 on its own so will be
> > done in a separate patch for ease of review. These calls do not conform
> > to kernel coding standards and are superfluous. Also restructure where
> > appropriate to remove no longer needed code left behind by removal of
> > these calls. This will allow the eventual removal of the DBG_88E macro
> > itself.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> 
> [code snip]
> 
> > -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> > -	 * suspend influence */
> > -	if (usb_autopm_get_interface(pusb_intf) < 0)
> > -			DBG_88E("can't get autopm:\n");
> > -
> 
> Didn't you make a function change here? I didn't test and also didn't find
> any mentions of tests in cover letter.
> 
> I am asking just to be sure you done it not by accident :)
> 
> 
> 
> 
> 
> With regards,
> Pavel Skripkin

Hi Pavel,

Thank you for this and your other feedback, really appreciate it :-) So
I mistakenly took this out, you're quite right - will fix in next
series.

Regards,
Phil
