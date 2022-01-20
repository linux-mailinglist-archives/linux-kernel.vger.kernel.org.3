Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883F495314
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbiATRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377233AbiATRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:22:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39329C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:22:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so31534603edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncvlTAS0L4yQCHvxcXlz75YOuPdmsFVoVMirXa2zJSc=;
        b=T1GENQb9E1UWqRHycMNTqlUbmq3o2r29qENRdmVki77UXsvLGqjYxS/6zQawXlMadi
         HjsVwbkLX6gCgiYKZngNC32r2Io5yH9L4N1HbshyAFc7PNzBDS5J7pmlN0W3UiBxvGtv
         Py1S5HNdjmSWUrNKfZdIGApUVY+OjZUybBl44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncvlTAS0L4yQCHvxcXlz75YOuPdmsFVoVMirXa2zJSc=;
        b=4E6RjBb3ORBTGKI5iOC8y1c3HcdumxBz44v7yrVXogOxPzHQJbzDw32O1ky4ua+O2V
         uD99yLx8Z5YM1gNrIG7xUcmFKEiLrCWLynVuVF8bwlV8Y62Lu2r+v2yPn4IUc0PPC09g
         6uqVF2ze+bPzydvjIWTFdc+HGP9rB52s8Qv9q6WKF27BtQ7QwHJCzQNAwCCh2SSmo+xt
         Hv8WCJLksSxPpJP6uonmmtzBSg9I9FMBo3+R3ni+vXeLF3ka+j5XiD5qyQL5vqn2eFGh
         jKyuKQ+5qEXkTj9V41SAdeZ7hc080ry6m3PkYWgJgeNWZyp0bTWUtunr6d6P0siOaMDi
         tzyg==
X-Gm-Message-State: AOAM531ChpHcFONStKQ5rg+06R4KOtYZtQKaZoI3jQeKXAuwufU3ItH9
        ueKcTeZMBCzKp73aKNXzhV8aFWdPWz6JAhy1kNQ=
X-Google-Smtp-Source: ABdhPJxixmdgc2+yAUKBFZNOBuDbpUQiO6pelb6gH7NNY6VJ1TBOHWLMnigfBIeMTCabT/j0B0u2RA==
X-Received: by 2002:a17:906:4796:: with SMTP id cw22mr31476921ejc.594.1642699342389;
        Thu, 20 Jan 2022 09:22:22 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id d25sm1252609ejz.4.2022.01.20.09.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:22:20 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso15302007wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:22:20 -0800 (PST)
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr31585wri.193.1642699339801;
 Thu, 20 Jan 2022 09:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org> <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com> <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com> <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com> <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com> <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com> <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
 <43e41259-b228-2a75-e59d-0c6a1e81912f@redhat.com>
In-Reply-To: <43e41259-b228-2a75-e59d-0c6a1e81912f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jan 2022 19:22:03 +0200
X-Gmail-Original-Message-ID: <CAHk-=wirJT_K381J+8AAnOeyEtUuQ=eAwg=EzBJPcN7TyygNbg@mail.gmail.com>
Message-ID: <CAHk-=wirJT_K381J+8AAnOeyEtUuQ=eAwg=EzBJPcN7TyygNbg@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 5:46 PM David Hildenbrand <david@redhat.com> wrote:
>
> I'm, not concerned about fork(), I'm concerned about other false positives.

Without a fork(), you won't have the THP marked for COW, so is it
really an issue?

> Here is what I currently have, I hope that makes sense:

From a quick look, that patch looks fine to me, but there might be
something I'm missing... And who knows what odd usage patterns there
might be in this area. The whole odd Android thing with forking that
zygote process.

Because that zygote thing _does_ use THP, I think, and it's where the
wrong-way COW thing mattered. Obviously doing COW is the right thing
to do, and that case doesn't want any sharing of pages (all copies),
but it might be worth at least checking that it works and there isn't
some odd performance gotcha.

               Linus
