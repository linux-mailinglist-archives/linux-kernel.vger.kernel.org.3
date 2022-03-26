Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6125E4E843B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiCZUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiCZUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:55:07 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51032AE5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:53:28 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id w189so6006254vke.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcKa0lFs61IqH0Q2OuV1GgPXmb8CKZ6CqPPFd4s4Pdo=;
        b=Xspes3HTVVdABfoVajMr3OEvWhBDkkTooZMWaUYGSrZFUpahQoYkrv1Q9EzqmaKA6V
         kg+1PcsBi4kGIrJg+pUt5M4OOn6UA49m2MCMFBuj6JiDN0sEwAGFnY+hoW9QEgu1rVpQ
         o2guAsbCVInzLWGCRoOj7XPHcpFsZU+vWVk3XpAyXieCwDkxD7S52atyPdGYgPbtP6tv
         fm78xa7C1zsHUPJGF83xIy0WJq7gTKNnZSE7OX8g2mR8Yy75CgDLFXEugTIfZNO880bs
         ThSuTnxmSYG0/DYmWqUQ1ylGBwUJgyRojWOMdyLGd+zQijI7sjenkZgM7B9GZjqL8hYY
         Z3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcKa0lFs61IqH0Q2OuV1GgPXmb8CKZ6CqPPFd4s4Pdo=;
        b=F7qAjFvlqGeYUO2Hwf4+ctEcuEcN1yHypkJbbKkuAGcpJ58pSzmEuznBfEQN6hlqJ9
         JjPN5CFvJMXoVRJGQBEYq8iAur8jcZgjWCSe9BzLF3shI+9m3YEE2LR1F5ZwEg5RXbki
         Ap5D3S4Bv2MVPmrZrpPa5odY+5f7h6sjU1QayccB5zdjjFjT7JDfTUfE6dRxIXOsx3dj
         U7IbrNrUK7fQ4MGF36h/8y+JYSK+Wkkz92sb4ArFL1tAEwxRjq6RxCR41ZlueMzpTdU9
         jByCxdFUlTteKeEuH9gSm5kVH3XBoTB5TQFYLMqLBBuZtckhyo2oS+DCj1l2HtEzz5YD
         pA2g==
X-Gm-Message-State: AOAM530ZIuQ16RYAeRPpTNKrAMdxwC+dPQ3rEISCKZPqr065jTpTl7rf
        yq34bQflQu+qPzei9PgZzD0FFqf9U0DnS64zhc5WtQ==
X-Google-Smtp-Source: ABdhPJyBTheGCd1/qWmKwHBWy11nbe8qMWIxCfeR6u/YZP/6FIuOSSlgRCNPyk+BnY3kdnzeEIN3aw8VCvkZ7FRAqak=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr7482497vkf.35.1648328007397; Sat, 26 Mar
 2022 13:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220326010003.3155137-1-yuzhao@google.com> <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
 <CAOUHufbqum18T4kZ=d_hMehz=N=3iSuNfGrLof5tB8kjGkk8yw@mail.gmail.com> <CAHk-=whbdpeeKbCYggJqfk0ExEPyxSW-yXSsNUqsGpd5ozt-Kg@mail.gmail.com>
In-Reply-To: <CAHk-=whbdpeeKbCYggJqfk0ExEPyxSW-yXSsNUqsGpd5ozt-Kg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 26 Mar 2022 14:53:16 -0600
Message-ID: <CAOUHufa8aDno3tSF3cuxCe2+FiuBG8gjBED=kAwY6PhkGfrkoQ@mail.gmail.com>
Subject: Re: [page-reclaim] Re: [GIT PULL] Multi-gen LRU for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Donald Carr <d@chaos-reins.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rik van Riel <riel@surriel.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Mar 26, 2022 at 2:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 25, 2022 at 6:16 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > No. I could ask Stephen to see if he is willing to take this series. I
> > was hoping to go through Andrew since his tree is what most MM
> > developers test. I haven't heard from Andrew, so I assume he has no
> > strong opinion and I don't want to put him in a different position.
>
> So I'd definitely want to see this in linux-next for a while, which
> implies it's not ready for this merge window.

Thanks for the clear instructions. Will follow them.
