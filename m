Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D745627FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiGABIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGABID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C5B7599E7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656637682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZzUciZDJ7qUGpwrJbdbnvPYQFAmuJY/A8ujZXjUH20=;
        b=RiKO2sZY5OAzT+ZXcHqsD5UjY8OQxjD+yuUUupPW/iK/mwfaalJOQP69J7kcqhtfHhznX/
        EjPo+8flDWlutEIqpfoKIcb5Pp4EH8DmtcWCpsSX9CoA6/sl9KOedAjPBxv0efTjtHkntP
        jzJ7cTObqLVokTYqcEF3+7gdPOgdjEo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-5-X2t7CwNMiXwpqqTvrRAw-1; Thu, 30 Jun 2022 21:08:00 -0400
X-MC-Unique: 5-X2t7CwNMiXwpqqTvrRAw-1
Received: by mail-lf1-f69.google.com with SMTP id e8-20020ac24e08000000b0047fad5770d2so360541lfr.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZzUciZDJ7qUGpwrJbdbnvPYQFAmuJY/A8ujZXjUH20=;
        b=gNWCZZRRSDLF02VcDVENptZgpbFlK1vcgu/nHm1LUSAGgbN1gUFX9YZW/jpOVtknmE
         cm3piYa6ujidxW4vsWI4URtAPSyaKlHsFgHyFlLbv3uPk3Z1FIKqCUJuSbr/asMizUbH
         lGDZeznaeiCWWF832RVIfVC7t+0Z27yHc1snSwpGlvJAJFarMKc5tGfZ1ZZgV79J2irC
         27i7PECkgn5xQAVU75N+ZX/PmKiCmFujp3g0+52wJHZGTEbr5dK2df3KOr6F0lvYwMFh
         bOmgYIP/Luk9vwtR9k5oZeAW90d7b7GoU8JEZ5kcwmPAqCaKbFuJJUCyn4tfvmL2vMw4
         JpNA==
X-Gm-Message-State: AJIora9YQfOrSAeoro/jnBgvSQwM860VUP1CEiSFHbiYP/DN6BnnEtbh
        c3Lt/dAUbT/kjcaQJsXLlRxCw4YvTNVyHkTWVq40fu4q4bFXgpazrnvHG2gyfTWUpus1yqJ5EGb
        BXv6+45HbAt551kpo+BO/UP8C1TkmddpkPb/7vkk/
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id g3-20020a05651222c300b0047f704b3820mr7361327lfu.411.1656637679293;
        Thu, 30 Jun 2022 18:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toB1nW2NBVDvG6XfbzuIpDkAVyjnOPGmQL5GWlI8LDvk41Vdbw2Hd1Wd+7GUaoZYtT7I7ie0BytPeEGakgxcY=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7361316lfu.411.1656637679072; Thu, 30
 Jun 2022 18:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220630191559.16738-1-mst@redhat.com>
In-Reply-To: <20220630191559.16738-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Jul 2022 09:07:48 +0800
Message-ID: <CACGkMEsLm=si3a8PiuAnkXxOud719_unNtQ7gbjAVD1ZVquf=A@mail.gmail.com>
Subject: Re: [PATCH] virtio: VIRTIO_HARDEN_NOTIFICATION is broken
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 3:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This option doesn't really work and breaks too many drivers.
> Not yet sure what's the right thing to do, for now
> let's make sure randconfig isn't broken by this.
>
> Fixes: c346dae4f3fb ("virtio: disable notification hardening by default")
> Cc: "Jason Wang" <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index e1556d2a355a..afb9051e0125 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -31,11 +31,12 @@ if VIRTIO_MENU
>
>  config VIRTIO_HARDEN_NOTIFICATION
>          bool "Harden virtio notification"
> +        depends on BROKEN
>          help
>            Enable this to harden the device notifications and suppress
>            those that happen at a time where notifications are illegal.
>
> -          Experimental: Note that several drivers still have bugs that
> +          Experimental: Note that several drivers still have issues that
>            may cause crashes or hangs when correct handling of
>            notifications is enforced; depending on the subset of
>            drivers and devices you use, this may or may not work.
> --
> MST
>

