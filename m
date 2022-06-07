Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242B536308
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbiE0MzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbiE0MzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:55:06 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9022BE8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:55:03 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id r84so4739489qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
        b=E1IEYVgSG0+Cp9E27az2DSZCdjooKZRFTIAknVPbxEA24IswYpisrb22a0LCO4Yutp
         4XsJlV3iiAHfEJHOUqZar/+z6eq/RNVnQDFf6R3luEpLOO9ZSoMj2k2S0fC4R/pSwYXU
         DOpBIBWUCslS52Qi/CzJYZEl+JwIDoG+YDkhlb773/e2F0xPQeqxylr+kzCyh268b3ya
         yKVvkB2lJlxnxrNfvpXMgjf4YpupMDYotK/5yJ7lKPpEk0ZuMkyWYAMEIMPhh7qzI2wh
         swLJ7nNqHWA6WZu24/335hmDWzwhZxSHaBFgg7blIZ9gyKzXZY7CMQ39H9PyDicns9IH
         ExdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BSsMozD0Lq0iC4EM9lYNlXi49mNRG6l4hCD1Hs5iBXM=;
        b=ZQ5RU61Bc3vwmU5Z2RwfjEGgj4WJ1MejNl7MMf2vIOsypS0BVu5rusniIORWqvBMaz
         95su8lbguBBVgCD/NOW8yeglQdS/UfJaJFvJB2D9rYDMTuiP5qv0Jbbol2CauwnBdY+t
         elCooDURSCGpv0xkURN0UJ8K//HXa5tg/nCS3MOWYrGxTF08Smv2G3mQ3welGoL5P0q/
         5yb9MhLAVDtxmuowmwSguFJmRx2RCrnhYsLojqyNiRWWRlcnyXCEt0bRWiw1VEqVmiAf
         pbMf/LpWeimWXuklUzobTs/yzcIACNh7HzEaqZa7eC4kWvest03QadG+ZCgPQ22JzOWQ
         6NRg==
X-Gm-Message-State: AOAM530RP0M6q71rYY7Jvd8dYYiQ2onNtFLlC08rg795ggPqKvOSi1uE
        ofatnbKKVJBCIR5enCs4B3sEzA==
X-Google-Smtp-Source: ABdhPJxcD+5XVE67Aydy9O792T3TtXb3ll0b0WRGBBEtp6VFaNN0UYQTLMiTbm4pLr0b1PVKMYNipA==
X-Received: by 2002:a05:620a:4481:b0:6a3:6326:784 with SMTP id x1-20020a05620a448100b006a363260784mr21538514qkp.372.1653656103072;
        Fri, 27 May 2022 05:55:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87d05000000b002f940249151sm3165272qtb.73.2022.05.27.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:55:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nuZUb-00DTYK-OD; Fri, 27 May 2022 09:55:01 -0300
Date:   Fri, 27 May 2022 09:55:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220527125501.GD2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154717.7695-21-logang@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	/* Ensure no new pages can be allocated in mappings */
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +
> +	/*
> +	 * On some architectures, TLB flushes are done with call_rcu()
> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> +	 * before freeing them.
> +	 */
> +	synchronize_rcu();
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);

With the series from Felix getting close this should get updated to
not set pte_devmap and use proper natural refcounting without any of
this stuff.

Jason
