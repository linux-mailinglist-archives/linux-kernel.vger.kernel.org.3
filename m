Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15674BDC47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbiBUOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:05:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiBUOFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBB4A1AF05
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645452300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuKH4ehNIIDunUbhgDK4MRZpKVeFrYeUdoSYN/COdpI=;
        b=E35knTLaUQYKTIncS7+KDd5++JRHfCjb2km6SlXjQqDyrAUxj6PEGXK5UZcVqXsMUd78JF
        p9LUoD+2pfbISlYLori7+e/bF94v9mcMrJR0SiHC1iWnfsDey4kkItyeGPlE6MVn/dMpwH
        XiIi2N4jpanQxLI0M3CJH0udHe6yyGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-UAsdU0GrM0uUZc6MFEk3Tw-1; Mon, 21 Feb 2022 09:04:58 -0500
X-MC-Unique: UAsdU0GrM0uUZc6MFEk3Tw-1
Received: by mail-wm1-f69.google.com with SMTP id b17-20020a05600c4e1100b0037cc0d56524so8084721wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuKH4ehNIIDunUbhgDK4MRZpKVeFrYeUdoSYN/COdpI=;
        b=r6WJtRRiSVrxAe1yhpDwTKqvTqqTFzURdxqwKDDWOJQRAOyDKldKa9HZ0a73nhtL5y
         gyykEr5GjAoM5g4O5wZkQIG7laq3qcx1U8Rrc8pgfdcs4nKCC0Srv2k8snMArNZwidLA
         81k2Qq/IwX9Y+Cvk6dA9Y3J25TW1RDUD+yQS2mlUfSdLvjVtEjfClHeBnu6jdVj6qvG9
         xIq7NJDpuK/ztNyThx0v/DH7tuaErAJw1i70HO8NrJxoDq2dRR23PTzT0U0m5qJlKYrA
         9W/iTsUu2cBcvsnU8wVXMlyn2YnCJO+kMUMqM1JYyaDEKGUoKF95rg4J3gGeqqcnphwW
         rJgw==
X-Gm-Message-State: AOAM532CZSbqNLs7ACzzoFjBzY+XAq4+50RFGx8jL8SmaU6l7vlYpbQR
        HpPCoK0QthLSrtywsdPrpqYK/La21/LRtzSFN6Jrc+ZsYWhre9K5KOZWeC2NTnibUFozKW1y6xQ
        yg2cOt4OrEYaVZGzH8V7DsrAZ
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr21594744wmp.41.1645452296644;
        Mon, 21 Feb 2022 06:04:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpKteAZqGf0JEeuOXtKjO41lLvVX2W/NT2aBtZT32/Tf2vYIt0N3yQFIpBz7f83lY+nAkcCQ==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr21594727wmp.41.1645452296423;
        Mon, 21 Feb 2022 06:04:56 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id ay41sm833174wmb.44.2022.02.21.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:04:55 -0800 (PST)
Date:   Mon, 21 Feb 2022 15:04:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221140453.ndai2piyhrs3y5jw@sgarzare-redhat>
References: <20220219125100.835-1-hdanton@sina.com>
 <000000000000e5720605d85e97d7@google.com>
 <20220221133646.1551-1-hdanton@sina.com>
 <20220221134516.gmm3a5bjdlnzile2@sgarzare-redhat>
 <20220221085926-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220221085926-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 08:59:56AM -0500, Michael S. Tsirkin wrote:
>On Mon, Feb 21, 2022 at 02:45:16PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 21, 2022 at 09:36:46PM +0800, Hillf Danton wrote:
>> > Hey Stefano,
>> >
>> > On Mon, 21 Feb 2022 14:09:26 +0100 Stefano Garzarella wrote:
>> > > It seems that this patch [1] should fix also this issue. (syzbot seems
>> > > happy).
>> >
>> > What do you mean by happy?
>> > Why not feed it to syzbot if it is a good fix, given a test-by tag can
>> > speak for itself?
>>
>> Because I sent the patch this morning for another report:
>> https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0
>>
>> Then I asked syzbot for this report to test my branch with that patch
>> applied and the result is OK.
>>
>> Is there any way to ask syzbot to test a patch already posted to the mailing
>> list? (instead of sending it back to it again)
>>
>> Stefano
>
>I don't know of a way, but hey, sending it back isn't too bad,
>just mention this in the mail text.
>

Okay, I'll do also for another report.

Thanks,
Stefano

