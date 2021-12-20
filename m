Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979A47B1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhLTRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhLTRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:06:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A71C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:06:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y13so40938561edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNJk3lOpWjrYYh9iRTIYtpzxxTCPSpTRjFQJd37Bmb8=;
        b=QeEaSqF6wRnXkEGw3/kNOX8uYe5WgpxXHKatDNhlsUwWKeNpCaCJbjgsB18Qq+H+fE
         5Oy90M3wURDDDMZbeYqziPFrK1tP53UX+Eg/nqWayLa7E/Vdig6MORGgQs1JX3NTdEHu
         KKxATxWLNpbF4a1HIyM1Tt7tMkraIjNUlNNlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNJk3lOpWjrYYh9iRTIYtpzxxTCPSpTRjFQJd37Bmb8=;
        b=7bqVP//GqndXoz5nJdFszcMVXo4Mtox/vlE0neb2/HLEjdU3x6HrVa1e4q7TbJWF3v
         bybIXGM6fM9KWnQCBRT5G1Tx+97djmDHXVRklfcWeGLd3XVtcMxI6NqRE5yHii0Zjmld
         WNBo/worglre9EfsweuOYbT+1pxMG3yckhPgwrDd5y0NpUb+YI0Luc136hn/kfOs4UNu
         ZzeCF2OKxsUJk7IyXu+/apv3SEBEf8A1XVyCl8kEYEybuVitr58Bjy8VPoMrQrpPMLc+
         dSahl8iDK1/yCTfIwN/8YdbDMW0EWj4dQ4ZsqPBSWyXsuP10IUk5dvQ7qyjNWbqdnUVC
         nQog==
X-Gm-Message-State: AOAM533sefz86OC5TL25Wl+M4qq+DJ4pQvPahw3JiwuZTXnOzz3C+QdV
        m+wZnUYWb7t0cUvqPiOMV4v/QD9JnJj1C2HzwNs=
X-Google-Smtp-Source: ABdhPJyf7hwIjVhYBnXvHKNiN8mPCsg+asGfKUKgf6pCZXkbZaWnLqIsc38HmWXWeUoIDy52NHao2w==
X-Received: by 2002:a50:ec10:: with SMTP id g16mr11462768edr.20.1640019971753;
        Mon, 20 Dec 2021 09:06:11 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s3sm5536885ejs.145.2021.12.20.09.06.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:06:11 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso9161120wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:06:11 -0800 (PST)
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr2874647wms.144.1640019971122;
 Mon, 20 Dec 2021 09:06:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgWuZPhK6dgXsS42iMz4o610Uw4QXeUsTSOQheNo1tf5A@mail.gmail.com>
 <20211220164718.GA2284495@roeck-us.net>
In-Reply-To: <20211220164718.GA2284495@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 09:05:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguJMGiNW6oay1Xdzea_qiMqdRtsijb6e9LRdD2wiWr2g@mail.gmail.com>
Message-ID: <CAHk-=wguJMGiNW6oay1Xdzea_qiMqdRtsijb6e9LRdD2wiWr2g@mail.gmail.com>
Subject: Re: Linux 5.16-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 8:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
> Build results:
>         total: 153 pass: 153 fail: 0
> Qemu test results:
>         total: 480 pass: 480 fail: 0

Well, we got there eventually.

Let's see if we can make regzbot happier than it currently is too.

                   Linus
