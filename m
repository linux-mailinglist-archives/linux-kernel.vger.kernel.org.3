Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D451B9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbiEEITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiEEITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:19:40 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A5129CB8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651738560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqkF1KE8HpAmQB4r+M2R5O0GOtheHQHEI+M7f5J9eiQ=;
        b=aQyEueKv5bawpWRSIfoAGtZLZ80Vps99RIbc9x9eUFLziVJNZcCnlIyrSvrcJEDEGS+qhc
        rMs+6dx/zzMSqr9OErHkErm77kxpapWMmGZw4ow3tA5B3BZ/i7jGFHpbghN01JRtwTxSL8
        GofBUTtpBAMRG+ovwfDzQvxANDYxm5E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-ZjAlkKR0NMmEFb5-35Pp1g-1; Thu, 05 May 2022 04:14:34 -0400
X-MC-Unique: ZjAlkKR0NMmEFb5-35Pp1g-1
Received: by mail-pl1-f198.google.com with SMTP id g12-20020a170902740c00b0015d243ff163so1938319pll.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GqkF1KE8HpAmQB4r+M2R5O0GOtheHQHEI+M7f5J9eiQ=;
        b=nhdx/KPXiRTLDbCpAua+UKKLGf77JtKzJJbm3hwiCl6V5elRU/Q7229QpBJ2SHVTFu
         1fVvu9SLMnxnb3xXEdIiGi5xj2v4oMT3mrbnMCh1kQEk2GN2EQkwsMrLlN8QbIzKnNoP
         lQkJcmqblqZsB8DNdmRwrO6fWclBXdNGnKo6PqSS7dTPO951BFE7AfWXQbcwEnOHw56p
         IIrtdpLB/t2UfR6jufVUbcGYeiHUNMBytSImNxmb947/Z5Pkd1fxIHOsCsbZg7hwJbXz
         M68Bj0ovNJlkGtBTVpUXGGrMarZ/83Y8fpBo5PhUqS33kKlp8Bs4z8LwZ/0zLmlN0YqW
         m0qQ==
X-Gm-Message-State: AOAM530sqBL5cxwXGX8QVdSNbB0X6HK/Z3AXWXaR06o9Dyk0AiJS0APg
        RuCiRgg/yMUEb+bwfxB3zbcd2ncTRt9BdQpJbH/RlXRoHaPv5g2g9qFlZESCAdQAJOV88KtkzKl
        1o3wQEg17KhJwyMZhN/hP3st6
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id n12-20020a170902f60c00b0015682c9e44bmr26008991plg.106.1651738472903;
        Thu, 05 May 2022 01:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKcqfKIUUPplDvbeDmjS+7tfF7ZK8ifv0ssT8p8bQdwz6KKEmOnlHoAb/8OBDNJIL2fD47Dg==
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id n12-20020a170902f60c00b0015682c9e44bmr26008973plg.106.1651738472663;
        Thu, 05 May 2022 01:14:32 -0700 (PDT)
Received: from [10.72.13.116] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7868f000000b0050dc76281aesm742906pfo.136.2022.05.05.01.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:14:32 -0700 (PDT)
Message-ID: <ad4c0688-6e4b-bc66-55c3-8d33493f7c8c@redhat.com>
Date:   Thu, 5 May 2022 16:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] vdpa/mlx5: Add RX MAC VLAN filter support
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-4-elic@nvidia.com>
 <eb381955-0a64-011f-2732-943c60541b18@redhat.com>
 <DM8PR12MB540032F367E9DB4C277AB946ABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <DM8PR12MB540032F367E9DB4C277AB946ABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/2 13:38, Eli Cohen 写道:
>>> +static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>>> +{
>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
>>> +	struct mlx5_control_vq *cvq = &mvdev->cvq;
>>> +	struct virtio_net_ctrl_vlan vlan;
>>> +	size_t read;
>>> +	u16 id;
>>> +
>>> +	switch (cmd) {
>>> +	case VIRTIO_NET_CTRL_VLAN_ADD:
>>> +		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&vlan, sizeof(vlan));
>>> +		if (read != sizeof(vlan))
>>> +			break;
>>> +
>>> +		id = mlx5vdpa16_to_cpu(mvdev, vlan.id);
>>> +		if (mac_vlan_add(ndev, ndev->config.mac, id, true))
>>> +			break;
>> This may work now but I wonder if we had the plan to support
>> VIRTIO_NET_F_CTRL_RX?
>>
>> if $mac is not in $mac_table
>>       drop;
>> if $vlan is not in $vlan_table
>>       drop;
>>
>> With that features we probably requires the dedicated vlan filters
>> without a mac? Or do we want to a $mac * $vlans rules?
>>
>> If yes, maybe it's better to decouple vlan filters from mac now.
>>
> If we use dedicated filter tables for VLAN and MAC working in series,
> we may not have full control over incoming traffic filtering.
> For example, suppose we have VLAN table allowing v1 and v2 to go through,
> and a MAC table allowing m1 and m2 to go through.
>
> If we want only (v1, m1) and (v2, m2) to go through but not (v1, m2) or (v2, m1)
> then it would not be possible to block the latter.


Yes, but this is currently how virtio-net work in the spec.


>
> As I can see, the spec does not require that finesse


Yes.


>   but I wonder if this not
> what real life requires.


Then we need to extend the spec.


> If you think we should follow the spec let me know and will prepare a new version.


It should be fine now. (But if we want too support CTRL_RX we need some 
refactoring on the codes).

So:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>

