Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA122551555
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiFTKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiFTKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6E8DE00
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655719672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgVcDHw4y4i1yqOyETruaMd5WfZ9yBBb+VW8a8NufLc=;
        b=VrH6E5/Qydq6kvVMVox4Z9kpO4G0FSaQwJU30mrFxmw98JMHBr00l3dlZgaBEUCR9w1cRc
        8VJK1J6FjcGdLKg7Dp+Mar+aSXVLiK1Gdh3sxXh5ewlFBrXXL/rKObXn5ttI6Qf7/Cmo0F
        aBa9kX0WNNMx31zsdarB3WcCbn+UlQE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-qIyJhqcQPx2SFK7jeIrdRg-1; Mon, 20 Jun 2022 06:07:51 -0400
X-MC-Unique: qIyJhqcQPx2SFK7jeIrdRg-1
Received: by mail-qk1-f200.google.com with SMTP id k13-20020a05620a414d00b006a6e4dc1dfcso12519335qko.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgVcDHw4y4i1yqOyETruaMd5WfZ9yBBb+VW8a8NufLc=;
        b=JC6k36FCayzz/yzFm2frgER2+Gc4NJOg1h3svD15nvUWhHYmpC1cyWG5ybaC+xCqxf
         UAI7cr2KS4TlgMFPBzoDQhVCEgFMCkWr61c47u9apclN/e4lY+0Xe6rnprKy/ss4AqnN
         lNTjFuhausKj+KtvRD8lA3YnnT7tRICIqIwEdvAJ3dx6RcOw/RtvYyjp0Yw3jP0fohz+
         ueqhYNKcW7AXHudWEyd2WyOX6FEidAh9mh5M+iNyIs90vkatP+Qg/0pQmxMLK6V/rUdX
         tG9ZFL/lnJw908M2yfSuiVgSp0buuh4Nmbj3C89oJyV6pmYiekcvfuOgGENXUOdsYY1n
         otqA==
X-Gm-Message-State: AJIora9tOVMcJVv/fg9FL0WqKwQhbVXDgbQrQFgHI3eYU+KTmG0Cg/hH
        lwwMzoYnXLrHspaR91iFu7lcMWylIBdIM2vkk4fZnGN/qTijNFlppL/xVg8EARWDcqAI/lNttSJ
        8FnIZvbZS9uAyde9PlvJJe10KdY2ZkCU1roDa67dl
X-Received: by 2002:a05:622a:252:b0:305:2d69:edef with SMTP id c18-20020a05622a025200b003052d69edefmr18308843qtx.592.1655719671281;
        Mon, 20 Jun 2022 03:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/JpPJxd3kFqYEHb0cVULRKjEwrZKc2C1kN0knT8Bw5EEdOvwBb5fi2pYfGp+MwdD/6em5b+bAsFlYXTy9nTA=
X-Received: by 2002:a05:622a:252:b0:305:2d69:edef with SMTP id
 c18-20020a05622a025200b003052d69edefmr18308831qtx.592.1655719671086; Mon, 20
 Jun 2022 03:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-2-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-2-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 20 Jun 2022 12:07:15 +0200
Message-ID: <CAJaqyWdGszhrP7dNXT9zTVXUmjoA5FquUKh=yrtkJ6dJqE4OyA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq;
> +       int i;
> +
> +       if (!suspend) {
> +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");

If the resume part it's a problem, maybe we can split the vdpa_sim
series so it only adds a callback to suspend() the device. If needed,
we can add a resume() later. suspend is the only operation we need to
perform LM.

Thoughts on this?

Thanks!

> +               return -EOPNOTSUPP;
> +       }
> +
> +       down_write(&ndev->reslock);
> +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> +               mvq = &ndev->vqs[i];
> +               suspend_vq(ndev, mvq);
> +       }
> +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> +       up_write(&ndev->reslock);
> +       return 0;
> +}
> +

