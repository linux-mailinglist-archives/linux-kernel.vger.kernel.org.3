Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99347D780
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhLVTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhLVTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:12:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF4FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:12:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bm14so12447729edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyrpWmBDffIXpDpE9r2nAUOucNSJb08zIyrGVuC0WBY=;
        b=PznTpRzt31liGkKFDqT5mT0nuJEUiJ/Oo8nOjFZKW17EpT0QwYGJbnAIr6jy0K4EKN
         +FB72gV+KCeuyb5uPBnN2HPZNRiU2lvHaOS6MYa2Tp8KTXL5GiKe1jgzxXG39JuEpHiX
         RyMnsboN1Vf+kLCWuc8PGnu+onBZk7JQxSoLDaR/oQdDYvfh8cRcKf7WWqxt8hfrQbjX
         EFCrSdeyOZelfJf3960Hv+poAxHJYlp/keKvqmg6iVqHOyU3nVC1tUzNRMI4rFkDg43Y
         iH2o64+CJFtrfytK9Qg2CjUFHYUseGJTFfH9BB3tnsYnxEBKFs4aNJGfJl0I20RaEUnd
         RC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyrpWmBDffIXpDpE9r2nAUOucNSJb08zIyrGVuC0WBY=;
        b=7rz6UDYCorasHhtkBef0lQAUXyYV6VE8MQinU0EBnF0dUeu5Oz2w6+QXGEIxZ9obqe
         5h/tdcBL3Nn5WrgDpqsDm1crehVMU67xd7GbnbbRPI8kDSzXWlwMT7289Bp45EiFN1JV
         XL9jrVXsi7D3SZXwcgcavlnxqguUC/TjBZFlh8Rzn+CDw+EWvdtmYvaS+ZZ80lbzFc2R
         bQCgYONwARt4ILcl05u3ROAWaIvUnVvip20QZCvruurIQaGdAImNr0PZCpPOONDC5h4R
         AuejZssvnPXBpnJ/VPlDQY7d/WD+vX2o9ioViUjsjz7ROjY8KJBDtOKNX/MlUQ8wCdd2
         RQIA==
X-Gm-Message-State: AOAM531pki3Z74C5Eb+1M+9pI+fcNpy9HCcEZFx2JmEw+V4J/ABtLSdu
        szOgk7eTjmn44sIHpJqLbQq/lhj5IpUV9u+aIkcqROUbVr0=
X-Google-Smtp-Source: ABdhPJy0Z8vkD4nq2X1x4bH/ViHnqlldjlghhWOvSUfcDmcIDnYqlu83mm0qGnuNpAhwVryiDFoAaEhTfEXRi0dtJPc=
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr2702711edz.258.1640200357120;
 Wed, 22 Dec 2021 11:12:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
In-Reply-To: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 21:10:38 +0200
Message-ID: <CAHp75VeQcD5Git6sgsrwCkW+AHPxPhvHZD4kuOt6o0PZsjjPdg@mail.gmail.com>
Subject: Re: header circular dependencies
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 9:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> `make headerdep` is full of printk.h circular dependencies, like
>
> include/kvm/arm_vgic.h:18: warning: recursive header inclusion

For the clearness, 18 here is with one of my (not related to printk,h)
patches, but the line in question is inclusion of jump_label.h. In the
original code it's 16.

> In file included from linux/printk.h,
>                 from linux/dynamic_debug.h:188
>                 from linux/printk.h:555 <-- here
>
> I'm wondering if it's a false positive?
> In either case, can we teach the headerdep not to complain by fixing
> the culprit?

-- 
With Best Regards,
Andy Shevchenko
