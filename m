Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3A46D595
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhLHO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbhLHO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638973527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IVTJNfmaEDM23Hd/62LzRs7TSG8ZwNZGUSqYW+zQh4=;
        b=aek1E5RTmdupvyNPL27JlW4WFnUNxVWjvAHzYeg44lCLx6jyHsdYaRD2mmnahG8s76FLjb
        cvWd5znoBN7hZG2fP9bXOew7U7E7wyySu8DXyGZLxxlewecO+u1mlx/lSOcPu8GFY0SHJv
        aQ3KjRFx5QCL098LSeyJ67iiVQfbHm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-TK7W-aVPPBKkn5IsyGmK6Q-1; Wed, 08 Dec 2021 09:25:24 -0500
X-MC-Unique: TK7W-aVPPBKkn5IsyGmK6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9818801AAB;
        Wed,  8 Dec 2021 14:25:22 +0000 (UTC)
Received: from localhost (unknown [10.39.193.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E7D781EF;
        Wed,  8 Dec 2021 14:25:22 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Thomas Huth <thuth@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <0f1c6b3e-7e33-6fd1-11e7-f4857ec55105@redhat.com>
Organization: Red Hat GmbH
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
 <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
 <0f1c6b3e-7e33-6fd1-11e7-f4857ec55105@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 08 Dec 2021 15:25:20 +0100
Message-ID: <87a6hbtbqn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2021, Thomas Huth <thuth@redhat.com> wrote:

> On 02/12/2021 09.33, Harald Freudenberger wrote:
>> On 02.12.21 08:13, Thomas Huth wrote:
>>> On 01/12/2021 18.10, Harald Freudenberger wrote:
>>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>>> itself. With this change, the vfio_ap module now gets automatically
>>>>> loaded if a supported crypto adapter is available in the host.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  =C2=A0 Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 please review carefully!
>>>>>
>>>>>  =C2=A0 drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>>  =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/=
vfio_ap_drv.c
>>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] =3D {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of sibling */ },
>>>>>  =C2=A0 };
>>>>>  =C2=A0 -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>>  =C2=A0 =C2=A0 /**
>>>>>  =C2=A0=C2=A0 * vfio_ap_queue_dev_probe:
>>>> Hello Thomas, interesting.
>>>> Did you test this ? I mean did you build a kernel and have it run on a=
 s390 with crypto cards available ?
>>>
>>> Yes, I've tested it. Without the patch, the vfio_ap module does not get=
 loaded automatically if a crypto card is available. With the patch applied=
, the vfio_ap module correctly gets loaded automatically on my system (simi=
lar to the vfio_ccw module).
>>>
>>>> My strong feeling is that this will make the AP bus code stumble as th=
e code silently assumes there are exact
>>>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>>>
>>> This is only about getting the module loaded automatically once such a =
device is available ... AFAIK it does not grab any of the devices automatic=
ally, so there shouldn't be any problems?
>>>
>>>  =C2=A0Thomas
>>>
>> Yes, of course for the automatic module load works this way. But you und=
erstand that now
>> the vfio devices are childs of the ap bus and thus are siblings of the a=
p queue and ap card
>> devices. As I wrote the ap bus code is not prepared to deal with a 3th t=
ype of devices
>> dangling on the ap bus. So you should test what happens when there are r=
eal vfio ap devices
>> in use together with 'regular' ap card and queue devices.

Um, the queues/cards are devices on the bus, and just can have
different drivers bound to them, right? The only device that the vfio-ap
driver creates is the matrix device (which does not live on the ap bus),
and this patch doesn't change that. It only correctly creates a table
for a driver that already matched on the ap bus.

>
> I pondered about this for a while, but I still do not quite understand. T=
he=20
> MODULE_DEVICE_TABLE macro only adds a __mod_something_device_table symbol=
 to=20
> the module, it does not change the hierarchy of the vfio devices ... so t=
his=20
> is really only about loading the module automatically. Or do you say that=
=20
> there is already a problem if a user loads the module manually and thus i=
t=20
> should not get loaded automatically?

Correct me if I'm wrong, but don't the devices on the ap bus need to be
actually configured before they can attach to a non-default
(i.e. vfio-ap) driver? IOW, it's not a simple bind operation, but extra
configuration is required, so a loaded vfio-ap module should not affect
any devices not configured to actually use it at all.

>
>> However, I am still not sure if it is preferable to have the vfio ap mod=
ule loaded automatically. The majority
>> of customers will never use vfio ap devices - this is specific to kvm ho=
sts only.
> vfio-ccw also gets loaded automatically via MODULE_DEVICE_TABLE, so I thi=
nk=20
> vfio-ap should be handled the same way.
> (Or should we maybe rather remove the MODULE_DEVICE_TABLE line from both=
=20
> modules instead?)

MODULE_DEVICE_TABLE declares "I can drive these devices", so it doesn't
feel correct to remove them. If the modules should not be autoloaded,
the system must be configured to not autoload them.

Besides, is loading an extra module really causing that much harm? Does
vfio-ap drag in too much other stuff?

