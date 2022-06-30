Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48847561743
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiF3KHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiF3KHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:07:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32844766
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:07:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id d5so32850130yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qjowXr8FmmxW1YnHvodXNxSOREMog+Yqbage1/jxe5M=;
        b=I9WBPRsp8kqwqS7SBBYwaQv2ztdCtDUKXzvF8cVYP2Txy8SVDjmsDnqKrQJCS+f1W2
         awsGSyc1BX4FwbaEiVzwMcVO+vipdtzlaChuM8aCtA6OVch5bRuKTZQ4sNgG5rQDX47E
         ksBx+2+3FgItcGaUgVwZUeQpisGFbCsCwvSOz6L1CIqWWDe36QqGG0nsmOTIuiNrO/1O
         qkNjODV94yHX3hMdpIn5UqKL6k67gUE37H0WjnXreLA1BpYMA3RDduhXCceaida2mKcE
         yUuRd8v+vfFDMCQn3FbzzsEttJ6e9TShv+jvlOfx8CzCGL1BMEz54iGopdNYOjr9ERyx
         dG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjowXr8FmmxW1YnHvodXNxSOREMog+Yqbage1/jxe5M=;
        b=SJCt2rbtsA2QVNVIRGeHernjAVleFnWKRa91ofuXM6jtFc3Wvu2r5FtK8kkPefGRGD
         oyB1DwGOhKcSe+iiYxkQPjVCCkckRWEpGnHg3zduEwwSIOUInMqPq7HSP/4WUwu40w0i
         qf811YfyDqOXYJHYIXZyVhKntqlgwR1zfKZ+gcZU8RFlWHgtIzv3Zlb0ubAxf2XsYbtv
         VWGXrDMEZxRtMdlBypYBddVu8eU98Dn5uoY/dbjKX8F5kP1GqXM04e3ikd1xPiSGsyhO
         5p+N+gIClx96ydqSqgoAXTP+0UkEW7ufNHdhFZRpxvVPoUOYfBE4PexTOPuEuzAEfpdI
         8pLg==
X-Gm-Message-State: AJIora+5zPDE0SGq6wKLp1irAsq1qwlkTMziv4EAPEVZgQ+VXHmoH4ER
        qMS5lpmXviS9gYRfrTKPCGgjyuPVnxCLUqAYS6Rviw==
X-Google-Smtp-Source: AGRyM1twU0WutAfZsPOOJC9VQ8DBawe3+rdE96PV6vmTf1cfwDTwN9yJQZRwG/ZDgrdEzI36JvfSzEj398hs15f8D8I=
X-Received: by 2002:a25:9388:0:b0:66d:1fd9:6f73 with SMTP id
 a8-20020a259388000000b0066d1fd96f73mr8206505ybm.147.1656583643894; Thu, 30
 Jun 2022 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com> <20220622162230.83474-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220622162230.83474-9-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Jun 2022 12:06:47 +0200
Message-ID: <CAG_fn=VFOFjYmT5o3jLe+qKo4A1qp8N0=USeyzbb-hcdYChK6Q@mail.gmail.com>
Subject: Re: [PATCHv4 OPTIONAL 8/8] x86/mm: Extend LAM to support to LAM_U48
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 22, 2022 at 6:23 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> LAM_U48 allows to encode 15 bits of tags into address.
>
> LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> userspace to use full address space on 5-level paging machine.
>
> Make these features mutually exclusive: whichever gets enabled first
> blocks the other one.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


> @@ -206,11 +209,15 @@ const char *arch_vma_name(struct vm_area_struct *vm=
a)
>   * the failure of such a fixed mapping request, so the restriction is no=
t
>   * applied.
>   */
> -bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
> +bool mmap_address_hint_valid(struct mm_struct *mm,
> +                            unsigned long addr, unsigned long len)
Please make sure to reflect the newly added parameter in the doc comment.
This may also apply to other patches in the series.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
