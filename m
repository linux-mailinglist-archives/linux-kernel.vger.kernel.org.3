Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578D4AF3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiBIOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiBIOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:14:26 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B668C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:14:29 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 13so1628662qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8BMy3fH62yXJxfHY+j4P80h5ALqrjcvX+ObTuKf0iA=;
        b=V7onSa8ruWkEtkdB8irRTbQO5EhI5+EN5mjt3u01+vlKyYcQfcNp9aFh92tP1OzUTh
         ScFSSPOJZDc270JM0jq7Rhgv2t8FwpCHJ20+6gStJqzqZxWKPGAiZe6G30wozCGKb6G+
         ZLQWTS1Ro4hAfH5OwcrYeqPEFEKYoHUMzawcDJx2RgUNBo1ohb8nkxONIHkbUDMBpr5o
         apeGjKCH5BBxtNM0aA8Q1I0DV6rlydLedHpS7mVvMx/qFqliS9UfDYoHrCMy5D2aCL3F
         0jecgeDZDBF6tjcMyMnIYAGizQnperLp47omGbCJq3v5uCCpJ63E6XzU+sfOUF4jG60Y
         /F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8BMy3fH62yXJxfHY+j4P80h5ALqrjcvX+ObTuKf0iA=;
        b=Phf4HGbM+JVvFvfPyro077aLdUMvW+uoqHnETAX3w0PqdBUHLC8Yu5BV4uHFkknPe2
         Np3rYZHpA6++zN3Z+ETrZUisJfusp66xepZpOLEJAJa03cLDwalTCV4HhOGYnCjwJkTs
         97Hjsa8qir8LSlcBR2fiXo48+et+oZDfYPBqwCacC0Lk02PjNhU5oyFX31RZdhkktnH1
         MNojBPFfVfQh+0XKao12ppzJmZ69c0FhfxYnQNeiDJZc1TAHjC8qR32a7RV4fTtqEtMx
         LTVV9A5Wmo9FauamBm/ld33dHgOwEndMP3DFFZRfTIYo9UnvQBu58rldB1JtwkmYD5rf
         B0rg==
X-Gm-Message-State: AOAM533TKpUzSC0g9ZPpFBPvPWvEfI4/e5LrN2uwmEQFtUCefNwmvrkK
        QJOma65GEglH4+XxxnzPF7g90Q==
X-Google-Smtp-Source: ABdhPJzQ+iaZjCKRuCc0J8n0Ck+TXJ7O0pFZ7w0y3yYzv/vscWA+Im2JaGH4eENvWOVqnzWKMTNFCg==
X-Received: by 2002:a05:620a:1351:: with SMTP id c17mr1137673qkl.460.1644416068212;
        Wed, 09 Feb 2022 06:14:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a14sm9094374qtb.92.2022.02.09.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:14:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nHnjn-001FdR-1z; Wed, 09 Feb 2022 10:14:27 -0400
Date:   Wed, 9 Feb 2022 10:14:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
Message-ID: <20220209141427.GJ49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-8-hch@lst.de>
 <CAPcyv4h_axDTmkZ35KFfCdzMoOp8V3dc6btYGq6gCj1OmLXM=g@mail.gmail.com>
 <20220209062345.GB7739@lst.de>
 <20220209122956.GI49147@ziepe.ca>
 <20220209135351.GA20631@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209135351.GA20631@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:53:51PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 08:29:56AM -0400, Jason Gunthorpe wrote:
> > It is nice, but the other series are still impacted by the fsdax mess
> > - they still stuff pages into ptes without proper refcounts and have
> > to carry nonsense to dance around this problem.
> > 
> > I certainly would be unhappy if the amd driver, for instance, gained
> > the fsdax problem as well and started pushing 4k pages into PMDs.
> 
> As said before: I think this all needs to be fixed.  But I'd rather
> fix it gradually and I think this series is a nice step forward.
> After that we can look at the pte mappings.

Right, I agree with this

Jason
