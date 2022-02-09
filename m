Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775FC4AF558
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiBIPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiBIPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:34:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675CC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:34:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso3423749wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6X/EAW4PGBx6CDB8KQmDtTWJkXrlZ6dQ+0Rs2M/cTuA=;
        b=nOrDAITSH7wzDvkmTQ+WxdJJ5LiypiQw8gyR5ZzYHI/ZxB6y4Vo5zdc2h4eVX9iuI3
         ckWEaTq8exA0XoNJ38vd7iuNuswyTgbDLt8X3JXbgbUOKciOr39qWtDNN1LdeQ42OuEM
         fF8T7oVHa1ew+OGdcRor3ZwDqdYE8s+R714wkGPFt9DP7kHplDSfD79FJ0HKcWyF17tg
         HjzwFETNEk40GIDISpiKX+lhlCcT1cyjr2nts+wOYJjGSo43l7jyc+9zR9UO7m+qP+oJ
         ZV1cSoyPlleHVR98rVHP1ff0Lw/9so2YyGXrKyLigCBioqdYVx4EknqE8e7uR61mb8G+
         bknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6X/EAW4PGBx6CDB8KQmDtTWJkXrlZ6dQ+0Rs2M/cTuA=;
        b=C//7AnWGOuDoyupYlLJdI/Kiw1XmfBQyXpxuxCLUYjACYp8rm6Nqu/iwN5ZEVpGKQ9
         FOvM2CFoQWJvs8zHahyjPamD9s3sXugMwduxhrxtJ0yMfQYOxhoB7Kr5+ttvcoli98Fj
         buuVFHlYm30Zo+Cii8KRdfGGRLWdehud63lPZogW829QRsTgWXZDh9pJlus5QsGWFC9v
         cNNmzx7W5EY5sCJyKWUv4TXzdXC7C6EfBNfCV2g6XYZX2bPV/AZrlcAQmevtLcX3gw6j
         zlSODkIkfNkl0iMH9/gr2wy6RCpPoZupll79f6lT2ls+XWcH7u6gAX+fGt92wyjb37w5
         85Vg==
X-Gm-Message-State: AOAM5330FvtEiMDjZIb76dx1daMdmPVu5NZ8Z1Eyn3/d7fbQQAVLqIj1
        0IIYBM9wcH08bW4Ku05JUXp0D7hpPPduF2doE4AvWs8rS8RMJg==
X-Google-Smtp-Source: ABdhPJxNv6jCZcI+iE2gzUBh5OZQiKto84KWQlOAB2YrLoAHr4oY6Zt2iCCYuiqnYpC4U4lH6Y+894SHzGcLDZoOC4s=
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr3103500wmr.26.1644420881817;
 Wed, 09 Feb 2022 07:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-2-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-2-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 9 Feb 2022 15:34:30 +0000
Message-ID: <CAJ9a7VjVfdDMJXMG0nosFrorYK8FmbXAa2qDhO6QuGp4H3+Q8g@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] Use IDR to maintain all the enabled sources' paths.
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Use hash length of the source's device name to map to the pointer
> of the enabled path. Using IDR will be more efficient than using
> the list. And there could be other sources except STM and CPU etms
> in the new HWs. It is better to maintain all the paths together.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 76 +++++++-------------
>  1 file changed, 27 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 88653d1c06a4..a90097f88425 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> +#include <linux/idr.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -26,6 +27,12 @@
>  static DEFINE_MUTEX(coresight_mutex);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>
> +/*
> + * Use IDR to map the hash length of the source's device name
> + * to the pointer of path for the source
> + */
> +static DEFINE_IDR(path_idr);
> +
>  /**
>   * struct coresight_node - elements of a path, from source to sink
>   * @csdev:     Address of an element.
> @@ -36,20 +43,6 @@ struct coresight_node {
>         struct list_head link;
>  };
>
> -/*
> - * When operating Coresight drivers from the sysFS interface, only a single
> - * path can exist from a tracer (associated to a CPU) to a sink.
> - */
> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
> -
> -/*
> - * As of this writing only a single STM can be found in CS topologies.  Since
> - * there is no way to know if we'll ever see more and what kind of
> - * configuration they will enact, for the time being only define a single path
> - * for STM.
> - */
> -static struct list_head *stm_path;
> -
>  /*
>   * When losing synchronisation a new barrier packet needs to be inserted at the
>   * beginning of the data collected in a buffer.  That way the decoder knows that
> @@ -1088,10 +1081,11 @@ static int coresight_validate_source(struct coresight_device *csdev,
>
>  int coresight_enable(struct coresight_device *csdev)
>  {
> -       int cpu, ret = 0;
> +       int ret = 0;
>         struct coresight_device *sink;
>         struct list_head *path;
>         enum coresight_dev_subtype_source subtype;
> +       u32 hash;
>
>         subtype = csdev->subtype.source_subtype;
>
> @@ -1133,26 +1127,14 @@ int coresight_enable(struct coresight_device *csdev)
>         if (ret)
>                 goto err_source;
>
> -       switch (subtype) {
> -       case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -               /*
> -                * When working from sysFS it is important to keep track
> -                * of the paths that were created so that they can be
> -                * undone in 'coresight_disable()'.  Since there can only
> -                * be a single session per tracer (when working from sysFS)
> -                * a per-cpu variable will do just fine.
> -                */
> -               cpu = source_ops(csdev)->cpu_id(csdev);
> -               per_cpu(tracer_path, cpu) = path;
> -               break;
> -       case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -               stm_path = path;
> -               break;
> -       default:
> -               /* We can't be here */
> -               break;
> -       }
> -
> +       /*
> +        * Use the hash length of source's device name as ID
Slightly confusing comment:
hashlen_string creates a hash and a length for the string. We are
using the hash here so comment should be:

"Use the hash of source's device name as ID"

> +        * and map the ID to the pointer of the path.
> +        */
> +       hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +       ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
> +       if (ret)
> +               goto err_source;
>  out:
>         mutex_unlock(&coresight_mutex);
>         return ret;
> @@ -1168,8 +1150,9 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>
>  void coresight_disable(struct coresight_device *csdev)
>  {
> -       int cpu, ret;
> +       int ret;
>         struct list_head *path = NULL;
> +       u32 hash;
>
>         mutex_lock(&coresight_mutex);
>
> @@ -1180,21 +1163,16 @@ void coresight_disable(struct coresight_device *csdev)
>         if (!csdev->enable || !coresight_disable_source(csdev))
>                 goto out;
>
> -       switch (csdev->subtype.source_subtype) {
> -       case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -               cpu = source_ops(csdev)->cpu_id(csdev);
> -               path = per_cpu(tracer_path, cpu);
> -               per_cpu(tracer_path, cpu) = NULL;
> -               break;
> -       case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -               path = stm_path;
> -               stm_path = NULL;
> -               break;
> -       default:
> -               /* We can't be here */
> -               break;
> +       hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +       /* Find the path by the hash length. */

same comment as above re hash  / hash length

> +       path = idr_find(&path_idr, hash);
> +       if (path == NULL) {
> +               dev_info(&csdev->dev, "Path is not found for %s\n",
> +                               dev_name(&csdev->dev));

pr_err() is used in other parts of this file to print error messages.


> +               return;

this skips the mutex_unlock(). use goto out;


>         }
>
> +       idr_remove(&path_idr, hash);
>         coresight_disable_path(path);
>         coresight_release_path(path);
>
> --
> 2.17.1
>
Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
