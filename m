Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB55A478C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiH2Kuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiH2Kuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:50:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADB165AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:50:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy31so14456781ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=po8eVdAenbpKrCkz4JKlV6W49Tq/nrJ3pgXdtpOZ1o0=;
        b=xrNoYu+VINF91H9AcGTj7e9utA7xAjnGhepEh7Mum1XaILF5AyXQ5ibbuXhZWPEhq4
         eK21KTbO7NqEhG09xLeHr2y8gUKn/YoaQEPPZ8yzvnUajc5sWnJRCYHqN5sFkDA/r4VO
         B+a0My7gnXQxEvaLEsTVFINlKbj7KsTZQDUwQgr0VLDc3RVmKQr4YbIaZFFv43ZavPRV
         CRI+PipDvyypVALt2/ie8L577D7XpAgwDDOb26a3pu3dvtWAogkH2GW5n08HdYRuQoLe
         9GAsOI/NOCUAE1QkRs8ouS6/15+vFINI9KYBUv19Cj2LXPHSsJfa6gVwkGXN14zCvg7d
         974Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=po8eVdAenbpKrCkz4JKlV6W49Tq/nrJ3pgXdtpOZ1o0=;
        b=xfo7Sc26yaOHMqhqgwnhDPVlcRwmb+pVEHwI2y8Q8tzAMoIW3C4zAPWmbrbznVPw8b
         xTKE3FjgKRyGqVTVw2P1/HnUDk0RvlNRfKYXDoM4SouLCPJJ3do4erZ4TnO6ajT6S4Aq
         XZbhfv8YB3Xykuh995j/fC825A/cWzaMYj+PNh/1Fj/jaaZQZna04mMsjc2+kTU/LgwF
         /Ew+oxEQZcHfKiEO5tTgtbn68zo8STVnidsR6tiozh9NdRTJCHLLGSqnXYFHHSlAhGcC
         +tuP58n5UkhgJvRMlxibMxJ8b+4TPzdNca0u/lKhA+NJ4tGB6Yg7zM7tkJJYBald80hQ
         JAFg==
X-Gm-Message-State: ACgBeo178QD1KP9KImNaldD/0i+axkLZhK5+f7QHTDvwVlAXGSnxaZV0
        7H3jg6jQUHg0CYELWYVzXrL+GebnI4lUvyxYuDbg
X-Google-Smtp-Source: AA6agR4ymvkqcOZ9j7iYAyghFUODCCCv85OPNuQdzTC6bw8PTsEM9PkmApCUYbvWD8oPjyF+makg3fmbdFjfwXg7L9Q=
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id
 wt14-20020a170906ee8e00b007304a24f311mr13688565ejb.420.1661770232677; Mon, 29
 Aug 2022 03:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
In-Reply-To: <20220829073424.5677-1-maxime.coquelin@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 29 Aug 2022 18:50:08 +0800
Message-ID: <CACycT3vaeULPQ8qcz+-uOYxLcKN5zXJA7hs95CjBL6OjDCS7tA@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eli Cohen <elic@nvidia.com>, guanjun@linux.alibaba.com,
        Parav Pandit <parav@nvidia.com>, gautam.dawar@xilinx.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 3:34 PM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
>
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
>
> This fix addresses CVE-2022-2308.
>
> Cc: xieyongji@bytedance.com
> Cc: stable@vger.kernel.org # v5.15+
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
