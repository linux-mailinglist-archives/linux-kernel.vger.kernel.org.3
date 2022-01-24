Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D7497A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiAXIZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiAXIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:25:49 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18592C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:25:49 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bb37so24377135oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5Kon1fyx96zs+S9bI+PC9J+wxhNv56hJEaz7FbSFSE=;
        b=eazm9+k5NrSkysNa4r0Etw/X4kuNIAgY2x0kj7nlI9lFPb6h4Xs6BwKJDPGQ+z3Y9P
         2XjCpVQ99nUVkdVvIR+f7P6/KjIpbVESJnVrtlGzipUn5sYQJg5O2foAbtHA2EjbElPi
         9Sj6z+OszOIDJT247jEQPO9zI+nSzuL79xivSwW1VtJSEA99a/QdKzN7Pamgsk7qOHk7
         HmVcTzATtNIn2RIRXLLegt4OYVIJTQn9aQTaSJMta+mraS7Rv7MJM84g6Og7EQa+WqOl
         hriMvAi26Qz3zrY1+keHAYUowvfb2AJqsVj2ApjjqNycg8KtiK7q9CcyOzvTZ8AEbRg7
         VlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5Kon1fyx96zs+S9bI+PC9J+wxhNv56hJEaz7FbSFSE=;
        b=Em83XT/MLcs69wa+NSgu5/q7b2uOtyjhW67G4tsuRnrg1Ky/Jb9bz0swuzCNEH80yj
         ZjANe+5APc4x3IP4Mx3Q19zj753PIhdKOe8eDEJ7ZYW0qmhGDLnQjcAgsO/EUo4AVDNh
         4sjhmmfAywStIwx94Hm6pZT0hdEwBxu8eOKSM3vrG4ZRd74SO014cm5ElnPr6/tkmSlc
         M7prVDShIjAW90+xSVAYno6NTlfMIZejD75cNeOXAUcg2ZDhIBiuqE7IID498FTJJ9Dl
         vldZUEn0hVKvDNnNs0Bv/j9rVZvt7LKHDCBFMcjLOgI3a3tEo5i56yolHwvBcXugQ+hB
         U4lA==
X-Gm-Message-State: AOAM531knkrX1HwMoEWLXd6jCPaDqZddvrMzZreWahYPcPiU6mQqdIC0
        thfH53e6OtIOJf5WO9bzkQs7on87c8Vwlt6x7eU3uw==
X-Google-Smtp-Source: ABdhPJy/mCoQ+yHuD/GHeBHQU6ztq1bT+RAtkGasd/wxL3uYVGLEuF1Vk0VGXgNWZnYdPvLrGxKFp1OI8pKW7eAq7Iw=
X-Received: by 2002:a05:6808:a97:: with SMTP id q23mr606047oij.4.1643012748254;
 Mon, 24 Jan 2022 00:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20220124025205.329752-1-liupeng256@huawei.com> <20220124025205.329752-4-liupeng256@huawei.com>
In-Reply-To: <20220124025205.329752-4-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 09:25:36 +0100
Message-ID: <CANpmjNNYG=izN12sqaB3dYbGmM=2yQ8gK=8_BMHkuoaKWMmYPw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] kfence: Make test case compatible with run time
 set sample interval
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 03:37, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The parameter kfence_sample_interval can be set via boot parameter
> and late shell command. However, KFENCE test case just use compile
> time CONFIG_KFENCE_SAMPLE_INTERVAL, this will make KFENCE test case
> not run as user desired. This patch will make KFENCE test case
> compatible with run-time-set sample interval.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  include/linux/kfence.h  | 2 ++
>  mm/kfence/core.c        | 3 ++-
>  mm/kfence/kfence_test.c | 8 ++++----
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index bf91b76b87ee..0fc913a7f017 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -19,6 +19,8 @@
>
>  extern bool kfence_enabled;
>  extern unsigned long kfence_num_objects;
> +extern unsigned long kfence_sample_interval;
> +
>  /*
>   * We allocate an even number of pages, as it simplifies calculations to map
>   * address to metadata indices; effectively, the very first page serves as an
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 2301923182b8..e2fcae34cc84 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -50,7 +50,8 @@
>
>  bool kfence_enabled __read_mostly;
>
> -static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
> +unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
> +EXPORT_SYMBOL(kfence_sample_interval); /* Export for test modules. */

While it would make some situations more convenient, I've wanted to
avoid exporting a new symbol just for the test. And in most cases it
only makes sense to run the test on a custom debug kernel.

Why do you need this?

Should you really need this, I suggest at least using
EXPORT_SYMBOL_GPL. Should you want it, you can resend this patch
standalone detached from the rest.

Thanks,
-- Marco
