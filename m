Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4056663A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiGEJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGEJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:34:30 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A2C58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:34:29 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g4so20812911ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbjCIIZRFAcdBvLfPi5iF2p3VYDhCnQrzVDaJUoVTM4=;
        b=RhH2PLszUgxnEFXXD86z6eIkJx/6HbBcx8Mw6fSE5CxCcMXaSkNovGaWApF0ULztJ7
         CMO1+qBqGce9MTZYDCJt6hPsgMstY0LzVfCzmPqI5EeaNvT80XYxIPUpEaFjzCWI8Zjw
         eU74ru5DvLR+6lgNl/Kv1Wi/o6jANrj8Vd4AZJrek+Mz77TaGzbktMwTjIIVrGIKYL8c
         d/FT14+SO7gHeEoB0ZXJsX4OqwamnHRtChDQLOASPgzelVYLLt6fqJJKm4TkPUb/Odcn
         8kIsUhklcsmQq+QHdVf6nZkyPojxxlbG6cS0cNfoj1RBJ8IABKyxSSEupiKS/wsOcFoX
         Gqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbjCIIZRFAcdBvLfPi5iF2p3VYDhCnQrzVDaJUoVTM4=;
        b=qYUsS+Bf4Vvd+3F67REoYs8BoyetvCfwVChWChEF2U+1obtzXbkJnojp3l3TpSsU2k
         wPAO8eXAEkCc2jjCSyRugylJh+23/rAntavRbAI3PNP9KUo11YjUGfImv6bYzcqlRDgq
         bst24+Np24Zv9lP6UC8vSD/AaX/4EnHEqpL3Lg9pbEnrtNYIIMiK+qVpmbG4bvFvNL3R
         e4LTeiApJ7QkSELvXdedJBWNa9oYc8xBLwrdkI62NAbrCjmb5y+2vqWGOsFq37dFadlt
         1IeB7y8CT0/9KQyctKKx69e5rVIn7K794h0dZVME5Wo44t22kjTCWs/OO+zlqwSiyW+u
         ZE7g==
X-Gm-Message-State: AJIora9bbyKrEb+Oamyie5aV5e0kbEXQjuCqJA/CF+uJlnYShXuznLIr
        I0o6yjT7fj0thrlgaQQKTEEO2LQHEiHZmwxvXkT75g==
X-Google-Smtp-Source: AGRyM1vcGOE/K3oD9kNHAl/XfRl6E6W82L7YqglpxUUWS8N7Rzp0rRM748fQs3fYK1VaA34H+g4atVsZWEvF5XLeVhc=
X-Received: by 2002:a25:7455:0:b0:66e:2daf:8924 with SMTP id
 p82-20020a257455000000b0066e2daf8924mr16949698ybc.427.1657013668862; Tue, 05
 Jul 2022 02:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jul 2022 17:33:51 +0800
Message-ID: <CAMZfGtVcQHFF+MMDN2LL8XUpFVe05wjwjJ=foz4G=HwyBpcRWg@mail.gmail.com>
Subject: Re: [PATCH v3] mm, hugetlb: skip irrelevant nodes in show_free_areas()
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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

On Tue, Jul 5, 2022 at 5:21 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> show_free_areas() allows to filter out node specific data which is
> irrelevant to the allocation request. But hugetlb_show_meminfo() still
> shows hugetlb on all nodes, which is redundant and unnecessary.
>
> Use show_mem_node_skip() to skip irrelevant nodes. And replace
> hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
