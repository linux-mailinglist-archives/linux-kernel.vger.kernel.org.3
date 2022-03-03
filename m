Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9144CB507
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiCCCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiCCCjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:39:45 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23156574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:39:00 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g26so7344835ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 18:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVZxRuOCFhfG5UcNmUMrWY5dCexmZUcmM57vzOUtIzc=;
        b=GVGoVZQOnRHwG3P1PJBo4RsNL8GTz8cSKlk7KeWh3ORutP3ONhWSiWCJv/naf7dd1p
         Aj2ieYCAxIGIriKvQ7QxjqwIeznojcIS6o8j0DA0n/vGhnMUDtgtUyWL9aZhyuBUMyOL
         iRqrBthwmJvILGWjOj5oxXyz5L9rxeW1Br5WF7pFIr1MYvl2XfiLW9LY/MqQoDi57te6
         tmrtvYxRKD4DKzveOAX62nDZFsWngJajNYhwlvwJ4wqKF0WwkpPJrYM75nqyrFbWf030
         yygB8L5NdBLlxDXn6BjUHB51vASX1hIK91GUP/64hrJwqTP2VbEsKMCu5JHyYRxoacls
         dS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVZxRuOCFhfG5UcNmUMrWY5dCexmZUcmM57vzOUtIzc=;
        b=U+XeDkgZcbZSS92UNpJIh39CAKNBqXbxNqg1oJv4/PQ6/I27lglz4Lx87pRwnP4m4a
         vo8hKjbRoQi7P4gX4MUpj4JO+MfJotN9xCKc3nUVrrRJ6cKFij5rmguIN5T7K891dExI
         MCPdaxgxuEnTSy3fiVvjof5XV98HBge4CBVRzEY70C6fuOv5KuKBsDSbI2vuKq39krZn
         wMikVTqqkIjnyVo70PFmXeXKs7ElCntbQy9anPmoudSMtTdRKbFBlD//YH3h37KEBYqn
         mYfWWNmCZmt9hBqZyTlUxMTTwQm773ZBC8cGZNL/ZAmQARVWc0c4TT5r9zQXdVa7q0Me
         Wa+Q==
X-Gm-Message-State: AOAM533PCswk8DfcolutqHHYjWakMuqL3x57gQCwTmQH1CPsepct9/mt
        +rzHZWjt7w1Q85YVLsh8Ch2XVVvdf1fvgG95gyTqVg==
X-Google-Smtp-Source: ABdhPJyVo566mGN4RFWjXSz/157hchstvm+m2G3uKWYOLAaPNg1L1WKOChYGCOJPt2Oz/k7cF1IPbIHim9gAA2gjasQ=
X-Received: by 2002:a25:6b4a:0:b0:628:a387:6123 with SMTP id
 o10-20020a256b4a000000b00628a3876123mr5114625ybm.132.1646275140013; Wed, 02
 Mar 2022 18:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20220302083758.32528-2-songmuchun@bytedance.com> <Yh/f7YpP0Oc2Nkun@bombadil.infradead.org>
In-Reply-To: <Yh/f7YpP0Oc2Nkun@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Mar 2022 10:38:23 +0800
Message-ID: <CAMZfGtV2y1RpQpYCuZpNMXzOwOd5JmzknoYyZk1MaULcaZR+zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 5:21 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 04:37:56PM +0800, Muchun Song wrote:
> > If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is enabled and the size
> > of "struct page" is not power of two, we cannot optimize vmemmap pages
> > of HugeTLB pages. We should disable this feature in this case.
>
> The commit log does not describe what happens if this is left enabled in
> that case? Is this a fix? Why would it be a fix? Was something failing?
> How did you spot this issue? What are the consequences of not applying
> this patch?
>

If the size of "struct page" is not the power of two and this feature is
enabled, then the vmemmap pages of HugeTLB will be corrupted
after remapping (panic is about to happen in theory).  But this only
exists when !CONFIG_MEMCG && CONFIG_SLAB on x86_64.
However, it is not a conventional configuration nowadays.  So it is
not a real word issue, just the result of a code review.  But we cannot
prevent someone from configuring that combined configure.  OK,
this information should go to the commit log. Will update it.

Thanks.
