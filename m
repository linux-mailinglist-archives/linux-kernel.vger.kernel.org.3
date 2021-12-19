Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E398B47A208
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbhLSUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:16:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:16:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so30108300eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckOazLTjTGH8+gaP5NR3czvAVfEhUtU3IMU+9pAvh2A=;
        b=g5wvtxNKoAEXOgzgT/k6/Vdhk8b3D2YTj/CV4c/X8FVxq2PVyntTR63rLgZ2WznBZv
         DAbZry1OvF6DL+zKLsyFd8m8F6aJ40f7W778JoYWZLVv9JMKX0OGlpvw6AOk+2fPyyYs
         gC/2sm4/4xT5dmTY1Ef9U/9YgkSHnJe+2vDTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckOazLTjTGH8+gaP5NR3czvAVfEhUtU3IMU+9pAvh2A=;
        b=flgfVpxBjOmCatRIW96uoeevZYHtgb9xUas6fngniJE8lhKENUbmIxvXXxpkmRJbib
         X6C57OYrLJvHAffjfY2c0XlC0bbbqMnEx5QxIxBc+Td/jtdyNqjku1cmXOaUCXYwyc6c
         84DGd9rJBs8SnTGC25sj2G7NS158g9KsC6M+y8Oio/ArukJNqbZ2kWlh9re/mpadG7jB
         LyNWgZdi/LjoM5YLShpBd18aAVb3SdsZ83Irp/sZDvxWs8mrb+E7pb83/00UAEKYPaBB
         R/lSNxAfkVR/UJ0B4PuagmomqqBMdieMyOLjp1eEWlWet8RN5MflnyhY7tK2bRzoTJwh
         U5QQ==
X-Gm-Message-State: AOAM533xTyoAfpdOjmiONkSrdEXnpPjAq5d7ApYYGqgj64Qqh3vtfmgv
        fFUE9eGULfx56b3qlZfIoXRqmyNZeZkt4YpenYs=
X-Google-Smtp-Source: ABdhPJwNaruj6bSkEO3YknHX1uKAJYIHaLUlftLmuXKEsFFnRDHQmZ/mCN8x5sUNViA0/+PKjtldFA==
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr12697277edw.110.1639944986609;
        Sun, 19 Dec 2021 12:16:26 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id d1sm4680703ejo.176.2021.12.19.12.16.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 12:16:26 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v11so15877821wrw.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:16:26 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr9714397wrx.193.1639944985945;
 Sun, 19 Dec 2021 12:16:25 -0800 (PST)
MIME-Version: 1.0
References: <Yb82O5i2DVcK9nAJ@zn.tnic> <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
In-Reply-To: <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 12:16:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd_o7z85PNZGzCJAYKFmhNer5Jo=kYddR-5e-jqZ4fvw@mail.gmail.com>
Message-ID: <CAHk-=wjd_o7z85PNZGzCJAYKFmhNer5Jo=kYddR-5e-jqZ4fvw@mail.gmail.com>
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
To:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 12:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note: I will throw this patch away after sending it out. If people agree,

Gah. I hit send too early. That sentence was supposed to continue: "If
people agree, please apply this with my sign-off after testing".

            Linus
