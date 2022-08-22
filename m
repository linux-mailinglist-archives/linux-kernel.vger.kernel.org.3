Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E791559BCE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiHVJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiHVJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:33:26 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73892111A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:33:25 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-335624d1e26so276755677b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9R4smTUrTtix23hl1msdwJHbp39AGcuckFuYU8krxz0=;
        b=Vhe5DlOn73vTv+pl6O9HXPL4V7zdUqRVPETGHnfRntxfQVtDCPY5APeE5CidkUBSBW
         04W0ZabHynsQ5RGaE8KRWRYUS36OCfo+6s/InP5ShZwZW3Mwayad7MHRMIFcnXKQlhK5
         sVEshfoOAf7+S81uH0SRXKrA9611Zcefy55zJ1IAKp2todYVRoX7KvvvpIicu5EEnK3C
         sfvoOsZhpJ5MDRk9bteLnCC7aTUcfreqCKY6EJhJFAPN4UdLvX0MokVxnx2hORzjTw2b
         tIMu46zdt6rmNRD/RuF9SWXVlCbBd4HBc0DZqReob6KnkvaIETvlTH8gIymTrCKuiLmC
         vAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9R4smTUrTtix23hl1msdwJHbp39AGcuckFuYU8krxz0=;
        b=hqU9N7TeolQ0TBTzWkPREMVMKZsY++JizDB2wVnB53mCvJCMdlriGbDC3mZneRtdpj
         yD3P8NODlICEqRB4JBc8AWE8S6kf2FEtHiSoKmHruoMNLr2c/McLx3hYUF5APxzzJec+
         wlvag4afMaEMzmkNUTgUBUwh+m0oLdkf3ykMD/frESBhbzjJxq47/EilIuBQdgVbLXSq
         uxd2rwlPAhYgYYJVVnbaCXz2UGY/FNdVCGQanb267yrF95vYP/yJE7azF/Laexs7Gn0/
         BHBJ8YYA+vu1VTBzdvGYmkFxNoLUKmV54lYrR47FDeAf5hQUCFb5Cb9YC7vuc4Y16oFu
         OBwA==
X-Gm-Message-State: ACgBeo0pqpLtJcpcpgUgx8FGqShm1qxox0e1mj/wLEXPeLBdxESN/wnx
        2jD5oPPmrK1bC7r6T0RsZI+jXXvHJ99XyEBtMPnd/g==
X-Google-Smtp-Source: AA6agR6AqGVT05hXT86203WI/ugfWvFwTAZ/n75hbNxSyuqn/zFfpss2El6hX/Phvonwj/sZxZX4gPl7QKaajEr7v74=
X-Received: by 2002:a05:6902:2cb:b0:684:aebe:49ab with SMTP id
 w11-20020a05690202cb00b00684aebe49abmr18525186ybh.242.1661160804578; Mon, 22
 Aug 2022 02:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com> <20220815041803.17954-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220815041803.17954-7-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 Aug 2022 11:32:48 +0200
Message-ID: <CAG_fn=VnedgJL62cL2bvjsp1yrxc_ngbtRPoLXhY9JsJJhz+2w@mail.gmail.com>
Subject: Re: [PATCHv6 06/11] x86/mm: Provide arch_prctl() interface for LAM
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 6:15 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a couple of arch_prctl() handles:
>
>  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
>    of tag bits. It is rounded up to the nearest LAM mode that can
>    provide it. For now only LAM_U57 is supported, with 6 tag bits.
>
>  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
>    bits located in the address.
>
>  - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
>    Zero if LAM is not supported.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(with a nit, see below)

> +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> +{
> +       int ret = 0;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +               return -ENODEV;
> +
> +       mutex_lock(&mm->context.lock);
> +
> +       /* Already enabled? */
> +       if (mm->context.lam_cr3_mask) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
> +       if (!nr_bits) {
> +               ret = -EINVAL;
> +               goto out;
> +       } else if (nr_bits <= 6) {

Can you please make this 6 a #define?


> +                       return put_user(6, (unsigned long __user *)arg2);
... and use it at least here (could also express masks in terms of
this number, but maybe it's enough to just declare them in the same
header next to each other).
