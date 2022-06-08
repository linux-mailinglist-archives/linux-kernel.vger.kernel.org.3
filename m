Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76C542A03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiFHIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiFHIw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2439F2A46DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654675906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnBT58Y92YriRHNYFwkaJJZXg0dEepk6NxGeotGng9s=;
        b=CguiZdMPoC+Rbh6/NTkNLPHHf6FEWaQpiN/k0/q5EtKZUsnVa1oBy1FEw5Ks5SpHiODiN/
        kVl+XoI3mpXUdQCxtX1mj4n61FYaLdyhVXz59mK9Qbw4vbj8EdZSDXSFjyTGT3HLb0vkkY
        z6gFrz1gcVC80IUh2r2y3KkbZTuK5bE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-zqnrx_NMOaehSfMsnEnx9g-1; Wed, 08 Jun 2022 04:11:44 -0400
X-MC-Unique: zqnrx_NMOaehSfMsnEnx9g-1
Received: by mail-lj1-f199.google.com with SMTP id b26-20020a2e989a000000b002556f92fa13so3415861ljj.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnBT58Y92YriRHNYFwkaJJZXg0dEepk6NxGeotGng9s=;
        b=fmy/lPvsuCw+VnZRee6Ay/rw3SsjKawrBFTLfBOl2UVA+X3wM7/I+6WYfUVugwpOwK
         fBV8OwwIMlV5uMa7plRr2hUMd1SFPAypgKT5okoTNZCMKU+api7W9+X36rWUecRkwQAl
         sDnK38IeM/7sNvc7nuO+kdffbSlXDFOhMRaDMXEWwIIcsJkmnqIfzb+bIvt/ACNPb0YX
         QVH2PYnXBkpJmf1/Q12ky8kd0XdEVOsjzRc738XAa1LLt3Ll8pzS7gUJz/MGVh/noJvc
         vFOVeYZBfXKCLNwtzJYESM/eZGLLtE/W0HIsyO1lZfg2w1141RmVr/x9ny1GiCxLqW0j
         7ytQ==
X-Gm-Message-State: AOAM532Odq/dnoZX6/hsMPNNGayRjZ8/ZsLy+/l+Xlu4juZmoQNu5A2C
        KmLeeRa1IUJNxJpvbmy6MxuIN0cR29Y9ou9I6OdN5XMJr1O+XloUytHoz60RTuIA8k1tDihNm+t
        jHC1vPBHQWIWUP5JmQ1gIeFH6TzBAtVYqeB9Z8aHY
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr54616041ljf.243.1654675903266;
        Wed, 08 Jun 2022 01:11:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFLTmBIi19ULkbHjw6TAyJpy08J0Qcv4mWpgPuSLf8SO3gP77EMGa0hPs5LddZudYxdYh1mDiNswq8UEfjRtE=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54616032ljf.243.1654675903108; Wed, 08
 Jun 2022 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220602005542.16489-1-chengkaitao@didiglobal.com>
In-Reply-To: <20220602005542.16489-1-chengkaitao@didiglobal.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 16:11:31 +0800
Message-ID: <CACGkMEvrRmLZ6aqo8J8wxpuqWSbsa=oEOGS+g80bLQzDKv=bww@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: fix missing put_device() when
 vm_cmdline_parent registration failed
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, smcdef@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 9:12 AM chengkaitao <pilgrimtao@gmail.com> wrote:
>
> From: chengkaitao <pilgrimtao@gmail.com>
>
> The reference must be released when device_register(&vm_cmdline_parent)
> failed. Add the corresponding 'put_device()' in the error handling path.
>
> Signed-off-by: chengkaitao <pilgrimtao@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..1dd396d4bebb 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -688,6 +688,7 @@ static int vm_cmdline_set(const char *device,
>         if (!vm_cmdline_parent_registered) {
>                 err = device_register(&vm_cmdline_parent);
>                 if (err) {
> +                       put_device(&vm_cmdline_parent);
>                         pr_err("Failed to register parent device!\n");
>                         return err;
>                 }
> --
> 2.14.1
>

