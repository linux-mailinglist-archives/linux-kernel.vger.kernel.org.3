Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167CE501784
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbiDNPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351382AbiDNOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:30:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7489D066
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:20:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p189so3194800wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0Lx+YhEV19cE3u0seAX25AMglV2jlQ8KZ9nMJnohWg=;
        b=UvekpSufaCupMwQjFJmDdWjqqU9Mnw2pwovna0fI8wu/2HabNbQN2EHHMayLZMsxbe
         uYXMPXdAowx/RjPryWxJ1yQwzn3FGhVX5quaeyGZMMdxp2jGcvX0jM8Wjv94nbiRlLLz
         Bk7gQC0X7UsZHlOw39cogznLkdKO4hSTqGYrtVWvv/oTIgpkoXrUfm98jFwpOBs93C6h
         6RDzdJKydgUJSwE0bPrYnM8xzOWj7CvDJH37gCuYCE6GcDNKd2Sb7w0pwZ1ccHheuePV
         ZZiZ8dVRoOkUIxBm6CAx8xKL1agwQPWH1ZUpFW5PonDkyb0mBSzsI6Uc3SafDo/qy9/R
         jeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0Lx+YhEV19cE3u0seAX25AMglV2jlQ8KZ9nMJnohWg=;
        b=MQhPYB/c0udDo0k/o230HRNWFWN4jidkanhWncmRI8PQhuyRjFl6wW/c9FL1CJqtPK
         5om6HDju27UdDuI/KV1rZHIQC8ST4a5S+VVWyvuKvy5KNLWsRH9VhoQUKKGB0w2N247c
         r+gQFXTvaNlH5VoAkL8zWVzJJHBFq5ZIIl450HJ6/jcr91YY9DDTOWEHi2NRimZpJ8u8
         WSqW+g6KTwgxCWZ9MNIa60Hei0Agz0oRb7uZc8lT1WKlMWOxObbze1r+RJ3cIS065+Se
         U7NQoNqJzPgTlrQTEEHE3V4GXq1tAGqKPYBH6Lxh8tf3OazHyD4Sr8t9+QxLaR4oJlUB
         bllA==
X-Gm-Message-State: AOAM530zmF7wnBMtBdahjfNUCxNCQmtJNfV19EGiZ1gzsZHbZUq3Gd+T
        eTAGXvb3yQqRS8zeNshro8WRRrt2XQAr5lD5eBmK9w==
X-Google-Smtp-Source: ABdhPJz+GFJXziev0rguku9HgxSUV2nE+m/p9z7reM3bfCNlZHuWqvlwzn6tLd5uWpRbVFk0Fj7k+FELa6wa36Czcgc=
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id
 n2-20020a7bcbc2000000b00388faec2036mr3476454wmi.190.1649946023247; Thu, 14
 Apr 2022 07:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-2-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-2-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 14 Apr 2022 15:20:12 +0100
Message-ID: <CAJ9a7ViMWpdVVt3veAbrr0HM5DyYcDechiJbub_S4uWKCfMfkw@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] coresight: core: Use IDR for non-cpu bound
 sources' paths.
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

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Except stm, there could be other sources which are not associated
> with cpus. Use IDR to store and search these sources' paths.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index bbf415c252f9..23ab16dd9b5d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> @@ -27,6 +28,13 @@
>  static DEFINE_MUTEX(coresight_mutex);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>
> +/*
> + * Use IDR to map the hash of the source's device name
> + * to the pointer of path for the source. The idr is for
> + * the sources which aren't associated with CPU.
> + */
> +static DEFINE_IDR(path_idr);
> +
>  /**
>   * struct coresight_node - elements of a path, from source to sink
>   * @csdev:     Address of an element.
> @@ -43,14 +51,6 @@ struct coresight_node {
>   */
>  static DEFINE_PER_CPU(struct list_head *, tracer_path);
>
> -/*
> - * As of this writing only a single STM can be found in CS topologies.  Since
> - * there is no way to know if we'll ever see more and what kind of
> - * configuration they will enact, for the time being only define a single path
> - * for STM.
> - */
> -static struct list_head *stm_path;
> -
>  /*
>   * Set up a global trace ID map.
>   * We may need a per sink ID map in future for larger / multi sink systems.
> @@ -1061,6 +1061,7 @@ int coresight_enable(struct coresight_device *csdev)
>         struct coresight_device *sink;
>         struct list_head *path;
>         enum coresight_dev_subtype_source subtype;
> +       u32 hash;
>
>         subtype = csdev->subtype.source_subtype;
>
> @@ -1115,7 +1116,14 @@ int coresight_enable(struct coresight_device *csdev)
>                 per_cpu(tracer_path, cpu) = path;
>                 break;
>         case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -               stm_path = path;
> +               /*
> +                * Use the hash of source's device name as ID
> +                * and map the ID to the pointer of the path.
> +                */
> +               hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +               ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
> +               if (ret)
> +                       goto err_source;
>                 break;
>         default:
>                 /* We can't be here */
> @@ -1139,6 +1147,7 @@ void coresight_disable(struct coresight_device *csdev)
>  {
>         int cpu, ret;
>         struct list_head *path = NULL;
> +       u32 hash;
>
>         mutex_lock(&coresight_mutex);
>
> @@ -1156,14 +1165,20 @@ void coresight_disable(struct coresight_device *csdev)
>                 per_cpu(tracer_path, cpu) = NULL;
>                 break;
>         case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -               path = stm_path;
> -               stm_path = NULL;
> +               hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
> +               /* Find the path by the hash. */
> +               path = idr_find(&path_idr, hash);
> +               if (path == NULL) {
> +                       pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
> +                       goto out;
> +               }
>                 break;
>         default:
>                 /* We can't be here */
>                 break;
>         }
>
> +       idr_remove(&path_idr, hash);
>         coresight_disable_path(path);
>         coresight_release_path(path);
>
> --
> 2.17.1
>
Reviewed by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
