Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0755761E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiFWI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiFWI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0345D140CD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655974716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QA4QBFkDM19s/kmNbbq6WAZHuSSj0hjTnufoIU8Ro9o=;
        b=PFj8nsoygWTg1I9lkxPLpzZMRczDLd5VAgMHyPm2XaonF2hOft7ui29OaVieedGV1eaPSk
        nNgVAfYYtlRiPqsxzexezqZZns1zWYr8u0jO4Z4b4NlQzbbCL+FPx3Ut26NXUJvi2LVarc
        k3d4vIBKnekE2UHZQT4BFnssmAtw3mc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-ATR2DeofOJSWOa-pVo2WLQ-1; Thu, 23 Jun 2022 04:58:35 -0400
X-MC-Unique: ATR2DeofOJSWOa-pVo2WLQ-1
Received: by mail-wr1-f71.google.com with SMTP id b10-20020adf9b0a000000b0021a0c74738aso4537248wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QA4QBFkDM19s/kmNbbq6WAZHuSSj0hjTnufoIU8Ro9o=;
        b=Rr13FZKKnYqrdTzdHYp51GmHJp9T5IfUkUHFdbZ45G42qtz8AqdCO3MTFGzR7D7xP5
         zIz+zuVINmdLKmtAK17fqVvpWQ49aSnsnvjjSeJKwnRvYyTDGmwAZs5VnzQ+97A2se+A
         iwQWqSzSjvhCqx8wEDMoM7zZvt13fy/CC2cprOTGXuyF2m52rn04wOQ4SXctnQwqK+US
         IzCrS1v+PvdxTNgrLGnL4zEodTG2Rwd7XQ9Asn5Qk5ftFLYtTCxGszx3So3vW5mguenD
         QmAzW/TJWR+BWX+/idnxkacKSv9Q9aG2Hb3MYA6vKAIMMOdjSDOfKXDsVuCvrMEq5NKZ
         ID9w==
X-Gm-Message-State: AJIora8Uu0VlE6m++1ZuKNuxaYgThfHenE5umxu0YXIwrlpNE2zwv4q2
        iz+cvOb1uCv8knBdi16fxsFEM7xgE7Sy9PRFOZQZHB5CcHMfw/sJliLcoIQFTWvWB0w3UXVRbnt
        wIU1E7kaa8m1dg6VTDopjjvxs
X-Received: by 2002:a05:600c:1553:b0:39c:87fc:5784 with SMTP id f19-20020a05600c155300b0039c87fc5784mr2834938wmg.90.1655974713531;
        Thu, 23 Jun 2022 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKzKYT9XjrtQPHP5sn9zFHwuvBaPFsVvMSjtZr6AU7TKAY9p+ZWuznb3fG50371xljWLlAVQ==
X-Received: by 2002:a05:600c:1553:b0:39c:87fc:5784 with SMTP id f19-20020a05600c155300b0039c87fc5784mr2834921wmg.90.1655974713318;
        Thu, 23 Jun 2022 01:58:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id b1-20020adfe301000000b00219b391c2d2sm26623088wrj.36.2022.06.23.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:58:32 -0700 (PDT)
Date:   Thu, 23 Jun 2022 10:58:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled
 per batch
Message-ID: <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:50:22AM +0800, Jason Wang wrote:
>On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Limit the number of requests (4 per queue as for vdpa_sim_net) handled
>> in a batch to prevent the worker from using the CPU for too long.
>>
>> Suggested-by: Eugenio Pérez <eperezma@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> index a83a5c76f620..ac86478845b6 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>>  static void vdpasim_blk_work(struct work_struct *work)
>>  {
>>         struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> +       bool reschedule = false;
>>         int i;
>>
>>         spin_lock(&vdpasim->lock);
>> @@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struct *work)
>>
>>         for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>>                 struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> +               bool vq_work = true;
>> +               int reqs = 0;
>>
>>                 if (!vq->ready)
>>                         continue;
>>
>> -               while (vdpasim_blk_handle_req(vdpasim, vq)) {
>> +               while (vq_work) {
>> +                       vq_work = vdpasim_blk_handle_req(vdpasim, vq);
>> +
>
>Is it better to check and exit the loop early here?

Maybe, but I'm not sure.

In vdpa_sim_net we call vringh_complete_iotlb() and send notification 
also in the error path, so I thought was better to send notification 
also when vdpasim_blk_handle_req() return false, since we will update 
the used.idx.

However, I don't think it's a common path, so if you think it's better 
to exit the loop early, I can do it.

Thanks,
Stefano

