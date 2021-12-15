Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0247591A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhLOMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhLOMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639572672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIz3HWEkXJXu8Z4HMLNGvCSYl8drq+KNuCJoZoTFtEQ=;
        b=C/bz8F04zHbOO5/UE9qbWujgLhvV2ZAG7JRDc8/M6AtG+eX6dWC/Xw+YJywhccf0i+oIyb
        pGLao7Y89Z96vbi0486Oy+yUDGip7LW/4tC8c2TNERnUKhYE7spuJuxj/GBYq1IfcGNjpg
        PNyeHx44PuY8v3tu+BNoEhiKxhgi20o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-rB4vMwE9OYeZOl0Wfbd1Hg-1; Wed, 15 Dec 2021 07:51:09 -0500
X-MC-Unique: rB4vMwE9OYeZOl0Wfbd1Hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0EB6100E33E;
        Wed, 15 Dec 2021 12:51:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A46C86B5A;
        Wed, 15 Dec 2021 12:51:04 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Thomas Huth <thuth@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
Organization: Red Hat GmbH
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
 <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
 <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Wed, 15 Dec 2021 13:51:02 +0100
Message-ID: <87tufaqbex.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:

> On 14/12/2021 22.55, Tony Krowiak wrote:
>> 
>> 
>> On 12/13/21 11:11, Cornelia Huck wrote:
>>> One possibility is simply blocking autoload of the module in userspace by
>>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
>>> is installed on the system. This is obviously something that needs to be
>>> decided by the distros.
>>>
>>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
>>> not really make it worse.)
>> 
>> Of the vfio_ccw module is automatically loaded, then the kvm
>> module will also get loaded. I startup up a RHEL8.3 system and
>> sure enough, the vfio_ccw module is loaded along with the
>> kvm, vfio and mdev modules. If this is true for all distros, then
>> it wouldn't make much difference if the vfio_ap module is
>> autoloaded too.
>
> I think I don't mind too much if we auto-load vfio-ap or not - but I think 
> we should make it consistent with vfio-ccw. So either auto-load both modules 
> (if the corresponding devices are available), or remove the 
> MODULE_DEVICE_TABLE() entries from both modules?

I think we really need to take a step back and think about the purpose
of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
of devices on a certain bus a driver supports, in a way that can be
consumed by userspace (after file2alias.c worked on it).

Userspace typically uses this to match devices it is notified about to
drivers that could possibly drive those devices. In general, the
assumption is that you will want to have the drivers for your devices
loaded. In some cases (drivers only used in special cases, like here),
it might be a better idea to autoload the drivers only under certain
circumstances (e.g. if you know you're going to run KVM guests).

My main point, however, is that we're talking about policy here: whether
a potentially useful driver should be loaded or not is a decision that
should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
not look like the right solution, as it deprives userspace of the
information to autoload the driver, if it actually wants to do so.

