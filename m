Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302057FCB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiGYJxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiGYJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:53:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB17167E6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:53:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b6so6439013wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SCWnGTh/CDGq33/h3DsVb0L1ToG1NnEQ+rGDHN+9rUk=;
        b=E5uVkBkfpOGF3nil14AOA5RBGvRCTw3m8K0QwzoBeHsQy0f4x84i+hF7z60Cfhc868
         v749tu0f24GjNoQ3+oGjxuBrnY/DTrCrfDAWyNFWSE5jYf0CEY5uClDrsePvJXRYI+s3
         5tTsXk7V20p6TjnDTNKQhVMYhBh8zRtgEtxuMh1g2/9ntzcY+3USCYoJF2Ub1+35TtBl
         5GbxKtdvvDX9YTUo1wG/cwen/3CJUjKjpHgsZHDEufvpGRf0g9zd6UCWfbLVvOunQatF
         HLA3WM/0jU8d+gmwRqkSEIbjy4zKWdJvpjiIOdwmXCCmdawvtw51rx5M+zXatUftOR3s
         hJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCWnGTh/CDGq33/h3DsVb0L1ToG1NnEQ+rGDHN+9rUk=;
        b=KKYBz+qi0wF4waAVt47p8b471bOxJq4HhB20SnyFy4EB3Rc0cx1bgdkDJ0MfiDO+qG
         SA34KrsQH+cn7rOSr9Q7CA11zzNl75Y1quls44hpTRupESKRCyA/QXPwJXa1VjQfjWZe
         p8zmymI2w0e0KhO/CST0cEJ2hfLZBx/jVLaxe5932lO8/OyNJnvUe870qZie7CFORODw
         mt0lKWqOoJK+Q5BgjapDxSwzCL+nKWde52ujhhtTpgCtJgePm2V8FWa0ggMFSKLTPMOF
         ldo3TtMjqEIbL3GJFVh/c8HGrvOPnTNQMuXx5mJ9xAJ1tDBweB2Zu/rpGm3QKOF1sd3g
         gxSA==
X-Gm-Message-State: AJIora9QEoNCB2UTqFhGtj9zZEjc/jzq/rITiB+W89dV3+TN51/6Cg3n
        s0g+Mt2lxqqrsTrKFgwp4/w5mw==
X-Google-Smtp-Source: AGRyM1sPkH/MiY2MpkVCdy7xIDcP8M3Xd/JbxpCRDuQRev8p4KQLBdqvmBnLHY1U96GVCaSejQ+AXA==
X-Received: by 2002:a05:600c:4fc5:b0:3a3:2d73:c147 with SMTP id o5-20020a05600c4fc500b003a32d73c147mr17884893wmq.197.1658742787261;
        Mon, 25 Jul 2022 02:53:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a3442f1229sm10109598wmq.29.2022.07.25.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 02:53:06 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:52:40 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yt5n6JCrigzh3cwh@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <Yt5IqyZw/Sa6Ck5t@myrica>
 <7862ed6f-b834-5dc7-8677-31ff52fec76d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7862ed6f-b834-5dc7-8677-31ff52fec76d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 05:33:05PM +0800, Baolu Lu wrote:
> Hi Jean,
> 
> On 2022/7/25 15:39, Jean-Philippe Brucker wrote:
> > On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
> > > /*
> > >   * iommu_detach_device_pasid() - Detach the domain from pasid of device
> > >   * @domain: the iommu domain.
> > >   * @dev: the attached device.
> > >   * @pasid: the pasid of the device.
> > >   *
> > >   * The @domain must have been attached to @pasid of the @dev with
> > >   * iommu_detach_device_pasid().
> > >   */
> > > void iommu_detach_device_pasid(struct iommu_domain *domain, struct device
> > > *dev,
> > > 			       ioasid_t pasid)
> > > {
> > > 	struct iommu_group *group = iommu_group_get(dev);
> > > 	struct group_pasid *param;
> > > 
> > > 	mutex_lock(&group->mutex);
> > > 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
> > Please also pass the old domain to this detach() function, so that the
> > IOMMU driver doesn't have to keep track of them internally.
> 
> The iommu core provides the interface to retrieve attached domain with a
> {device, pasid} pair. Therefore in the smmuv3 driver, the set_dev_pasid
> could do like this:

Thanks for the example, yes I can do something like this. I maintain that
attach+detach is clearer, but as long as it can be made to work, fine by
me

Thanks,
Jean

> 
> +static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
> +                                     struct device *dev, ioasid_t id)
> +{
> +       int ret = 0;
> +       struct mm_struct *mm;
> +       struct iommu_sva *handle;
> +
> +       /*
> +        * Detach the domain if a blocking domain is set. Check the
> +        * right domain type once the IOMMU driver supports a real
> +        * blocking domain.
> +        */
> +       if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
> +               struct pasid_iommu *param;
> +
> +               param = iommu_device_pasid_param(dev, id);
> +               if (!param || !param->domain)
> +                       return -EINVAL;
> +               arm_smmu_sva_block_dev_pasid(param->domain, dev, id);
> +
> +               return 0;
> +       }
> +
> +       mm = domain->mm;
> +       mutex_lock(&sva_lock);
> +       handle = __arm_smmu_sva_bind(dev, mm);
> +       if (IS_ERR(handle))
> +               ret = PTR_ERR(handle);
> +       mutex_unlock(&sva_lock);
> +
> +       return ret;
> +}
> 
> The check of "(!domain || domain->type == IOMMU_DOMAIN_UNMANAGED)" looks
> odd, but could get cleaned up after a real blocking domain is added.
> Then, we can simply check "domain->type == IOMMU_DOMAIN_BLOCKING".


