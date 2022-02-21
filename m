Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690B84BDCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379025AbiBUPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiBUPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A446BCA3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645456968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//ocvqSZP1Bqt7GMZm3TubXy/TDW1Bh0IsBpphamyS8=;
        b=I0XcvEWMZ1fPOMjpGWJoTiBcbvyH+Fx/OHjWzUR2qeBCVRe7P3L7xElCGtX/UZHYORlK/i
        oabhkGWS+PB5kuyjjk4yJjAqMEZW6NdQfIPWiziKzZgVHb0M6cZb49xAPq1DAaYuIjKDFj
        C4Gv1fHHDcsekotdZtln4e4ly9/V/L4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-4DlDJiYIO-SqeWhcPpvP7w-1; Mon, 21 Feb 2022 10:22:45 -0500
X-MC-Unique: 4DlDJiYIO-SqeWhcPpvP7w-1
Received: by mail-wm1-f70.google.com with SMTP id ay41-20020a05600c1e2900b0037c5168b3c4so8150259wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//ocvqSZP1Bqt7GMZm3TubXy/TDW1Bh0IsBpphamyS8=;
        b=svyCUNUeemf+0+HQoggkZ/KrY8OCS4Z1hwoUcbgyMXMzMO/MjoyKQ9HCkqrBWh8032
         s5GQN1eoxqvXtuorlNjvOAmcvJ6Yr9fGATAucaB+6ngTJqI83ggjeg7GQcxB0F39/TM4
         YqYqt1Ggt55rG2bcaeRD4JgZNU4IZz2wVydVuqHDoYFiHnjv1A9GTO/XeW8fd0DdJTrb
         cvHWZJIRgceqHMLSjTGUekxPB7p/PMUzwfC/QClhOfWidfZsn1gjCsbhoiYq2lb553qW
         SGfwDN+IfS8XQaYXZfztSFNyW7x54mPtW6l5uxTedVdzpWU4fwBLFMqqmDHNT8CMk2uy
         yY+g==
X-Gm-Message-State: AOAM5334NrKQ9waqRKP9iqaIQfnS8HC/XybWPTnpUeiO8nqlJBIpTLdB
        GZ+RdSfbpvoxSRMS1c5wSOvQmuKsdu/gxbjqxb2ILv2SYBcPyEdDtNDauOHnxaG214lUoSUfoei
        l9UvxwD7CW6oTTYvufQ8YrvrV
X-Received: by 2002:adf:f3cc:0:b0:1e7:4fd9:6fd3 with SMTP id g12-20020adff3cc000000b001e74fd96fd3mr15663038wrp.266.1645456964077;
        Mon, 21 Feb 2022 07:22:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRe76b/qP2XEzCDRn/yzRVG9vTAJA8nQ+6DymsN10XGTOpBA26zz1vt6D+IC5eOeVGMUheYA==
X-Received: by 2002:adf:f3cc:0:b0:1e7:4fd9:6fd3 with SMTP id g12-20020adff3cc000000b001e74fd96fd3mr15663016wrp.266.1645456963802;
        Mon, 21 Feb 2022 07:22:43 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm7745956wmi.7.2022.02.21.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:22:43 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:22:40 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Asias He <asias@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220221152240.nbdthe4grii577zd@sgarzare-redhat>
References: <20220221114916.107045-1-sgarzare@redhat.com>
 <20220221094829-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220221094829-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:03:39AM -0500, Michael S. Tsirkin wrote:
>On Mon, Feb 21, 2022 at 12:49:16PM +0100, Stefano Garzarella wrote:
>> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
>> ownership. It expects current->mm to be valid.
>>
>> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
>> the user has not done close(), so when we are in do_exit(). In this
>> case current->mm is invalid and we're releasing the device, so we
>> should clean it anyway.
>>
>> Let's check the owner only when vhost_vsock_stop() is called
>> by an ioctl.
>
>
>
>
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vhost/vsock.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index d6ca1c7ad513..f00d2dfd72b7 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>>  	return ret;
>>  }
>>
>> -static int vhost_vsock_stop(struct vhost_vsock *vsock)
>> +static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>
>>  {
>>  	size_t i;
>>  	int ret;
>>
>>  	mutex_lock(&vsock->dev.mutex);
>>
>> -	ret = vhost_dev_check_owner(&vsock->dev);
>> -	if (ret)
>> -		goto err;
>> +	if (check_owner) {
>> +		ret = vhost_dev_check_owner(&vsock->dev);
>> +		if (ret)
>> +			goto err;
>> +	}
>>
>>  	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>>  		struct vhost_virtqueue *vq = &vsock->vqs[i];
>> @@ -753,7 +755,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	 * inefficient.  Room for improvement here. */
>>  	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
>>
>> -	vhost_vsock_stop(vsock);
>
>Let's add an explanation:
>
>When invoked from release we can not fail so we don't
>check return code of vhost_vsock_stop.
>We need to stop vsock even if it's not the owner.

Do you want me to send a v2 by adding this as a comment in the code?

Thanks,
Stefano

