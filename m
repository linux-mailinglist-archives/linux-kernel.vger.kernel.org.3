Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C64C818B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiCADOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiCADOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:14:24 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDC1ADAD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:13:44 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id j5so6192312vkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jo1MKBOh2f6DEXbk+W9R0wMjJjjsqgmG76Kwwylfkfc=;
        b=OMQ7DK56z9FBSuIWpdua2Rc/UGWxr8PeWRtjqqickcZ25vTIuqSG+JpWY5Aqnc7F8F
         n5TCGBkz8td9NO8ZAiQEjZo4fGZw72v9ZsmCsGrk9F4+NlIN9U69vFaS2k0r9wVjLO6i
         hm0fG61MHxfH8dDTvSH++V/UiRWGGAzGcAORKfPiH2SLdTllzNDQuLbXQRhoEkpYH/K0
         Dri42CKJMlK91E2bl48PMBkKKZDvB4LJ8UvRt9bba+uF2yJ0KE+9prg2EgiyBy77SBwQ
         hJIiE9oVUzuedcYNeDmUrjlBVI4q7Xq1avs60ul62NZxj/X7WAlzdyqDiTeDYmqDEmGp
         MWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jo1MKBOh2f6DEXbk+W9R0wMjJjjsqgmG76Kwwylfkfc=;
        b=OWFpn+tq5LXE+84hTC6xVPvzkZBFI6vszVgKix9rZ7CoHnJ1UNU5bjcPgCVIQf4Sxw
         gYREi0Xj29ziQFsH5uK+NU2Mq0RNjRaEZ2ngpBgT4ASRRl1NN5uz3xAlKfpOFZIFqfIU
         7TCF+o2tm9NgOAbD+3ZekugAMoPohdrakO+esjF+JDAk2P3cG9UdqyHNIwwJ349G8VD3
         j+pGnNN3LQJ0RD8Hh+KcqUpvpxFtQpW6hbTDDYDhbBb+d4Lh7KFprt5GXdxNd1dBTczz
         KFScRlXa1nDdhWL0c6614E6FBkg5Hvh0a3tPOrbvOdSpFOq9UT0Q2VITqRFePlB1AK+h
         nawA==
X-Gm-Message-State: AOAM533IeLsWkUBMOy9rywuMYRkW0DKEORAQvu8r9n7u5LZ96im8Clx6
        UDNbkmHNjBrCCxS/7Yol5JtMCNdtpUx95th1vHU=
X-Google-Smtp-Source: ABdhPJzt8bIozp4IhzhyuVespABxw5MtB60E5/0SAjHQ0y7ZwH9ABBheSEzxpN9jRIBTyLojrsBuLbzpWoWgNHhZUTk=
X-Received: by 2002:a05:6122:78b:b0:320:eb11:995c with SMTP id
 k11-20020a056122078b00b00320eb11995cmr8995775vkr.27.1646104424061; Mon, 28
 Feb 2022 19:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20220218163303.33344-1-jrdr.linux@gmail.com>
In-Reply-To: <20220218163303.33344-1-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 1 Mar 2022 08:43:32 +0530
Message-ID: <CAFqt6zb4v9T0VP+PUB1bbK+xmr3qi0JyOXeO7VyF3wBko-eM_A@mail.gmail.com>
Subject: Re: [PATCH] irqchip: nvic: release nvic_base upon failure
To:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:03 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> smatch warning was reported as below ->
>
> smatch warnings:
> drivers/irqchip/irq-nvic.c:131 nvic_of_init()
> warn: 'nvic_base' not released on lines: 97.
>
> Release nvic_base upon failure.

Any comments on this patch ?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  drivers/irqchip/irq-nvic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 125f9c1cf0c3..ba6332b00a0a 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -94,6 +94,7 @@ static int __init nvic_of_init(struct device_node *node,
>
>         if (!nvic_irq_domain) {
>                 pr_warn("Failed to allocate irq domain\n");
> +               iounmap(nvic_base);
>                 return -ENOMEM;
>         }
>
> @@ -103,6 +104,7 @@ static int __init nvic_of_init(struct device_node *node,
>         if (ret) {
>                 pr_warn("Failed to allocate irq chips\n");
>                 irq_domain_remove(nvic_irq_domain);
> +               iounmap(nvic_base);
>                 return ret;
>         }
>
> --
> 2.25.1
>
