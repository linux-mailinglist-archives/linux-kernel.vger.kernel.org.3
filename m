Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56325A92F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiIAJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiIAJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:18:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A2121431;
        Thu,  1 Sep 2022 02:18:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 72so16915617pfx.9;
        Thu, 01 Sep 2022 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=EHj+UQ7Tu6usfmBtBbDH78MoNwVO7qgjOcn++ecvlvY=;
        b=aMwYpy2KmhETBuSWfDOMI/KUwUdaiz66ylUoOKLq/yZ8fmJ+Ul7XISdXpYSPdOs5aZ
         hZtBfzrZqXVL7x14Wk9CnFzHh2iORZE3AZbAV2KF9NTQVMQ9Tq/p/uMR1sOCGRSFPQ66
         ZxgiRXFlzY376dnus4ZOMl/YJ6CvYDbuGf/ya2l4+ggklFsSC0Csoz5MNHaAIpsXzACZ
         F72/kjARU9SXz10euMoRn8wBl8jW+cmz05VTepLee1r5K7llYtEnoNJ4X/sBptiPyqUb
         ULchk4Bw0rjEzTOAKJ7oVVnRzfDmJhGmI8RAHAHgkISeioj2Zms3zL+ab3biVreZPpj7
         NCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=EHj+UQ7Tu6usfmBtBbDH78MoNwVO7qgjOcn++ecvlvY=;
        b=h7PjYcJ6i+uqbFxxsZN3oO9cHM7hoRHHtSYoeF4meKQvyeaZCFTnsKgcfBfzog/Vbk
         LG7WPLYgM91cmfB33wHZfyFY3MNKoxQYO7d3QbpaONr/S6tAjbJ6hhwGcbQsbcBVCWWm
         ODCVTTBnGAVn4ErvWtqNrfMCKAuCxAiPi7Ff+fz/p+VgrrMjikM7/01A1FCCOPFFbBff
         c2UbwfycjzxZvw/vmjcKuVnuGEQlUCI0UHfRLSX0SgVjZK6t50LvZ4rmVVOccEmTl1BI
         m6xo3/8qM3FMiXrA2RgIf88pkryrQi1cjDOQn57eEmHX8gLLMaXn5rGO8TI9CiUcXLMW
         qEHg==
X-Gm-Message-State: ACgBeo2paTpH31Dc8vv2GLtsUF7cvn1cJuw0nhvWbwtoEyh8nguHSnRM
        ldK751/gKvknrkEqWOoVj8I=
X-Google-Smtp-Source: AA6agR76OOzHcAQSPNDhPXO6cgJytqnQSy7k6ZWl7/3QSAmuwkzg82qYETdDuikHUMV5zDmsOuUM4g==
X-Received: by 2002:a05:6a00:850:b0:536:341b:99b7 with SMTP id q16-20020a056a00085000b00536341b99b7mr30073896pfk.47.1662023896175;
        Thu, 01 Sep 2022 02:18:16 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id bg8-20020a056a02010800b0042a5e8486a1sm4782830pgb.42.2022.09.01.02.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:18:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v14 07/14] mm: multi-gen LRU: exploit locality in rmap
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220815071332.627393-8-yuzhao@google.com>
Date:   Thu, 1 Sep 2022 02:18:10 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        page-reclaim@google.com, Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F7CF2A7-F671-4196-B8FD-F35E9556391B@gmail.com>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-8-yuzhao@google.com>
To:     Yu Zhao <yuzhao@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 15, 2022, at 12:13 AM, Yu Zhao <yuzhao@google.com> wrote:
>=20
> Searching the rmap for PTEs mapping each page on an LRU list (to test
> and clear the accessed bit) can be expensive because pages from
> different VMAs (PA space) are not cache friendly to the rmap (VA
> space). For workloads mostly using mapped pages, searching the rmap
> can incur the highest CPU cost in the reclaim path.

Impressive work. Sorry if my feedback is not timely.

Just one minor point for thought, that can be left for a later cleanup.

>=20
> +	for (i =3D 0, addr =3D start; addr !=3D end; i++, addr +=3D =
PAGE_SIZE) {
> +		unsigned long pfn;
> +
> +		pfn =3D get_pte_pfn(pte[i], pvmw->vma, addr);
> +		if (pfn =3D=3D -1)
> +			continue;
> +
> +		if (!pte_young(pte[i]))
> +			continue;
> +
> +		folio =3D get_pfn_folio(pfn, memcg, pgdat);
> +		if (!folio)
> +			continue;
> +
> +		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + =
i))
> +			continue;
> +

You have already checked that the PTE is old (not young), so this check
seems redundant. I do not see a way in which the access-bit can be =
cleared
since you hold the ptl. IOW, there is no need for the =E2=80=9Cif" and =
=E2=80=9Ccontinue".

Makes me also wonder whether having a separate ptep_clear_young() can
slightly help, since anyhow the access-bit is more of an estimation,
and having a separate ptep_clear_young() can enable optimizations.

On x86, for instance, if the PTE is dirty, we may be able to clear the
access-bit without an atomic operation, which should be faster.

