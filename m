Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CAD4911BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiAQWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243572AbiAQWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642458705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FL822A+VhuSR8ouSoFdCDXJX7fbLnOA4cmggcaKq1ko=;
        b=Te5sMuXo3EoowvB26sbT9xghEb9jHXJb2wpvOWM4HhwK4lWA0/v7M45iFoL85fCO6dhe2p
        sFnO3qDLyKys4yXKU9hcqpphnVRkjaGKGOxugZ66BRpFRGx9z2/o9+6MTMPZiCMSaMioyZ
        8Pe4VRH6gCA+mSI+WqhcjXNmu3KPc4o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-_igYuaxHO42ugrP84GUDHA-1; Mon, 17 Jan 2022 17:31:43 -0500
X-MC-Unique: _igYuaxHO42ugrP84GUDHA-1
Received: by mail-ed1-f70.google.com with SMTP id a8-20020a056402168800b004022fcdeb25so4512372edv.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FL822A+VhuSR8ouSoFdCDXJX7fbLnOA4cmggcaKq1ko=;
        b=rhA0kkOBpJLw3WCFlT7oQlDNvc6fGe4YYTQG31nKPkBbbhKOXpGV3L3LxPkQp/e1/m
         avRLJ6XL3hQ0tt66wYb9sHgEsZ2AianLYmZ/gMYTHW+Qc7EQ7sC7UCLJpDaM0fAZ6B5G
         n4Uni+0ISkwCkm81yDb6rcjyieAICubpS2D0TXMDtfq7JeYzhOV3spZn6Chms6ZMktRH
         CdeQ6QSNHou1NuwgLwxLv8wGR4QPJHbyBSLgQ8TZ/ohPIubJhlHdf5d0/sNduWQ5oqrD
         w6rtB+6GlfdgWLQhgmSjB2fjmuaJglk/+a7AbS8upOMHYZ4nN/2EJrz8wYmB+5x+asFK
         /7LA==
X-Gm-Message-State: AOAM531NBmYgzzFtVToz+hdg+L7XxWd7fJMXAPW3l3nTXA2IZUTlNVZJ
        1ZZh/w8C2CHp6mBKT3rCadMAzqIY6Ujo+7UAXx6zKasoMOShP1pIcVlLawNttH495Cu3z+9JhMn
        vzRzDZatDcF8Qf/WENriy6Wmg
X-Received: by 2002:a17:907:3f94:: with SMTP id hr20mr8801515ejc.88.1642458702589;
        Mon, 17 Jan 2022 14:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFtcIaT07HfzGtTIKKXfoD/SNDOq7+REx2KhQH3zo4ePI7rSI/H0kRcW3ViUs+z49kNyQvBw==
X-Received: by 2002:a17:907:3f94:: with SMTP id hr20mr8801484ejc.88.1642458702391;
        Mon, 17 Jan 2022 14:31:42 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id a1sm6330754edu.17.2022.01.17.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:31:39 -0800 (PST)
Date:   Mon, 17 Jan 2022 17:31:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.jaillet@wanadoo.fr, dapeng1.mi@intel.com,
        david@redhat.com, elic@nvidia.com, eperezma@redhat.com,
        flyingpenghao@gmail.com, flyingpeng@tencent.com,
        gregkh@linuxfoundation.org, guanjun@linux.alibaba.com,
        jasowang@redhat.com, jean-philippe@linaro.org,
        jiasheng@iscas.ac.cn, johan@kernel.org, keescook@chromium.org,
        labbott@kernel.org, lingshan.zhu@intel.com, lkp@intel.com,
        luolikang@nsfocus.com, lvivier@redhat.com, pasic@linux.ibm.com,
        sgarzare@redhat.com, somlo@cmu.edu, trix@redhat.com,
        wu000273@umn.edu, xianting.tian@linux.alibaba.com,
        xuanzhuo@linux.alibaba.com, yun.wang@linux.alibaba.com
Subject: Re: [GIT PULL] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
Message-ID: <20220117172924-mutt-send-email-mst@kernel.org>
References: <20220114153515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114153515-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:35:15PM -0500, Michael S. Tsirkin wrote:
> Jean-Philippe Brucker (5):
>       iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>       iommu/virtio: Support bypass domains
>       iommu/virtio: Sort reserved regions
>       iommu/virtio: Pass end address to viommu_add_mapping()
>       iommu/virtio: Support identity-mapped domains

Linus, just making sure we are on the same page: Jean-Philippe
asked me to drop these patches since another version has been
accepted into another tree. So I did and sent v2 of the pull.
Hope that's clear and sorry about the noise.

-- 
MST

