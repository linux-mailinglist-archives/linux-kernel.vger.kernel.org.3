Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF984DE769
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiCSKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiCSKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:16:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925C1AFE85;
        Sat, 19 Mar 2022 03:14:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2e5969bdf31so112725737b3.8;
        Sat, 19 Mar 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D28RjDg0IIqsedMZiUTeTKR3AfquY6OXe4oxRWEJ2lM=;
        b=QGQCc9TMOPGLYL8s5mQbPX8X6J7/it2KQjPcOjm3W5A1X1wJr6lt11KRnCf4khbnPl
         W2RcZ1hTzC0lFofJf2N+HyT4A7715ZrFGsRd56ADXzkC3mhgR7xZnjiA3S2PAZWzvBce
         qBmrgRjYbV9Dtz+p9VxWq9DdvNe6r9L9KXnUadtwjQVEKqLGS11ox028JAQFMOdTw565
         FlvhTZoXpMFJqyUdZrzDxHYYlm1uVq3o96a4onOm9BKYZQL5CHmFBL0Jp2d3C0CS50Y0
         g8bnLQyCo8c+aEC/PMDcUVDE7TBkNK+sQNi+sAsrUAIkE+DGWpvx8M1hz0wgTf8lfoof
         shnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D28RjDg0IIqsedMZiUTeTKR3AfquY6OXe4oxRWEJ2lM=;
        b=ygxETty/QsU3MaaYwNOOH0Poh2Rg04q583+t63/K0ziJtBRceXblXbRUKNS9yDCVnm
         apLPoS1GLwEZAIUWIByHCO/Ax/Kptek7wc88MXh+xidJL9PK5VGeHFibAqmLA04+QJcQ
         D/KpHhQPDT1HfDDxrinnCB7UvlHR5n6W5e//LBVBMD817HlmZcTOo4BCfaEWCS9PFDDb
         wHsK8iL3ufyK6uDjCIvIv/bRTkV1nPZhCTWdUvagC6TwhI64WjmyElvORZp6u2vfok7E
         +5ZCkxD48EYRHxrVaUrSIUvSd8qSQ+1BbDQVD6ukBhhrVj6MVHDQlaq5zUtrPmQbbON/
         J+Cw==
X-Gm-Message-State: AOAM533xxhePWa/X2hCnAcq/he0hxAG2UP4zI0fOFNmGlakIH2jXMX58
        9zlHGThUA+3dIuYVbEYJPFR0HdO4RwWI8/me7oA=
X-Google-Smtp-Source: ABdhPJzJrX2B/OXlsxOEw1tdhFyFNMg00bXB1Jc7YkruqljBL7SBfoUlpJXYokrcB+ueqDcCLkyF1DinAmFTH/odJx8=
X-Received: by 2002:a81:944:0:b0:2e5:e5cb:a04a with SMTP id
 65-20020a810944000000b002e5e5cba04amr5799603ywj.406.1647684895529; Sat, 19
 Mar 2022 03:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 19 Mar 2022 23:14:45 +1300
Message-ID: <CAGsJ_4wW-SUPZ+soz5L+TROcmWtiYoABMcYzNyw4p=f2ro9vLQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void inc_max_seq(struct lruvec *lruvec, unsigned long max_seq)
> +{
> +       int prev, next;
> +       int type, zone;
> +       struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
> +
> +       spin_lock_irq(&lruvec->lru_lock);
> +
> +       VM_BUG_ON(!seq_is_valid(lruvec));
> +
> +       if (max_seq !=3D lrugen->max_seq)
> +               goto unlock;
> +
> +       inc_min_seq(lruvec);
> +
> +       /* update the active/inactive LRU sizes for compatibility */
> +       prev =3D lru_gen_from_seq(lrugen->max_seq - 1);
> +       next =3D lru_gen_from_seq(lrugen->max_seq + 1);
> +
> +       for (type =3D 0; type < ANON_AND_FILE; type++) {
> +               for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> +                       enum lru_list lru =3D type * LRU_INACTIVE_FILE;
> +                       long delta =3D lrugen->nr_pages[prev][type][zone]=
 -
> +                                    lrugen->nr_pages[next][type][zone];

this is confusing to me. does lrugen->nr_pages[next][type][zone] have a
chance to be none-zero even before max_seq is increased? some pages
can be in the next generation before the generation is born?

isn't it a bug if(lrugen->nr_pages[next][type][zone] > 0)? shouldn't it be=
=EF=BC=9F

delta =3D lrugen->nr_pages[prev][type][zone]=EF=BC=9B

> +
> +                       if (!delta)
> +                               continue;
> +
> +                       __update_lru_size(lruvec, lru, zone, delta);
> +                       __update_lru_size(lruvec, lru + LRU_ACTIVE, zone,=
 -delta);
> +               }
> +       }
> +
> +       for (type =3D 0; type < ANON_AND_FILE; type++)
> +               reset_ctrl_pos(lruvec, type, false);
> +
> +       /* make sure preceding modifications appear */
> +       smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
> +unlock:
> +       spin_unlock_irq(&lruvec->lru_lock);
> +}

Thanks
Barry
