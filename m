Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35C4E6978
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiCXTqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbiCXTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:46:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC784A93A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:45:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w7so9859131lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/SpAkDZmYsurKOrmNkyHHFnP0zb0UOgoVrdpJO91Oc=;
        b=ZoSCZ766Kxe8wT/YhSf5nEhzp8afBIvXr9XNRko3mNj+l4/a/cZ9dn1i1lKN1IbMmc
         pHFOKqqVoGl36ORhq656wjKXAiIQMVs1tHJjhHLw3rXrs6xDSfbWALmkglNN9AD88o4W
         6TIaEH/IftuwCvs6gPTFSieDspeOImXdTKrhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/SpAkDZmYsurKOrmNkyHHFnP0zb0UOgoVrdpJO91Oc=;
        b=n2ij5SdyH30TmNYSpwce3+bacaYKwmLjay1REjnXRBfMs+JRf1VKunxE1hF/2SdWYs
         fJ8tkrHHheuCiGGg9vsKv/8KB9PyJU/2sUUe5S4Dh/Z6x7PUWKQjtqd6a7Pl/Pr87c5Q
         t2mJZ8U7USXAYtqLcy2OUDx18NoEt1mApCoJaCPijBGos3HNi7TdNMqh+nDJZieipx51
         i6f/aiw5Yji2yASysFuRkaC7669t/1VDLFF/JiueXk0iH1Jd/CSLtVTHrMhSTXA4Fa1a
         M2U5iN5L+wRuU5907UlORCzmu+q6zc4x2ikI5359U8NZr0G3nJrtJhG/Y5hdhroDK8VI
         gZqQ==
X-Gm-Message-State: AOAM532ulN55h7nYEkynvlzXQd+B9edbRhspmSvUhT2ghRRIwt9pD8Kv
        aE84mV075VxVYTBYxaH/s+LsA5tRz97Xvucb8rs=
X-Google-Smtp-Source: ABdhPJzTKmKaGfczQR8i833p/Y5fYIxiTQ/TRuCazCJXaZfRkD1yaAeECKXnuB7WKiqY0W4ux2S7sg==
X-Received: by 2002:a05:6512:22d1:b0:44a:6e6a:8ff6 with SMTP id g17-20020a05651222d100b0044a6e6a8ff6mr608150lfu.61.1648151117819;
        Thu, 24 Mar 2022 12:45:17 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b0044331f8f1f8sm442487lft.128.2022.03.24.12.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 12:45:17 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w7so9859019lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:45:17 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr4959201lfs.27.1648151116683; Thu, 24
 Mar 2022 12:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
 <0000000000009901d505dafc07b3@google.com>
In-Reply-To: <0000000000009901d505dafc07b3@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 12:45:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
Message-ID: <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Thu, Mar 24, 2022 at 12:41 PM syzbot
<syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com> wrote:
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Heh, well that's unfortunate.

I think the issue is that it triggered a new BUG() that didn't match
the previous NULL pointer dereference, so it thinks things are
"fixed".

             Linus
