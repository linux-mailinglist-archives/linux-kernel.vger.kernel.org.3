Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444554D3EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiCJBTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiCJBTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:19:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28F41334
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:18:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 9so3491351pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4hEHK6Zf1OckbrcPAbGgRaFqGZN8ERpSZRldjSg7T8=;
        b=TyPdmdqiekZ/n9d4Ed7fThBKKvMOiRXpDBhk6CRTb1CCdBbZsdfWVidPWd8lkBIlQt
         Bi9+tIghX0iKpdES4tS2LA7m4erzVJERrwWD6sSCN5IWzYALAa4XtoXTRpIn8cCoVHTn
         anQ8wi6VRV9z2fMzamLvqbFJZzmhj4hNl9Ne/Sqxdk3cAVLWqGdjeH9b2/NthE0ZezPL
         GzCixCaNGxZ185gA/obGKTBeM6YkTPF1pKDOOEIDD7SKc6Oh6lQfaMJ1zAtm1AMZXv5Z
         eXXktCwVVJEvXH1+tpO/TlGMZvHQusQu2JgfeT8mnB6KSfzdHKQGoJTZWuhN1O2YUthN
         Huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4hEHK6Zf1OckbrcPAbGgRaFqGZN8ERpSZRldjSg7T8=;
        b=eOw/7ffFdmrKWnAcD3gf6PZ99Fe8hql1kMPln2QdFNVdUYJl+j/u15iRqclbhHWACA
         S3k7qQQiNFPT8YvQ0H/0jUKsdkU8sxYHWhrZrw6KaUd9fnnQ0rxUki3gtfXdZeERD6EI
         5OHmKWSMYzz2N41A5MRl4iyHAtqoqbpB9kJxIpo+H7P/wXXAKBiFNARFleFOoEJU+I5O
         VuS2ESY7/jvo3LawB2meY/d/knT9rdM0Pfj6PwIdeLX24AUv+gGBt8EmoPyI364lAapn
         9LDXwVWz4SWSuZJFOnabeOlIRz0+VZI7/JpQaAg9ayevYPg5xW3ra3uXD2cyVCvGkmVN
         5NDg==
X-Gm-Message-State: AOAM5326QQvzFVMsIbwQX0AqdNElEkbkirDm6bRDBmM4lkvtmNP4uaqp
        YZtBljPrAbviJPmsQPGa8qlWzBh+ztcD81brKl0=
X-Google-Smtp-Source: ABdhPJz9Ii4BygLhegpERqY0L1cI7YoixvVkAriv4MwFiwa2tw1+EVbTxcqMEPb5H+euWYwDgkEH8Zb8elfW4q2D2WU=
X-Received: by 2002:a17:90b:a41:b0:1bf:72b5:ae95 with SMTP id
 gw1-20020a17090b0a4100b001bf72b5ae95mr13350672pjb.110.1646875101000; Wed, 09
 Mar 2022 17:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20220309145052.219138-1-sxwjean@me.com> <20220309145052.219138-3-sxwjean@me.com>
 <YijHr+kkp2bPE1dA@casper.infradead.org>
In-Reply-To: <YijHr+kkp2bPE1dA@casper.infradead.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 10 Mar 2022 09:17:54 +0800
Message-ID: <CAEVVKH-an5XO7a3kVJ_fRhqAcMR-2TEnSd5mmWQPqHpnOduAZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: Delete useless parameter of alloc_slab_page()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
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

On Wed, Mar 9, 2022 at 11:29 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 09, 2022 at 10:50:52PM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The parameter @s is useless for alloc_slab_page(), let's delete it.
>
> Perhaps we could add a little more information here.
>
> It was added in 2014 by 5dfb41750992 ("sl[au]b: charge slabs to kmemcg
> explicitly").  The need for it was removed in 2020 by 1f3147b49d75
> ("mm: slub: call account_slab_page() after slab page initialization").

Ok. Will update.

>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thank you.

Regards,
Xiongwei
