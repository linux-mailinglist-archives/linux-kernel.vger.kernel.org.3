Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41795ACFA9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiIEKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiIEKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:06:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D127543C6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:06:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p16so16006982ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CCsjW2ihj3ub+9/+LDmvPPjSWhHhWWtp7N+Zepi/39Y=;
        b=oHAZeqW2U8L71CZoOZtH1/y98LVWEMlURbJLey/QyPpyChU9dmTRk+W2x4ws4Tw6nQ
         DSCYlOWNOwepWtTneN215b2TQYJz7qKVriScywgG1a5fEKBQIR26zqjhCBqw0HGoKOpa
         npTL9N2l2AwGcAEyN9bRSm2eHTFVQx6YcKJi/n0nQgtdRplDwPC7/JjjkI3zzfDwQf+J
         wngGdQ6gWXcY0aLVQrWPsiqWxPaomA34AzsN49BaG69C411K5snO3MBd28kzaM/qcnqV
         w54bNmHzSPt50p1QHmHMKlQoJ2LzjPXyNezDe2XmLL5KI6qYdJSQJNrkulew2tmywKwY
         iSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CCsjW2ihj3ub+9/+LDmvPPjSWhHhWWtp7N+Zepi/39Y=;
        b=u+3nEfWS+WojUmjhxpeomDV38CMkrO15lHTwSpC9l6eUrhfaQFXMnAiCcqoSs1xxmD
         vaDtpMfwA+dZnYubNK1tFLNfKaGbyj8XS5Qem5HOp1rx6ILUy3j6804ZtlYJfa3uEP2n
         TZYe0PAUljUqT5ZyEI7vghFF+DH6MTp/Sx8DIhPT9JtRkb4Ife/7fXbig8fMN63C4TTe
         zwt/hcnoZ+hP/msLUw57D4cF0BVXVDBeDlQPdyiVnhQoBQFwqtWZSH9ogl8cOhYhTGsJ
         rX17NHiZgUDcqvHvUhFTlprzZocMofEdsKEBO/cEpPO4wgsM0BvG8TduECGKseGeGj07
         GmUg==
X-Gm-Message-State: ACgBeo2+yS6+7nVfQsYntEjmqHbF/OvLX49c7pEjZg0nZQJvKvp5r1lv
        aS1iv2NuQH14QpfqoV1YZXVINLiigJn6kquIrsA=
X-Google-Smtp-Source: AA6agR4XmCqRrivqKqPnefhDNeWZBexPCoGlW8Un49/pYDOQDuTy8dBANcs+Bj7DR5pDZsd+8tsirkyf326P95S7KKE=
X-Received: by 2002:a17:907:7d8c:b0:731:65f6:1f28 with SMTP id
 oz12-20020a1709077d8c00b0073165f61f28mr33463880ejc.91.1662372374610; Mon, 05
 Sep 2022 03:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
 <20220905081552.2740917-8-senozhatsky@chromium.org> <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
 <YxXHFZ1PJI3h6BZY@google.com>
In-Reply-To: <YxXHFZ1PJI3h6BZY@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 5 Sep 2022 22:06:00 +1200
Message-ID: <CAGsJ_4zqXJJHA02NzyZ662jfL+sNp3LrErTP18vGz2N4u1Tqiw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 9:53 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/05 21:21), Barry Song wrote:
> > > 3) HUGE pages recompression is activated by `huge` mode
> > >
> > >         echo huge > /sys/block/zram0/recompress
> >
> > Thanks for developing this interesting feature. It seems reasonable for cold
> > pages. But for a huge page,  do you have some data to show that the hugepage
> > is not compressed by lzo/lz4 so we need zstd further? i assume the size of
> > the huge page you are talking about is 2MB?
>
> Oh, yeah, this is the lingo we use in zram. We used "huge" object and "huge"
> size class in zsmalloc and the term "huge" transitioned to zram, but zram
> operates with pages not objects, so huge zsmalloc object is "huge zram page".
>
> > on second thoughts, it seems you mean hugepage is those pages
> > whose compressed data is big? if so, can you please avoid using
> > "huge page" as it is quite misleading in linux. we are using hugepage
> > for pages larger than 4KB.
>
> Yes, you are right. And I wish I could use a different term, but...
> this is what zram has been using for many years:
> Documentation/admin-guide/blockdev/zram.rst
>
> And we already accept "huge" and "huge pages", and so, in sysfs knobs
> (zram device attrs), so the confusing term, unfortunately, is there
> forever.

make sense! thanks! i assume you will have some benchmark data to compare
three cases,
1. lzo with recompress zstd
2. always use lzo
3. always use zstd

such as power consumption, cpu utilization, available memory, benefits to user
experiences especially to UI smoothness under memory pressure?

Thanks
Barry
