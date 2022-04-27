Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9C510FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357644AbiD0EI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357630AbiD0EIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0B3C237FA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651032335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OI2D7xQGQPORWCdvPh4NHGqLdP0i5IRZXFjtfHEyKNI=;
        b=KX+ZS9QnJj1STCz6JT5g5I9C7zemLTr+KIZURFFSIeGqI0sciXRhljVkfQD2X6qNyUcyH9
        en3qQpL1Hurd6d4IG8TiOfNvW0Oa97USY2Q8/IX9UBlsJUxql9HxB0lIdd/gq6nYUDGpsY
        b/vxRh19T8OFpbCKGmG/DzRZjIwNj20=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-7SB6zZWHNsS43kJAD99IuQ-1; Wed, 27 Apr 2022 00:05:33 -0400
X-MC-Unique: 7SB6zZWHNsS43kJAD99IuQ-1
Received: by mail-pl1-f197.google.com with SMTP id i3-20020a170902c94300b0015d34d24e91so393993pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OI2D7xQGQPORWCdvPh4NHGqLdP0i5IRZXFjtfHEyKNI=;
        b=K1ICr1cTh8r/zbaR5P67ljWe1TbiLED1wnetBBlECVUWSeZVY80ah2/JFSFsAdgmvj
         wPGRW3H0v+fzE41bnrAOGhg4gzgmNnxhjSmlRBVhUKbP0l9DIajbPoAWLuzgZrTi8qW0
         HgaxjkEHFkBdfmQ7o5L8gzoOAUrKEJgwQ/Z6dHI/Uk3tBht2CczOh11NrFKnSvRLvG4R
         n6w+HkO+kb+qcLlcikcRGO6Ao05F9h/F3+MIuji0xFvukmyeWv0CSzMOnIrmbnQdqgv7
         pg07k2l5+T6ediQaA2cI0ulRFjGHT3gXbnco1u3vzsmgRuK1pi6KmGy+MI4fcGipTiQd
         nM7A==
X-Gm-Message-State: AOAM533c8sxdoSP2adXXe1az/bIDuxrfbVF83KNOz4pPWftB3PgnnJyb
        Smo3mWDNBkdoJW7nYIq/FYu5HpCpW2lTlu4FK7Jyhg4Pl+TCEcw2MVJCEA011WC4p25flAj60cV
        tPvjTi8VgRVMGl2WBhMpsbXPy
X-Received: by 2002:a63:d449:0:b0:399:365e:d13e with SMTP id i9-20020a63d449000000b00399365ed13emr22146209pgj.96.1651032332544;
        Tue, 26 Apr 2022 21:05:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi/YAPoTV3Di7OG/IjOmSo+U2UvRJCAn0OBXSlF/ljnz/il+13VVFaxFxNujygNbmvYKEaBg==
X-Received: by 2002:a63:d449:0:b0:399:365e:d13e with SMTP id i9-20020a63d449000000b00399365ed13emr22146195pgj.96.1651032332231;
        Tue, 26 Apr 2022 21:05:32 -0700 (PDT)
Received: from [10.72.12.60] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a1f4900b001cd498dc153sm5089742pjy.3.2022.04.26.21.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 21:05:31 -0700 (PDT)
Message-ID: <b10af1ae-d396-6694-8f1d-4a3769a84494@redhat.com>
Date:   Wed, 27 Apr 2022 12:05:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220425062735.172576-2-lulu@redhat.com>
 <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
 <CACLfguUmEEdJzPTsR9h-N=rVa4ktT8s6=aBsJ_MdRRy24LRyMg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACLfguUmEEdJzPTsR9h-N=rVa4ktT8s6=aBsJ_MdRRy24LRyMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/27 09:58, Cindy Lu 写道:
> On Tue, Apr 26, 2022 at 2:05 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>>> this patch is to add the support for vdpa tool in vp_vdpa
>>> here is the example steps
>>>
>>> modprobe vp_vdpa
>>> modprobe vhost_vdpa
>>> echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
>>> echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>>>
>>> vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
>>>
>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>>> ---
>>>   drivers/vdpa/virtio_pci/vp_vdpa.c | 138 +++++++++++++++++++++++-------
>>>   1 file changed, 106 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> index cce101e6a940..873402977543 100644
>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> @@ -32,7 +32,8 @@ struct vp_vring {
>>>
>>>   struct vp_vdpa {
>>>          struct vdpa_device vdpa;
>>> -       struct virtio_pci_modern_device mdev;
>>> +       /* this is an pointer point to the mdev in vp_vdpa_mgmtdev*/
>>> +       struct virtio_pci_modern_device *mdev;
>> The code can explain itself, so the comment is redundant.
>>
> sure wll remove this.
>>>          struct vp_vring *vring;
>>>          struct vdpa_callback config_cb;
>>>          char msix_name[VP_VDPA_NAME_SIZE];
>>> @@ -41,6 +42,12 @@ struct vp_vdpa {
>>>          int vectors;
>>>   };
>>>
>>> +struct vp_vdpa_mgmtdev {
>>> +       struct vdpa_mgmt_dev mgtdev;
>>> +       struct virtio_pci_modern_device mdev;
>> I think coupling it with mgmt device is probably not good, any reason
>> we can't allocate it independently?
>>
> yes I also think it make code confused,  but we need to init  it in
> static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> and then  pass it to
> static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>     const struct vdpa_dev_set_config *add_config)
> the only struct we can use is struct vdpa_mgmt_dev *v_mdev,  not sure
> if we have
> some better choice ?


I think we can just allocate it and assign it to vdpa_mgmt_dev structure?

struct vp_vdpa_mgmtdev {
     stuct virtio_pci_modern_device *mdev;
};

Thanks


>
>> Thanks
>>
>>> +       struct vp_vdpa *vp_vdpa;
>>> +};

