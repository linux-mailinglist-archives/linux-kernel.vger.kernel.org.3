Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75517490214
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiAQGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbiAQGka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642401629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1E8hjpydB+1Ebcg5NG3WSQev5EeNdXP/CDEeZweK/0=;
        b=Mo+PLf4nDmfcqsVXw82i8XU2mQpHgmp5/fkWpR8FxLIDu2ejGlWm/j86ebHZx0VaOfFjev
        1mmWXDVacm4s5T8m3AFBo4Huej33e/74dCRLBPbDu40mrC70CgK0XEl96Do/sc/H8z+tIe
        jAHRVldsw9rhV/VFDFd8MU5UOKyqY0U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-jfmFyGU3ME6c7CKQOzSb7w-1; Mon, 17 Jan 2022 01:40:20 -0500
X-MC-Unique: jfmFyGU3ME6c7CKQOzSb7w-1
Received: by mail-pj1-f72.google.com with SMTP id a4-20020a17090a70c400b001b21d9c8bc8so16234060pjm.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z1E8hjpydB+1Ebcg5NG3WSQev5EeNdXP/CDEeZweK/0=;
        b=Vjhl1KdMErPGfnnuuMSjrF3aF/3WQgQ2vQU5KPQCsJm6gkTMjk4+3ogh6s/YEsXZhq
         KL9N+88ee3jFK2jCGepE/Rj2LnwqxDHKPsEPydupv7dYUi/ATbu9KTIDKbFBQ0odti70
         h2Zr6eYVIv3Eq8SIlsQ3Btni9URVd+4KH0egdCu7vYyB6K015M2Op551nH/4QDpVbDhU
         Xa2nD/mnp4usMbkFbzn81NvExbglp5oQeZ+/2zWkXaRu2azrs0njq0D6eYi5wIv31SdN
         1cjSmIqEp6V7sfzmjF11zCeDCeBa+J9ZU/1ljYc/o6ySdt9XUdu3hlEigLG71wsfW5Dw
         cZlg==
X-Gm-Message-State: AOAM530HH8zNm97i080VIyoez7UePIQofJ5NiVQbZ5GgoWrzUSGDXv09
        tKtBB43BCvkKYI6AmsA/qrDX7CbYX4Adj+AjeQ3ykjprk25RLcWe8hGB6SEhW+Yzjlbq+44BrII
        z39ZvjZA9G2sviZOYOk8c+Qy1
X-Received: by 2002:a17:903:11d0:b0:149:a969:400c with SMTP id q16-20020a17090311d000b00149a969400cmr21317007plh.120.1642401616150;
        Sun, 16 Jan 2022 22:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuBZ9AYJjw5KpCOAVuPoXkf9CMob/mn9UwVMIe1y13FBPLr9fe56+zJZi7vmL3oQex3gPhfQ==
X-Received: by 2002:a17:903:11d0:b0:149:a969:400c with SMTP id q16-20020a17090311d000b00149a969400cmr21316998plh.120.1642401615926;
        Sun, 16 Jan 2022 22:40:15 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z29sm3431743pfg.87.2022.01.16.22.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 22:40:15 -0800 (PST)
Message-ID: <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
Date:   Mon, 17 Jan 2022 14:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio_mem: break device on remove
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220114214324.239444-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114214324.239444-1-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
> A common pattern for device reset is currently:
> vdev->config->reset(vdev);
> .. cleanup ..
>
> reset prevents new interrupts from arriving and waits for interrupt
> handlers to finish.
>
> However if - as is common - the handler queues a work request which is
> flushed during the cleanup stage, we have code adding buffers / trying
> to get buffers while device is reset. Not good.
>
> This was reproduced by running
> 	modprobe virtio_console
> 	modprobe -r virtio_console
> in a loop, and this reasoning seems to apply to virtio mem though
> I could not reproduce it there.
>
> Fix this up by calling virtio_break_device + flush before reset.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_mem.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 38becd8d578c..33b8a118a3ae 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>   		virtio_mem_deinit_hotplug(vm);
>   
>   	/* reset the device and cleanup the queues */
> +	virtio_break_device(vdev);
> +	flush_work(&vm->wq);


We set vm->removing to true and call cancel_work_sync() in 
virtio_mem_deinit_hotplug(). Isn't is sufficient?

Thanks


>   	virtio_reset_device(vdev);
>   	vdev->config->del_vqs(vdev);
>   

