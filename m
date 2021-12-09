Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2183F46E704
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhLIKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhLIKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:53:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C03C061746;
        Thu,  9 Dec 2021 02:49:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so18305115edv.1;
        Thu, 09 Dec 2021 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn5yiHEVIcPf8apFH8WOG/o386JPX61QJAV5CIBGr5o=;
        b=SceT5lGxXiYZEVyNTiTvxpynV6odUf/rM3ek99juOQusZAe0MnwqtotI/GjRMXc8WC
         t/K94bZZr9Kf2T1NkpDkI0mq+u9cAGAQ0skR7sY0DWu6JMTDxFaUFRx3YgyRNSiWSB1t
         D0Fg+JS354vAwJjvr5WPxEDduxeOxsA8vgUosDeahAhRmWEvfLywmn4Wonf2ic8RZ865
         0HTBy6meUvnwB4r2ZJHAcaqhvpezaGhk1UGVBFOyPGcERDplhk+2Mllr6DoqYKN79H+1
         yWFi3JLEA9RRXUDwEu3ZmaDsIlToImzSzYtXp+iQ1/W6XZOoIVnaP/PP7SdK8ywoYpxG
         Vzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn5yiHEVIcPf8apFH8WOG/o386JPX61QJAV5CIBGr5o=;
        b=iG0e0WOqOK/44Ga/TGHSYCTlctNeuwTZ6gwDk4JhW/EHaEOe1emHsmkQssgPTYScvm
         AZbmedcP2E+tjxODPDMmKofed/f21JhJDxYT8hYZc9UrP3L4QALbRiDlAs0HbQBAz5oQ
         xax/XxfJdxsVK2uQP5kMhO4CxulDMj8Nrbf0VIqofPACyRBes8R62GpsUFtccbbmmcTP
         BBktRUHQLEyu/jAkYOJdqwsu72Q2kgEuBctMTBVWh+OuWdVQjalOl/X7xyKB/EeqUlLH
         JMBREzB4oXpGCw+umXfJolE6Uw6FOWgw1yyESZ8Ypl8qUDjD8ESyqzV5CPGd6W5Zqxdw
         66Kw==
X-Gm-Message-State: AOAM530URH+2F8xe611q/muhM7Ke5BpNtz/ITONWY/v8mXKcM4X2in1H
        gxBaAEugXd1sqhWNB0ciu9I4vFiQMdUzshoF86Q=
X-Google-Smtp-Source: ABdhPJxlRS6j6rkvUOvm4x+7k8ZlYSH6E7d9IqpkhN2VYrbnf2Ir6tr8DLFWXU0HKJiIwY9yqWcQeXDz5qcn4YRzYaQ=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr14231892ejb.377.1639046979775;
 Thu, 09 Dec 2021 02:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20211124073419.181799-1-marcan@marcan.st> <20211124074625.182815-11-marcan@marcan.st>
 <78ce61a9-b345-437a-df02-49951eb3f31e@canonical.com>
In-Reply-To: <78ce61a9-b345-437a-df02-49951eb3f31e@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Dec 2021 12:48:06 +0200
Message-ID: <CAHp75VetdyXbeQ7hie2Oae6J0qn+fMmz+YN2zYXK+X0vppapEQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] tty: serial: samsung_tty: Support runtime PM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 4:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On 24/11/2021 08:46, Hector Martin wrote:
> > This allows idle UART devices to be suspended using the standard
> > runtime-PM framework. The logic is modeled after stm32-usart.

Guys, have you seen this activity:
https://lore.kernel.org/linux-serial/YbGyNW2EQlA%2F+VIg@atomide.com/T/#t?

The idea eventually is to bring the serial core to do this for us. Can
you test that series and see if it has a use in your case?

-- 
With Best Regards,
Andy Shevchenko
