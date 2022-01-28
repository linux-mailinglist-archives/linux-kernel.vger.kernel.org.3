Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4A49F6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiA1KML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiA1KMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:12:09 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:12:09 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q204so7081355iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNPUfF1dwsGSwixCd2rgdU0h/HhD4TFDiOUvTQkWOEw=;
        b=M7eajZzEWKAncpyXdu/HipsM/BbPDnRWxumzOXgLR3bNg3puk4HY8RWpErAOAyvZRJ
         dLuxXEMFGu0r76nmAuFHh+cILobCzGgMKju5UFC+pQwBi0BdyNpldCDaDxu+H/aEyT2+
         VrbLU9n4jkA5Fg45qihW1O4j0sGAVjEQ8z/sv+5jRl18OPR9yIxQWrEoOBp4y7DVK9Bm
         ipmTMEOSgZgqJra4/6TZczJGTqa/NEfaQTIkBqBaDYWSbalOaqIaBbwV7vADAvD6+wEw
         iSbxk6KLEW3Si+dazP8BDLOZAIgOGJiNTfTpQLxSjvsy1eIs64w9hm2UCFDlacn8hUgy
         B3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNPUfF1dwsGSwixCd2rgdU0h/HhD4TFDiOUvTQkWOEw=;
        b=NlnIAH9rDLpYMUhWFIeN/+n/ih2B9AKtBdeU1w9sytLHXFD3Ddb25E+Dck/uP3+iAm
         bGQJtSEeAhsvO81BYIntojGB7R356SLw/aByb4UbJJL6kGeLx0nNJnG3wo9+TvC3QxXl
         704OHiPp+k1gbrbldecK8IORQIrOsF+IXsZjOKZAKNHTtzw6ll0P4+PczLwPktFoUdmn
         Ck/BlfNJi6T6E2x5DEFIS1hMuLTDD6KYzgkZGWTAj/ezecymOf59E4ROMbh2WnHofe82
         9iIrjuBytg1j3OvvI4IviV1XzowNP3OoAlHESRXHxBOLs6XtPFGJEGb3LdLhIa+HPZjw
         vPnw==
X-Gm-Message-State: AOAM532vZvyuFPl9vvkLi0NuXzT0WBwoll+RlW+MOd72XDjNelx3r2o8
        1WPJFr8D5I0TFKczySKr7fVfyQVSWjZLtTaqMds=
X-Google-Smtp-Source: ABdhPJzA47HiAINhIev418uQPCnpTvMVzET/UujTk/Xfo0TPNEGz8HIjGdEOu3Tn8BgVJiYxgWxjHGWM1CF4UL+nCTg=
X-Received: by 2002:a5e:9249:: with SMTP id z9mr4758438iop.188.1643364728844;
 Fri, 28 Jan 2022 02:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 28 Jan 2022 11:11:57 +0100
Message-ID: <CAM9Jb+gDKEt_XK-cE-2Q08u8EM3cYMTegrwM01R9m4JYe32mbA@mail.gmail.com>
Subject: Re: [RFC v3 0/2] virtio-pmem: Asynchronous flush
To:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        jmoyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

>  Jeff reported preflush order issue with the existing implementation
>  of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
>  for virtio pmem using work queue as done in md/RAID. This patch series
>  intends to solve the preflush ordering issue and makes the flush asynchronous
>  for the submitting thread. Also, adds the flush coalscing logic.
>
>  Submitting this RFC v3 series for review. Thank You!
>
>  RFC v2 -> RFC v3
>  - Improve commit log message - patch1.
>  - Improve return error handling for Async flush.
>  - declare'INIT_WORK' only once.
>  - More testing and bug fix.
>
>  [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
>
> Pankaj Gupta (2):
>   virtio-pmem: Async virtio-pmem flush
>   pmem: enable pmem_submit_bio for asynchronous flush
>
>  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
>  drivers/nvdimm/pmem.c        | 15 ++++++--
>  drivers/nvdimm/region_devs.c |  4 +-
>  drivers/nvdimm/virtio_pmem.c | 10 +++++
>  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
>  5 files changed, 98 insertions(+), 21 deletions(-)
>
> --
> 2.25.1
>
