Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B44BE66C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiBUQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiBUQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CFA4237C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645462104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugkg/6bHK4I9I6rQyjp9bnBEEpgwBXrQHXcejLYuUBI=;
        b=TFcrL5PjpcpYhTGWBpFtiw5ExZuMT4fePd7GaXEd3NkeOuuDgM17Q33P+AoIeshnBDVqBI
        /VGt1ZB6msQHQszN8aMwE1gJjK3w5yGc8npZ0KSnpFaEUiY6gHCAox2+6YK7EZRoFbSDfO
        RnwZYEcSKZpZJw3rGb6IvrkM+vT42lA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-HrMkyeIAOLqQYwWvEgEVLA-1; Mon, 21 Feb 2022 11:48:23 -0500
X-MC-Unique: HrMkyeIAOLqQYwWvEgEVLA-1
Received: by mail-qv1-f69.google.com with SMTP id e9-20020a0cf749000000b0042bf697ff6bso17747620qvo.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugkg/6bHK4I9I6rQyjp9bnBEEpgwBXrQHXcejLYuUBI=;
        b=UABRXlYiwD4wZVOOp9WfD26NCC624nIFs8koTxsEaExnQIiN/xR0Z8GUTA4CEoy/Wx
         zOB+IqL0c7Leat/cu7hZEe6bDRDKCxaU2Q+OPrve5XtgBVX6yDn5qINbqXWM/Z53+33M
         cik/63Ku6zRtmwJ6vL1P25MZr+px8XNym5NUjLXph1i86d1MTt/fqo7XCtN/0xbQDLsR
         LtU7aOmASZAyGCMeAVJMt5LBoVOf/j2T2qzAFSV+1EhCbJbx4JeDc9ucEyr+tpnoNFXX
         DYYm616wqe06t0c06jDdnIfvT4x547yL7YZDG87+xDLt1A4hVAqna8+cWHmYYKzcAmmS
         +YGg==
X-Gm-Message-State: AOAM530oC+kpH+GBALKfeHY7uT9ghsF4DSwRd2ciy8dp9FoJZHeb/qLW
        7iVpDUMIqRqPF8HIgYiItDBvVGi1GCs0l0YQHTAPbnInZCWeKzVoU8ZGO3w2iP2L/7bDbUW2euX
        dWUvSdPBRCKBC66wC+SkSnwR7
X-Received: by 2002:ac8:5e48:0:b0:2dd:aae2:9163 with SMTP id i8-20020ac85e48000000b002ddaae29163mr13786997qtx.95.1645462102878;
        Mon, 21 Feb 2022 08:48:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFv1gdovuCvIHcpiRkTUusMpouueO/kTbQ3gip4zmAzUzlcfKIHRaFuNGZVTP437Hqjr+tcA==
X-Received: by 2002:ac8:5e48:0:b0:2dd:aae2:9163 with SMTP id i8-20020ac85e48000000b002ddaae29163mr13786978qtx.95.1645462102586;
        Mon, 21 Feb 2022 08:48:22 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id e3sm7388100qto.25.2022.02.21.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:48:21 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:48:17 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: handle zero regions in vhost_set_memory
Message-ID: <20220221164817.obpw477w74auxlkn@sgarzare-redhat>
References: <20220221072852.31820-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220221072852.31820-1-mail@anirudhrb.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 12:58:51PM +0530, Anirudh Rayabharam wrote:
>Return early when userspace sends zero regions in the VHOST_SET_MEM_TABLE
>ioctl.
>
>Otherwise, this causes an erroneous entry to be added to the iotlb. This
>entry has a range size of 0 (due to u64 overflow). This then causes
>iotlb_access_ok() to loop indefinitely resulting in a hung thread.
>Syzbot has reported this here:
>
>https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87

IIUC vhost_iotlb_add_range() in the for loop is never called if 
mem.nregions is 0, so I'm not sure the problem reported by syzbot is 
related.

In any case maybe this patch is fine, but currently I think we're just 
registering an iotlb without any regions, which in theory shouldn't 
cause any problems.

Thanks,
Stefano

>
>Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
>Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>---
> drivers/vhost/vhost.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 59edb5a1ffe2..821aba60eac2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1428,6 +1428,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
> 		return -EFAULT;
> 	if (mem.padding)
> 		return -EOPNOTSUPP;
>+	if (mem.nregions == 0)
>+		return 0;
> 	if (mem.nregions > max_mem_regions)
> 		return -E2BIG;
> 	newmem = kvzalloc(struct_size(newmem, regions, mem.nregions),
>-- 
>2.35.1
>

