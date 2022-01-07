Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0C487077
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbiAGCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:34:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231945AbiAGCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641522860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gukSGapSoGJbsOoSIlY9+yDTYqhJluxlGmKYG1ZWqag=;
        b=YnA9BPgk7rEOex1G62Mf8Qt+UiMv5AksYG3yDOuKxuCmB1KQsykmXwS1rI9OYSiMuupWZa
        DLN20+EuB4Pa7cVDc8IXU/x+BtYkfSsEmd9PTzvg39dBznyXc40TrK/LPQyUqA+ba2gAFX
        Z+ESFbVRZvBbUhqhCSRfsZ1mUfpk5Wg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-mglNkto3Nce0zs51x5TptA-1; Thu, 06 Jan 2022 21:34:19 -0500
X-MC-Unique: mglNkto3Nce0zs51x5TptA-1
Received: by mail-lf1-f71.google.com with SMTP id r21-20020ac25f95000000b004259e6ab262so1322462lfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gukSGapSoGJbsOoSIlY9+yDTYqhJluxlGmKYG1ZWqag=;
        b=OxkDPgbbvvsmfI97xqWcmnwZK3dvXBdht5gKfEr4dQDtfHEE2JMxxZSJhrZEyN76uj
         1h7GIfhOdyYr1dSVw75O9nvBtkwCa8a+TJt0eYCHKlyggToV2XwILFi8N3h1hDqr0L99
         lh03goHpnpMM/yhqxlOtDcnwm32CYe8PoFABCjzolmFR0bs+SarF/UtBv7WOgzQuXMBi
         KEUx7wihDNvdl6chWH9WiyNfY51bJAymyblWxFPDPYlTR2sDeFJ7ocK0UqUeD5MZ/DVP
         5sL5ydxn/NKuldPRULpKhPS9reRYPJjHAigxlw7Ro5fTi0VQlOyKvE1otk1Ej3+Cs1Pz
         ZpUg==
X-Gm-Message-State: AOAM532zGL6PNhenhgicEmjMFLM1CMs+TJzvkwgP1Uz/Mvjevr86pRO3
        k3UFQhcwyIYCeXn0XPblZlG3k9HPSFZ9nG690l2CRkCNM1XIWxkzB9iwS6L1YefZGe5q8SIaf9E
        WFMJF3xtuKf3X3NXGfrzROZy0spFNxT6tNCzGANaQ
X-Received: by 2002:ac2:5a4e:: with SMTP id r14mr52548501lfn.498.1641522857270;
        Thu, 06 Jan 2022 18:34:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB6ZzpEeRHQ37DNlNp3pKZLLyLn7ryO1J7eQBa6wklXIDOHOoLYJpdwYxb3tIpS8fIRfCBixN3t3rxE1aWYtQ=
X-Received: by 2002:ac2:5a4e:: with SMTP id r14mr52548496lfn.498.1641522857110;
 Thu, 06 Jan 2022 18:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 7 Jan 2022 10:34:06 +0800
Message-ID: <CACGkMEuW5po+v-fFPNH6wtVVXD84Bx0UWhe86sHFYXQM39OKRA@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: fix memory leak of vp_dev
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:31 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> In virtio_pci_probe(), vp_dev will not be freed if it goes to
> "err_register" branch. fix it
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

So we had this:

commit 33635bd976fb4c3ccf0cfbb81a8d29bb87760607
Author: weiping zhang <zhangweiping@didichuxing.com>
Date:   Thu Dec 21 20:40:24 2017 +0800

    virtio_pci: don't kfree device on register failure

    As mentioned at drivers/base/core.c:
    /*
     * NOTE: _Never_ directly free @dev after calling this function, even
     * if it returned an error! Always use put_device() to give up the
     * reference initialized in this function instead.
     */
    so we don't free vp_dev until vp_dev->vdev.dev.release be called.

    Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Any reason that the above fix is wrong?

Thanks

> ---
>  drivers/virtio/virtio_pci_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fdbde1db5..48b5ac15e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -602,8 +602,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  err_enable_device:
>         if (reg_dev)
>                 put_device(&vp_dev->vdev.dev);
> -       else
> -               kfree(vp_dev);
> +       kfree(vp_dev);
>         return rc;
>  }
>
> --
> 2.17.1
>

