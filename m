Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838B549997
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbiFMROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiFMROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:14:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5B562DF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:20:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 184so5353673pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z0oEkfDVJe+HvF3K4yQj+I/I4I4F1ajdtFNjkCqfrE4=;
        b=HvvYkH2n5qn/QCZLJcg/jHbtZWu7OazLAFjOfxK5ql3Y9+4zNyt6n9R8RkcuMy2ClU
         RJdk8sFbawmM3HQB/1tzN7aST+J6ldbAU0Xg1Oq5UcLgdxxern83DakfCeF7MXKyiJCQ
         TqxapXtnyHBTqAIqYrk3KzyKJHszezFcombmWN9OKTTpPyV9Z4Ee5F40vGyzj2fFxsWV
         N2Nv11kjMdymUzUg6yk041oz7xEpSAoYWEh4tKccm5tP+ymXZ0nUemtu2Br6ykn7zMkt
         Xo9wFWSOYLocpAN6ScJO1bRK8uZ4H8u74/UsIXHXtRTtdKfJX3aR8EkiDCW27bhyxcpJ
         9zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0oEkfDVJe+HvF3K4yQj+I/I4I4F1ajdtFNjkCqfrE4=;
        b=i93erp1UrngJE4rS+fVaWg1jjFbgXTm30lKgcGi+s1rpZ4h++nqZwDHzkeOEHfAz0V
         B7L6Qzbv8Mvxk8YfJEKKn6H+bZ9qbtAVj7bEpebx72rAa0MoU/HFsdFgN7/E03FtbnB2
         Yv4iXudK6vLlmC7OIhKxptIu6onQHUYrdEY6bL7QqLNYUJJxKJeFUB96aJQx8tfQX7Hx
         0I3oMny5FAujnJFZVroRRK1eNf9u95ZT1sGJHpU6EAL4qStYG2ZCAxD5xfVnQ5S3NlOP
         KZIJjQFZKXrCKkdpCnO8F5pdrvExbIcNrO1RtdX9dTguSRWjxJL+DhhdRiNLpuFb6mIB
         q09w==
X-Gm-Message-State: AOAM5302/Ev/qqhE2Jp/BPZ03K25Lz1719hdGZuA7bsH/eLUdO1RS9jP
        40QYU/23SUZbjTzfQVUeueTf0w==
X-Google-Smtp-Source: ABdhPJzvjve4xAnVW/ZwpbBTzlF6lkZU8LuA+bcz0387m1+Rf+OnvgQ2HZdlwb6VqKgpLYWwS8Na6Q==
X-Received: by 2002:a63:9c4:0:b0:401:a7b6:ad18 with SMTP id 187-20020a6309c4000000b00401a7b6ad18mr18250278pgj.523.1655122817456;
        Mon, 13 Jun 2022 05:20:17 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902820400b00163fbb1eec5sm4944428pln.229.2022.06.13.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:20:16 -0700 (PDT)
Date:   Mon, 13 Jun 2022 20:20:13 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 1/3] mm: rename kernel_init_free_pages to
 kernel_init_pages
Message-ID: <YqcrfaaImHWEYuRK@FVFYT0MHHV2J.usts.net>
References: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:18:45PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Rename kernel_init_free_pages() to kernel_init_pages(). This function is
> not only used for free pages but also for pages that were just allocated.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
