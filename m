Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F78592608
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiHNSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:47:06 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F9FD3;
        Sun, 14 Aug 2022 11:47:04 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l8so4139425qvr.5;
        Sun, 14 Aug 2022 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dudlmWjuSuvNbi9ZYyo/rAhbjJyLDMtzGN5G53OzaMo=;
        b=ZcNgkuU+zWbAKcAGArBWE8maGMxvPQ7VlP0YNqDbjIPV8BeVbWwnoua6cHVFuLyH4l
         Y+eaEC5T+XPw1vLxXzcQsWDey3KX78uyEbjfuqi4pwC+42YiT39WsUA628D79tfh6K8d
         4DY725D0GLL5UQ+8tL59nOSTxuD88uzXAM37WpK1T7DkyyJN4R0TRPKJW10UE5YXaqS6
         qUDPl03aM301291lSSXaacqjwyNXXJDtlXWf0TNGiKDbQiFzQ0K9B20MCltUdnOy1i+Y
         z0mGQlMIyw7XXHzaEHp31ukbzY5PON8ezIqMqYl5d4JQW2i4XMjGkbiQjLyDVBSeOjLN
         6u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dudlmWjuSuvNbi9ZYyo/rAhbjJyLDMtzGN5G53OzaMo=;
        b=3kaq1f6Xw6m8ZIKrT+earLk7Ycnznm/dQZcB6BJkq/EN5FXs5154Kf5HxrQJu5TRPP
         sCCCfOj37+LR2uJLFR0U4mKqPGqnHC6n0CcmNu2jTL3NMZYRZKNxDUoySfvN7LRI5zJG
         qNLQl2ER/DAxfjK75/n7OhJgC0rJxQ5chExksyvHBrLwQPbbgXEnoVqTJqckrowD1OUc
         JLkbRysiNC4Sn44N1qfULiw/HuCn33cvPxtuuD7JN6xYkGwyVml3d96bk390eFADYCXR
         dztk3ywYUo4QW4TVdKSxCU0tyN+REPxuW/dfK4+7MWKdMH5MrN5pfkWHQV6KaLCfZDlB
         PszQ==
X-Gm-Message-State: ACgBeo2seqi0ZQqcIgZ+ATclJ0faLoMs8AxJirqpWWZOdH9T37XLv1Z6
        18AGK7U4eE1VE5SVfMIJhbBHY7RSIhwixq1qsws=
X-Google-Smtp-Source: AA6agR4oQuZQwsVyjXb+7L9CQIbO7cRvAMkkYymfXxeLEfz+ouuOzmVVtEFPSsbedtPUWQLE/CKEUbV8wlJCDhKD/P0=
X-Received: by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr10935326qvb.97.1660502823159; Sun, 14
 Aug 2022 11:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
In-Reply-To: <20220814080416.7531-1-khalid.masum.92@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 21:46:26 +0300
Message-ID: <CAHp75Ve4UaLsUknGKm14_-f5=qsq1s_Ws+j6h0kAY5_XMkSmQw@mail.gmail.com>
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Sun, Aug 14, 2022 at 11:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>
> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
> populated with properties from FW node props. Make this happen by
> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use
> the flag to store the multi_link value from intel_link_startup. Use
> this flag to initialize bus->multi_link.

...

>         /*
>          * Initialize multi_link flag
> -        * TODO: populate this flag by reading property from FW node
>          */
> -       bus->multi_link = false;
> +       bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
> +               == FWNODE_FLAG_MULTI_LINKED;

NAK (as far as I understood the context of the comment and the change itself).

These flags are for devlink, we do not mix FW properties with those
internal flags anyhow. The comment suggests that this should be a
property. Also commit message doesn't explain the relation to devlink.

-- 
With Best Regards,
Andy Shevchenko
