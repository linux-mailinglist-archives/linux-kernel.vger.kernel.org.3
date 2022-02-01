Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D870F4A6403
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiBASfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiBASfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:35:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFAC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:35:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z4so35742523lft.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nr6pfr8A3FnsPiDXPtirr2skdbzbz2tK8kJNlUysBkY=;
        b=QHacZhjK+Fp00RNIE2ceB9nwsvdfkDUuxTL3FTI8anO97N3zlh89jVYTdvBd/txElw
         hRCYJRTZnz0U0B4glYZ3kVNgGmbqJSmcnm9xcRZlPEDoJvVZDFmqKdPjj28QxLFWI7Oc
         EEYpBYtuicJ0kXHuuFvdiNNKd4io9yZ0Q4WgszqsUrG16BPJZdQA/NOss/Ouzf51suIT
         1YeAMIA4BvkaJ3sM7pKDWh609ffgAsE+cXfhlvlLUu0kqJNHkjk/t7GUnh8wT9gZfxKt
         9zqgfEygHf0Q6ZbMylfldD8IMXBHYQe34+j0gugiPQ4QbySHDcpQXZOERKXt8WUZyvNp
         r1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nr6pfr8A3FnsPiDXPtirr2skdbzbz2tK8kJNlUysBkY=;
        b=p4qQgG/2tNaUEmCyU4dIG5yhCGpZI1GW+FQ/CKScyR8VlyxdBJtcS6RmfBbkvA3z/8
         d06kOvPz7JJuvft98IPuCNnHDjxUeYdA3F8nPxn8GNC1co7jNWBTjOjrovxhHTrj//G0
         MKHhIKpND1sKwTJhLeYsPxASsWPlCuQ00Nq7aZzEFIUFWOdlEw+bwtheFcteVnmQvl9i
         vyMF0eDHoPx5IxDgUVy0hc+yycxwkNE/029thveuWiQakVjhf5Y8bgqRrM+hJfDjj4s3
         sNgi4rXVgcKlMAoe7Qen2T6Hgj56wLBDbWtKRvmC8AtQi3Nri6KwZ3A9CSJ2YlexSS8u
         3kwA==
X-Gm-Message-State: AOAM531TEIjAnMcOi7YUx/p8NUTXuCKU+VUcnechX2vd+lGaQ2DspsRL
        MBc1XgE5PAkE2WfK9ZgxGduOjc95TJdrafDDbk8nHA==
X-Google-Smtp-Source: ABdhPJyAYi19CYUwKC8npzOgD/p6q3a1QworJ5jjPe8fVFfn1ObwC/pYojTe1W5g5w3xGvlv135+L6M+QjyA3pqA2oI=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr20022304lfb.288.1643740538778;
 Tue, 01 Feb 2022 10:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 19:35:12 +0100
Message-ID: <CAG48ez1O2Nt2eiJ6ZbV8q+XSsg+Co4GhdaLxi-aNF4PRm5R+mg@mail.gmail.com>
Subject: Re: [PATCH 3/5] coredump: Remove the WARN_ON in dump_vma_snapshot
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
> The condition is impossible and to the best of my knowledge has never
> triggered.
>
> We are in deep trouble if that conditions happens and we walk past
> the end of our allocated array.
>
> So delete the WARN_ON and the code that makes it look like the kernel
> can handle the case of walking past the end of it's vma_meta array.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Jann Horn <jannh@google.com>
