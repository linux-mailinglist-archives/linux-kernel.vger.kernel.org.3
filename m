Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD84FDB43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbiDLHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbiDLHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:09:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6207E49F31
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so30455263lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAV9zD/9i3JbiiASrVcLIQyrbdWy7ico6dvybKeWvXs=;
        b=M/AHANmKGN/x+pUfTld06wGLxBZO8idhvqokFKh3BT7GGmJsUzvYs7TnI5abkdSjIW
         PMSxmtD12lJgdcdZ2OqdkCSLdMxu98RMRLkVkArQbM54XQ1sY2yeEjL+w00BVnLPR1SX
         sv1fHZETALyHeOuUK7+l+iTeLbFoU0iMZrz7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAV9zD/9i3JbiiASrVcLIQyrbdWy7ico6dvybKeWvXs=;
        b=fF02Mk7zV2mAAi1c6CR6gttAfsfNRXnKork0eWfrdUdrQ8AzpO5Hr+W0a0RzGjgQb4
         N5sW55eUCQrnkrqi92WSz/jAPx/PpJBUZo6fmmrT7YVJCGOSb2uy/Oxpw4SgHzkkExhP
         UrC3CjMi/7y+XMq3yRD+fvAHRmrznpkceU4ChwbHd7kLOOWtUSwpd/mWAaS+KMukBZG2
         zBK82h4GfHWeMMbcbv0gXZsWkC6I3vOji6Fz0BAscRZEHqiZ9YdCZXcOHON7x7RjuL6P
         y0ws4QVc1oOpPrXd9cYJKFvw4fJcokCBtc3CpEDBxUNS+RTSv3SiJNx8lYdLGu3w7f0U
         ZDmA==
X-Gm-Message-State: AOAM5334QU/morHIWbboU1GXACKqiYRKHaPi2oY+a0HwaWIthz29Lw3r
        1nCeKzKSEeFlMUMfjIJuZDtawPl9Q4j05JOH
X-Google-Smtp-Source: ABdhPJxtCZT+Xd9QOaYV8hT7Fv/lZpTQCI5H5M4p+s5pEMsAHV/d3wUx7454NSi6YM2m+scDqVUuQQ==
X-Received: by 2002:a05:6512:b06:b0:44a:f7bf:a425 with SMTP id w6-20020a0565120b0600b0044af7bfa425mr24423404lfu.445.1649746170480;
        Mon, 11 Apr 2022 23:49:30 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id bq1-20020a056512150100b004481de98e5bsm3545389lfb.305.2022.04.11.23.49.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:49:29 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r18so7210386ljp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:29 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr22850127ljn.358.1649746169549; Mon, 11
 Apr 2022 23:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
In-Reply-To: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 20:49:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjfLQdsjMBRQm=UB+RB08Cs6G41+kk2ybe7JHuu4ydhRQ@mail.gmail.com>
Message-ID: <CAHk-=wjfLQdsjMBRQm=UB+RB08Cs6G41+kk2ybe7JHuu4ydhRQ@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
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

On Mon, Apr 11, 2022 at 7:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Correct. It's literally the compat structure that has no basis in reality.
>
> Or it might be some truly ancient thing, but I really don't think so.

I was intrigued, so I went back and checked.

        unsigned short st_dev;
        unsigned short __pad1;

is in fact historical. But it was changed to

        unsigned long  st_dev;

(for i386, so this is a 32-bit 'unsigned long') on April 2, 2003.

From the BK tree conversion:

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=e95b2065677fe32512a597a79db94b77b90c968d

so I think we should just make sure that the 64-bit compat system call
is compatible with that 2003+ state, not with some truly ancient
state.

                      Linus
