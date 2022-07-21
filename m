Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414A57D2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiGURwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGURwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:52:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71182F89
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:52:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x91so3124617ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMJ4sYloZ6Ki+evZiJphLGd4MCu55Rzh4CGanCbl/Ws=;
        b=B9QRit07Z6p3k5Ew54dExdLkEDxI4GvdhGxGqJEYXSNH2REBhgKTrzmgYJzNXz8upR
         m0HPzdFUK/Yo2E2sfXjdV7xfGkz+qckuWTGIT2h0E9qoHk/nqMNH75AJ5E5Mnfh5Bbe+
         OG7Pf0Tz1A5JxRIRru6uLkAeC1erxxMt1UYuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMJ4sYloZ6Ki+evZiJphLGd4MCu55Rzh4CGanCbl/Ws=;
        b=GMIB9JdveHC0DyZ/tSHuU+smHhgfnc6pvT9FEh2XCZCyMCoUmFSfTDVHgz/FXeybJk
         E134MD60fFjr8xnfQ3jDSi8sq9ud32+25omO6Dt6QcRjF0TWvJNvTXUsKOcd0iU/UThk
         +HcuJXPpJfmOyJONKy8UfUuPG2aaI5fEU1cIOmiqnetvlj/qLXyqGmeq1emKlnOyp/s/
         lXHb53QkEmRS5npM6eXHpu/nt/9vu/jWGRdbv/GpZ/XgJtD1NMT+HTfcr+cYKznYGmtK
         eGDhW7kUXR69AwoCuWs4TmE2uPpud++4z4BB6ppJP6yk31GglEJc0hIx5yQQLcxWHh4H
         R3iw==
X-Gm-Message-State: AJIora/Q2feJElSW//+Owf6aNotuxjCvs4RMU8v1Plwil71agaaJEAZ4
        Q7QB/0UShEVRWPozs6iqUB52C9P2y8qm2vQROvg=
X-Google-Smtp-Source: AGRyM1t5hbrOiV/49xvpFv/TVlS0v21U1ZdlfF5scGcnAJKh+pBULXTQ3gCY+WkdA5e4Oz1eoB1IBw==
X-Received: by 2002:aa7:de0a:0:b0:43b:bd52:355e with SMTP id h10-20020aa7de0a000000b0043bbd52355emr8138210edv.225.1658425967396;
        Thu, 21 Jul 2022 10:52:47 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id t8-20020aa7db08000000b0043bba84ded6sm1333919eds.92.2022.07.21.10.52.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 10:52:47 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h9so3374399wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:52:46 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr36287730wry.97.1658425966602; Thu, 21
 Jul 2022 10:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220708071802.751003711@infradead.org> <YtkQNA4jkhfEfWzs@hirez.programming.kicks-ass.net>
 <CAHk-=wiDZmXm9AJHNMJEVKmwJg4ndQP-UeZxT7+gi13SnVsuvw@mail.gmail.com>
In-Reply-To: <CAHk-=wiDZmXm9AJHNMJEVKmwJg4ndQP-UeZxT7+gi13SnVsuvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 21 Jul 2022 10:52:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihX0AyBFoF3MzrhpOW+wYB-UuNNLio9LaxaJCLngw-SA@mail.gmail.com>
Message-ID: <CAHk-=wihX0AyBFoF3MzrhpOW+wYB-UuNNLio9LaxaJCLngw-SA@mail.gmail.com>
Subject: Re: [PATCH 0/4] munmap() vs unmap_mapping_range()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:46 AM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I'm picking up other random things right now anyway as people have
> emailed me, so I'll just do that with this series too.

.. and I took the suggestion from Jann to make that last patch also
check VM_MIXEDMAP in addition to VM_PFNMAP.

                Linus
