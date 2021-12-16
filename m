Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC5477A26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhLPRNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbhLPRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:13:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so89367601edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDlVC7K2J17hzYvXNGm7cNY1/KwjC4f0j/S6KBI3XWs=;
        b=PxNTueayzydirKFNX/aZFqvh4eZHQBO97bcxKPIYWoWoCvbu8Ge53zcL9pNJMa/zLp
         r8ZbkaBEnzyU6SZUXscNGuO+CsXsHd4v11HNOvdiZ/be6hs23tOkhRInYjl8q5WBjzE2
         BB1MRornTquTrS71dnLK/z/ae3fGLJSGif8LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDlVC7K2J17hzYvXNGm7cNY1/KwjC4f0j/S6KBI3XWs=;
        b=QuJ2k6WPTBJLFixUH4AoS/xSItKyOPTwplTqYF2Fu0wlpZlZBnkIjCUDQTBdIBA+VV
         LsTLu7f8wlMreYOATVZpM1rYT7g71mRSUHDYuQTdK4/BFhd179nL/zbGp0N4mVteWhKU
         toYSqoxZ3mrK81raZjVSvDIKy79IfAUgsaXrfwmovC59XL2WnygLp+8uzzs7ZnbUWjAs
         6A7O/gZgAwTmMDe63JNryTlO1kAwZW6WSo+FjiDPYIXlDtoViUCKQ4whpTTK+uVFp8FE
         G5+Wvd9kZFRUz33cQ5F3KKf/lL716SOU3NmHnGW/pspZxK4/7tLBlI4ZDOrBjlJvkQL2
         hr8Q==
X-Gm-Message-State: AOAM533wrvSUZULqKvVJ3eQBDjO5Cl1tjiVtzX1/QB06OS1ddKFnrLvR
        kDWsA63EKl1N9jH2n5wbhfK+laaYRBqGe+suFOk=
X-Google-Smtp-Source: ABdhPJwp7P+zh9y3EvjmJebgVfWhwrigvkndA8GyfDSzsfEy9pyEc5fZhX2yrE9L7pjQzESKdx0dVg==
X-Received: by 2002:a05:6402:1ca2:: with SMTP id cz2mr20934511edb.302.1639674808767;
        Thu, 16 Dec 2021 09:13:28 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id s16sm2585469edt.30.2021.12.16.09.13.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:13:28 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso1750074wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:27 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr5920009wmq.26.1639674807647;
 Thu, 16 Dec 2021 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <759480.1639473732@warthog.procyon.org.uk>
In-Reply-To: <759480.1639473732@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 09:13:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB+Q+KbMBXtZZyMChdg8E8fBL8uipJn4j_rFxbAXangA@mail.gmail.com>
Message-ID: <CAHk-=wiB+Q+KbMBXtZZyMChdg8E8fBL8uipJn4j_rFxbAXangA@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix mmap
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey E Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 1:22 AM David Howells <dhowells@redhat.com> wrote:
>
> Could you apply this patch please?  Note the odd email address in the
> Reported-by and Tested-by fields.  That's an attempt to note Auristor's
> internal testcase ID for their tracking purposes.  Is this a reasonable way
> to do it?  It's kind of modelled on what syzbot does.

Yeah, this looks sane to me.

I don't like bare bug tracking IDs that don't tell anybody else
anything, but the "embedding it in the email" trick means that it now
(a) gives a contact for it so that it contains meaningful information
and (b) also acts a "namespace" for the testcase ID.

Applied.

            Linus
