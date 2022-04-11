Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF64FB66F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbiDKIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiDKIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021BA2DFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649667164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vhVjgwfYwcRcHV2AMePulXHtfyrvzl0sIkmLC3McIg=;
        b=QuFbQvr0bXNHkOQz/4HbDnCSqg9oNWDNYJRfd+emRgYkwCeq9kFEe2UU19i8pslVNxmCxb
        OrG/nLdCZ0As652ODMa2mGsHxJStVQjJ8MjcPymn3CXwWI4nUm4PkL9n7eQarlnnkPwzFi
        XXgIFUnXl9J61WzhFGQSNLoNSRuexLE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-fmOP-I5oN86C4l4VcrKoSA-1; Mon, 11 Apr 2022 04:52:42 -0400
X-MC-Unique: fmOP-I5oN86C4l4VcrKoSA-1
Received: by mail-lf1-f69.google.com with SMTP id h10-20020a056512220a00b0046ba3b7febfso604649lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vhVjgwfYwcRcHV2AMePulXHtfyrvzl0sIkmLC3McIg=;
        b=yrhkfGxPtt6TahcCR1Pcl55dI6FrNiXnhtV3Ds9nx34hnKc1lCiZDv0v282rqqrFNz
         GLGYRy9Oug8yb4NtSAPAX8MRy0UNQNPPbPOQgl5lT28YoMu1QcOzsUy+xwDY5GXKTa+P
         ogJkJUpq736rOS9552DkcUOL8olwBLQ9eBsmjP462OLKCg6OH++v7QO4sL4w+PaFFSVc
         lE+MfqmIfMxq34GOT5dOwop8qcKLsaMKDljyOF85JG8OW45zgq0geWfiPHjxgc4Ep2t1
         eH0sOla2GCNQi5vtYCSG98QeSGfUHX/sVesvfSW2c88YggCFRVpj7rV+NbnPLcOhlulq
         aSRw==
X-Gm-Message-State: AOAM530Vm0k39nVP4R0Xw0zAu486BmSGWi7KUXcSTzD6VHYe0fI4MMQt
        F+fybt8L+vPQg09tPzzDkWVYIG93+kJX8GnIkO7MkQiMSLs2/ZS/CnC2tmqdPhNNEFP+PaO2Qyk
        LT8tDJP0NtISYXxusi5+umWSBxH8y9Q8LQIK3IcGk
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id t10-20020a2e534a000000b0024af64fa1d6mr19829764ljd.315.1649667161213;
        Mon, 11 Apr 2022 01:52:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaCCcq7nzVRPmSTC73Cx4/AdfiCOSQZBHo+c8EM69IwSw30oxA7oVSPieHafcAVtM2ZPlOdRk8jntSD0+GICQ=
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr19829758ljd.315.1649667161018; Mon, 11
 Apr 2022 01:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Apr 2022 16:52:30 +0800
Message-ID: <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: drop phys_addr_t typedef
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 9:39 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote=
:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With commit 884ee1e585ca ("tools/include: Add phys_addr_t to types.h"),
>
> When building virtio tools, there is a type conficting error:
>
> "
> ./linux/kernel.h:32:28: error: conflicting types for =E2=80=98phys_addr_t=
=E2=80=99
>    32 | typedef unsigned long long phys_addr_t;
>       |                            ^~~~~~~~~~~
> In file included from /usr/include/linux/virtio_blk.h:28,
>                  from virtio-ivshmem-block.c:29:
> ../include/linux/types.h:69:13: note: previous declaration of =E2=80=98ph=
ys_addr_t=E2=80=99 was here
>    69 | typedef u32 phys_addr_t;
>       |             ^~~~~~~~~~~
> "
>
> Let's drop the typedef in tools/virtio/linux/kernel.h
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  tools/virtio/linux/kernel.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 0b493542e61a..1d3248e3f270 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -29,7 +29,6 @@
>  #define READ                    0
>  #define WRITE                   1
>
> -typedef unsigned long long phys_addr_t;
>  typedef unsigned long long dma_addr_t;
>  typedef size_t __kernel_size_t;
>  typedef unsigned int __wsum;
> --
> 2.25.1
>

