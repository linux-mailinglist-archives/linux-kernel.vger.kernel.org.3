Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D35259CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376576AbiEMCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbiEMCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:43:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECA6472A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:43:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ec42eae76bso76584917b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJATvbs+c7HdVifM63KtQYvZ8Mhm1JMx8gFzxnLPfQ0=;
        b=w9/GktHWvNwrINLYqPp9w9hNUejUyIa5qHfnfVLwxaOOk44qeqoo3ENWm3RynrCgFZ
         MAl/ThZ6aA4SC6GpYTVQjjqFNkNo+SOzvysMf/WqhvXpHG7yDBZN6038AQ+lJebKqjwK
         ogDA7opoOz+XatkWV8WN1Y01gl30/KaRnHi9lxRblMo74gW6x01F72tpUt5QFsQjkLTm
         wZuyq+2NGvEqgqg4Ebed5smbRd3caW2TJkWFdAtRxJfOZ6hrKIlCCIr6KY1ACFhMT7v7
         E3vU8Od8KEMQD0Rr25Big1tfrudAa33nV7SNutQgPxHrKvP+A13XEeVC25bN2/kdd6Ss
         k2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJATvbs+c7HdVifM63KtQYvZ8Mhm1JMx8gFzxnLPfQ0=;
        b=qXl3w4oK3g6yWLfBT8IZU0tCVmVnB+ZIz1s0k6BFlkbTg6Gemm3jyppJabgc76uVgc
         tci1UtZOmCQSzHX/oK6xCaHRItWJNfikWdx+AczyhNy/siYXnbCBWYT+M9pVCAhaZ+NP
         i4fAPgvVFySVF2OwNbMf+blceGmzgJXNLItmJor22GPxzlzo/kyAZ+wV7K6DaXTFbfWC
         AO7RzJlxolBntpLc6tdWIVKZ/Ur/qu+Ub75OvWMV4mfQnjNrUX23SQUGQz8ptK7kds3p
         SsGmrfU+HkuUJE/PcLtcO4UIruRa/oPQXef33aHYwM2J5G687o+moTiddFwHans9IvSZ
         AxWA==
X-Gm-Message-State: AOAM533IQqugQkrAiVRctUCcigEEyDbkD2z/6Y3ehXB1WRENVHroQmhv
        D++PzkUGUw7AyKU4s7fRalKqUwyHOl90KkWhGXPkvtCag8M0Ng==
X-Google-Smtp-Source: ABdhPJzhTU139A2t+p+5aLkdNUBjcKV3gOw/sLBbmWr5Pm6ZdcTkgjK00py7PagWVoak7TH1JrJQKiXvEDdatwz1mgk=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr3412927ywb.331.1652409822672; Thu, 12
 May 2022 19:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220512174551.81279-1-shy828301@gmail.com>
In-Reply-To: <20220512174551.81279-1-shy828301@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 13 May 2022 10:42:56 +0800
Message-ID: <CAMZfGtWTV1n+NGOur++25usy2U6BM1Vdjiid0EPCJQdWiYd9OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: rmap: use the correct parameter name for DEFINE_PAGE_VMA_WALK
To:     Yang Shi <shy828301@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 1:45 AM Yang Shi <shy828301@gmail.com> wrote:
>
> The parameter used by DEFINE_PAGE_VMA_WALK is _page not page, fix the
> parameter name.  It didn't cause any build error, it is probably because
> the only caller is write_protect_page() from ksm.c, which pass in page.
>
> Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks
