Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A354FA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382817AbiFQP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382720AbiFQP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:26:45 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E42CDFD;
        Fri, 17 Jun 2022 08:26:44 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id cu16so6304141qvb.7;
        Fri, 17 Jun 2022 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxeOkeINDpzy3OEEqm+X2I0MEyWZgikOx3MDeUuxZIA=;
        b=x352egzjQ+bgWBPvIOmHwrWHqtJYzKs6aPO2F8bLrEH9JwpqkX/8NsU9XVQkI5fKwV
         6ltnZCkL9bPTM/vaZYzpAuRgmNkrTuwem4mmLvu42R49EykYrgqHQDfD4WdKzop+Db51
         xuYOVSO3jIMn16mYfmHh/GrkHReTvLUcD9zrC5hTqBVwG40E4ykj2L0gOQlsS7J+rzoj
         1D/hAzkZ7UfSBzFb223OuZgruktaAftR32nSZwts7o4Wsccqp6B4ey5E5RbKdI/n/1rl
         CTXDLH4J1RuCSY1/ysET+h5VPadAiCXvXei41bhvjpiumn4BmftMo0pVAQ6E8ajug0lt
         Va4g==
X-Gm-Message-State: AJIora/bHuAycwqoF7x7xcQ4vk/j3wsHR06DlCn9FXbTEyhjtOztZEsh
        +s9zIUbqnxtCQbIoY2J9QJQiM/dZuJC8cQ==
X-Google-Smtp-Source: AGRyM1sIcwLrFMLBTl9Zjr0d8MQNxHkWGqCz9qYTJ1djfdjakA8ISv2WHTFx3VpDrDScxXOd1IppdA==
X-Received: by 2002:ac8:5d93:0:b0:305:2b38:af70 with SMTP id d19-20020ac85d93000000b003052b38af70mr8952987qtx.383.1655479604039;
        Fri, 17 Jun 2022 08:26:44 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v63-20020a372f42000000b006a6a5d1e240sm4298333qkh.34.2022.06.17.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 08:26:43 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id k2so7838468ybj.3;
        Fri, 17 Jun 2022 08:26:42 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr11481017ybb.202.1655479602392; Fri, 17
 Jun 2022 08:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-2-mike.kravetz@oracle.com> <YqyMhmAjrQ4C+EyA@xz-m1.local>
In-Reply-To: <YqyMhmAjrQ4C+EyA@xz-m1.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jun 2022 17:26:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-qdNMqwtpm+PMixKoicYHPokAQqWAh-Vw-sjZz_z7xA@mail.gmail.com>
Message-ID: <CAMuHMdU-qdNMqwtpm+PMixKoicYHPokAQqWAh-Vw-sjZz_z7xA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not present
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jun 17, 2022 at 4:22 PM Peter Xu <peterx@redhat.com> wrote:
> On Thu, Jun 16, 2022 at 02:05:15PM -0700, Mike Kravetz wrote:
> > @@ -6877,6 +6896,39 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >       return (pte_t *)pmd;
> >  }
> >
> > +/*
> > + * Return a mask that can be used to update an address to the last huge
> > + * page in a page table page mapping size.  Used to skip non-present
> > + * page table entries when linearly scanning address ranges.  Architectures
> > + * with unique huge page to page table relationships can define their own
> > + * version of this routine.
> > + */
> > +unsigned long hugetlb_mask_last_page(struct hstate *h)
> > +{
> > +     unsigned long hp_size = huge_page_size(h);
> > +
> > +     switch (hp_size) {
> > +     case P4D_SIZE:
> > +             return PGDIR_SIZE - P4D_SIZE;
> > +     case PUD_SIZE:
> > +             return P4D_SIZE - PUD_SIZE;
> > +     case PMD_SIZE:
> > +             return PUD_SIZE - PMD_SIZE;
> > +     default:
>
> Should we add a WARN_ON_ONCE() if it should never trigger?

And with panic_on_warn, it'll panic only once ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
