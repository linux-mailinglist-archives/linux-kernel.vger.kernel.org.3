Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B85A707B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiH3WSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiH3WSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083316D9E7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661897923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSSAWMfY5IhOGMsl4sCR/Sqq+wVCREXXNdNLZqAgz7E=;
        b=SlbKa74lYPJssd8c/BRasmJh/BCMoFRnl+LKFu990Im56H2r9rlfnBx/pOVX2WeyD+cO3o
        FYv9Aq3OVjO0cCeb16LKkwvyDQSzcG9QtFHmy/Qqt2/f0jWBkgt7YcdOlSmwj0HlMHgXb+
        EhLsUhL3sgVDc+T6UkwIx9stxfQlMAg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-8uZ9sd4qOtqzvjUReITHDg-1; Tue, 30 Aug 2022 18:18:42 -0400
X-MC-Unique: 8uZ9sd4qOtqzvjUReITHDg-1
Received: by mail-io1-f71.google.com with SMTP id y10-20020a5d914a000000b00688fa7b2252so7542822ioq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=TSSAWMfY5IhOGMsl4sCR/Sqq+wVCREXXNdNLZqAgz7E=;
        b=0V+4mC32oIDaeOjyLYNbcveucbM5zyuzckq6P0P6Ep0tnXyTkUC4G4+jyNs+batQ6S
         d37itlK6Yzreeg/6bVdNG8hkCy5sf6mULl2rYP/ZVibkBL15ozItVXXOPOd/yJcwgAnv
         ZHB8FybDdP8zff8gGfnLukUGC9ajPpfY54lf0HSzgPu/trby70BmmZZ+X+f+C/azu5pc
         w8ZdLupgsR8Dl6pDYmXMPtsgx5vxK+lN12jCh1dD/G2YVcwV9Yc5eiTSL8Z6a0AXeiyQ
         bmGeDFWiLI+vnRxDd0K6fU8UJvlXG7r1xi5QGvyUwF1y7QB8EAyU99TyqfZhhZe9H18K
         iYHw==
X-Gm-Message-State: ACgBeo1+QmPyazwlLXC/VFvF2BCWglM9054Azkger7DroZDck90soOrC
        BYrUtHRTv8rLgDCyQD+QXp9NotfQ6nqgB0OFLMEUmJAnF0cgjdquRYjWQu1cj/A51zQivQzpECc
        ys2S+baqGzR3vvcziJynyQAVt
X-Received: by 2002:a05:6602:1c4:b0:689:2db5:ea0f with SMTP id w4-20020a05660201c400b006892db5ea0fmr11509838iot.197.1661897921390;
        Tue, 30 Aug 2022 15:18:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73OWrrAXNYUM7X5f/RFjdmLhOTn+HRSKcgl5cCW81jvTLPZGl1q1ozpKM9lFAFywZRpg27UQ==
X-Received: by 2002:a05:6602:1c4:b0:689:2db5:ea0f with SMTP id w4-20020a05660201c400b006892db5ea0fmr11509822iot.197.1661897921151;
        Tue, 30 Aug 2022 15:18:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6110858iow.13.2022.08.30.15.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:18:40 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:18:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kevin Tian <kevin.tian@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220830161838.4aa47045.alex.williamson@redhat.com>
In-Reply-To: <20220827171037.30297-16-kevin.tian@intel.com>
References: <20220827171037.30297-1-kevin.tian@intel.com>
        <20220827171037.30297-16-kevin.tian@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 01:10:37 +0800
Kevin Tian <kevin.tian@intel.com> wrote:

> From: Yi Liu <yi.l.liu@intel.com>
> 
> and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> sysfs path of the parent, indicating the device is bound to a vfio
> driver, e.g.:
> 
> /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> 
> It is also a preparatory step toward adding cdev for supporting future
> device-oriented uAPI.

Shall we start Documentation/ABI/testing/vfio-dev now?  Thanks.

Alex

