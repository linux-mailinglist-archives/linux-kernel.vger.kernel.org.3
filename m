Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9E488AC7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiAIRCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234264AbiAIRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641747757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwlVvjpkCfCZyjeB70jf85ClGNNPpOVEysVuCxvxjrs=;
        b=CIixVG/xDBeHErCQT5jMrPLwT6r878RcwjwQN7jJBZnucjbQEtf3XXQm87z66Gm1P26f25
        Vi2E4WzcL7IsP4/Am94M2A4Sng+k+WHlD0GrCHZpK0bIZHBiB/+0V9ZKyOeYpicQozuftq
        nZDllHyhGkD1V3SqF8+deTa9Ew0n49o=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-YzF9hxKwNau_K-rAPmJF5Q-1; Sun, 09 Jan 2022 12:02:36 -0500
X-MC-Unique: YzF9hxKwNau_K-rAPmJF5Q-1
Received: by mail-ot1-f69.google.com with SMTP id i3-20020a05683033e300b0057a02219a82so2127812otu.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 09:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xwlVvjpkCfCZyjeB70jf85ClGNNPpOVEysVuCxvxjrs=;
        b=LnS3rTDuifT/odW+DZyymTUDzj+XwcsFHt0y4hvDBT+B0OP57K3vzPY89qUj54K8iM
         dEGPJIEMMcPbJWUUrntOjKalsgKNnqXB5OH16Xy7N1xgJg6VYfcOxwm7ik3oAZDqNGno
         S43224+ieU+A9MFeK98ul9MrNrTS6HpugH6wfWNJ7cRUST5qu73uTwIxjA4/aAIbbCyj
         I1fdfyU9jZ283XAJuD5nTFP5dUFQ+L+adWhJNKRQuje7HWlfajU/QCofqKGexiKBONJj
         Panj+dt75dr/G5s3nDNJuWnssoS/0dabrHt33P3na05orWwT8uoBTZe7Bxf5Ggt2VSUD
         Yc0Q==
X-Gm-Message-State: AOAM531gJFxFdy40x9lx8u4CI7TPzAL/mUc5zgjzsRoQkro7qhndXtl5
        TvdV2XBy+7rAI9QMGYGvqmWMD6pMamcasx89XNZjopCH6gR1RZSJmRhXU1a+G+klHMJ16n56rbR
        1yA1MMBGbXUOdETOmZuETf23/dFlZzBHl+z8j/ajyJLLirhkKW/vqEgtXttv/1XF3qpxZsIo=
X-Received: by 2002:aca:ac04:: with SMTP id v4mr16677145oie.18.1641747755272;
        Sun, 09 Jan 2022 09:02:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYS7quo4u6yvWAJ/zoKA+4SvFRy2RcRYxIqGGm4jUm/S7mnSVWbuGpXJaqwfm4m0mhkGUP9w==
X-Received: by 2002:aca:ac04:: with SMTP id v4mr16677113oie.18.1641747754912;
        Sun, 09 Jan 2022 09:02:34 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x26sm981729ote.78.2022.01.09.09.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 09:02:34 -0800 (PST)
Subject: Re: [PATCH] vdpa/mlx5: simplfy error handler in mlx5_vdpa_dev_add()
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        si-wei.liu@oracle.com, xieyongji@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220109132422.4047425-1-trix@redhat.com>
 <20220109141207.GC70879@mtl-vdi-166.wap.labs.mlnx>
From:   Tom Rix <trix@redhat.com>
Message-ID: <26ef040d-8b18-aa65-85ab-6e223c97c39d@redhat.com>
Date:   Sun, 9 Jan 2022 09:02:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220109141207.GC70879@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/22 6:12 AM, Eli Cohen wrote:
> On Sun, Jan 09, 2022 at 05:24:22AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The use of pfmdev is protected by two calls to is_zero_ether_add().
>> The second call in the error handler can be replaced by
>> checking if pfmdev was set as part of the earlier call.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
> It's not fixing anything, right?
Correct, or I would have added a Fixes: tag
> Maybe add justification for this change
> by e.g. showing the code size had decreased or so?

Sorry, I thought I had done that.  Generally removing any function call 
is a win and the worst case is a tie.

Tom

>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 37220f6db7ad7..2d38b8fe9305e 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2530,7 +2530,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>   {
>>   	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>>   	struct virtio_net_config *config;
>> -	struct mlx5_core_dev *pfmdev;
>> +	struct mlx5_core_dev *pfmdev = NULL;
>>   	struct mlx5_vdpa_dev *mvdev;
>>   	struct mlx5_vdpa_net *ndev;
>>   	struct mlx5_core_dev *mdev;
>> @@ -2654,7 +2654,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>   err_res:
>>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>>   err_mpfs:
>> -	if (!is_zero_ether_addr(config->mac))
>> +	if (pfmdev)
>>   		mlx5_mpfs_del_mac(pfmdev, config->mac);
>>   err_mtu:
>>   	mutex_destroy(&ndev->reslock);
>> -- 
>> 2.26.3
>>

