Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0935F4772A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhLPNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhLPNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:05:37 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16412C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:05:37 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 193so23139880qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pM8lzFE2adl9e7OGeD04l8kwcRxPJfnL9cXWkQLHi0=;
        b=sFkavAu2ycRGPu7LaVIsmTmvVY+YxG1OJIThDvAhyEaxG3FT+BS4f3MJnedZe/PBZn
         25HaFvD3LDSnviI5KqeLOPTBa2dDgKGMYS72Cy+baltMPxLuN9cgW7MjFre2Ln4k1eVd
         cGqWLRp5DpsiDJg2isiYHx3Lfg2Pz+N2QR7ae6vILGOFlN1jv6mKs+m5FOUnvCruvIWK
         GPeta3oIg4NTbpYqjtKzsJMxaVpBLETbKypBiMqolh9nTzBkhnyve/CwQKuVm+1fHGo8
         GbSTZtFAyVAdVtCqmxOPxg7USV+kZHesVIqIdoHUKxk939so6feNoQiOFaFVt8XYryZ8
         ukcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pM8lzFE2adl9e7OGeD04l8kwcRxPJfnL9cXWkQLHi0=;
        b=muOVuznAEXud11RJZjVaHiTjszIxdWLQ6+KNV6QJX9KlRwcRtd7m6GefdduHkYn5Xz
         VNVMa2WLc9UDu71caq+PWUAxW2JsDVyMayyFHMjjjVDjZUAkLKT9ORIreO3NpI+LzKCL
         1RvOL5YhCrM19RT3A3jnQ/+gH1B5Wvkdx2RjEMs7tr9Fv1ELxFtqIXSMnmBR/xs7m4O1
         VBF7AcF/2wNns/4t/TQOcIVlzShJp14a6vZ/1fRWbnqxwTq8D2cE8/46cbN+RtOV2exp
         IyFOPjFhym9AWTSAtbbJCGT6rkgKVaT3f02DTXL6H2iiMqXp3GqAARNZc4Sq6awvXo9U
         EB3w==
X-Gm-Message-State: AOAM533eBNfTazvm6dmuqo275syzhvL+ba2ciY6rjSS2B7xVzCpcc8Pp
        CszQuDkJ4hqr602EZO0WzgbycBICvmlaOsxfga3eKw==
X-Google-Smtp-Source: ABdhPJyOhXiPcG5QDw1HnHMGGZ76QdPQv7ZSBjFTaYon+P6ZULmmQzepXRM1EtRTuGv5hn7L85A/ff6kEfzaYZOsA6Q=
X-Received: by 2002:a05:620a:2955:: with SMTP id n21mr11809849qkp.581.1639659936010;
 Thu, 16 Dec 2021 05:05:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <585c27bfa692331cd75de7c9dc713a318d3db466.1639432170.git.andreyknvl@google.com>
In-Reply-To: <585c27bfa692331cd75de7c9dc713a318d3db466.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 14:04:59 +0100
Message-ID: <CAG_fn=Vo9d3xrE_HGqZEHyT4jkkKy6-Raqqvz_a8b9TCqisPuA@mail.gmail.com>
Subject: Re: [PATCH mm v3 11/38] kasan, page_alloc: combine tag_clear_highpage
 calls in post_alloc_hook
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

On Mon, Dec 13, 2021 at 10:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Move tag_clear_highpage() loops out of the kasan_has_integrated_init()
> clause as a code simplification.
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
