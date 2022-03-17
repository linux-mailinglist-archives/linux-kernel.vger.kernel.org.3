Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944C64DBD90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiCQD1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCQD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A288D35DE2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647487567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2SLUI2o5WSRk9a3lKvJBCeORiM/sUU5CpB7omPJTl4=;
        b=RFzoaWd6gtjxhDoPT2qu1BOaIm0bDmOYI+We9hh9V3iC/Yxip6vkEgDMfM5ZXWee/1DAUN
        9c0q/nojXdM192HTGEiRz0oh3yIdwVCax+kkGdwtfUgnxIGUWN/qUM83av4Toe0iX7n+w4
        /ZTpemV15IoeCvstL+sFtGOmYkTueX0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-7QnVfYRyNsiG6C9IlO0NvA-1; Wed, 16 Mar 2022 23:26:06 -0400
X-MC-Unique: 7QnVfYRyNsiG6C9IlO0NvA-1
Received: by mail-lj1-f199.google.com with SMTP id 76-20020a2e054f000000b00249606fea4fso279171ljf.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2SLUI2o5WSRk9a3lKvJBCeORiM/sUU5CpB7omPJTl4=;
        b=DfnNrrqEdJnSsnmb5H3l2jYG6sngAaxVK571OQqKL6u1GpY/awigPcpzMCArHglNwA
         nX1a/2qEfidC42kDkX+TwTuvj6BdCIxXJVrYl/nU7z/k6Xr2HV8BEfTh9SZRO/2iucx3
         ZmZwx21hM/MOdbsS6IJiB5Zc8ANoMIO8EqEQG0xbKzVTJVjle+JF0YYH9/9rPYvSZSwc
         yHhYHI5+6XbyG/ww+cJLz1wPI0fz/InD/TP2ktYHEVpvlRvo9Q7OFsewVFVVyuiF2xYy
         NDtZAQgIeQctPseRRyhkjBgpj8ZsumGpVMiPjGQ5cUdUFoS9TLouEKbpITJg7K4QGPsA
         amvw==
X-Gm-Message-State: AOAM5339YZjidMnMGCZKYBR9qCREbsh/ybyG2p1YX9vS9/Bcp9FjiIt/
        OW/QOplKdeXJ+mQ9XOFX8ytW94hTyl79gapo+WYctAQXM3OM51+iNInpC5vLm/K3WSmXQHLXhVs
        qG4/ffq2MaxItzP5SoN26/bmy3P+w/y4m26wGp5s3
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id z9-20020ac24189000000b00448bc2be762mr1484749lfh.471.1647487564798;
        Wed, 16 Mar 2022 20:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXgM3TrKtjE8JRO+JLQ4gZHrItL2DfPkyIFRVyKVrsUjNu6z7Jg/bAU90mtxG6avLG14+uPzJmzqIeygxmack=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr1484712lfh.471.1647487564603; Wed, 16
 Mar 2022 20:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220316192010.19001-1-rdunlap@infradead.org> <20220316192010.19001-6-rdunlap@infradead.org>
In-Reply-To: <20220316192010.19001-6-rdunlap@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 17 Mar 2022 11:25:53 +0800
Message-ID: <CACGkMEsX4bS+wmmOE=L5COZxsdFCZmbLTnCe4fZs58MZRx+tQQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] virtio-scsi: eliminate anonymous module_init & module_exit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Igor Kotrasinski <i.kotrasinsk@samsung.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
        Joachim Fritschi <jfritschi@freenet.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev <netdev@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 3:24 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Eliminate anonymous module_init() and module_exit(), which can lead to
> confusion or ambiguity when reading System.map, crashes/oops/bugs,
> or an initcall_debug log.
>
> Give each of these init and exit functions unique driver-specific
> names to eliminate the anonymous names.
>
> Example 1: (System.map)
>  ffffffff832fc78c t init
>  ffffffff832fc79e t init
>  ffffffff832fc8f8 t init
>
> Example 2: (initcall_debug log)
>  calling  init+0x0/0x12 @ 1
>  initcall init+0x0/0x12 returned 0 after 15 usecs
>  calling  init+0x0/0x60 @ 1
>  initcall init+0x0/0x60 returned 0 after 2 usecs
>  calling  init+0x0/0x9a @ 1
>  initcall init+0x0/0x9a returned 0 after 74 usecs
>
> Fixes: 4fe74b1cb051 ("[SCSI] virtio-scsi: SCSI driver for QEMU based virtual machines")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/scsi/virtio_scsi.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- lnx-517-rc8.orig/drivers/scsi/virtio_scsi.c
> +++ lnx-517-rc8/drivers/scsi/virtio_scsi.c
> @@ -988,7 +988,7 @@ static struct virtio_driver virtio_scsi_
>         .remove = virtscsi_remove,
>  };
>
> -static int __init init(void)
> +static int __init virtio_scsi_init(void)
>  {
>         int ret = -ENOMEM;
>
> @@ -1020,14 +1020,14 @@ error:
>         return ret;
>  }
>
> -static void __exit fini(void)
> +static void __exit virtio_scsi_fini(void)
>  {
>         unregister_virtio_driver(&virtio_scsi_driver);
>         mempool_destroy(virtscsi_cmd_pool);
>         kmem_cache_destroy(virtscsi_cmd_cache);
>  }
> -module_init(init);
> -module_exit(fini);
> +module_init(virtio_scsi_init);
> +module_exit(virtio_scsi_fini);
>
>  MODULE_DEVICE_TABLE(virtio, id_table);
>  MODULE_DESCRIPTION("Virtio SCSI HBA driver");
>

