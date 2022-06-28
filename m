Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B955E67C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiF1OVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbiF1OVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:21:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B632C13E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:21:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ay16so26126687ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
        b=M4Yy8biplcD6xIbSik7Fcanj3qmtX6uFR9Lkcg9HY9n8g3FbAUo/QCyipVsW7Jci/W
         76nJc0C4Qpa49bHjnodI8YHf+WPa5SaGG+EjfkUFHOKnlUtuQ6CROXVHEuKZnX/CpnBb
         mX6lu4SJJksUAqA5Mt/x2GJW7I+b6qEIW+PXpPA/+w2YWkE+9QRCSUIvYGi5xprrKF9D
         rVQ3kf6SiheUWDlrr/LE0VkX54WLqK4BZIiUu0tzWsts/0WbnNKrk0IqYkokD3unorO7
         V0ZCyCwpJtlkSobho6Ucmi7hZHCLLGDYI8FgiZaC5zhiI7DhrFhYUjIn7/mV5L1eDGZb
         V2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
        b=r6TfBLnn32C0mNNxGgF9pgzGsrxfi22w3/0Olwoo+3XFrQOhQRqQKue5q9lDAsUuS0
         mMCJzTkPM3eYYon1SA74Q8+qdvFM9ztKXA3JFg+j3ZVlC6LTJEBHqvmmfYlRB77zDF0O
         BJnT7j4FLyGqqyfCjPyO44AU6NypOKS4AgH5sTfp6aBdnKQ0vuO2UgA+0w7Yx6MC3EOP
         Q/7sBviHX+6611ZtYG4MRrN8263Xcz1BufQNyVSR9+eq7qhKC7VdnEDkbopJzmJIXiZp
         rXDc3wCnF6zPV39OU5DwE3A07BroYLOzkA4CwfyQhtt3rhzKSq+bXd837P3C9rbB6EPB
         VZqw==
X-Gm-Message-State: AJIora+8t6ZfOAe5oWCizWMFngrKHJ4nX7cmwMzKuISJ1TCsgDu2Ndq6
        xE0lYv0IPz0a0/KsRk9nXifHog==
X-Google-Smtp-Source: AGRyM1vBIfDF8EgzPZnXgOQ5Ii/P2pbYxSeydCSmLWtpDh0bAERdGZisVP2CiMBF+dMiaZzFptnbAw==
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id sc37-20020a1709078a2500b00726c9f22f5emr4317430ejc.286.1656426067781;
        Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm6518768ejj.160.2022.06.28.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:20:43 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Message-ID: <YrsOO9E+j+CMgKMA@myrica>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
> > > > Once the iopf_handle_single() is removed, the name of
> > > > iopf_handle_group() looks a little weired
> > > > 
> > > > and confused, does this group mean the iommu group (domain) ?
> > > > while I take some minutes to
> > > 
> > > No. This is not the iommu group. It's page request group defined by the
> > > PCI SIG spec. Multiple page requests could be put in a group with a
> > > same group id. All page requests in a group could be responded to device
> > > in one shot.
> > 
> > Thanks your explaination, understand the concept of PCIe PRG.  I meant
> > 
> > do we still have the necessity to mention the "group" here in the name
> > 
> > iopf_handle_group(),  which one is better ? iopf_handle_prg() or
> > 
> > iopf_handler(),  perhaps none of them ? :)
> 
> Oh! Sorry for the misunderstanding.
> 
> I have no strong feeling to change this naming. :-) All the names
> express what the helper does. Jean is the author of this framework. If
> he has the same idea as you, I don't mind renaming it in this patch.

I'm not attached to the name, and I see how it could be confusing. Given
that io-pgfault is not only for PCIe, 'prg' is not the best here either.
iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Thanks,
Jean
