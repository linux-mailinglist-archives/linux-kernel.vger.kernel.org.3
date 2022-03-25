Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923244E73A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359136AbiCYMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357600AbiCYMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:39:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B22AD9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:38:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so15162425ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfRCxH9/uoNXtWgRWX0fdM2M20zvzSKi6ZQUaCI8/Tw=;
        b=moZNf82k4PSvCr9JvQF0xyYIXTQ+Mg7iw0IhkDLsNH5P4XX1npD+w81xQ00GaiEzC+
         1vIo6IJ1nIRX0jh8/fOvYlXU5nAHK7EaBS57eVuzlQnU3Kz4LRykgxXtApWrbrBas5yk
         m9eIKf1dIdKtwLOsHUvLu7ne7jzHnlxjR0sg4d2UKUK73cgpCJxYsj8FEQxSIZRMxzHB
         C5VMpAw41BYmz6psWz+cF5itMoq9TJ6zNmWC32Lu4dd3WeD8yubRZFpTKul95gS+gJYV
         oeA5ytPxEy8QwKeRYii24dheEmnIlyCfrUaih3NW3qXGE3kpey7USWnwiaJp5pxRfWD0
         1APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfRCxH9/uoNXtWgRWX0fdM2M20zvzSKi6ZQUaCI8/Tw=;
        b=nNo58AIy7aukjkeZzvXp5IyyEXc4tmxh2XN9hFY4cBJrg9ilNc9ktg3LUOLFHN1w9O
         W+0tD8zWv5hES4cDjI7Ttfsi98Qrfxh9DlSd6O7I+9PcS63/FUxNiB5/tz/m09roe7jG
         hQL/+MY6itjKxWeRpkRUod0vHI6VvX/9ivIaZfxsmhgi33sKbiRQXZ1pbeMpwUKuFZq6
         5SByRTl0omUBQ11kbUmTrS7K/CBNHCvSKecPeQw7AhtJAhLMwXN4VM2Bp3koZqATn8BP
         XsqNJeRIBzEsFUlOeS71CmOu8+axS2KLd8Ug+4Q+3kPTjd0Vrv/L5OiOBnKkX76t70Ja
         R1LA==
X-Gm-Message-State: AOAM531yLyfMBgxIsv6Liv3jdT9JPjwj5W/WkLxXvnByfWOUfBkZyEbZ
        bk0ZcODC6901OkuFPswdC/A=
X-Google-Smtp-Source: ABdhPJxgPKfxl4xOHxp27VuyTs/QRe8Q5kwMcIBQO1+3mFrvBxcCkah3EqqXiaGGnNY7wo62YGewXA==
X-Received: by 2002:a17:907:7da6:b0:6e0:5b7c:e3f9 with SMTP id oz38-20020a1709077da600b006e05b7ce3f9mr11872382ejc.239.1648211881003;
        Fri, 25 Mar 2022 05:38:01 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090600db00b006df6b34d9b8sm2270193eji.211.2022.03.25.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 05:37:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
Date:   Fri, 25 Mar 2022 13:37:57 +0100
Message-ID: <5818154.lOV4Wx5bFT@leap>
In-Reply-To: <12984828.uLZWGnKmhe@leap>
References: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com> <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com> <12984828.uLZWGnKmhe@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=C3=AC 25 marzo 2022 06:47:36 CET Fabio M. De Francesco wrote:
> On gioved=C3=AC 24 marzo 2022 20:45:00 CET Linus Torvalds wrote:
> > On Thu, Mar 24, 2022 at 12:41 PM syzbot
> > <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigg=
er any issue:
> >=20
> > Heh, well that's unfortunate.
> >=20
> > I think the issue is that it triggered a new BUG() that didn't match
> > the previous NULL pointer dereference, so it thinks things are
> > "fixed".
> >=20
> >              Linus
> >=20
> > --=20
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-bugs/CAHk-%3DwhxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd%2BUWCMf8dg%=
40mail.gmail.com.
> >=20
>=20
> No, not at all, Linus!
>=20
> Unless I'm still sleeping with wide open eyes (it's 6.30 AM here), you ar=
e misunderstanding=20
> this message from Syzbot :)

Oh sorry for the noise.

I hadn't read his changes, so I didn't know that they were a no-op patch th=
at wasn't meant
to fix the reported issue :(

Regards,

=46abio



