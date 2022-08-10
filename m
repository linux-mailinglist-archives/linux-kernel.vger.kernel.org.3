Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B158F134
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiHJRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHJRHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:07:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF886D544
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:07:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l64so14934791pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+DbX3SDxILgYRcy9rAL2BFcYYrfgkda6PI0B6f6Q+Wc=;
        b=dXIzUSwtUBZ6mwguU9x6MqXFayTwWdFNH/quGDfA9cjEFMjiD6eWlfL3UKACXmpFwo
         yEXz3do8WJKLybz4SqQxbq0tjhRBfuEnaPAXz+6a5hitQyZqrGh9vmHxhwXOBza8hr0I
         CZ+eN/gi9PXzFknQXrKXv2KdcC7io2kdThNMxYtApvINmDFr8Eewi7gEVdRaxa9+aV8n
         ORtpoQvtg9l6fwhnvjiSxYwHYLQIZAQ5RyFVuLGF4gBQ8F7xg4ef3hyznBCgqlh/jO/o
         wVsox4lfUfkHfKUyFgh3U9uj/cxFG2BPj+FjeGBuPr0SZVdKGYX4I1XL3MlFGy35WAcS
         qrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+DbX3SDxILgYRcy9rAL2BFcYYrfgkda6PI0B6f6Q+Wc=;
        b=1pyBlrE0H2cwrlxImjSiIcQVQTNPqrrZxY5qHtMHckvcAV1d6IWzb1cqXku8lvhOo7
         WaGscuoCRbsQMRH1K9TQgzquetNhX8vl0mtAycyvMulD+0RHeKDtTGU+0uRjRacqKJ/f
         HKFX3Vz1FUPxLUCi5GUwdCkDeFbjElrK1tyJzCAnphMiEe0Y42IpTEoJ3J5JZRgzuoMB
         orkX3FNqLxWvkx9bBSXN8vkAzAHT/MIzrYEKCxbQAi1FU4WaJNeQuB4fVW7AHHl5RJFu
         XnkdsXmqtXtq1SD80UgHzyV5S+SRMbzJRm4MMllHhDii+b/nWHgEeQ7D9x2sJjga1Cn2
         NtDw==
X-Gm-Message-State: ACgBeo2LcRNZSfpKUuO52xw96CVw6T9ThCdH3S01axeZCUrxdKLvgiva
        ZfEc9bRtXFwHYcjVbJohlx1qZRZPwquyGC2+8UY=
X-Google-Smtp-Source: AA6agR6hExV1SvfL6DRTRzFUR5H98AfQE+kaKcvA7Cbd9AMeX+kOeD9uSPVVwyjGz56ei3Qfhgdd6XtAkS6/FM/rUO8=
X-Received: by 2002:a63:8848:0:b0:41c:45da:2db9 with SMTP id
 l69-20020a638848000000b0041c45da2db9mr23108542pgd.206.1660151264726; Wed, 10
 Aug 2022 10:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
In-Reply-To: <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Aug 2022 10:07:32 -0700
Message-ID: <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     Yu Zhao <yuzhao@google.com>
Cc:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 4:36 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Aug 9, 2022 at 11:16 AM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
> >
> >
> > > OK, it is hard to tell what it looks like now. But the THPs on the
> > > deferred split list may be on the "low utilization split" list too?
> > > IIUC the major difference is to replace zero-filled subpage to special
> > > zero page, so you implemented another THP split function to handle it?
> > >
> > > Anyway the code should answer the most questions.
> >
> > They can indeed end up on both lists. This did have to be handled when
> > implementing the shrinker.
> >
> > We free the zero filled subpages, while modifying the existing split_huge_page()
> > function. Will follow up that change in another patch.
>
> FYI. This series does it:
>
> https://lore.kernel.org/r/20210731063938.1391602-1-yuzhao@google.com/
>
> And this one:
>
> https://lore.kernel.org/r/1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/

Thanks, Yu. I totally forgot about these series. It is time to refresh
my memory.
