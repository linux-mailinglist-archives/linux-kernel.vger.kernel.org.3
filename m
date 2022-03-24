Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED224E6041
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiCXIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiCXIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514F09284B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648110049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqYtQSBegGxeYkN/lgul0x/vukAzbn7E8fW29poebx4=;
        b=PguHiOGvxWhcuQjup2jN0A2xmzWb3mTXV4zlW/VpGD8RLwe7ECoraSDos/gnEzOV67CB3r
        a0r10xHXq3+bOUIoPP8Gv1MG9mCkg7BVXrCeXKi/x+RKGj2t2DBzuqsWAe/nvVrth7QRSZ
        I0EsdS9feZNzV3Mo9C4xgT5QXJwRnoI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-jSCATG8cPkWXfhy8-bBTCg-1; Thu, 24 Mar 2022 04:20:48 -0400
X-MC-Unique: jSCATG8cPkWXfhy8-bBTCg-1
Received: by mail-lf1-f72.google.com with SMTP id bt40-20020a056512262800b004481fbe2d29so1473882lfb.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqYtQSBegGxeYkN/lgul0x/vukAzbn7E8fW29poebx4=;
        b=SOHBk5iNpB2yx8MfTvgf0K7EGHf9rXViQPJPwZgwHP1ZgMoIqtHUTM39XV1gIykSOt
         +UYn0lxQhkGgxQaUZrSA+zlnLIsjhCbk0+UPVXOrGA5hyf9w/kXIIAuYf8PH9NvbataV
         jQWIz4w1WpONMSq0ULaApzkqhNkyRrc8wM1gjr2jsJxqZ9lgG8ol0hD9+2sntyUzvo/7
         dERBnCW409G+Qr83bdllRPHI+sbZ8Mq1U6MLA9N+gOISV23HNiGYtUL3grbzfVISA4q8
         CJU9IptplaD08nw9a6ORmBCszd54Wu5GDXyOTl6xBxPkoo2wk1hQPbQ+OtEV6BioTmek
         vXJA==
X-Gm-Message-State: AOAM533u1pWO5x7MDKPUehAtoUW4mm2nqjw8nBmiJlNabrqTlRDGp2c2
        oiWD5XABiLaIbBImRGqXoONC4yG3wK9DFpd2DDMfLwwEk6taeL/h/wN9RH3thJ8Apbj6ahPTH+Q
        8F+ildIDvhaMLRb5Ul39TzxV4z0bY/nCXerTXB9Uv
X-Received: by 2002:a05:6512:108a:b0:448:756a:f5fb with SMTP id j10-20020a056512108a00b00448756af5fbmr3005740lfg.587.1648110046271;
        Thu, 24 Mar 2022 01:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfT0Xe23zFs2/wV2CRifK0H0/uU7lnCg6gAd91jtsZiI045kyG5D8Pur9xXbLwQeiPG1qsVOPoSkmKIloAQqY=
X-Received: by 2002:a05:6512:108a:b0:448:756a:f5fb with SMTP id
 j10-20020a056512108a00b00448756af5fbmr3005727lfg.587.1648110046028; Thu, 24
 Mar 2022 01:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com> <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com> <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220324021428-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 24 Mar 2022 16:20:34 +0800
Message-ID: <CACGkMEuD-9cHmZotAwdLSecmBtWhBS0qxhSKfZ84e9_wS4E4EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, Eli Cohen <elic@nvidia.com>,
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

On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > >
> > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > >
> > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > workqueue forever which is still suboptimal.
> > > >
> > > > Usually it is barely possible to shoot two birds using a stone.
> > > >
> > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > another cobble is to add another line in the loop checking if mvdev is
> > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > workqueue.
> > > >
> > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > {
> > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > >
> > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > >         destroy_workqueue(mvdev->wq);
> > > >         _vdpa_unregister_device(dev);
> > > >         mgtdev->ndev = NULL;
> > > > }
> > > >
> > >
> > > Yes, so we had
> > >
> > > 1) using a quota for re-requeue
> > > 2) using something like
> > >
> > > while (READ_ONCE(cvq->ready)) {
> > >         ...
> > >         cond_resched();
> > > }
> > >
> > > There should not be too much difference except we need to use
> > > cancel_work_sync() instead of flush_work for 1).
> > >
> > > I would keep the code as is but if you stick I can change.
> >
> > No Sir I would not - I am simply not a fan of work requeue.
> >
> > Hillf
>
> I think I agree - requeue adds latency spikes under heavy load -
> unfortunately, not measured by netperf but still important
> for latency sensitive workloads. Checking a flag is cheaper.

Just spot another possible issue.

The workqueue will be used by another work to update the carrier
(event_handler()). Using cond_resched() may still have unfair issue
which blocks the carrier update for infinite time,

Thanks

>
> --
> MST
>

