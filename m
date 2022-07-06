Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16B568B91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiGFOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:44:24 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62974252B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:44:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31bf3656517so141933857b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8nzXgal2msjMVDTnA8zsOLTUVP8huhCkUI38Q9wMik=;
        b=Pc9q9ysdte082azRicyZZICVd0daCGl7wh/AM/oxOaXyVEwzAhOcHZ+nii+IRPnHa3
         3tiS1tBa0ujmS7LwzFPmvKgX3wZUzpKZZJ3+0TQmjr7xnTLP9B3hv2WFBscXb/aytkCD
         wGSBFsQ3WMZRrrDrmKR7RHgXmzqiKlv2E4g3wg8Ixi5PlNXj74dbHmiKYpopa4xSZTQJ
         C/qntZB16I9WfaNOiLrOfkcrDHCn2hbehIUb9tz0VVjPT/W2tVJB7+YHMALlVWU0BawF
         BYmxQBJSERQdftDQrD5LrxhUuPzMF2/y6NtmgssZ7Hrh/Lm2i4WMFGTGmspY2+Z96V9N
         mc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8nzXgal2msjMVDTnA8zsOLTUVP8huhCkUI38Q9wMik=;
        b=HXuUu4WATkeVPMjn0HlyvwAkJse/w1CPkvdEUpjHFZG010ioTZryh2dG9v5a3H4rbe
         U1VV9XT5NPOVFaGcIqukEL4AU6ekNP1zrgpJUlI/v7ZrE+29HIUiPbZb+W179q0+JtIl
         5xT6whRxBt6d43ufpN9T1ycXm5vf2O8Ok8pGMcDgOcm+byU2XEPu6b1izFACT07Ux2Jc
         MlqPaKpQrClu03rAr+tm8IIxfSBgGnyDyWUSGRSXf3lcSnrxfzBYCKIbN0MDopO3tqvO
         8myxSMcqrswAf8BP6GU/LLj/kn1h2Q1730nMzrLBpOqPuyEAY7GEt+cCjM9ir8ZxHkjv
         v0ag==
X-Gm-Message-State: AJIora/6AEQuIdpqOaZqnathKGoreghVRhxviyhytOyfymnWoCCogzGf
        I7cL8AZ2doTDOxSpDN2xj0nMLV87ATLksOEEJYGSp7wG
X-Google-Smtp-Source: AGRyM1viPF79fBhh3sHU+fwkYIJzyOdYW+WrW4Kj3mFD7AgqhqC906Ryyu79zItn569gEBs9hCMYZZARlLvnwdjsOaU=
X-Received: by 2002:a81:5841:0:b0:31c:a7ed:85ee with SMTP id
 m62-20020a815841000000b0031ca7ed85eemr16906217ywb.215.1657118662439; Wed, 06
 Jul 2022 07:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220705113158.127600-1-patrick.wang.shcn@gmail.com> <20220705142000.4679acaaf1238a73a555ea58@linux-foundation.org>
In-Reply-To: <20220705142000.4679acaaf1238a73a555ea58@linux-foundation.org>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Wed, 6 Jul 2022 22:44:11 +0800
Message-ID: <CAGcnep_1QSdkNYqvgYC+ec2XVmqvG6rjZud-NfG22f_wQrJHKQ@mail.gmail.com>
Subject: Re: [PATCH] mm: percpu: use kmemleak_ignore_phys() instead of kmemleak_free()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
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

On Wed, Jul 6, 2022 at 5:20 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  5 Jul 2022 19:31:58 +0800 Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
>
> > Kmemleak recently added a rbtree to store the objects
> > allocted with physical address. Those objects can't be
> > freed with kmemleak_free(). Use kmemleak_ignore_phys()
> > instead of kmemleak_free() for those objects.
>
> Thanks.  What are the user-visible runtime effects of this?

According to the comments, percpu allocations are tracked
by kmemleak separately. Kmemleak_free() was used to avoid
the unnecessary tracking. If kmemleak_free() fails, those
objects would be scanned by kmemleak, which is unnecessary
but shouldn't lead to other effects.

I didn't observe any anomaly without this commit on riscv
and arm64.

>
> And are we able to identify a commit for the Fixes: line?

0c24e061196c (mm: kmemleak: add rbtree and store physical
address for objects allocated with PA)
Current in mm-stable.

Thanks,
Patrick
