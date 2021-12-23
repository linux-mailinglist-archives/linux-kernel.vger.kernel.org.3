Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20F47E6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbhLWRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbhLWRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:20:45 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC73C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:20:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so23978939edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
        b=Nh/JZnZIQKCHcPVE2zpqDRAQAn0zb++R5dsUx6CD9Px4tIKzLNH7ltOy99r46sform
         XbYcxDbgfY9qMeDQTvAylVkdl84hTQIpccqjy/whmUbb0NTpxCu88QbVwqlRJXpX5Jhg
         1p8NIZQrFDAHm6FTOXtluShv4LkDp+sGEoVI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6ewMJ2Z+IzcgF6xIUMHr0fBNib7MLyFPwMExIntXDQ=;
        b=XodxzUMoEqy8W7kX6X2gFhBDXQSpqyS42rgpekxZBM7dQ9CgJ1dxH0/fSvVG8FOFEB
         fMGfNwLxaX3m/LJY1M51bk7GGA0iFa1Hz6O9cfj3bZzgTfP+o1CWbkEjE0qGEfFITOvV
         I60tgKIAqvF18ErmUDGyoJuHLjtcL1NF3RiLCzKvpSPPtnv86OE0OHfk1/UpTNrSb8a4
         S/BcaXp+0YywLmLvgoVgDE9LuonluVhY0deIcbDI6Qdunc8nK1sil2ovPtaR7WEAKeOI
         0pnoVebswro54rh7ebotwxX4HfkDDjZk6qgJX1VM0irfrYP7uU6Dr/gdjlcOyGB8lq8k
         RYCA==
X-Gm-Message-State: AOAM533mu6v86SpeiskRKtyKAtWz5ZlURZR/iCt/pPv7Bw79cANT2wgV
        8z1CqnNnltKYZjhVOiUobKpxyqJc8M0UW779G7M=
X-Google-Smtp-Source: ABdhPJybifWWETl6kkSsE8QcjTxvcr6srsuo6ydmMq+WPt00gxZBTvIDv5p10yLzCiG9jUvMKTLh/w==
X-Received: by 2002:a17:907:7dac:: with SMTP id oz44mr2580746ejc.307.1640280043646;
        Thu, 23 Dec 2021 09:20:43 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a13sm2140709edk.29.2021.12.23.09.20.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 09:20:43 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id q16so12788927wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:20:42 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr2336024wrx.193.1640280042472;
 Thu, 23 Dec 2021 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com> <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org> <YcNyjxac3wlKPywk@archlinux-ax161>
 <87pmpow7ga.fsf@email.froward.int.ebiederm.org> <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
 <87o858uh80.fsf@email.froward.int.ebiederm.org> <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87a6grvqy8.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Dec 2021 09:20:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Message-ID: <CAHk-=whmsosJkXoN+arC6eUdayq42pTZzr1j0rG3=RsPBgqujA@mail.gmail.com>
Subject: Re: [PATCH] kthread: Generalize pf_io_worker so it can point to
 struct kthread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        virtualization@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 9:19 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of continuing to use the set_child_tid field of task_struct
> generalize the pf_io_worker field of task_struct and use it to hold
> the kthread pointer.

Well that patch certainly looks like a nice cleanup to me. Thanks.

                Linus
