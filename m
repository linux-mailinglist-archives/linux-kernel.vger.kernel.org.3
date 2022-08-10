Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363958F1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiHJRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiHJRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:54:47 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362A24F36
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:54:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d126so11638606vsd.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Rlv2WQ1JmFKF5LVuV05sS5o0PVRGZSe94PF6HIeV4q4=;
        b=RijjTTaUH2ZlP08yANZYBkSU9HSQOgcbY8bcsSTx0zMK/KC0OXPgf1Kc+FnhdK8HxM
         YS0Zjh8zGaezHcboSrpY0mqtXImQGhDM4H+lILyGcUa2SNtGnIS5FEk+dxx5KVZecXsV
         dqaTruyolmywIXWwPTijg574GzxvC1R2DJ+O3p0rs57TvDuzLjxIYU25lTw+NjLbfYJI
         0AbW0n/kyGN0DNPiqE7Sbue5WUPoeKMNFFLgdpWgax6g75NkPZHTpnqnyoiRuEZf5rPY
         8mQF0wp98Kcv+Fvndz9qaOxB5jHR2xc1oukiVN0ctlaGIcpHDlNsgHLyFZGTH+/YL07l
         udFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Rlv2WQ1JmFKF5LVuV05sS5o0PVRGZSe94PF6HIeV4q4=;
        b=u3zo0wSn8H30fiM+bUlnj+51PQjS2/kLpOMJOaw7Bh97b8JDJrnC7+zfI/oGFwMrRm
         TcKtT9h/GTpl+AxMVcAIO2jNobbC/FocSoEtO/2L09D4Qfs9p21fKHRvyQY6no4sYcHz
         xXf09e2QQjG4dJENr2KxkvxD3prRc4pLU/TeviEvuye8GWQZy3vFoZfzaW0Swwi8sTps
         tIcGaY8MyhDClruTRh5/rTpVRhmbw7LPTAH8EiRqkN7VHiTjcEzsEKOf1J45U+7sR2kL
         GMupEUrzYaXnCEwyaFirguwxhx/Ncj7PTUPeJh31t4kshV2P4vGFfwBUSR+zJcBN0Aky
         uHLw==
X-Gm-Message-State: ACgBeo1uro/cn3Q+6Aams2XlP8XuyispOCjqmmUSV9IcxcjS0BnRtxOW
        tEH9JvTUA7syZhMQh/TnDYVKsBHGjIBGpGXdhJdXkg==
X-Google-Smtp-Source: AA6agR5kY/kLbzuH9ZykaZBVWHJV5Zhb70+5G9OYvVxmweSmQ5yeuSJXIzMQLuRs/5VyHzU9HKpuuu97NKmRrwn97Rk=
X-Received: by 2002:a05:6102:665:b0:387:b34:d579 with SMTP id
 z5-20020a056102066500b003870b34d579mr11561008vsf.50.1660154085425; Wed, 10
 Aug 2022 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com> <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com>
In-Reply-To: <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 10 Aug 2022 11:54:09 -0600
Message-ID: <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:15 AM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
>
> > On Aug 10, 2022, at 10:07 AM, Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Aug 9, 2022 at 4:36 PM Yu Zhao <yuzhao@google.com> wrote:
> >>
> >> On Tue, Aug 9, 2022 at 11:16 AM Alex Zhu (Kernel) <alexlzhu@fb.com> wr=
ote:
> >>>
> >>>
> >>>> OK, it is hard to tell what it looks like now. But the THPs on the
> >>>> deferred split list may be on the "low utilization split" list too?
> >>>> IIUC the major difference is to replace zero-filled subpage to speci=
al
> >>>> zero page, so you implemented another THP split function to handle i=
t?
> >>>>
> >>>> Anyway the code should answer the most questions.
> >>>
> >>> They can indeed end up on both lists. This did have to be handled whe=
n
> >>> implementing the shrinker.
> >>>
> >>> We free the zero filled subpages, while modifying the existing split_=
huge_page()
> >>> function. Will follow up that change in another patch.
> >>
> >> FYI. This series does it:
> >>
> >> https://lore.kernel.org/r/20210731063938.1391602-1-yuzhao@google.com/
> >>
> >> And this one:
> >>
> >> https://lore.kernel.org/r/1635422215-99394-1-git-send-email-ningzhang@=
linux.alibaba.com/
> >
> > Thanks, Yu. I totally forgot about these series. It is time to refresh
> > my memory.
>
> I looked through these patches yesterday. There are indeed parts that are=
 very similar, but the approach
> taken seems overly complicated compared to what I have written. What=E2=
=80=99s the status of work on this since last year?

Overly complicated... which patches and how?

At a minimum, you'd need 1 & 3 from the first series and this patch:

https://lore.kernel.org/r/20220608141432.23258-1-linmiaohe@huawei.com/
