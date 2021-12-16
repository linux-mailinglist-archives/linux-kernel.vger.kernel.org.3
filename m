Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8F477338
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhLPNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhLPNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:33:34 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:33:34 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id ke6so1115022qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DioPzCu1zsCkrV4YGIzTyYHRCTuSei+k8/YBOQlCxpM=;
        b=eupZD4nbfs0lstONzI8kde9vq/qFmZxaclh3UZ2DRXV+leRJ1q3/qzJ2FzWrksujCC
         /G03Ytbm4EAWYj3tSyucid7zXeBuASV4KUA5zkMiDh/NdY3pXZRS/fhhvZ7EtomXw9jD
         dIBKsfyDv8WkQpFs1OkR/oc7g0wDww5uP3/DqejBqfdvsACeUWTDXQ0CFhFH8r5mnF00
         25Wi1BCHkNPHqtOxWU7KLTCKLt3JnZXbpTutzdr1wJMUwTyEOc3gQMvM/JghPHP38ZAd
         EOrPWar5wjv0qVECyhqxOocAg5WeooxizqSKvAj9wD2EbXpdPfdiCIGCuG6FhDXM6xvI
         idow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DioPzCu1zsCkrV4YGIzTyYHRCTuSei+k8/YBOQlCxpM=;
        b=CD2oyjcruqCLvwZ0Bv2xlQaisW1nCHX2VX5CvrbQpgjlz/X6Et2xJnyI98JNSnfSXq
         ZaZO8UNVbCumRzLt5VHnervzmpzLFlE0RVIX4VhnmMbW2Crb8X9UJ9xcNbVeRzyo7LQ9
         CVb+MPHJjJQHwerXzl3bF2zhRhqI1KgeIurAqXke5Wmy7Ut596SunkdLu6LKRMAgS97D
         fVChQgiMdnYv+7BFc8Zff3Ts8l9mvf4npPdDYvtQgsp7J2Z8TX/Z5iwmU7dMnW0/EIxt
         MxqjCtlPLdQ3DIqRgB3GUyfOwMT9jxzYxMeRE2zYwo/3CSUPnYi9qvXjC82SLVA7e5zZ
         Hd9g==
X-Gm-Message-State: AOAM530YlzTc/Cr0+HBHcTiuO8OrsvA/09+zcCVxQh+2JbAhTb3gV6N0
        XUr+Dd7e8vTDN84OQgalOSgYiXSbTmRK0L5BFTixbg==
X-Google-Smtp-Source: ABdhPJxDNmr1/1QKYZKCAhbtGAMuT8bLAdalv8abIR5jCYVZhKLGloBSXVp0pXLbFIEiyeH5K7tuMDS8XgfONT0BMxw=
X-Received: by 2002:a05:6214:5190:: with SMTP id kl16mr15576473qvb.36.1639661612968;
 Thu, 16 Dec 2021 05:33:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <fa64826c55c90d29f8ce2f71b588591fb9cfc23e.1639432170.git.andreyknvl@google.com>
In-Reply-To: <fa64826c55c90d29f8ce2f71b588591fb9cfc23e.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 14:32:56 +0100
Message-ID: <CAG_fn=VVnpsiAP5zpOZVjUYSoVgFZtrPCkN8fzx1t-5OEGhcMQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 09/38] kasan, page_alloc: refactor init checks in post_alloc_hook
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:52 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Separate code for zeroing memory from the code clearing tags in
> post_alloc_hook().
>
> This patch is not useful by itself but makes the simplifications in
> the following patches easier to follow.
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
