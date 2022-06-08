Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C6542517
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiFHFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiFHFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8A8271A94
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654656616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoU/O6w4YUxRgQevDzGWElcceiZ5d1yaMFWFpbdwK/w=;
        b=I0BQ566MC2XU/6BQF7zKJZY0U8Xsk73Vc4ZZ8Bf+vXzVxHXy2qYi6BgvgVR397k4umlbrA
        YSc930TE8D4d9kZrCxL1mAmmPH/8UGkUjtCpLvd3H+3yiMy5GY/Tk/jtFl5iVPL/McbCQj
        U2Ct37V9XS4yqCW38cZfyQSwOCRPaG8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-6_qHXYHkNLKuR14fEobOlg-1; Tue, 07 Jun 2022 22:50:15 -0400
X-MC-Unique: 6_qHXYHkNLKuR14fEobOlg-1
Received: by mail-lj1-f200.google.com with SMTP id g13-20020a2eb5cd000000b00255ac505e62so874458ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoU/O6w4YUxRgQevDzGWElcceiZ5d1yaMFWFpbdwK/w=;
        b=t+GYakarjG+icWWG6GM3rfseK8EeJJoBYduHsTuLbPL+p7ZNNGiaJpugHGVFu8XnTD
         mBy+4AQvlwhq14zL6DC8W6DNLqcqXCKZhLwJXx4qesRoz5xucvAiVB1exNutVBewxcSy
         rVuOBhujvlqx43FJ92JJdpdJHoeewLeYZUXjZOEEsERpLxpkT2GhBRS6rr/gHMEovQeD
         lmkCWivfvyXHqKRdWUzmvv6edjv1N66eo1SyId5FLYlRdJYvfhIDu7DjdtyUJ3FFl4Ic
         DONMP2mn3+MGTaIDA+5fMX+i89JvKicHY2XJvku/JPdm2acpB/y1xHFi3c0CyDQH0vZT
         qbhA==
X-Gm-Message-State: AOAM531pv81ONl1NXFhdXx3ib16cQ4HNCtYzolNRgp7mEtsTE/8j093z
        lnXzC12OLYjeb7akzicPS57xOn/xgoORFOBsmKTDy5+YXDNp2UR8Ud5CEvVC+meXO5d9U3tlFsO
        vV/WhIbjVZZ4SC9oSSNmk8On3wV7QR6vbvi3+SMfJ
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id p16-20020a056512313000b00479385fe2acmr10304382lfd.575.1654656613666;
        Tue, 07 Jun 2022 19:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/wfYs6HkHvDClc0YAeZNLik8QgxxmOJ07fcWIYgWskZhjMfRl7qmsfjJQ28CN49VdSzGUpv/CZ6BO3tueZYs=
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id
 p16-20020a056512313000b00479385fe2acmr10304377lfd.575.1654656613505; Tue, 07
 Jun 2022 19:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEt_e59wRotUo9D1UqubAhe+txy0GF=r1BYBVdND8-uKbA@mail.gmail.com>
 <0000000000002cccbd05e0e69570@google.com>
In-Reply-To: <0000000000002cccbd05e0e69570@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 10:50:02 +0800
Message-ID: <CACGkMEvtV+hVdpgpkYvAmkRteYDN+2dDacrfXsYDv0ZzjJU+ag@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
To:     syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, mpm@selenic.com, mst <mst@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 10:37 AM syzbot
<syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file drivers/char/hw_random/virtio-rng.c
> patch: **** unexpected end of file in patch
>

Copy-paste error :(

Let's try this:

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

diff --git a/drivers/char/hw_random/virtio-rng.c
b/drivers/char/hw_random/virtio-rng.c
index e856df7e285c..a6f3a8a2aca6 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -159,6 +159,8 @@ static int probe_common(struct virtio_device *vdev)
                goto err_find;
        }

+       virtio_device_ready(vdev);
+
        /* we always have a pending entropy request */
        request_entropy(vi);

--

