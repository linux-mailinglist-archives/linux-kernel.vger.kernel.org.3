Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76C513DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiD1VjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiD1VjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFFC9682B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651181764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQbiMIo1gUtSCaq3YFPNWEYorFG8oaTPuL0iosH3Hq4=;
        b=cNuihQ61Pnxw+DoDoUkuvYLtXERwzTAGWiiWgrxyM6xZHxQFJOkOKRC7+SCLStk1RUgKKV
        pTVuzNVU75dg2RigKUGyC9IhNO8WhQy7VDMQXH5k5SEFnrcWhzP0y9fYl7Di9i86n26yXb
        Jk3jiD5LAC9iE7nOYsvgG7kZpx6AAQ8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-3_qcrhhuPoKKcwPLOwgpPA-1; Thu, 28 Apr 2022 17:36:03 -0400
X-MC-Unique: 3_qcrhhuPoKKcwPLOwgpPA-1
Received: by mail-io1-f70.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so5422954iov.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=iQbiMIo1gUtSCaq3YFPNWEYorFG8oaTPuL0iosH3Hq4=;
        b=Ce80Hcf2h6cFgLlmMvCALoZN7ETue5VsQJYDgIg+31vMPkx7HzeEVaH5P8QrtZwsp7
         Lxt8LxlD2s/Iwzd3UAQN1aS++1i8cq9KiNgo6vfTWro5vbdWVR2aa7GwrCwa11vucSNG
         PrpEWk7EZGdlqr02yWK7WGcpqc3BJ4DeuQmDLx6NqgbJhxtzlZWe1EwXBkloOSA6UCy0
         d7WvqL/75tEDr/caQB0l5Qk/jwiXxrU5GfphABTmwWy371L/WG/cmXYvTT7gckkCXpmM
         VcgPpB5cdCSFAWbI0i5xqzaNhxW4tWYGKprJKEazQVMEXkxeqFaw82Dke7i+wCtGsWLV
         rhKA==
X-Gm-Message-State: AOAM533ht7l3Yak7AkStc/pQfbyZh0pZ7D4isiEgpVjNY1cJ1v4LaGSi
        PD49sg2EgedKZnuIlAk5tFPIXll34/p9z5YPdbFFDkFY1fkuZ7YNgj0G97HGIToylXM3ge40Dxn
        DWpedQj3X/dVMgRve9ITZZin3
X-Received: by 2002:a05:6e02:214b:b0:2cc:1c95:8198 with SMTP id d11-20020a056e02214b00b002cc1c958198mr14200463ilv.231.1651181760596;
        Thu, 28 Apr 2022 14:36:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO2Ydk1G1hZccHv0hPl1sCdxwwRZq6FDq1leR+oIkXB3miVaj8H4gAjSSbLmAYq/XYS2oOAg==
X-Received: by 2002:a05:6e02:214b:b0:2cc:1c95:8198 with SMTP id d11-20020a056e02214b00b002cc1c958198mr14200452ilv.231.1651181760310;
        Thu, 28 Apr 2022 14:36:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c94-20020a029667000000b0032b3a7817a3sm43663jai.103.2022.04.28.14.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:35:59 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:35:58 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PULL] gvt-next
Message-ID: <20220428153558.4b13fa27.alex.williamson@redhat.com>
In-Reply-To: <20220426115258.GJ2125828@nvidia.com>
References: <c5cf6773-e7a2-8ba8-4cde-0bb14007bc6b@intel.com>
        <87zgk8tf3l.fsf@intel.com>
        <a0800c9b-71da-1cad-1dd4-78c0910ac266@intel.com>
        <20220426115258.GJ2125828@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 08:52:58 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Apr 26, 2022 at 08:42:25AM +0000, Wang, Zhi A wrote:
> > On 4/26/22 8:37 AM, Jani Nikula wrote:  
> > > On Tue, 26 Apr 2022, "Wang, Zhi A" <zhi.a.wang@intel.com> wrote:  
> > >> Hi folks:
> > >>
> > >> Here is the pull of gvt-next which fixs the compilation error when i915 debug
> > >> is open after the GVT-g refactor patches.
> > >>
> > >> Thanks so much for the efforts.  
> > > 
> > > Pulled, thanks.
> > > 
> > > BR,
> > > Jani.
> > >   
> > Thanks, looks good now. :)  
> 
> Great! Thanks everyone!
> 
> Alex, can you pull this to VFIO now too? The top commit should be:

I see a gvt-next-2022-04-29 tag adding the following fixes:

419f8299ddad i915/gvt: Fix NULL pointer dereference in init_mmio_block_handlers
5b95b9d58fb0 drm/i915/gvt: Fix the compiling error when CONFIG_DRM_I915_DEBUG_RUNTIME_PM=n
fa630c304b93 drm/i915/gvt: Make intel_gvt_match_device() static

I'm expecting that's my new merge target once a pull request is
completed for that.  Please keep me cc'd.  Thanks,

Alex

> commit 5e9ae5c47052e28a31fb4f55a6e735c28d4c3948
> Author: Zhi Wang <zhi.wang.linux@gmail.com>
> Date:   Mon Apr 25 18:03:31 2022 -0400
> 
>     drm/i915/gvt: Add missing symbol export.
>     
>     When CONFIG_DRM_I915_DEBUG_RUNTIME and CONFIG_DRM_I915_DEBUG_PM
>     are enabled, two more extra symols in i915 are required to be
>     exported.
>     
>     Cc: Jani Nikula <jani.nikula@intel.com>
>     Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
>     Link: http://patchwork.freedesktop.org/patch/msgid/20220425220331.24865-1-zhi.a.wang@intel.com
>     Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> Which was picked up here:
> 
> https://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-next&id=f08699ec5bd924be4c9572e21fd0a806d3fb34c2
> 
> It will have these commits:
> 
> 5e9ae5c47052e2 drm/i915/gvt: Add missing symbol export.
> 2917f53113be3b vfio/mdev: Remove mdev drvdata
> 2aa72ec97ce9eb vfio/mdev: Use the driver core to create the 'remove' file
> 6b42f491e17ce1 vfio/mdev: Remove mdev_parent_ops
> e6486939d8ea22 vfio/mdev: Remove mdev_parent_ops dev_attr_groups
> 6c7f98b334a32d vfio/mdev: Remove vfio_mdev.c
> cba619cb0d4d66 drm/i915/gvt: merge gvt.c into kvmgvt.c
> 978cf586ac35f3 drm/i915/gvt: convert to use vfio_register_emulated_iommu_dev
> 0e09f4066ad11b drm/i915/gvt: remove kvmgt_guest_{init,exit}
> 7f11e6893ff01b drm/i915/gvt: pass a struct intel_vgpu to the vfio read/write helpers
> 4456641232e2c1 drm/i915/gvt: streamline intel_vgpu_create
> 37e4bdbd5bad71 drm/i915/gvt: remove the extra vfio_device refcounting for dmabufs
> 5f8f3fe67cd908 drm/i915/gvt: remove struct intel_gvt_mpt
> 91879bbaf8890f drm/i915/gvt: devirtualize dma_pin_guest_page
> 8398eee85fd009 drm/i915/gvt: devirtualize ->dma_{,un}map_guest_page
> 4c2baaaf764bfb drm/i915/gvt: devirtualize ->{enable,disable}_page_track
> 4050dab5981cd4 drm/i915/gvt: devirtualize ->gfn_to_mfn
> bd73b4b193d450 drm/i915/gvt: devirtualize ->is_valid_gfn
> b3bece34956f86 drm/i915/gvt: devirtualize ->inject_msi
> 4c705ad0d784fd drm/i915/gvt: devirtualize ->detach_vgpu
> f9399b0e4a9555 drm/i915/gvt: devirtualize ->set_edid and ->set_opregion
> fe902f0ce686e8 drm/i915/gvt: devirtualize ->{get,put}_vfio_device
> e3d7640eeeb306 drm/i915/gvt: devirtualize ->{read,write}_gpa
> 3c340d05868d98 drm/i915/gvt: remove vgpu->handle
> 10ddb96295f3bd drm/i915/gvt: merge struct kvmgt_guest_info into strut intel_vgpu
> 62980cacc37f58 drm/i915/gvt: merge struct kvmgt_vdev into struct intel_vgpu
> 3cbac24c2cdbfe drm/i915/gvt: remove the unused from_virt_to_mfn op
> c977092a997708 drm/i915/gvt: remove the map_gfn_to_mfn and set_trap_area ops
> 675e5c4a33e20c drm/i915/gvt: remove intel_gvt_ops
> 8b750bf744181c drm/i915/gvt: move the gvt code into kvmgt.ko
> f49fc35799fa63 drm/i915/gvt: rename intel_vgpu_ops to intel_vgpu_mdev_ops
> 367748066eeb37 drm/i915/gvt: remove enum hypervisor_type
> a85749e12d66c2 drm/i915/gvt: remove module refcounting in intel_gvt_{,un}register_hypervisor
> 7f0cf30187cdb1 drm/i915/gvt: better align the Makefile with i915 Makefile
> de5d437ae8696a drm/i915/gvt: fix trace TRACE_INCLUDE_PATH
> 1672991412dfef i915/gvt: Use the initial HW state snapshot saved in i915
> 66e7a8063381cb i915/gvt: Save the initial HW state snapshot in i915
> e0f74ed4634d6d i915/gvt: Separate the MMIO tracking table from GVT-g
> 
> Thanks,
> Jason
> 

