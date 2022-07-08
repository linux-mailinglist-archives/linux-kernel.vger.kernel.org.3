Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4956BDD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiGHP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiGHP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:59:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE46D55C;
        Fri,  8 Jul 2022 08:59:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n74so8864284yba.3;
        Fri, 08 Jul 2022 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIFsfOSVQfXvBX0XrqyFJCcU4eKxtUIBtIyIMnlR/d0=;
        b=Xl8u1ENIUNBQhTTOE5t4JNqEmRipm9EBBREnAES0k9aa1UbMLxMBTGsusTv203kd9s
         0fZc8DLeOOiBt7Kb5aoI0qsl/VkODJAA9j6bRtMpEooSocNgj5JIhlvNKO24FkkWZtQl
         vUwWG/w+DvDQ0+PE3qWWeclifxolJwG4zkyOZpvlzdYetzKeQttoF5LCsgKSBgCX7DXv
         lWxyG/CWauM7LGsRfW9YTWu/I6sjJOUKSzH4BraS8GwoYzFvdf0eWLE1SI+YJVMvsDiS
         PqtVEzEGfu/Ld0XfvNR+fLXzRmLEREfG7NLoNiu9FGpYqHrqOCwZ4d4G4pfYMGXfpE7C
         W9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIFsfOSVQfXvBX0XrqyFJCcU4eKxtUIBtIyIMnlR/d0=;
        b=OFqeTAOxCcIlp9DJOXrBIAod3vpLpIfshQ4Wvv8YuYwS1bJqRh1aMir+xNNgfuOUMt
         r/lzC8qfV64YqWOeeRno19ONImXOjRkeds8++7eow21KhcYGG4MUuhcq4kfU0msGFHqS
         LbdYSiPA11fhNH4FtfEWnLX1F3ndB7PP1daBTVeZxJEuPDC2LqV4eQ8jLvC2f9Oz9IfQ
         J4PFc8mgGpUvFjADyrFWUYkPHLCG5m7my/DHVO7UYy1mQJAaEhmGtI4XZEvljbXfvUe/
         p5cv34plDz0uB2Y/jy3qY7BRsgdvbHfeuGzcD65db1P5UE/Z+sXcIuwBB+noExrY8+Y0
         6NBA==
X-Gm-Message-State: AJIora/2kYBwo0yx8AbEvWANV2RyBdoxl65QU9H7BD5fgducLgCKZZCl
        L+21l5hiiksezMgOMYV9FOLEQ+RXSDW0ryKgFlM=
X-Google-Smtp-Source: AGRyM1squvqQ9ABX/jhZ3VK0FtqZmCMqquBhgcf3oL7ktfaTXhDh+hRyB1BDUIo5cwHztujLr1s7GVpkXTpoSTEUduk=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr4399948ybg.460.1657295968321; Fri, 08
 Jul 2022 08:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
In-Reply-To: <20220701154604.2211008-1-imran.f.khan@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:58:51 +0200
Message-ID: <CAHp75VdY=UoBnL=vGkq2xPX6OBD2aDgB+t85z=zKpS1ovin4=w@mail.gmail.com>
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Petr Mladek <pmladek@suse.com>
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

On Fri, Jul 1, 2022 at 5:49 PM Imran Khan <imran.f.khan@oracle.com> wrote:

...

> +       if (kn->attr.notify_next.next != NULL) {

Isn't there a helper to get next pointer from an llist pointer?

> +               kernfs_get(kn);
> +               llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> +               schedule_work(&kernfs_notify_work);
> +       }

-- 
With Best Regards,
Andy Shevchenko
