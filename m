Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BE5A406F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiH2Aof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Aod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C5101E2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661733871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TykdAivd2LEYHVOXlU8fC3DRzq2oxD33Z0Ct9UAkNAo=;
        b=iVDj6C3dBNdHNDojWQAwBFievRU0scpys2cZ5q/v6vGDS/x/VI+L1H00nm6auBh3XHyQLC
        DRnM7BK3uY6cxWNcplvnfxCUn/Wktr/RwVBwL3pXNnNyFIx0m9A1FWRaOQv42oXTgdSZf2
        ofSytRmWZ4CcFNmq7COJXdCpXcldv30=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-ZB9xtelQMDOKDE6cKCXSnA-1; Sun, 28 Aug 2022 20:44:30 -0400
X-MC-Unique: ZB9xtelQMDOKDE6cKCXSnA-1
Received: by mail-lf1-f70.google.com with SMTP id w18-20020ac25d52000000b0048af13b6ef6so1560520lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 17:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TykdAivd2LEYHVOXlU8fC3DRzq2oxD33Z0Ct9UAkNAo=;
        b=p4/VzYgJ92fo6tMxfdxfFmkqXV9CPFF3fDErJWb3HWCWfJlaNCJb4qlwNfsFUsE0tQ
         4CSIHY0PZbyu6GzygIZj1i0RI/bdrZC7/MGSoO23tCpiM0RfqJXgkTmRh1/j9uIjKrOI
         JKe8miEfHG3IxKsw54cQQSFJyIEqjLJDMMYgSKeGZBt2nzm0sZX+ynwAeOhoIPR8ns0M
         JHRnLgS1ZAUEZ2vpz3DwPUFbjDRMGzv2+6DpwJV36RGpzGH5EHO4MCtGi1ilSTg404Vf
         /gue8jXzekd2i8Vg+xVPXwSasFEVJEshTpIYjHh9/Ec/xYVmOX7aHbTb3X9Qeif2DVm6
         8h9w==
X-Gm-Message-State: ACgBeo32dds/c9rf+mV0Ptb7JGm1/bR4PEOpPm7YUWucxSH8u3kch1dv
        7LB2yWGDRDVuN/NNtfnq2ztnyaKAFRigqxdBQjqMhUl9ORvyj/LOB47hD+UAnE3lm+ve7qleF0B
        +V4xTrAF8KHSlhT3gg9DFistDtaMt+T+/7G62DHtb
X-Received: by 2002:a05:6512:1518:b0:492:d08a:a360 with SMTP id bq24-20020a056512151800b00492d08aa360mr6380631lfb.238.1661733868733;
        Sun, 28 Aug 2022 17:44:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70MD0oSJ0ZjSxYT1B9kZV5EV7+PMpjfUUNkjfv1EXfC/HPAEVqQZExv5RBjzwBAQ4co6mpfUo0DzpgdNaciTM=
X-Received: by 2002:a05:6512:1518:b0:492:d08a:a360 with SMTP id
 bq24-20020a056512151800b00492d08aa360mr6380627lfb.238.1661733868575; Sun, 28
 Aug 2022 17:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220826161605.559317-1-maxime.coquelin@redhat.com>
In-Reply-To: <20220826161605.559317-1-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 29 Aug 2022 08:44:17 +0800
Message-ID: <CACGkMEt=WOBuF0M7PyY_y4pdpANW96_ku78cRuCKTR4-v+_q_Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: prevent uninitialized memory accesses
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eli Cohen <elic@nvidia.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yongji Xie <xieyongji@bytedance.com>, mst <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:16 AM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
>
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 41c0b29739f1..35dceee3ed56 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -673,10 +673,15 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>
> -       if (offset > dev->config_size ||
> -           len > dev->config_size - offset)
> +       /* Initialize the buffer in case of partial copy. */
> +       memset(buf, 0, len);
> +
> +       if (offset > dev->config_size)
>                 return;
>
> +       if (len > dev->config_size - offset)
> +               len = dev->config_size - offset;
> +
>         memcpy(buf, dev->config + offset, len);
>  }
>
> --
> 2.37.1
>

