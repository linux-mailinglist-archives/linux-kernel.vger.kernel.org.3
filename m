Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EF4D3EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiCJBTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiCJBTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:19:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBAB4AE20
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:18:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e3so3719289pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3b2mjjq1mHcjmOgIT8uYofnDUrYP6rBEFBC8nbAEVo=;
        b=e/w5dQf3sCiBt2/uT4NupMc7nhScIOA1t7tI7nc+VMK+agjcXmz2nb62a8/EvbhIFh
         RWavHFDvn8WwY33us47MxG5HLusoAJHKGDhLJEKQKzrKSdF7aCPVhnd4xI5fn4acZNAH
         YA0O9CL5ytnYfCzTLFg11EqTQS1GG9HnIfBaeYIECcGYzFNw5Qg/dr7jwoTQIc8HqYcU
         31es6Fog5L2tr7jl9ohuvHs9GyDXke3XNqu0/M0ypMT0zy5KiMWTVuVcA5lgREyI2Z61
         JQHwZ2IJwoiv+ZTwnFZQLTzWzNGRnAbxhS/s30rn8ERv8ppSPYS16KX5C0RVJNnwoDea
         CsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3b2mjjq1mHcjmOgIT8uYofnDUrYP6rBEFBC8nbAEVo=;
        b=H3NniBkUR1YCrln182V3j7giAMO6JrUBe+hpC4BCFiolayz1xxPo8VMJPSVHFRP+tm
         6C6Xe1mw/Ge9qNEuG+Dy25F6cNsrWUjCIu4kUmlQQdXeW63NGlXYU+8bPK3FaBBV4kQH
         1cHZmZUPppYLnYRiKX4y3IxeoApU5aXceUt2JxUteiVlRHdQhSEiSFzjk4k/efiQTMSj
         RPALmfn4A7H8UfvKOxg3R5G7ZLbPdfuJeIQlWKKVoVCh42DSE47i6JK2PpI7zKwD2hya
         YE9XNCgAi7leBH6awRC+Aghzk7l6yoPIDiKM1y8uhhLFyYBkoJXOf2e3nSm3RjF9CIS1
         O+UA==
X-Gm-Message-State: AOAM531LQOzRL10h6tukgVnvaA5/URps0psMHbSTXL19kGzRaE7NgVho
        gk5PsaufUaAajaX9KKg2DDzONqYqKVL8mTd91jw=
X-Google-Smtp-Source: ABdhPJz4iTGal0kDNh/jp1SKXcjW6M3pQjsU6lksmYnVKrpJfbMk6adEP9gHkfkQm55robBYlwj+Hz/O4lxDQXWulho=
X-Received: by 2002:a17:903:1d1:b0:151:9e73:61b1 with SMTP id
 e17-20020a17090301d100b001519e7361b1mr2378719plh.84.1646875127921; Wed, 09
 Mar 2022 17:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20220309145052.219138-1-sxwjean@me.com> <20220309145052.219138-3-sxwjean@me.com>
 <YijHr+kkp2bPE1dA@casper.infradead.org> <7c116655-a4ce-5f61-2d98-e85c31e11184@google.com>
In-Reply-To: <7c116655-a4ce-5f61-2d98-e85c31e11184@google.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 10 Mar 2022 09:18:21 +0800
Message-ID: <CAEVVKH-YbqE_dicLvFG8py0W6tFVEiFwsx_OUcnbv=u4ASkEUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: Delete useless parameter of alloc_slab_page()
To:     David Rientjes <rientjes@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <sxwjean@me.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, longman@redhat.com,
        guro@fb.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 1:15 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 9 Mar 2022, Matthew Wilcox wrote:
>
> > On Wed, Mar 09, 2022 at 10:50:52PM +0800, sxwjean@me.com wrote:
> > > From: Xiongwei Song <sxwjean@gmail.com>
> > >
> > > The parameter @s is useless for alloc_slab_page(), let's delete it.
> >
> > Perhaps we could add a little more information here.
> >
> > It was added in 2014 by 5dfb41750992 ("sl[au]b: charge slabs to kmemcg
> > explicitly").  The need for it was removed in 2020 by 1f3147b49d75
> > ("mm: slub: call account_slab_page() after slab page initialization").
> >
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you!
