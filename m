Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175C3476889
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhLPDOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhLPDOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:14:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAB0C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:14:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b7so22409421edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRJtCkOVfUgTAMWatq3W/aBk4fwy5a5oyZt3PFpdaS4=;
        b=yZIOqIsAjQCt7njlamfrdE+rtF1l3+l/gFLv4KQC5DuZmRj8urEV4UWFgjIVm0o+iU
         vpEtloJI+IzVX2tXqz4sa82JN7gzawR6nyP2x9R0psDnIbg38QV2rmHfbT3MxlygJ+ct
         9T6NUjYJQar5WOU5WvLYPIBevxLfjW0I6gLScY+Ye6e+2YNLzz94KvOXpd+1z+CIp90e
         jA5c7vdTbPz0s6bzG20PzuWeZ6Ynq9Q6SVO5PrREL9tAt31FlRGRUEtjSy3lvuGrNqWo
         vCM6zyMcb+Qcl8BLzWryIyVzqlKq0vfAjMZiPu59PyA0LoBcs4L+7Z0c+Z8yJXrlVLDd
         s+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRJtCkOVfUgTAMWatq3W/aBk4fwy5a5oyZt3PFpdaS4=;
        b=EOWoArFNF3UIrArrOFzJQvKFCj9It2GCS5JF0sH2Sbwgq+bJp2qfSpJq/OGtIaD75z
         7Qt10VPUFp9W01QaprxyWmBO5ydf3Pmo8UrPOTAmewdE+r9yxbA+DoF+4RjovA8YSMZt
         pUTrXYgJ7ekMrQRjUQl/AVq2E/g2OUCKiiYMYSageIUGBaTii9Wy/AoOabU4CMzB/6IT
         2LUQwYjx5rfEW+Yg23nHKw5zXDAUCcrZFLOfOhx4EUZV+TN+UKkED4UwBtam3kxQ1s3m
         g8FAo0j/dsmR0F6oG6N8A9/8Bh4DEt3ORRIN6vhuSyHylWUAysgKXMV9q5njd0YA9VY7
         H9jg==
X-Gm-Message-State: AOAM533VLHX9em/7Vr6ZEDl/4cvPKtkGzIXi5UKFzhOAnJxd0aIs9qgo
        UXJneHRVyUL0ae5+44C221NUJEEa0xqP7Pf47OJa
X-Google-Smtp-Source: ABdhPJyh/2rdN/nxxKqd/9pZ1m42sM7/mFowcjf72RArlQQNNFljSAMOPNptA4jOUherbnGuDCs87QWDqzRtBF4nhSM=
X-Received: by 2002:a05:6402:650:: with SMTP id u16mr4787977edx.157.1639624458258;
 Wed, 15 Dec 2021 19:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com> <61B9BF2C.6070703@huawei.com>
In-Reply-To: <61B9BF2C.6070703@huawei.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 16 Dec 2021 11:14:09 +0800
Message-ID: <CACycT3vbaa-XAjnFA921dC7kXH8WKPXpJ+OXvS-5SdVx8qqgVw@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Introduce VDUSE - vDPA Device in Userspace
To:     Liuxiangdong <liuxiangdong5@huawei.com>
Cc:     "Fangyi (Eric)" <eric.fangyi@huawei.com>,
        kvm <kvm@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 6:11 PM Liuxiangdong <liuxiangdong5@huawei.com> wrote:
>
> Hi, yongji.
>
> In vduse patches serial[1], you said "The support for other device types
> can be added after the security issue of corresponding device driver
> is clarified or fixed in the future."
>
> What does this "security issue" mean?
>
> [1]https://lore.kernel.org/all/20210831103634.33-1-xieyongji@bytedance.com/
>
> Do you mean that vduse device is untrusted, so we should check config or
> data transferred
> from vduse to virtio module? Or something others?

Yes, we need to make sure untrusted devices can not do harm to the
kernel. So we need careful auditing for the device driver before we
add more device types.

> Because I found you added some validation in virtio module just like
> this patch[2].
>
> [2]https://lore.kernel.org/lkml/20210531135852.113-1-xieyongji@bytedance.com/
>

Other efforts are shown below:

https://lwn.net/Articles/865216/
https://lwn.net/Articles/872648/

Thanks,
Yongji
