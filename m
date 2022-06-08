Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC55421FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiFHEpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiFHEpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 128FB13F1DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654655750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4gannku3cD3bDCFoY39hZ+ipBpvR06huyXSqGOx7GQ=;
        b=eW1vAERXGyx4xCnFdf7cnwbawxDm/EzWRcNOAkO1PCfGV6d7RGXiBiz/1wQSM4awpKNCah
        tE8IKuOAwZqf9c6jHXMFY8fJNGi8Lt7IMKXbIsmh3CzJ+nnGsoYCcImFAimjFdt0PONwJN
        ysBJ1sRNIsnnoOtlbF6rMq6lkBaONRk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-WX1s9hcCPh-vf0yXsnKE1w-1; Tue, 07 Jun 2022 22:35:48 -0400
X-MC-Unique: WX1s9hcCPh-vf0yXsnKE1w-1
Received: by mail-lf1-f69.google.com with SMTP id c25-20020ac25f79000000b00478f05f8f49so9517984lfc.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4gannku3cD3bDCFoY39hZ+ipBpvR06huyXSqGOx7GQ=;
        b=qlLbAmE/Jgrm4Hlb6u2A6uRZb4X98EAskn5o6ckAh0o4egMGJOPJNDkUn8rCMdaKPS
         RrOcTxkJsjfq7N/j2qFc3dqUsEgzXqFPLh+4ag9r1SAtzySgYbNs1mzPj/SDP/c7JXNL
         yS1aXUiXKxh7jMQTSLgcuNZUjBnVU1Iui0UGNaMYruc2h1zf0FJ4Uy9WCzdZrI9uNkUC
         IkvnfzwP12GrY+72JSqKDB0fOvndSvUbIcqtQDs7l+jjMLKKP1z8c6EUC5mdz2+5x5+V
         ZiuzA0jc6rfkbFEmHLcP2qt6aJ0dDTIOJwCnD6kYOBeC9Qo5wNVfVmwhREtu3r00b5ml
         QsEQ==
X-Gm-Message-State: AOAM530EBzbbAThUj3mWEW9ZdPUw9MAeQx6zVUQZWm9Bpol995ADnXEl
        C9W0AoRkh5bv3bQRj/4cfWakYcLGVUFtW2ycvsjnBjwD36OY5EXVlnvg6edztHMzW//L2YRN1zO
        8v7/KpniWD+h6gRo6VdyK1mgC1jgNxw+uW5Ocyqum
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id p16-20020a056512313000b00479385fe2acmr10282602lfd.575.1654655747453;
        Tue, 07 Jun 2022 19:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6PTdL2iQbnlRkFFk3B+toTiehZhE3ZjEV06tKErjTWBkqxnS3ACVhG1QE08Nfywp1LEi9aACvUeNgRUIS7EQ=
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id
 p16-20020a056512313000b00479385fe2acmr10282595lfd.575.1654655747247; Tue, 07
 Jun 2022 19:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseR-vDzgei21jftC8Grm0Not+e1XEefyLgV8C4yfWOHQ@mail.gmail.com>
 <000000000000a09fc105e0e5bedb@google.com>
In-Reply-To: <000000000000a09fc105e0e5bedb@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 10:35:36 +0800
Message-ID: <CACGkMEt_e59wRotUo9D1UqubAhe+txy0GF=r1BYBVdND8-uKbA@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 9:37 AM syzbot
<syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in add_early_randomness
>

Ok, looking at virtio-rng.c, probe_common() tries to kick the
virtqueue before DRIVER_OK which is kind of violates the spec.

Please test the following patch:

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

