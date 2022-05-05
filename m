Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EF51BAED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbiEEIvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350420AbiEEIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:51:49 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:48:07 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCEB34AE23
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651740423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7LO8hebdbIw0WAuomKQFjBNareExAhRiWx3BsvsTNQ=;
        b=PrGwLm8f98OJnzwfgH3DM5fOY+9onMk0PnH3r0G+rjUgwlblqwPKrPOq68varrYwAFZSyd
        HSeXzmevRTf8ZQalUT4ND5faJ3HcvoCnrhV24sGKNatr7ZbpjJpJfiTWtZyojh5KPSeEBs
        XW/9Srn66uurIeMispk/EoXQnnxsK6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-MNBhRzQAN7WcTtLfG-yMSg-1; Thu, 05 May 2022 04:40:51 -0400
X-MC-Unique: MNBhRzQAN7WcTtLfG-yMSg-1
Received: by mail-wm1-f72.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so1473126wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7LO8hebdbIw0WAuomKQFjBNareExAhRiWx3BsvsTNQ=;
        b=r+Sqhl6WqPO2jhZ9pc9A6TBFlDrJRs2ddKNPKkrniaa9kebCFw1kYZ/u+OhXVVwGbW
         tLnA/xPDLnwY8nkanCOgp0nUH+c39C2XPtahbD63IWOC7EEhOrxAj8Ct3dd11WEX9VDG
         USYo7zLM4MgV3liWqaR7s5gGePJPsGhxPLR6FXJa6+Sr0OdQ9snK5n/mcKoHClCP9uQt
         nxkTYm6TnyVyArDm9cN5lzmJ1zlASWS/ArnJsuCVQ9K3WiEK5/sVMlzzFS336B61OpyV
         Gf32Auz4HVNuLijOcsVDbjzcCqgKloPYmTQISEUQeDrqZ6eA7w1LiwgPrvFUZPR65fOP
         KjkA==
X-Gm-Message-State: AOAM532mLHmJpmuLI0rpK3kKUi8mtXA382MfLAeK3ZqSO7ZyyQ1/GRnc
        yjjK03JpV9tm9o/Rykp1ChHFm/wNfq7hU/IyPXWvkNklqcGv+7Pm1ttpAa49Vu0RoPJu0reMznl
        7YiO3AIF+AwvTz/nkpu1r5/EX
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id u18-20020a05600c19d200b00393efff7c26mr3623073wmq.9.1651740050374;
        Thu, 05 May 2022 01:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcbG871wt8Ul5pXQZdb/CfKU/UNSFjxHuQCDKeSp3PMM+Po2SZi2INJ/W6uVagnsqlJsEQqA==
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id u18-20020a05600c19d200b00393efff7c26mr3623056wmq.9.1651740050085;
        Thu, 05 May 2022 01:40:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-85.retail.telecomitalia.it. [82.57.51.85])
        by smtp.gmail.com with ESMTPSA id p20-20020a7bcc94000000b003942a244f38sm5584441wma.17.2022.05.05.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:40:49 -0700 (PDT)
Date:   Thu, 5 May 2022 10:40:45 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Message-ID: <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
 <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:26:24PM +0800, Jason Wang wrote:
>On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
>> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> The simulator behaves like a ramdisk, so we don't have to do
>> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
>> >> could be useful to test driver behavior.
>> >>
>> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
>> >> that we support the flush command.
>> >>
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>> >>  1 file changed, 12 insertions(+)
>> >>
>> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> index 42d401d43911..a6dd1233797c 100644
>> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> >> @@ -25,6 +25,7 @@
>> >>  #define DRV_LICENSE  "GPL v2"
>> >>
>> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
>> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
>> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>> >>                 pushed += bytes;
>> >>                 break;
>> >>
>> >> +       case VIRTIO_BLK_T_FLUSH:
>> >> +               if (sector != 0) {
>> >> +                       dev_err(&vdpasim->vdpa.dev,
>> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
>> >> +                               sector);
>> >
>> >If this is something that could be triggered by userspace/guest, then
>> >we should avoid this.
>>
>> It can only be triggered by an erratic driver.
>
>Right, so guest can try to DOS the host via this.

Yes, but I don't expect the simulator to be used in the real world, but 
only for testing and development, so the user should have full control 
of the guest.

>
>>
>> I was using the simulator to test a virtio-blk driver that I'm writing
>> in userspace and I forgot to set `sector` to zero, so I thought it would
>> be useful.
>>
>> Do you mean to remove the error message?
>
>Some like dev_warn_once() might be better here.

We also have other checks we do for each request (in and out header 
length, etc.) where we use dev_err(), should we change those too?

I don't know, from a developer's point of view I'd prefer to have them 
all printed, but actually if we have a totally wrong driver in the 
guest, we risk to hang our host to print an infinite number of messages.

Maybe we should change all the errors in the data path to 
dev_warn_once() and keep returning VIRTIO_BLK_S_IOERR to the guest which 
will surely get angry and print something.

If you agree, I'll send a patch to change all the printing and then 
repost this with your suggestion as well.

Thanks,
Stefano

