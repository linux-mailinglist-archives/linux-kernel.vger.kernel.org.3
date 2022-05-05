Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2051CB02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385938AbiEEVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385560AbiEEVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:32:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F950050;
        Thu,  5 May 2022 14:29:08 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edeb6c3642so5509192fac.3;
        Thu, 05 May 2022 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8oe3sfqDkyfNUlcgiBtlkeMr/xCKR9BR/x7tlYGAaAg=;
        b=cHpjKpSXs6kKH2wCI+zunweNKPfOCNIAvDTrpHekpLonqSfQxiUbe2GXfiulSuITgt
         1RfU3k6AdLPHqIN4GdAADkktcMX2Bxba1aPbA/7ThNdj3kq5m2IoXZ/7wURcMGexW2rV
         T7jcUArbOzAgjQJhJPQ7RZ0qvr9QpruL+6vl7A21eL0SE2PDRs4yE+ZJ8je79f9+Z292
         imKsIL1OUvBqfY6XBiUzFDMndPHbo4aGspHMmdgyoh+Yw29iBZcWlTIju4waxNV9JKk8
         YADUp1qbHA/l5s/UqLpSEAKra8v9eGmfvkBEkyJzdsTgQNtWM74KUenL4Qa0is+Kib8c
         51Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8oe3sfqDkyfNUlcgiBtlkeMr/xCKR9BR/x7tlYGAaAg=;
        b=2zAkF6RoEgqgGsGR4mDIe+f7k2xObyGHpJgxxdCkBc9ny0E3odDns8IW/8DkXHUoTL
         iY/atcBbHQK6j+ZXHy2iJZxssj8nZ2qlYJg9wq8+iwdTEir41LGgsRNAimIlbt3K0XJZ
         wOkkQ6GEKirs7+fYBA13NgCnf/NxuAi6Y3HsfPNBKQYTJ0nfFuMB6UGli4nCeyXos3Au
         heQe2RdGSwi8KJljzc7ahZCMjFP+HJu5/3E/NO3+sndPDYmIseERcIjGpeeNzNBTU25I
         TUNjRCozrIvlKUlI5gBB8GHzg5QlVKxMtXWxkywmNZloaSHQ+naYa+6a2YBmeY12W7GU
         WHhg==
X-Gm-Message-State: AOAM532AiIqEFQt3swPy6PbdwGczoFNnbg3gDu+E+8+b1ME0j6hyqoMs
        lTJtnfvsceSiUP/xsH1jWeaaD/9g1lcQeg==
X-Google-Smtp-Source: ABdhPJxGgq1qnFkliFAawJ5WADwR3GbxkWdgTyuWmkSWwp7sBIM74NgVIv9e9rFX7ictyH8ZI1h61w==
X-Received: by 2002:a05:6870:f206:b0:d6:ca78:94f0 with SMTP id t6-20020a056870f20600b000d6ca7894f0mr119445oao.4.1651786147940;
        Thu, 05 May 2022 14:29:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i19-20020a9d1713000000b006062d346083sm1023918ota.22.2022.05.05.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:29:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 May 2022 14:29:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Message-ID: <20220505212905.GC1988522@roeck-us.net>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-3-nick.hawkins@hpe.com>
 <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
 <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <d88523a8-a240-915d-9ae7-54b2277e424a@roeck-us.net>
 <CAK8P3a3t7-ozDHu18vMKEWxfNS4yd_BNHUh7hQ24rfS20tssDg@mail.gmail.com>
 <PH0PR84MB1718D0238BEF9173AF5D5B7688C39@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR84MB1718D0238BEF9173AF5D5B7688C39@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:25:59PM +0000, Hawkins, Nick wrote:
> 
> On Tue, May 3, 2022 at 6:53 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > One bad deed tends to multiply.
> > >
> > > No, I didn't ask to pass a struct resource as platform data.
> > > That would be no different to the current code. Resources can be added 
> > > to a platform device using platform_device_add_resources(), and the 
> > > platform driver can then use platform_get_resource() to use it. This 
> > > would make it independent of a "private" mechanism.
> 
> > Unfortunately there is no resource type for __iomem tokens, only for physical addresses, so you'd end up having to do
> ioremap() of the same address twice to map it into both the timer and the watchdog driver . Not the end of the world of course, but that doesn't seem much better than abusing the device private data.
> 
> Hello Guenter,
> 
> Given Arnd's feedback would you like me to proceed with this change still or do you have another recommendation?
> 

Just leave it as is and add a note explaining why it is done
that way.

Guenter
