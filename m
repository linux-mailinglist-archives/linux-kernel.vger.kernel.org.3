Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D614CF25C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiCGHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:03:47 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5F54F89
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:02:53 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2dbc48104beso152752217b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geOY0BIdj9dQeQr7DqDH3p1hC5fsVdyguZbly+zPwEA=;
        b=eoKBFkv0FaSw/htLzF49O05SJL61SrM2q6muI4X/eTCvVopJwjVnZy/U6ieybXM2yS
         cgAubMZzSziznc4i6TrZSbZq1vhhRi6NyTLgn3s7NGmMRDqE5jyuYrxleF1bz2UuxhTA
         zxwnLHHecgF/150OvTd6MONyyWMGYOJEw8wnXC/daertskkGHEqorUfOlHxri3ZQhmkI
         bc2oDsJpzKVkBRkJU1YBKjncfbAcEKguvIUs6mnQNUWSUzRQySaOy64Mx7JGC0egtyQ7
         Rg13CPlGODHwEJQJWa61iHITNjjMtMWPbXbNCHj1B3HLezJlqw1HDGPhn9yjMGaGQ/OV
         AHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geOY0BIdj9dQeQr7DqDH3p1hC5fsVdyguZbly+zPwEA=;
        b=hMnR8/inTroGRsiSbVYtoBYtzVMF3Am2DqpL6SAzKUJk6AKql8YBnVPEkwTuFmS6K7
         mqKJQqz4UcW5jXH8htmxr2RfcA6ZTmwxvlj6FR2cNlPi2Pwzdg76txv43lMim4XjC5ZY
         f8k8A8O+c4YAmISZK8vgt6GuepXHMs13V49/rc2V7txuFK7lufFV/GJaEPnXRCtS7ayZ
         cmHzfDIIam3SObGIk+NOd3KRh1jFYr4EGGNZd4RB9FsgUYTWrC+61LkIvIrh1fSyM3xh
         RP93VY61l9kB8Iz7mp/b9WhJNov2aNscA/t69ugWy2Lo3aIuxKFLBDrZIK9QRtSIS7RO
         fpiA==
X-Gm-Message-State: AOAM5320m0uhB1cHAlg/pRwloiYjhuhvCmVHP7t3BgIKK49y3BTFa9Kf
        O3V1jOBtAnDuvKEgYO3YXLgFzWR8xZAdbyoUgqgfiw==
X-Google-Smtp-Source: ABdhPJyY0qfIRpVo0WQFwnKf7xkXXwTlFOCupODWGFK0/ryR8UoK13fwckAiCay7cW3UMCqPiVTVg510FSrE7UVS4f4=
X-Received: by 2002:a0d:cec2:0:b0:2dc:a4d3:4528 with SMTP id
 q185-20020a0dcec2000000b002dca4d34528mr5361083ywd.35.1646636572768; Sun, 06
 Mar 2022 23:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20220304093409.25829-1-linmiaohe@huawei.com> <20220304093409.25829-16-linmiaohe@huawei.com>
 <875yoq5od4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875yoq5od4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Mar 2022 15:01:12 +0800
Message-ID: <CAMZfGtXKa73ZVLtJeE5O40rOgn7oZkxP5CB+q5t--ihUerfKew@mail.gmail.com>
Subject: Re: [PATCH 15/16] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        riel@redhat.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 1:22 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Miaohe Lin <linmiaohe@huawei.com> writes:
>
> > When follow_page peeks a page, the page could be reclaimed under heavy
> > memory pressure
>
> I don't think that memory pressure and reclaiming will be an issue.

I think he means a page first to be reclaimed then to be offline
could encounter this issue and reclaiming is a precondition.

Thanks.

>
> > and thus be offlined while it's still being used by the
> > do_pages_stat_array().
>
> "offline" seems a possible problem.
