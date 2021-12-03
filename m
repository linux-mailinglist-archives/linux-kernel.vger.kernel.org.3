Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF779467C59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbhLCRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:21:12 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37853 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353365AbhLCRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:21:11 -0500
Received: by mail-oi1-f176.google.com with SMTP id bj13so7086268oib.4;
        Fri, 03 Dec 2021 09:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0FJhx/6HQsKAFHJBn8ATZSp/5WRG30SWNsqu0eljKeg=;
        b=4i07yDVpOrHahree2VK6LS1M+mldpdWyMHkWyxOm0XnJ8YGfmeHDHevmtj5v3qTDpn
         paGsybDV3UQQbGbZFFb1ml5Fcqv1CLKlYOTVwDTWLc8AZFmgEeuZDCiS0Ttzu4fT5qMy
         qlRysFJ4gq7+iZMuurCKG2lwZwK+ZZtRDazQHazdQG5dirVF+MUXr7OuMgrYS/DQAHZF
         kJIJdtBMYH+HsKMH5XSY9aotCl2FszZscpVOy6FbAhkBpIoTQhkA1rsGUkh4ewtoH55Y
         y/0H6+4DbLKXV8BhT/JQbKVruv7ButymdTkrjE4HapNQTqlQL/Ij7eXLQJo0+tAqAAzM
         pd6w==
X-Gm-Message-State: AOAM531XWIk/EDVC3CfUVIdh4O8HcgwxipX0WB241jwa1tVrPkb+xG9n
        XRWxr+r4Ad4jb/Ca8UdJ2g==
X-Google-Smtp-Source: ABdhPJyTvKVlcRv16983B8bsN/LkpwGXk6vJYQ7QVsAHgYa6MvlsAEk/wKd5VPPlr3WfHV6hnDrdyA==
X-Received: by 2002:a05:6808:170e:: with SMTP id bc14mr11032236oib.86.1638551866873;
        Fri, 03 Dec 2021 09:17:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m2sm747239oop.12.2021.12.03.09.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 09:17:46 -0800 (PST)
Received: (nullmailer pid 231874 invoked by uid 1000);
        Fri, 03 Dec 2021 17:17:45 -0000
Date:   Fri, 3 Dec 2021 11:17:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Biwen Li <biwen.li@nxp.com>, devicetree@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sander Vanheule <sander@svanheule.net>,
        John Crispin <john@phrozen.org>, kernel-team@android.com
Subject: Re: [PATCH v2] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
Message-ID: <YapROd/1lE/Yb0DQ@robh.at.kernel.org>
References: <20211201114102.13446-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201114102.13446-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2021 11:41:02 +0000, Marc Zyngier wrote:
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), a handful of interrupt controllers have
> stopped working correctly. This is due to the DT exposing a non-sensical
> interrupt-map property, and their drivers relying on the kernel ignoring
> this property.
> 
> Since we cannot realistically fix this terrible behaviour, add a quirk
> for the limited set of devices that have implemented this monster,
> and document that this is a pretty bad practice.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Biwen Li <biwen.li@nxp.com>
> Cc: Chris Brandt <chris.brandt@renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
> 
> Notes:
>     v2: Switched over to of_device_compatible_match() as per Rob's
>         request.
> 
>  drivers/of/irq.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 

Applied, thanks!
