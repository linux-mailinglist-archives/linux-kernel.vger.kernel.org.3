Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75D48DAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiAMPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232699AbiAMPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642088722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOQmkcxnHsUnotvr77pJAq4wKyjZXJltLlB+w8uHbjI=;
        b=KK/gyAfe2hkZR59jS8uWZ5KkJGDPMQpTPZ1ak5G/oKNVFpWR2QsddcwSUKbJKfaqK13PcL
        40NexyEudGDxx+iKzHwUa4YDu8MwRWQbHDpSG2oOX7rz7xmuaGn+90bWCCa13ZNPifkqtW
        Q8m/uw+UQui4tcQMcageyvJaFiAzupM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-qjZIfvIVMOWm9lGJEQojQA-1; Thu, 13 Jan 2022 10:45:21 -0500
X-MC-Unique: qjZIfvIVMOWm9lGJEQojQA-1
Received: by mail-pg1-f200.google.com with SMTP id t1-20020a6564c1000000b002e7f31cf59fso117775pgv.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOQmkcxnHsUnotvr77pJAq4wKyjZXJltLlB+w8uHbjI=;
        b=AwqY+dtHCwc+gguV1DmQRRSa82eGRXw4ImAxh94wjjC7B1VNBEOvK1eCsK+JCkmaDT
         5pAVMzLrXkMbzOX2vKptnAYWF2OluMPUW9sZyZBwkv4hGSIbY/J94UtxT2uM5nuehbJK
         SLH5zoTUx9fKrDPzGfn9dWvRj4av5EXyeZw0eAitVBmiJvpgYtLJyy2lmyzDabmY/Gbo
         4tUZKfvbwaXZfJIhCMahXAWAPP2dUK9xVHNVxN2itXffCkFpx0inUlaAhPVVc6MNfiSc
         YhXb4yOLG5fhubWL3MLri6HrIazmYL+zGN+gE2XGemI8FW2reC20DfaSnFvDB4qNJCAj
         WkZg==
X-Gm-Message-State: AOAM531wGWrYx2DZBsE4DtWvr7iCsJkEq6xIGMZCBghfTSOULilHVHow
        yEsLHbtiaQvsSfHeqpn8puQmQzuXSS/5lHHGCMH4JvobuoYW3B5LzY664KaZCvqtK/vhaC63fPi
        NUL2MUebEKjM5kAtIO/mztcF9
X-Received: by 2002:a63:4186:: with SMTP id o128mr4373788pga.450.1642088719908;
        Thu, 13 Jan 2022 07:45:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoTVzJmaQMaCWyrTgeBzpvTXnZncov7SOddrWkGnSqiIzv5eZXOkdcIXRKCxNIrGEynwLc4Q==
X-Received: by 2002:a63:4186:: with SMTP id o128mr4373770pga.450.1642088719635;
        Thu, 13 Jan 2022 07:45:19 -0800 (PST)
Received: from steredhat (host-79-51-11-180.retail.telecomitalia.it. [79.51.11.180])
        by smtp.gmail.com with ESMTPSA id n28sm2603973pgl.7.2022.01.13.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 07:45:19 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:44:47 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stefanha@redhat.com, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220113154301.qd3ayuhrcjnsaim7@steredhat>
References: <20220113145642.205388-1-sgarzare@redhat.com>
 <20220113101922-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220113101922-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:19:46AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 13, 2022 at 03:56:42PM +0100, Stefano Garzarella wrote:
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime. In this case, the device would go to re-read avail
>> index to access the descriptor.
>>
>> As we already do in other place, we can cache the value in `avail_idx`
>> and compare it with `last_avail_idx` to check if there are new
>> buffers available.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I guess we can ... but what's the point?
>

That without this patch if avail index is new, then device when will 
call vhost_get_vq_desc() will find old value in cache and will read it 
again.

With this patch we also do the same path and update the cache every time 
we read avail index.

I marked it RFC because I don't know if it's worth it :-)

Stefano

