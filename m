Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6147314E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbhLMQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236838AbhLMQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639411872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxYrzFZ5aQZcKiNKGplZGCKDDpbz86OviVlYCbHfgJI=;
        b=P85h3mmJAqLRtl+BLXYxSLyvlcXHdcs5F975u3A02u95TJHyeNYD5AiDppqio0kM2XClrR
        xGUWUnlcwsf1BLQPBUg6UefY7s36ySqGFdXbrMlp/Bcb271XeByVtDO5PRiw12tiuNYthK
        cdjyIU6AHV9pdDjQuk9yYoF5KRwCAW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-598-M7kOco1jPqi7Bew0bBlfBw-1; Mon, 13 Dec 2021 11:11:10 -0500
X-MC-Unique: M7kOco1jPqi7Bew0bBlfBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C996185EE69;
        Mon, 13 Dec 2021 16:11:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A106ADCB;
        Mon, 13 Dec 2021 16:11:08 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 13 Dec 2021 17:11:06 +0100
Message-ID: <87k0g8scx1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13 2021, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 01.12.21 15:11, Thomas Huth wrote:
>> The crypto devices that we can use with the vfio_ap module are sitting
>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>> itself. With this change, the vfio_ap module now gets automatically
>> loaded if a supported crypto adapter is available in the host.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Note: Marked as "RFC" since I'm not 100% sure about it ...
>>        please review carefully!
>>
>>  drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfi=
o_ap_drv.c
>> index 4d2556bc7fe5..5580e40608a4 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] =3D {
>>  	{ /* end of sibling */ },
>>  };
>>=20=20
>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>=20=20
>>  /**
>>   * vfio_ap_queue_dev_probe:
> I had a chance to check this now.
> First I have to apologize about the dispute with vfio devices appearing o=
n the ap bus.
> That's not the case with this patch. As Connie states the MODULE_DEVICE_T=
ABLE() does not
> change the parent of a device and vfio_ap_drv is a driver for ap devices =
and thus
> belongs to the ap bus anyway.
> So what's left is that with this change the vfio_ap kernel module is auto=
matically loaded
> when an ap device type 10-13 is recognized by the ap bus. So the intentio=
n of the patch
> is fulfilled.
> Yet another kernel module which may occupy memory but will never get used=
 by most customers.
> This may not be a problem but I had a glance at the list of kernel module=
s loaded on my
> LPAR with and without the patch and the difference is:
> ...
> kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512000=C2=A0 1 vfio_ap
> vfio_ap=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 28672=C2=A0 0
> ...
> So the vfio_ap module has a dependency to the biggest kernel module ever =
- kvm.
> Do I need to say something more?
>
> If this dependency is removed then I would not hesitate to accept this pa=
tch. However
> this is up to Tony as he is the maintainer of the vfio ap device driver.

I don't think you can drop the kvm reference, as the code in vfio-ap
obviously depends on it...

One possibility is simply blocking autoload of the module in userspace by
default, and only allow it to be loaded automatically when e.g. qemu-kvm
is installed on the system. This is obviously something that needs to be
decided by the distros.

(kvm might actually be autoloaded already, so autoloading vfio-ap would
not really make it worse.)

