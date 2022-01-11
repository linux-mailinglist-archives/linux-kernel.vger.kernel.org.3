Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E248A6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347902AbiAKEiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233487AbiAKEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641875883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6Za2ptl35SuGhC5n7POzBQa3m4oQeyjIDBWh6B2yXY=;
        b=KtTVOSpAh8czqjfIZDgZh8/PUj1dSe+mhPmHjbOgrjfty56zBi3lMeUFu6fDsHn6NBHFtT
        xIR38c6ctqiELM7ciIy9lGb/BRobN9O8nNI7x4I0i4yaJf3BxGzx31A450BoE6/hcY2Q5F
        rz2FzhROI949RPFqpBkYJOSyfhS5yJ8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-cbQi6MWaM46UjRoWIx0x3g-1; Mon, 10 Jan 2022 23:38:01 -0500
X-MC-Unique: cbQi6MWaM46UjRoWIx0x3g-1
Received: by mail-lf1-f72.google.com with SMTP id m8-20020a0565120a8800b00425edb1a456so8098929lfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6Za2ptl35SuGhC5n7POzBQa3m4oQeyjIDBWh6B2yXY=;
        b=fEX6BBicSxZh1QXZoc6qmFGKPPjfXBnmT9abyeRIuhyD5P3cc4PV9AnviA+vvTa2C1
         pmfeYHXs+EgLkCy1/bjEKWnzPpXJvd49eVAfBWcLtdqTggmAb62V8ekV4y8B20sHRVZq
         lN6CSQVBd4jtFRHc3CKXCkl2QppfNvzMoSBkHpSuUq7VSx+jIvL41J8oYRz4QnklySV0
         jonx28fOB3BmssDR8Y8h1NVsTqxFOIOXgdJdx/87RJ6pRu04F7NzhqmZZ0VAhhAL/wyJ
         z5G8lCWfegjX7xNn6t13/61kzOYS9YpYLWDMcJULAcKD9aPXhJgo//e6dRMKrTkh+jOw
         faww==
X-Gm-Message-State: AOAM533e0jpryxc6PUlCyVQKXcFtQKOZjcjmZj+Ah9JUEZGfucvqxFxS
        sLWApSa9Stl51nlAbtqC2PRy/Bjh3TuLtfTDoLK65PEigfPUxMaimcIE0RkB4cvJjfFRmdpymr4
        YS452tOjDeuQ9w5Xvr/giHDDpWa3xN8Kds4Va/WLI
X-Received: by 2002:a19:f705:: with SMTP id z5mr2078439lfe.580.1641875880230;
        Mon, 10 Jan 2022 20:38:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEScSQ+NLDyZQJEdPRRrnW7ysvazimsnd2b8anK6GfyRsmAv1dN+TCIzjoRFHjKYZ3/I3SXe1ryD4NhgKHJTk=
X-Received: by 2002:a19:f705:: with SMTP id z5mr2078429lfe.580.1641875880070;
 Mon, 10 Jan 2022 20:38:00 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
In-Reply-To: <tencent_7A45E1E967F13AE14B061269@qq.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 11 Jan 2022 12:37:49 +0800
Message-ID: <CACGkMEvPnsDHn_gUdq2g2_Xzzqp8KVVhpaApnssYT9NT=mgm1A@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa device
To:     =?UTF-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:38 AM =E6=9D=8E=E4=B8=9C=E5=8D=87 <lidongsheng@d=
ayudpu.com> wrote:
>
> When virtio vdpa device removed, the abnormal damage of the device cannot=
 be
> perceived normally, which will cause problems similar to:
>
> 43bb40c5b926
>
> Hence, add the ability to abort the command on surprise removal
>
> Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 4a9ddb44b2a7..fd930409d190 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vd=
pa)
>  {
>   struct virtio_vdpa_device *vd_dev =3D vdpa_get_drvdata(vdpa);
>
> + virtio_break_device(vd_dev->vdev);
>   unregister_virtio_device(&vd_dev->vdev);
>  }
>
> --
> 2.17.1

