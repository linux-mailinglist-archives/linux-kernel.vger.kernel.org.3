Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305BA4E2564
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiCULoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbiCULoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:44:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7981D5E91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:42:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w4so17453952edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NNPeHmxdF8gHjFiX3QjGS+ywX8wOJltgInHjhtuRslo=;
        b=ifNll0L47nfcmc3hlduk3ET8FSxJenvOrndoBFQg+HkpqT7sDxUJpPs+NGlcKMfYUt
         CfoNb9T0Ht8yDZxbObm33aB8N4f/cU6+ACJEcXelxxhZgcOncbgwe4vRPTFkYww/hBND
         oTw7fhzpqcXstpdMQQPf4NKv2Ox9QWuY3oXyahPE3jF+7XrhyMB47Lx/iMppSrAQ4Zyr
         AFzbtH3qWdCdP3P5FUqbzs6QjINPhngUPbt+8STreA6OrmpWSrjZi4ttgnVoFSRW1pgQ
         z4kyhZF9qvieTrbbmpWHbJoNyrG7oHAqyN9lL+JpCaR53PUIJAsWbDSyQn0EW1uVP7Vi
         iBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NNPeHmxdF8gHjFiX3QjGS+ywX8wOJltgInHjhtuRslo=;
        b=j7HUDshfU5K9HXLHqsqZIS9pt+bGxGzgMtoP4nIJPZgGOaflqPgtr0mOw7IVfiN8rX
         ylFKrQCl1M1FyVzQwIn9lRGBO3QqXndXsscsrvOsryf53sfwMFm9++jySDko6sVArOwa
         U5MERBboCFEOCI00X7gVtRKNh2jjn2Qjml3rEXuwpOMwD2tD4NAyZPR2oWpepe3P0je6
         K8WzjOZ86G0i3AbeKJ2q81SNUqgrG9Phf37vp/3zgEO71wlfL/qL5+CuwJ2XxQSyBJOL
         HP7Lc+WKMCv9cq1NxCNqQOY3s5RUwaaFJoOwy05a7M8ilJugInWzxqgnubuTmLQqJY1x
         3hew==
X-Gm-Message-State: AOAM533KZi6L1UbHDuY8R9oosmMjwGJDBcEc8rFAsNN4k14okD7OP28f
        U50FF2Iau/jZp4zG8Ac4DrbQ3Q==
X-Google-Smtp-Source: ABdhPJwDX4IZxw1gclDOUzGxiWS+Ph3KwDQ4iz4g6W0Am91T/s5bNL6bHCnqaoXVmgmVbFgJGKJNwg==
X-Received: by 2002:a05:6402:5192:b0:415:c6e6:23b with SMTP id q18-20020a056402519200b00415c6e6023bmr22681814edd.336.1647862961242;
        Mon, 21 Mar 2022 04:42:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402525600b00416cb5fdc56sm7810619edd.57.2022.03.21.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:42:40 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:42:16 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjhkmDEGwF4EcM8R@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Mon, Mar 21, 2022 at 08:09:36AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Sunday, March 20, 2022 2:40 PM
> > 
> > The existing IOPF handling framework only handles the I/O page faults for
> > SVA. Ginven that we are able to link iommu domain with each I/O page fault,
> > we can now make the I/O page fault handling framework more general for
> > more types of page faults.
> 
> "make ... generic" in subject line is kind of confusing. Reading this patch I
> think you really meant changing from per-device fault handling to per-domain
> fault handling. This is more accurate in concept since the fault is caused by
> the domain page table. 😊

I tend to disagree with that last part. The fault is caused by a specific
device accessing shared page tables. We should keep that device
information throughout the fault handling, so that we can report it to the
driver when things go wrong. A process can have multiple threads bound to
different devices, they share the same mm so if the driver wanted to
signal a misbehaving thread, similarly to a SEGV on the CPU side, it would
need the device information to precisely report it to userspace.

Thanks,
Jean
