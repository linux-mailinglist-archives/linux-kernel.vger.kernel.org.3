Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575EB4A63F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbiBASd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiBASd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:33:27 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCADC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:33:26 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q127so25417206ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgthoaOBpcV2t6u9HPTZYJsO7n2oWLRBDWbitx5G3AU=;
        b=O5IsEazrKevTZ+9eZBugHhs7ANQJxEM8AUW6YFDoeE2PNudszA/uxrffxfInnedLwI
         M0UYfOTaH0oP80QTrzssS+zDXKuxOGwqpLHqlOfTFGU5sjaCvhgXJhqx0uDWKgH2iKrw
         mn+TRgMOk+XrE9G1CN8kRjwddOmI/NcUrRooFj1gJ2Av8d+FGmYzEomveQinCIp7uPqx
         3HOdDc0h10+h1SFIhcQkC4K1jWitUM3/uP2r102mwhnTcILRh12UakJ2MwoSPiuqFFe/
         WqpHdBLgTLN0lfGrzF0RNRr6kblhKA46qTZkvBSVV2HBaxk4XoxifoUTJyKLaS/BrlzW
         w9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgthoaOBpcV2t6u9HPTZYJsO7n2oWLRBDWbitx5G3AU=;
        b=Krh3saQju+AnP1/hI2SJuleFnrvz/yIoqnBWLaAWsiMKLbcf1vTsfVNyFDyoWbXv+F
         /9jg9BqWR5/WzxvLuN4VPfsIHTXC1BPP5VQwh4N4siKwsUY1UEmJnYAEyqr0YZ+cK4Ce
         mET7L47ot10JK5RNMTaFTyKjUrrhbIvcnWj+aJuXYeE1NHN7+urk2NJgzBfiWbgvpa2O
         DBubL4J9HsuJSnUst914aeuGwM6dLB9MnZJnfniBpQPg3vbB8bwP7N9xItQG+seruoHJ
         joeVxVv9u8RQEbUtBYFjc6+UEUbtxoQg0iKtFOkwCkSQ8lG2fRm2hqT3EZr9RvF9RnSl
         S3LA==
X-Gm-Message-State: AOAM5323RiP4swyX4LTl8VTeDxYi06h6FptuH/vsCPctQLfTUwtPHp5L
        DhM1o92razsz8gCSu9tY9EJpL5I5Ya8YOlptx5XRdg==
X-Google-Smtp-Source: ABdhPJwvNpDFaASwpByfs886vMuUV37gkdaOVyA+sDmL3QJYH+2+Z/geU9fjEP0A3mS9mLE5VLeCWsSCnXX0Bk6cshs=
X-Received: by 2002:a05:651c:19ac:: with SMTP id bx44mr13432207ljb.459.1643740405002;
 Tue, 01 Feb 2022 10:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87zgnbn3pd.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87zgnbn3pd.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 19:32:58 +0100
Message-ID: <CAG48ez0uV87=myLX1X1KjQ_8q_Sgg1QZBG6vpdkGLWj==EAUBw@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Snapshot the vmas in do_coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:46 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Move the call of dump_vma_snapshot and kvfree(vma_meta) out of the
> individual coredump routines into do_coredump itself.  This makes
> the code less error prone and easier to maintain.
>
> Make the vma snapshot available to the coredump routines
> in struct coredump_params.  This makes it easier to
> change and update what is captures in the vma snapshot
> and will be needed for fixing fill_file_notes.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Jann Horn <jannh@google.com>

>         for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
>                         vma = next_vma(vma, gate_vma), i++) {
> -               struct core_vma_metadata *m = (*vma_meta) + i;
> +               struct core_vma_metadata *m = cprm->vma_meta + i;
>
>                 m->start = vma->vm_start;
>                 m->end = vma->vm_end;
>                 m->flags = vma->vm_flags;
>                 m->dump_size = vma_dump_size(vma, cprm->mm_flags);
>
> -               vma_data_size += m->dump_size;
> +               cprm->vma_data_size += m->dump_size;

FYI, this part is probably going to cause a merge conflict with the
fix https://www.ozlabs.org/~akpm/mmotm/broken-out/coredump-also-dump-first-pages-of-non-executable-elf-libraries.patch
in akpm's tree. I don't know what the right way to handle that is,
just thought I'd point it out.
