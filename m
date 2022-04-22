Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51250BEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiDVRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDVRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:44:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162511481A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:41:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bg9so7856937pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OZTgMPH9Pxi3nCqnIacIQrfeG7gnS/pKi1r4Mc7HcDs=;
        b=fjjvrmTdM9nn7GZ2f47W0XnahdAqPMYF645kNo0dHqor07t5HOJrx+xy4RBWf+He4x
         v1DVWg+2UoGFcgRunb+/wSx4FLdf3eD62Ao8J4t0mScnpTxiy3mjZWy0QD4pa5lHnNJs
         mL3otI21RYGUksjcY5+m2py0xBTzboASdb9sP80hXMWwWKAzJ8svXz11UIpNcDqqzsbQ
         ZNmGc3oQe7SLc5N2y2WQVMuOoOhJ5gZip36Ppcb24hPXNSOv8SeA0wNmKMa6g+hFk/pK
         V+xUWh6Nj6ZWRCSwJnwAMpTR1W/tV2uqiEXgm5jjZkoGH4fGwDSb0gY6IFvuDVgGfh+6
         daxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OZTgMPH9Pxi3nCqnIacIQrfeG7gnS/pKi1r4Mc7HcDs=;
        b=CvYksoLLPbqZf1Yf0Z4r4rDAhOtwngedkb7oXY9Svdl21HtLcrochW250drc5Tn3p1
         CAJ3qO9Ih/sWTkwNoY1Hh4IB/gSEepRwIEwwECuXqhmFD4rAzkZcovT+SrL9KxYX5F/F
         GVIbHnke0W0HWyHxVDQ097+7rYswjaoH0U90tepbJoaxMzZdDp3CuNA7mapZBaCAdgKf
         DRsjLrBgZ5N6jM07AuLP/4mLRElQSUSXXjd1gKpvZ58Ex7maSMqV//ah96KTxgldCHrv
         We87YNqS8eQJrUGy5xREjQzBpS1LNOGgYosg8+oBR/Mb0zRO5W18lnlTFHKrpsSbXUnC
         X2pA==
X-Gm-Message-State: AOAM531kVRGk78QQzDRnHFVwqxQODPQpPDOq70hYGOEB9jiRhpGqQWo5
        tf21WFhxNLjpdGZjj0nGW/0rT9KmDuEufNVPtRU=
X-Google-Smtp-Source: ABdhPJwcty+geLkVBerxwWZAwgWuRj+bwlAp3XZHyWx/9WdIbvLqVAmvr1abK4wNU/x8a40h2nNdKPB43lTYeGeJhow=
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id
 n24-20020a62e518000000b004fa9333ddbdmr6140985pff.11.1650649034742; Fri, 22
 Apr 2022 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220416053902.68517-1-dave@stgolabs.net> <20220417034932.jborenmvfbqrfhlj@offworld>
In-Reply-To: <20220417034932.jborenmvfbqrfhlj@offworld>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Apr 2022 10:37:00 -0700
Message-ID: <CAHbLzkpNBRdhBewviYWke+dgERjKi_nhEdTU5V75Sr92yp2K3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/migrate: export whether or not node is toptier in sysf
To:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org, jvgediya@linux.ibm.com,
        ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 8:49 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>
>
> This allows userspace to know if the node is considered fast
> memory (with CPUs attached to it). While this can be already
> derived without a new file, this helps further encapsulate the
> concept.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Resending, just noticed this oatch was never posted.
>
>   Documentation/ABI/stable/sysfs-devices-node |  6 ++++++
>   drivers/base/node.c                         | 13 +++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index f620c6ae013c..1c21c3985535 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -198,3 +198,9 @@ Date:               April 2022
>   Contact:      Davidlohr Bueso <dave@stgolabs.net>
>   Description:
>                 Shows nodes within the next tier of slower memory below this node.
> +
> +What:          /sys/devices/system/node/nodeX/memory_toptier
> +Date:          April 2022
> +Contact:       Davidlohr Bueso <dave@stgolabs.net>
> +Description:
> +               Node is attached to fast memory or not.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ab4bae777535..b9de5b0360f2 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -598,12 +598,25 @@ static ssize_t node_read_demotion_path(struct device *dev,
>   }
>   static DEVICE_ATTR(demotion_path, 0444, node_read_demotion_path, NULL);
>
> +static ssize_t node_read_memory_toptier(struct device *dev,
> +                                    struct device_attribute *attr, char *buf)
> +{
> +       int nid = dev->id;
> +       int len = 0;
> +
> +       len += sysfs_emit_at(buf, len, "%d\n", !!node_is_toptier(nid));

It is not guaranteed. Some hardware configurations have cpuless DRAM
nodes, but they should be treated as top tier nodes IMHO. Please see
https://lore.kernel.org/linux-mm/20220413092206.73974-1-jvgediya@linux.ibm.com/

> +
> +       return len;
> +}
> +static DEVICE_ATTR(memory_toptier, 0444, node_read_memory_toptier, NULL);
> +
>   static struct attribute *node_dev_attrs[] = {
>         &dev_attr_meminfo.attr,
>         &dev_attr_numastat.attr,
>         &dev_attr_distance.attr,
>         &dev_attr_vmstat.attr,
>         &dev_attr_demotion_path.attr,
> +       &dev_attr_memory_toptier.attr,
>         NULL
>   };
>
> --
> 2.26.2
>
