Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD593508EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355373AbiDTRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348613AbiDTRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 166094706C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650476443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6Zu8efagxCg0qjIbj3LGsUm4V9r8EQ58X79KLBO8as=;
        b=Jh0vJuYeLXNjNvBoHmeQdiO+226CJo7QymEj1RC80qqGe6tNDcxW1wfNjbl+gSdqW+WLPX
        gj1OlJYwcuozE0iDUBOuVvYptzLt5s/2DMXe6rQrogXlbBz/qet5EeBvp5OiJLZkVC+Kw4
        Hn0gBmzTlcUw0UEnyg3rrHMzuMtkyp4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-P_zf1Ew6MfyVBVLpS0Y1Kg-1; Wed, 20 Apr 2022 13:40:42 -0400
X-MC-Unique: P_zf1Ew6MfyVBVLpS0Y1Kg-1
Received: by mail-oi1-f198.google.com with SMTP id c3-20020acab303000000b003226fc84078so1208935oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=N6Zu8efagxCg0qjIbj3LGsUm4V9r8EQ58X79KLBO8as=;
        b=7QPcYh2oluIAutKkmG30DmwVDAYD4CoLu6XPFTQgsW11BuZ9g8JQw+E6CE2Bl/oTEw
         hV930H6b4o1wobCN6xRDKeyn6RQDSGATQxf7SAy4nUPEC7ELVgAqa4nFjGf04AB/UcPc
         4i4GXulaayPzvF2wuXFinIlYduGr5ZZVAIgAHcBzzmdgNqn2tSoZ926CGHz7oY6iUttY
         6yXtsTx/IDRMhrkNgnmitiOLBzIL6H27rHdGUsW8jVZoh/bwwPq0JLvtWdgbikB3VkFk
         h/gAGZ6atVExqV3cHBGsjhpuJjy57pzZecvDGdk8FPbvQ+42iQC9xtqNTrM40duEAxfJ
         PhDA==
X-Gm-Message-State: AOAM533Yg3MeDt2Ibwdn0frvPJGXm3eG6eSK+hpNtUSWpAT6sTiarCf4
        qDCL7Oj+g2dBigZrnG00nK0nPRLL4HwGCGci1Y4+RhyaQFCJ4CzFAHlJN5lEoiCUmp5UuNcste3
        kVo5ihY0L4ykfFcFMiFyQvshc
X-Received: by 2002:a4a:b3c5:0:b0:324:527f:8709 with SMTP id q5-20020a4ab3c5000000b00324527f8709mr7558540ooo.90.1650476441819;
        Wed, 20 Apr 2022 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQODyrfz4O2ySVJfB4AMKPDpvPokiiH++tjPxvtaenmiy7ATr53rd1FOYaFbMSL0CEN6bEdQ==
X-Received: by 2002:a4a:b3c5:0:b0:324:527f:8709 with SMTP id q5-20020a4ab3c5000000b00324527f8709mr7558526ooo.90.1650476441569;
        Wed, 20 Apr 2022 10:40:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm6870564oou.10.2022.04.20.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:40:41 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:40:33 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PULL v2] gvt-next
Message-ID: <20220420114033.7f8b57c7.alex.williamson@redhat.com>
In-Reply-To: <20220420164351.GC2120790@nvidia.com>
References: <5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com>
        <20220420164351.GC2120790@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 13:43:51 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 20, 2022 at 04:34:47PM +0000, Wang, Zhi A wrote:
> > Hi folks:
> > 
> > Here is the PR of gvt-next. Thanks so much for the patience.
> > 
> > Mostly it includes the patch bundle of GVT-g re-factor patches for adapting the GVT-g with the
> > new MDEV interfaces:
> > 
> > - Separating the MMIO table from GVT-g. (Zhi)
> > - GVT-g re-factor. (Christoph)
> > - GVT-g mdev API cleanup. (Jason)
> > - GVT-g trace/makefile cleanup. (Jani)
> > 
> > Thanks so much for making this happen.
> > 
> > This PR has been tested as following and no problem shows up:
> > 
> > $dim update-branches
> > $dim apply-pull drm-intel-next < this_email.eml
> > 
> > The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> > 
> >   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/intel/gvt-linux tags/gvt-next-2022-04-20-for-christoph
> > 
> > for you to fetch changes up to ae7875879b7c838bffb42ed6db4658e5c504032e:
> > 
> >   vfio/mdev: Remove mdev drvdata (2022-04-20 03:15:58 -0400)  
> 
> This looks well constructed now! thanks
> 
> Alex you can pull this for VFIO after Jani&co grab it
> 
> I'll respin my vfio_group series on top of this branch

Sure, so just to confirm tags/gvt-next-2022-04-20-for-christoph is
pruned down to exactly the commits we're looking for now?  Thanks,

Alex

