Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EED463EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhK3Tfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343531AbhK3TfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638300702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ab/eEvberRXEPRpb3m3KuYEHLhIA3GZ7+BfNOiqphxQ=;
        b=i0mCXs9A3rGUzY9wLVmWGOwu+PQVHZRljVq32Vl5vrtnsatlW88MLDlucvzfQsIrVk4cjZ
        1t85D7TPpJ41fn5Dl9FEEuiCIgix3to7CVaIsU56vuL+RZwPEOeTYO9MMyIN2chm3k/L6O
        1AJXlqEK050y+pQyLiYhEW7Ox7Q0IoU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-hHUZBg_3OLWuDc4XphS3yA-1; Tue, 30 Nov 2021 14:30:34 -0500
X-MC-Unique: hHUZBg_3OLWuDc4XphS3yA-1
Received: by mail-oi1-f197.google.com with SMTP id bj40-20020a05680819a800b002bc9d122f13so14585412oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ab/eEvberRXEPRpb3m3KuYEHLhIA3GZ7+BfNOiqphxQ=;
        b=gsThMaiHRWSZYWuF3B/xO0kobeanHrfW/dPQLfcaaFtYAefz47KlSTK8Yx5NHjaAtW
         HgxyRP5JUNdEv/Zz0taeogS3Z8znQzAi14iTd0DIRP//b0BtR+iUAPqlqi1XiuzD3nNU
         lBHdc9PTeWIvSaDn7kvj/tePE7ZkW1RoI7wsBAxw+SvMvmEr7Sr6lqzE0AiSH90Rz803
         072J9kYbMrZ55bNJ3vB6K6pomPWri1n0JFbTfPk3CzPaYwrcZz0ZMMVuubYPtLm5x1YF
         fIlFmqVYHPZaZX4ji4zyldKe9aA+L3e5We+G8hsxxqLJFAF0CVd054mjr/dJmOyskYuY
         FqWQ==
X-Gm-Message-State: AOAM530W7DyVD4BuY3rf9EYEq1bMZxrE62aqksNB0lxrHcP0lXbNKFpF
        LNNklf3GLTgnwmUm7jMQkQ+SjkLgiFYkl2fOdWqXYlL87iLjmELKa6M1uJbuzx+Blm5AFTvU+gf
        nLCd96L2Aqlmb/aXq4iALx1Zb
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr1031475oib.86.1638300633998;
        Tue, 30 Nov 2021 11:30:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3Si/RLkbte2UbCSB+fXYe0z9rbN1DldK0ufEbhrVBrNTEHU0y5Rd9OyyNvf+l26pUv4YugA==
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr1031454oib.86.1638300633775;
        Tue, 30 Nov 2021 11:30:33 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e14sm3815037oie.7.2021.11.30.11.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:30:33 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:30:32 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: drivers/vfio/vfio.c:293: warning: expecting prototype for
 Container objects(). Prototype was for vfio_container_get() instead
Message-ID: <20211130123032.035e06a3.alex.williamson@redhat.com>
In-Reply-To: <38a9cb92-a473-40bf-b8f9-85cc5cfc2da4@infradead.org>
References: <202111102328.WDUm0Bl7-lkp@intel.com>
        <20211110164256.GY1740502@nvidia.com>
        <38a9cb92-a473-40bf-b8f9-85cc5cfc2da4@infradead.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 15:19:40 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/10/21 8:42 AM, Jason Gunthorpe wrote:
> > On Wed, Nov 10, 2021 at 11:12:39PM +0800, kernel test robot wrote:  
> >> Hi Jason,
> >>
> >> FYI, the error/warning still remains.  
> > 
> > This is just a long standing kdoc misuse.
> > 
> > vfio is not W=1 kdoc clean.
> > 
> > Until someone takes a project to fix this comprehensively there is not
> > much point in reporting new complaints related the existing mis-use..  
> 
> Hi,
> 
> Can we just remove all misused "/**" comments in vfio.c until
> someone cares enough to use proper kernel-doc there?
> 
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] vfio/vfio: remove all kernel-doc notation
> 
> vfio.c abuses (misuses) "/**", which indicates the beginning of
> kernel-doc notation in the kernel tree. This causes a bunch of
> kernel-doc complaints about this source file, so quieten all of
> them by changing all "/**" to "/*".
> 
> vfio.c:236: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * IOMMU driver registration
> vfio.c:236: warning: missing initial short description on line:
>   * IOMMU driver registration
> vfio.c:295: warning: expecting prototype for Container objects(). Prototype was for vfio_container_get() instead
> vfio.c:317: warning: expecting prototype for Group objects(). Prototype was for __vfio_group_get_from_iommu() instead
> vfio.c:496: warning: Function parameter or member 'device' not described in 'vfio_device_put'
> vfio.c:496: warning: expecting prototype for Device objects(). Prototype was for vfio_device_put() instead
> vfio.c:599: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Async device support
> vfio.c:599: warning: missing initial short description on line:
>   * Async device support
> vfio.c:693: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * VFIO driver API
> vfio.c:693: warning: missing initial short description on line:
>   * VFIO driver API
> vfio.c:835: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Get a reference to the vfio_device for a device.  Even if the
> vfio.c:835: warning: missing initial short description on line:
>   * Get a reference to the vfio_device for a device.  Even if the
> vfio.c:969: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * VFIO base fd, /dev/vfio/vfio
> vfio.c:969: warning: missing initial short description on line:
>   * VFIO base fd, /dev/vfio/vfio
> vfio.c:1187: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * VFIO Group fd, /dev/vfio/$GROUP
> vfio.c:1187: warning: missing initial short description on line:
>   * VFIO Group fd, /dev/vfio/$GROUP
> vfio.c:1540: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * VFIO Device fd
> vfio.c:1540: warning: missing initial short description on line:
>   * VFIO Device fd
> vfio.c:1615: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * External user API, exported by symbols to be linked dynamically.
> vfio.c:1615: warning: missing initial short description on line:
>   * External user API, exported by symbols to be linked dynamically.
> vfio.c:1663: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * External user API, exported by symbols to be linked dynamically.
> vfio.c:1663: warning: missing initial short description on line:
>   * External user API, exported by symbols to be linked dynamically.
> vfio.c:1742: warning: Function parameter or member 'caps' not described in 'vfio_info_cap_add'
> vfio.c:1742: warning: Function parameter or member 'size' not described in 'vfio_info_cap_add'
> vfio.c:1742: warning: Function parameter or member 'id' not described in 'vfio_info_cap_add'
> vfio.c:1742: warning: Function parameter or member 'version' not described in 'vfio_info_cap_add'
> vfio.c:1742: warning: expecting prototype for Sub(). Prototype was for vfio_info_cap_add() instead
> vfio.c:2276: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Module/class support
> vfio.c:2276: warning: missing initial short description on line:
>   * Module/class support
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>   drivers/vfio/vfio.c |   28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

These were never intended to be kernel-doc, thanks for the cleanup.
I've scraped this into my for-linus branch with Jason and Connie's acks
for v5.16.  Thanks,

Alex

