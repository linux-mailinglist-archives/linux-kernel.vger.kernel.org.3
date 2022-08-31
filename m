Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29635A7B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiHaK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiHaK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:29:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A246B9F97
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:29:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-340f82c77baso187230187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JtUe231ScKnZZsv1scR1HDTAYqZvJhxRELB+mbC/erg=;
        b=mWhAoBVM0lwZyI1sH4kD3oX7WXZLDc+gi00olyO/QOzC0P684xrcgzgK6q/pjqoLHc
         Eks24hDrkJB/Bm0cKceUEOcyM/wq8BUZluENZJJvHTc7ugj5TrAMQkigt9vN/130vWyZ
         Sj/FmjGyCq38iBXtNDLB76Oba5SLylD5ocj7+x0BEpOwguzPjC0WQ2BXC3GDtJbEu8F9
         5471l4UlL6vZPWrCfBxHIIhl0EAhF+ZQgEHYA73mXUg1SrkMkJkqBUFf59ice3rI/qt+
         745AoSfcVN4ZJ0GHTQIgBdq5xgZlnm+m99Ek+whN7+UKSMAktpq6RVwNeArIlMrTFZFG
         0fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JtUe231ScKnZZsv1scR1HDTAYqZvJhxRELB+mbC/erg=;
        b=Hzaw5D02sMNf52Q8VxocHQiU64CNAeaino1F6S30WxXigPgr9Jnw/zz1DiG5IBE+HZ
         2ElKYRYvOkBboaIOBI3FKQHRE2KzQOq78jPW9Nt3/vJN5I3T+bCBW1Ht4sZOpWnNv1hB
         fijXvbpFR1Mz7a5enrBWxhvW8PFCliC/na5XXkzDHQ011Lq2c6nNcQeLLSdZEzY+b76z
         K/VJrSM+hf/GKqQrmHYDPAZp1w/FGDmWzDveMgxeM6kYhKS8nSh9CbtYjeoh0JRuZYEd
         1ls3Kqr5cqn2KuRCxIzCJAzcMjdMSMTVlRg+f1I/LlJIGYhC24ujw/MbLrI5Ybwh6RX9
         k5tg==
X-Gm-Message-State: ACgBeo2MRcoNVa5HFCxZDLhUw4tQxAmrxcLHbyOEH+34fwWLCJg0Wq9W
        rISclO08qTPRX1uWIsKE/jx7lXH9swfJiCrt6zo=
X-Google-Smtp-Source: AA6agR50wbmpClPpyJmIAU5A6Exa3YSSFc/iq/A6NBiwt8jVUSyIzpRlI6EGXrxDHzSOD3Qw6JIyvIYeFRbKK0XKAtU=
X-Received: by 2002:a0d:cc47:0:b0:340:cf17:9362 with SMTP id
 o68-20020a0dcc47000000b00340cf179362mr14990924ywd.127.1661941766239; Wed, 31
 Aug 2022 03:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv> <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
 <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com> <Yw83WQOgQf2yICaM@arm.com>
In-Reply-To: <Yw83WQOgQf2yICaM@arm.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 31 Aug 2022 19:29:15 +0900
Message-ID: <CAM7-yPQEF3PUH5ER7n1beSncEj=hJcE0Dk0JPZrxkh9-oHxt+Q@mail.gmail.com>
Subject: Re: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Baoquan He <bhe@redhat.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> To be even more precise, it should be:
>
> Cc: <stable@vger.kernel.org> # 5.19.x

Thanks! I'll fix it!


> Something happened to the whitespace here, so the patch can't be
> applied.

Sorry, I'll check and send again :). Thanks!

On Wed, Aug 31, 2022 at 7:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Aug 31, 2022 at 10:49:30AM +0900, Yun Levi wrote:
> > Like crashk_res, Calling crash_exclude_mem_range function with
> > crashk_low_res area would need extra crash_mem range too.
> >
> > Add one more extra cmem slot in case of crashk_low_res is used.
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> > Cc: stable@vger.kernel.org
>
> To be even more precise, it should be:
>
> Cc: <stable@vger.kernel.org> # 5.19.x
>
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/kernel/machine_kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c
> > b/arch/arm64/kernel/machine_kexec_file.c
> > index 889951291cc0..a11a6e14ba89 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
> >   u64 i;
> >   phys_addr_t start, end;
> >
> > - nr_ranges = 1; /* for exclusion of crashkernel region */
> > + nr_ranges = 2; /* for exclusion of crashkernel region */
> >   for_each_mem_range(i, &start, &end)
> >   nr_ranges++;
>
> Something happened to the whitespace here, so the patch can't be
> applied.
>
> --
> Catalin
