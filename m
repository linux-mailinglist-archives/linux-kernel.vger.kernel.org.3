Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2731F49FB83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiA1OUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348069AbiA1OUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:20:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45DC061714;
        Fri, 28 Jan 2022 06:20:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p7so10094718edc.12;
        Fri, 28 Jan 2022 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+J7Y28MxCnMYBbIsUpYD7C4RITvnrtVaqSAjjPutwc4=;
        b=OyXxgsA7XeWtgJF/nhNOdz3kkv/fl7EiCMyq4HQ6tmuDq7Usg1rm+BdxRDMd5xdVgP
         g8dQBdqTXYn4aErOt7DdbLDPykWd8DJJLNbqWXb+KFn7d2fubrYszQ9CNZEkstHZXO/h
         0WrUllYs2RfE0N7BAZNBjJvV7Do2/mdS2SrW9zdyYuXFVeyebyENflf8MRYl6cPTpIOW
         d8xdI3F306FDiQ415DKKoYbK7tPRxZg4tGMa06o9UeiLjF6ll88D6WrICEgNwcFSjt7C
         6aA+RpXtx4zBkAkJ5zLhP30npkqCLD2DZloM6Vmoj4ijIhRRUawNnDCtVG+Pafln3b1Y
         Z/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+J7Y28MxCnMYBbIsUpYD7C4RITvnrtVaqSAjjPutwc4=;
        b=6bedi2WV8mSgMPtXoMX/bVDphFj2rOBT58pPvXD5njPmqejwcmOlGQ9RfdlTSy6Ibu
         8gxJPKKmM0jC2lk8RH75XGqycdYvrzI0MZwlW8mWW9TM4/hvpIGZMWXp/Jvu0B2Fy0iG
         qy+1XW/cZ45ZJK8TdrtII6HyHgJpJ8Ub+iDMrCmGNdKsSBODBZVXLgpBdkZeX1IvzXgc
         p4Xm5GrbMDkF9vs7ur0y7i118jDFiG5ELVlE7px4UmIE5DEEp94tiJH5w+IFPXOLtPsO
         1sd1bd83A5Vt/Qv5WFcLxcWFoUfhR4ikERsBM1YnZNbmuhwN0x248KuHLbPSBVi5ADj8
         upbQ==
X-Gm-Message-State: AOAM533GnaNlbpWm17OjFy5Bmh0V9lmGJkRkcE+EmE1pGKKwjMpIrNkk
        8fuDLsN23NGDxebseDjTfvPGZdDkzZRSvQO0KpbbGEuXR6vBXA==
X-Google-Smtp-Source: ABdhPJxblons+zl0iKzVvNBCyWrNzlRY/6qPcM6d5TbNTj6qyvel4wqyOJ/Nq/Wtxh4kAvN5OohBS46Y2CU58jXaihg=
X-Received: by 2002:a05:6402:350d:: with SMTP id b13mr8392678edd.125.1643379649912;
 Fri, 28 Jan 2022 06:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20220125161245.418882-1-horatiu.vultur@microchip.com> <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
In-Reply-To: <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jan 2022 16:19:12 +0200
Message-ID: <CAHp75Vc71mnKST5aFGEivoU8ZhmmRf-ArNYVMb5Cf52jE8jetQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 3:19 AM Colin Foster
<colin.foster@in-advantage.com> wrote:
> On Tue, Jan 25, 2022 at 05:12:45PM +0100, Horatiu Vultur wrote:

> The only difference is I
> had copied reg_stride into sgpio_priv instead of making regmap_config
> file-scope.

I'm wondering if we may access config via a pointer to regmap.

-- 
With Best Regards,
Andy Shevchenko
