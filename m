Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A24E5D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiCXCf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCXCfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2305F59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648089263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZgZoSoq2Ajh3ptSZyqEaLy0ew178lVliWAwMQIyGhQ=;
        b=cXjVBGwMv7vKbb3zUtHISghkILdKHR7FrkbyJWDLcBeZSaLMy2R88ODB9ofC+AtkbaEUyM
        kWZ1R79NhMu3mlfEMbDw3eEseBd8JlJmhrQRDNAXWwylPoxLqIl9LCDaBE6JQ0tXnAJMMV
        kRSXpgtLTNKTnk2w+1kVTOMjuUGY4JU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-kEzCe9IWM5S_tY8L5S4Igw-1; Wed, 23 Mar 2022 22:34:22 -0400
X-MC-Unique: kEzCe9IWM5S_tY8L5S4Igw-1
Received: by mail-lf1-f69.google.com with SMTP id w13-20020ac25d4d000000b004488cf80eb1so1206015lfd.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZgZoSoq2Ajh3ptSZyqEaLy0ew178lVliWAwMQIyGhQ=;
        b=nyFjb/3mTYbPhvqrW8J4z05UU+QfEpLlCbqlXyHkEKCtMGpedxSGHghKq+P/oCLlbP
         MHx5n3/KSDVFXllT5izSB4AeuGE9O4Ro9uVyWjP3xQsI+27y9XVWxrhz/Qw/BqL0fkk2
         aUmIdC+Ypgs8T7QaL6EzPNimVpVvxnBtV1ILlICQtvXf/WjuKAU8TkWsXfIcIDIR6/u/
         f8x309b0ETsD2XPhOuHI5b1uG14x4G27FdCoR23kysRjJpWURUy/AockOZPzUKU6zRm3
         E3Cbzj5TRcRX9OmaUeLbz42iUGmT7AszASXtk3Ci46Y1diF4EKUsKf2BvQYcZEYKBkWG
         rbzQ==
X-Gm-Message-State: AOAM530AzhDSIYdauE5v0652Amu7z5yTVQHMpfNOV/1sNOg+uddOT1JO
        ubEYFkGDjOErWqBDc/jTjD5eW5rApGepfZwGnmRZ5dtsPkSFZLQo0JNUMhRBU140BzRHlZml+CQ
        qf+0XKcWT99Vn/mi+KHP0xjH3c/polhYeWzOQFgmu
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr2163467lfd.190.1648089260746;
        Wed, 23 Mar 2022 19:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgjxViUv3QZ02fLzvUCLI93q8I4pGTbyS8uaLbqsbMnU9Ozt3C8qezHbBI6I2b8SkXRulI8T1pzOsiVyRVteM=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr2163460lfd.190.1648089260578; Wed, 23
 Mar 2022 19:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com> <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
In-Reply-To: <20220324005345.3623-1-hdanton@sina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 24 Mar 2022 10:34:09 +0800
Message-ID: <CACGkMEt7i3aA+qnsBjyvoZLFBsmbg3vDvvjd_N2MnJeJ8DuY4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To:     Hillf Danton <hdanton@sina.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> >
> > Yes, there will be no "infinite" loop, but since the loop is triggered
> > by userspace. It looks to me it will delay the flush/drain of the
> > workqueue forever which is still suboptimal.
>
> Usually it is barely possible to shoot two birds using a stone.
>
> Given the "forever", I am inclined to not running faster, hehe, though
> another cobble is to add another line in the loop checking if mvdev is
> unregistered, and for example make mvdev->cvq unready before destroying
> workqueue.
>
> static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>
>         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>         destroy_workqueue(mvdev->wq);
>         _vdpa_unregister_device(dev);
>         mgtdev->ndev = NULL;
> }
>

Yes, so we had

1) using a quota for re-requeue
2) using something like

while (READ_ONCE(cvq->ready)) {
        ...
        cond_resched();
}

There should not be too much difference except we need to use
cancel_work_sync() instead of flush_work for 1).

I would keep the code as is but if you stick I can change.

Thanks

