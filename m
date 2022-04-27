Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48578510FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357615AbiD0EH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiD0EHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00909CE10D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651032253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH86V8owPQ8N+aMjzBoR2fcN3m/CqaWBYAhno71vU5g=;
        b=Q6cMYHUmbQgWIBehckXTK7JXSrwRdqwVG6ixOWdZgoTTHhx0VUK1YYURPY94fBW//pThAv
        vujGdqDJ7Nl1+FUeOcRzNG+jnaOcnfZtsqyFp9Ty6WKbCSMlw6ZNv+kGicfGSicoQqxA4o
        Gbnk/fwRnzQQsrXh6Ti9Xq7pgr1GCrc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-QE_jTCxJPyyh6hOlxQqRxg-1; Wed, 27 Apr 2022 00:04:04 -0400
X-MC-Unique: QE_jTCxJPyyh6hOlxQqRxg-1
Received: by mail-pj1-f72.google.com with SMTP id a23-20020a17090a6d9700b001d60327d73aso2678905pjk.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OH86V8owPQ8N+aMjzBoR2fcN3m/CqaWBYAhno71vU5g=;
        b=l/d6YBiyNjbLfCuF/x/I37nyZyahOFhuIR6rOapNYUvPlARAqn+UZdl7RgZQNpN9B6
         hIh86jwK2fE/h3xv1uSZs+ELwVWm9a7/WcVClXfa7n+GxmHC4nObamEaqbTe7UlX2+y6
         4l0uHjdiRZEEWplfkHGjIE6+m2dSaW5gaP8LhSs7xqfF2DTlalw1utC1zu32HrUgyEfp
         HUu/894fO+ncoxqgR9SDUmYx2T1MGYFhmHYkh8g77VKZRg7srW9Bu45fH8ENKjE+61sf
         j0hB/651Qz4qL67SOadPvAEU56ZPqs1v7iuKXjAFXIbS+2rVfUgSPCMflwl7GDjRFtPf
         fyWw==
X-Gm-Message-State: AOAM533D9dCPH/wrLuS6EqFMNHF7g3gxut80qbbpPY89P0VtPiUjFifV
        T+JpgRGQaDH541nZ1q9mD/KiLOtiYpsb+zyntTcwiKDBCTcuqQu+KicfSw/JJaKj5RJggZpvZgK
        JxWsa3zscXxXPIuuvKdF5ax7x
X-Received: by 2002:a17:902:7897:b0:15d:318d:706b with SMTP id q23-20020a170902789700b0015d318d706bmr7975411pll.16.1651032243639;
        Tue, 26 Apr 2022 21:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/GVt4L0b3NsfyKmTgh5DsBLXHJFRjd28qfTAKnNcKsAPZ1TXoZmkTwbFM+AWJr7AUoaFRfQ==
X-Received: by 2002:a17:902:7897:b0:15d:318d:706b with SMTP id q23-20020a170902789700b0015d318d706bmr7975394pll.16.1651032243379;
        Tue, 26 Apr 2022 21:04:03 -0700 (PDT)
Received: from [10.72.12.60] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm16925270pfb.189.2022.04.26.21.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 21:04:02 -0700 (PDT)
Message-ID: <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
Date:   Wed, 27 Apr 2022 12:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct
 vdpa_mgmt_dev
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220425062735.172576-1-lulu@redhat.com>
 <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
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


在 2022/4/27 10:01, Cindy Lu 写道:
> On Mon, Apr 25, 2022 at 5:00 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>>> To support the dynamic ids in vp_vdpa, we need to add the check for
>>> id table. If the id table is NULL, will not set the device type
>>>
>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>>> ---
>>>   drivers/vdpa/vdpa.c | 11 +++++++----
>>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 1ea525433a5c..09edd92cede0 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>          if (err)
>>>                  goto msg_err;
>>>
>>> -       while (mdev->id_table[i].device) {
>>> -               if (mdev->id_table[i].device <= 63)
>>> -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
>>> -               i++;
>>> +       if (mdev->id_table != NULL) {
>>> +               while (mdev->id_table[i].device) {
>>> +                       if (mdev->id_table[i].device <= 63)
>>> +                               supported_classes |=
>>> +                                       BIT_ULL(mdev->id_table[i].device);
>>> +                       i++;
>>> +               }
>>>          }
>> This will cause 0 to be advertised as the supported classes.
>>
>> I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
>> export it to via uAPI probably).
>>
>> Thanks
>>
> like the below one? not sure if this ok to use like this?
> static struct virtio_device_id vp_vdpa_id_table[] = {
> { VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
> { 0 },
> };


Something like this.

Thanks


>
>
>>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
>>> --
>>> 2.34.1
>>>

