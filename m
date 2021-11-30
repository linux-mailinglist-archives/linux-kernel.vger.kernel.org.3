Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF846405A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhK3Vmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344253AbhK3Vma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E377C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:39:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t34so21753158qtc.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmjlNfIqFHjkoSqyGG2+jA20pUXVqvYW14ZXL9GlJYg=;
        b=oOrVlIwlmBC0xoMqFv6bWncerV6dmDBOzYaa88gA4TFUeV/QBXS7GcHrsWcuJJig7w
         IjrhYvYIiD3MqHo/F42pGow78IbBM2u6sPm1fp43ho7sY8nXegS60XGzj2Hx73GcJDuj
         reVB3/t3rqlxqAl3UkHO5XTZtOH5meSprObq6rC2qOmFtorFVMk/YxKybgkbbQREtRe/
         YthKDu+mQWkytGDVn4qP3ZoN1TMIFxB8EC66pRUh3ta9tTTHafAsyuXgeBCk19ly6jZZ
         NwQHkqrfi2y1A+lad7vp6JwezlobQucgNkZNUA1niI5ve+B7Usmzyt/0QQyf9UbbgoPu
         KTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmjlNfIqFHjkoSqyGG2+jA20pUXVqvYW14ZXL9GlJYg=;
        b=iOmuXr+yblxKcN8fIt8hzvNM8TWlZlmRKQRw0fLuf9s4LXP2BmAVMFc/n7F29BaUma
         ibonPaTv9AS5/0gztlyT6qsztrR3L1Ueab6KdH3Sh/0elV3gk1oHmSkpRxQARrbKmVrs
         X70wkdCSRQCqX7QymNlc9UodQZMMv4qlFR1NPY15YAzqpqQnfQ6ce+OJJo5eYqhAo1gv
         l6vbtlYh0smZbmcD5gG0APT69y38H7jDHGp0msg/5T1mRqMI4sOjOiQA5TG361k3/96K
         9MpXQkImPudb41QDz2kMsGvGuEd6HBVFLh9uWUvk/PCykO0KaGGuYaJqb0wq52DPNU/R
         +Jzg==
X-Gm-Message-State: AOAM533uYJPPLSUJsY2hNaQ6r1awncwSnldTJh8+e+JkFfj9TWBMgyyS
        FLLBFAsGEPYoWauAlr1zFO+Cv6r/B/2lo3AUimah+g==
X-Google-Smtp-Source: ABdhPJxl6YtK/h165mnccKscHmrNx8hv+5LU3oxmgVt8xO6NFVkqE7pdFuWXIupjmUN6d4vv2UqvlixHXkWBKv/zKyU=
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr2458797qta.620.1638308349300;
 Tue, 30 Nov 2021 13:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20211126124746.761278-1-glider@google.com> <b740b48e-2675-d324-d35c-d96f973f24e0@intel.com>
In-Reply-To: <b740b48e-2675-d324-d35c-d96f973f24e0@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 Nov 2021 22:38:33 +0100
Message-ID: <CAG_fn=WVwh0593rX-+OwEHxEcHO9GHc-Tux=XzQs5F-T+os_5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu/signal: initialize sw_bytes in save_xstate_epilog()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, chang.seok.bae@intel.com, bp@suse.de,
        dvyukov@google.com, elver@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:09 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/26/21 4:47 AM, Alexander Potapenko wrote:
> > save_sw_bytes() did not fully initialize sw_bytes, which caused KMSAN
> > to report an infoleak (see below).
> > Initialize sw_bytes explicitly to avoid this.
> ...
> > Reported-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Tested-by: Alexander Potapenko <glider@google.com>
> > Fixes: 53599b4d54b9b8dd ("x86/fpu/signal: Prepare for variable sigframe=
 length")
> > Link: https://lore.kernel.org/all/CAG_fn=3DV9T6OKPonSjsi9PmWB0hMHFC=3Dy=
awozdft8i1-MSxrv=3Dw@mail.gmail.com/
>
> Hi Alexander,
>
> Marco's SoB entry is before yours.  Was this authored by you or Marco?
> If it was Marco, it's customary to add a:
>
>         From: Marco Elver <elver@google.com>
>
> at the top of the changelog to make sure git gets the author right.  I'm
> happy to fix it up this time, I just need to know who wrote it.

Hi Dave,

Yes, it was authored by Marco. Thanks in advance for fixing this, I'll
keep that in mind next time :)


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
