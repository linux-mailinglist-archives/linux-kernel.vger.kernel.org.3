Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3350FC95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbiDZMQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiDZMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:16:10 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF42D1E0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:13:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r28so589889iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iw7K6nCCY2OADjsb8Nofj7+6LEhdgiYrXDfUt6aiWUE=;
        b=5bqtWofE8Fxma9Ypg91zSPBNQNy+vC5YGVVQuozyXp9qeTRC1s5bKL+Byv5qKSZkiU
         3Vr3IBHogrezQlqmM623G7+B7+r2kr0QxOfCtnvhD3RFOku88kH4ZoZ5hGQncwrGm6bS
         QJApdPcRHPYoD/+/Z3nMNIZoBMaVmMR88+n01HuZePHPTGZTqUWSmsPwcmj84AFxoT7A
         4fIxPFW6QQmOLi25Fbb/3v4+A/P6I7hTAch6lbjl4+PXEx/TvgePsVYUHO6lx/do6v0/
         kXzwzT2rW+tCcAq4cfFwuc7cB7WilRUqy5g9AcKozqH2nhoGLr/TwWBr3as8k6PNmIOX
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iw7K6nCCY2OADjsb8Nofj7+6LEhdgiYrXDfUt6aiWUE=;
        b=LiqNrh14O2uiw5MXdmsW2QJPAR34N8D3dFRcmK4t85KVmAxpk9i/NB6el/w4vZsfHX
         u6sDGn1jTMdjdE7/a8xZNKwMJ6yXIa2DDiqDcueSY7PDMb36hoM7h3OrvYFefByH4xkg
         iF9ZRf0+fDiCfmyOyhhtcDR/CkjoGJa3Hdb65cYdF7YupZpqnp7/gOrhIM0ExNvcUGli
         k59yJ9w0GqHdbZvAX73yQgVUmkHWlcdVy29tmbpFyUyyvojLGRbKi1GPUYGWIfq5VzXT
         2aFKEZDuITvgj3ej5qgYOdDkBSgI7ma7e4gEPssJYFOhIxYv/ieIObeNX0xzeTPa5PQE
         Bgag==
X-Gm-Message-State: AOAM531gdOCIZ1Bn1bV2uqQLDdIkaYwSme00DRvtgkLbpCom8DnFIqgm
        V2KlvbDiS5U9iu7jbGoVbuDmgSZDpdR+Lvh7Ro0IungO2i4=
X-Google-Smtp-Source: ABdhPJwA4CEFR4iluxwi0koj9QkC2gNSwcjVobubRZereaoHVRvWtye2XVmU73oenYqtgSaOf64574wdjmrfaC2MvCY=
X-Received: by 2002:a05:6e02:1d09:b0:2cc:4f8c:273e with SMTP id
 i9-20020a056e021d0900b002cc4f8c273emr8773095ila.129.1650975181787; Tue, 26
 Apr 2022 05:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422180305.301882-1-maxime.chevallier@bootlin.com> <YmMQMoMcO8uU2dKN@lunn.ch>
In-Reply-To: <YmMQMoMcO8uU2dKN@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 26 Apr 2022 14:12:51 +0200
Message-ID: <CA+HBbNEKN7xKKg8wHagC-2nZ9mCRV=U4gMW4hiQO3gV9MgEoVA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] net: ipqess: introduce Qualcomm IPQESS driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:29 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Apr 22, 2022 at 08:03:00PM +0200, Maxime Chevallier wrote:
> > Hello everyone,
> >
> > This series introduces a new driver, for the Qualcomm IPQESS Ethernet
> > Controller, found on the IPQ4019.
> >
> > The driver itself is pretty straightforward, but has lived out-of-tree
> > for a while. I've done my best to clean-up some outdated API calls, but
> > some might remain.
> >
> > This controller is somewhat special, since it's part of the IPQ4019 SoC
> > which also includes an QCA8K switch, and uses the IPQESS controller for
> > the CPU port.
>
> Does it exist in a form where it is not connected to a switch?

Hi Andrew, both the ethernet controller and the QCA8337N based switch are
part of the SoC silicon and are always present.
The ethernet controller is always connected to the switch port 0.

Regards,
Robert
>
> As Florian has suggested, if we assume frames are always going
> to/coming from a switch, we can play around with the frame format a
> little. A dummy tag could be added to the head or tail of the frame,
> which the MAC driver then uses. That gives us a more normal structure.
>
>       Andrew



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
