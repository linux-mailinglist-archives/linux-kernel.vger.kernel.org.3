Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B746C69B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhLGVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:23:33 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:38887 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhLGVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:23:29 -0500
Received: by mail-oo1-f42.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so150140ooj.5;
        Tue, 07 Dec 2021 13:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDybkYmRgN7ASFL9lU803KLgt8MDRIp7lKanWAFVy8w=;
        b=vIrkEJqBtQ72BkRPn0vsp3EPkYea6bruoBesaf8cXk53P5nO4zCmSQETK+xjTAoKRb
         zRO2xyRurEyZBCFCe89QU7rOFov1H9NADnUiBvcvg0/j2YwVdMxhe9Av4iPZ98m5fwr+
         kI0SOOB11fK2OK8qcXn51bPmvKpyuTEACk5XD8fyxwWY4TvzX2DBYkFVoTITP+EgK5HM
         9VYomR/Nt7IrfelUikjjcAjG20hqbkXAch0I9C/v3aiUbkjX9qINMG456zc17HbYFoP1
         GhU0c2jxjGpY51HkrRoNNiP5tpGN9XGhPsznoVUBDAR34JAVsIna/pUIVzSrYNZtespk
         DU3w==
X-Gm-Message-State: AOAM532dFr3NnHejE4qLwu4YP9kqU5QzcgoSeOs9QCTRnXW8tKSMJbiV
        K1paGShK6u6ehpcliPobbg==
X-Google-Smtp-Source: ABdhPJzQx6ifBIeo7YNw/4J7ZMf9KeE80PBI87o4MLSSxGDKBHAC15DEydOg8wZjHXu+Y1USi6AwDQ==
X-Received: by 2002:a4a:b00e:: with SMTP id f14mr27855125oon.10.1638911997778;
        Tue, 07 Dec 2021 13:19:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o2sm214597oik.11.2021.12.07.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:19:56 -0800 (PST)
Received: (nullmailer pid 850716 invoked by uid 1000);
        Tue, 07 Dec 2021 21:19:55 -0000
Date:   Tue, 7 Dec 2021 15:19:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v14 0/2] Support pwm driver for aspeed ast26xx
Message-ID: <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
 <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:45:47AM +0000, Joel Stanley wrote:
> Hi Billy,
> 
> On Tue, 30 Nov 2021 at 05:58, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > The legacy driver of aspeed pwm is binding with tach controller and it
> > doesn't follow the pwm framworks usage. In addition, the pwm register
> > usage of the 6th generation of ast26xx has drastic change. So these
> > patch serials add the new aspeed pwm driver to fix up the problem above.
> 
> Sorry for not taking a look earlier. Well done on making it this far.
> 
> There's a few things that need to be addressed before merging this.
> 
> Firstly, the bindings need fixing up. I think these should be the one
> file. The device tree bindings are supposed to describe the hardware,
> and it doesn't make sense to separate them out just because we plan on
> using two subsystems to implement the functionality.
> 
> Rob, please chime in if you would prefer something different.

I prefer to see a common binding for fans which I said multiple times 
on this series. As the same thing keeps getting posted, I've stopped 
looking at this one.

Rob
