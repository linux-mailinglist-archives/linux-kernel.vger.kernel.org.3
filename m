Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A94D2327
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbiCHVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350391AbiCHVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:18:43 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A39764E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:17:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z11so203411lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMUI5wNHfK4o2rZYGcQ4S/vaXJq6Pohkek5MekQIM+Y=;
        b=CzfnizVS8xJF0XYcNlZGRC4X3t9oWbY6F50AYJw7V5IHulZd2tgVTPNS397S7hu1kT
         cWEbdXKwxA4eZPfzwlCDFga8/zVZabdhLbDRI0n4vQ8zL7Wpsypxof7EhRLkeSntSi56
         tjjvGMwL7IJs80Bbf+IaYbCzbkp80A4enfr0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMUI5wNHfK4o2rZYGcQ4S/vaXJq6Pohkek5MekQIM+Y=;
        b=l5i12wr4tNTZGEzDDWaRQJKtlZKOFeUwG+gowXQmIWDUD9WXYnH/RAm9qIlniRUn0m
         YyRzzSlxNHiPKlWRb62XO8tu860vfOQOOy0C/tWXg9gap5lIeMAj5JIiDQXA7zPSPg44
         pt1Xdu8LpR7N6F0WxC30WX8FwULXKmtNkl7/KchhRSLKY84fBdtA2sdjtp4sPNjppnZ9
         BAj8TLzFowA7r11+QyaaKhXx4Kjn4fGyvEpE3JF7jZnOqRvBAkPYjcwBp37W+00a7ogg
         X9wP1OekSyUv5PduAzf4qki5bIj5/23g6XDqwPthyySaiAKB1oTEWgCpNypTTyBLC6s1
         5XCA==
X-Gm-Message-State: AOAM532H3XxaTChdCywjFYKZr4LCLp0FQ/+gHCZJIsEnkB6iY4zvu8KK
        OCJlT//f+5lmZ79flJpljRAbMS8ofyBLKR3P5IA=
X-Google-Smtp-Source: ABdhPJz/0Ekh63b9ekllVXH0kw/3WwRv29J5FYPzg8qmBgYsCw2lN3kISe6IQDZKAHE0jQYnADwvag==
X-Received: by 2002:a05:6512:10cd:b0:448:224f:ee55 with SMTP id k13-20020a05651210cd00b00448224fee55mr11853974lfg.87.1646774264548;
        Tue, 08 Mar 2022 13:17:44 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a8-20020a195f48000000b004482914411asm1976720lfj.2.2022.03.08.13.17.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:17:44 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id v28so365419ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:17:44 -0800 (PST)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr324137ljc.506.1646774263805; Tue, 08
 Mar 2022 13:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
In-Reply-To: <20220308171818.384491-1-jakobkoschel@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 13:17:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9FBXiHY1_6jWULY-Pxe6aMAj6EdHc1YkP43DSMWwq+w@mail.gmail.com>
Message-ID: <CAHk-=wj9FBXiHY1_6jWULY-Pxe6aMAj6EdHc1YkP43DSMWwq+w@mail.gmail.com>
Subject: Re: [PATCH v2 00/26] usb: gadget: remove usage of list iterator past
 the loop
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:19 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> This patch set removes any use of the list iterator variable past
> the list body [..]

This looks good to me.  It also looks like now all of those cna
trivially be written as that "list_traverse()" thing, but that can be
done separately.

             Linus
