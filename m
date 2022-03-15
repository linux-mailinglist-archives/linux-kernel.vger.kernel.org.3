Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDCE4D981E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbiCOJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbiCOJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 763A34F47F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647337957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5IW2ZO+i2H4FBZWSS5hn4aliQk4aAVWjsRwugmKOuA=;
        b=IJriEEimqoVFuHclqYTe53PgHwrfe70+YcVvLJqu40Env95ZqBy3/H3lkgFK9JVwLs7duM
        D84TleK3knakvy94DqHfvJ3mFu6ZNqJDOUq5bRJ8axL0LZyyESxHHpfsVTryaehRsxJ2WC
        rz3ht5aPQayBSJG/Qyc68yKjDyz1woQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-qq8CX2ZwNZqAamecpeRCJg-1; Tue, 15 Mar 2022 05:52:36 -0400
X-MC-Unique: qq8CX2ZwNZqAamecpeRCJg-1
Received: by mail-qk1-f197.google.com with SMTP id h68-20020a376c47000000b0067e05dade89so935896qkc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N5IW2ZO+i2H4FBZWSS5hn4aliQk4aAVWjsRwugmKOuA=;
        b=OOSBR1kX2sF1oMbpLZmwv1Fw3TeKyF6N/Di8Ppqf4/w0945Upt6avHZxxHCnSCibgZ
         5XxXKrOrZmdB4kZV2eF6NZloU/tcE98TrJR/1LEBAeny2RyeWVlg5wU76qGvm1CAhIjd
         ybIcJOPdtJHkvaxO6HAhS5U4welF289c44EobcinDP9Tk/KAHjEod+Q38QYxossyi9NV
         FeDkzt/51pxdsPe0Y1s2/TMYpkhNu7Env2qY/cRb07qUW+VndAOwV5jvNY94AtIEAgNS
         JyKjM0FO0ynI+cJxzDP0lv5bwHk0APH2YP2j8rvoEBdG8csjRplxSqXeKcV2Y737WRw1
         xIsQ==
X-Gm-Message-State: AOAM533WCRwKsHdtZrjFq+6U9NlPOS7cN55cnkmArMDcSpD79ygOGgGO
        xPT6YvU0+2gc/PmOvOtS57uo2DDLUglkASt7ipsOR/gh+IfCSdJ3forPxd6NYvRMSc78Q9Xb8nC
        NOMH09fHlFbBEMc0eCt/Kal0u
X-Received: by 2002:a05:6214:19c4:b0:440:b035:594b with SMTP id j4-20020a05621419c400b00440b035594bmr6906957qvc.110.1647337955340;
        Tue, 15 Mar 2022 02:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYTGoAIi2s1TzUq1JTWuGCm8A+zaGPrqws9RQeK42gHYAbCHsAokQeH5UfPekVFaxnkxUqmw==
X-Received: by 2002:a05:6214:19c4:b0:440:b035:594b with SMTP id j4-20020a05621419c400b00440b035594bmr6906945qvc.110.1647337955103;
        Tue, 15 Mar 2022 02:52:35 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002e1cd88645dsm5162039qtw.74.2022.03.15.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 02:52:34 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:52:29 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vdpa: support exposing the count of vqs to
 userspace
Message-ID: <20220315095229.e6to3g6juxbacjgk@sgarzare-redhat>
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-4-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220315032553.455-4-longpeng2@huawei.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:25:53AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>- GET_VQS_COUNT: the count of virtqueues that exposed
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vhost/vdpa.c       | 13 +++++++++++++
> include/uapi/linux/vhost.h |  3 +++
> 2 files changed, 16 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 0c82eb5..69b3f05 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -370,6 +370,16 @@ static long vhost_vdpa_get_config_size(struct vhost_vdpa *v, u32 __user *argp)
> 	return 0;
> }
>
>+static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *argp)
>+{
>+	struct vdpa_device *vdpa = v->vdpa;
>+
>+	if (copy_to_user(argp, &vdpa->nvqs, sizeof(vdpa->nvqs)))
>+		return -EFAULT;
>+
>+	return 0;
>+}
>+
> static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> 				   void __user *argp)
> {
>@@ -510,6 +520,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 	case VHOST_VDPA_GET_CONFIG_SIZE:
> 		r = vhost_vdpa_get_config_size(v, argp);
> 		break;
>+	case VHOST_VDPA_GET_VQS_COUNT:
>+		r = vhost_vdpa_get_vqs_count(v, argp);
>+		break;
> 	default:
> 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> 		if (r == -ENOIOCTLCMD)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index bc74e95..5d99e7c 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -154,4 +154,7 @@
> /* Get the config size */
> #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
>
>+/* Get the count of all virtqueues */
>+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)

I'd prefer VHOST_VDPA_GET_NUM_QUEUES, since we use "num_queues" also in 
the spec [1].

But I'm fine also with this:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] 
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-1120003

