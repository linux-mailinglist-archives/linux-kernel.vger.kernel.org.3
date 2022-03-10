Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58414D3E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiCJBDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCJBDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:03:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654F11B5F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:02:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n18so788028plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhfcqA5j4A8+cMHFR/NtiJjgNVB+qOjhOgFLJgToPWQ=;
        b=NdlCgpyR4b6VJWwPwqOC1MX6c6jvcptN0j9px6P5gSJixNo6VOfOmyZRxxRxE+VcE+
         3nEGij+QWTIieZfJjhT4HEQ3r8HlS19ooIBYayhvUymBhIQ9hyFgxtJgI8pCRkAg+1pQ
         wZsyJA2tqg/k12oz9Zx1hzeXs53PX/Kj85fAbo2oA10eW2hvyuDPgEUBhgXI6pkk7Y4r
         4/vjzDmA4LTjsDjSdL3djqJkFB/CcFZI7eYmB7zcVbZW/JYEKjHk2esCGc2dbDEPdE6T
         FFVi6RCbUv4X+dMgyidWvaHx1H1e/ThhA9xh9EmPmn8MxL3p8c6rsvYdZ7ZqiLAGwoMG
         82mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhfcqA5j4A8+cMHFR/NtiJjgNVB+qOjhOgFLJgToPWQ=;
        b=nb/9nXz9fHxEWZhAC5dmvXKpS6013QhvKbVStEnndsbyoUkKXpDJjMIUpBf2pU8cZL
         b4wu65q55300wKKpCTYcofpJDlKFrEoBDk0DreiUDzkZdth30NT9KwvMWWPDSK+gaWuX
         DQvyaeXeQ8lMxHUlGW2lrcuuJqV8xc0IaItrl4Ofmkr1G85VZCWbartNZf21r1HSAKPO
         G3DN7DtyHmMXsIMVa8kLAXksfcmIO4UNxzET4M0DNeBrQlN+gsd9TVV9QbpQrrn+J3sd
         1GsGtvROJsE8GtzHb2YFowpyHzohM/JNf9bg2joTyGTwe9kvXjUmyEaYMyekjUC4+e90
         x4CQ==
X-Gm-Message-State: AOAM531LsfKyvEgVHDz3+nQVaVRmkCbmsPSnRsy/8GEZCOMQ1GWcTHNw
        hIruix+8LpJHBWSrYcE0su1RnJAJmvsi5JLbIf15fQ==
X-Google-Smtp-Source: ABdhPJwgZUATGKxceYX9Kl5KUvMdd8JlCChq4tHFBS02sVXYJrllv/gFImd7TLQzyeaZBA7iP0auoWsyQWoxXaoDMk0=
X-Received: by 2002:a17:902:d506:b0:151:ced2:3cf with SMTP id
 b6-20020a170902d50600b00151ced203cfmr2284734plg.147.1646874136625; Wed, 09
 Mar 2022 17:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com> <20220302082718.32268-7-songmuchun@bytedance.com>
In-Reply-To: <20220302082718.32268-7-songmuchun@bytedance.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 17:02:05 -0800
Message-ID: <CAPcyv4gnzDMWgzw9xW6PLRvDgw18RL35NtWsKYRV391SRWSuQg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: remove range parameter from follow_invalidate_pte()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:30 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The only user (DAX) of range parameter of follow_invalidate_pte()
> is gone, it safe to remove the range paramter and make it static
> to simlify the code.
>

Looks good, I suspect this savings is still valid if the "just use
page_mkclean_one" directly feedback is workable.

Otherwise you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
