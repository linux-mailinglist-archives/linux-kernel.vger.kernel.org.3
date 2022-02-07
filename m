Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2572A4AC9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiBGTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiBGTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:36:20 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83857C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:36:19 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d3so6548170qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZb+VjqCK8DT8gUN4DVyYxz5ldTv3hxfq1kOHV3So/k=;
        b=KntHAMqOekGnRUkUpQJ4RmJ6jMnHjUV7NyerhvsEdoAGvARGmb4G3Wj/k8wnWrJ4v5
         8kPwNbh9XAYp6cLgi4gIv627uiqcRa+LFZjBeDErIxOg8LxHgVSzpBBgB4/02CnckDoW
         j/vS99YpkyicivGZvG7tPxKD1tg9I4Ra2r60sYYIh7hopzEEGFHdBxN13YaxsF1pjtQ4
         t2UWWLHBR9zIycMbU/55yGUwhwjflg+CGCZLsD+asK60z79VcLiGPwy6B0EGe8DupEXr
         Ad4Gbvw45NbEij0sfEUWdE7DXdHVlwqV31kqZB6dVE9msUcvQULHgg4p2QKDUMuJskEz
         lXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZb+VjqCK8DT8gUN4DVyYxz5ldTv3hxfq1kOHV3So/k=;
        b=Ran8q1ay3cmUgaSx6upC7tUmTVbKdPfqB1QnEXlrndeJwVx9xJHFmTEvf9FD85VKQx
         2RYKvncviIAqrBOsSSsc1dvXlnLyGcWHbmFdT9i5ecyj+rk8GFV1EbiI9ThgLYV6uqAV
         7B03WHSg1lvzoVCLc/lExm5+sbVClBA4djQzIXi6dkB/FZT1VuxX6wuWD72a/f4TrrJE
         FaS8UvMpqRJTiWjvqjy0x1lKOJGs1VHIBqXbdyojyBKsBguhS2fUm3Wrv3k8PalfjEq4
         Fpbg6O5FmPmUYi9wypnxSGjMRlowiQ+H/+V3St/9fWD1Q798Gnn1a9PfkNChiAGRYeTw
         1SBw==
X-Gm-Message-State: AOAM533pXV+SZv78bD/q1gTI3Srr4Cm5eYmY2mO29r9q2ahWxGRfySD3
        yvtlkEbx9ZpXr/qeYl09ZAFqpQ==
X-Google-Smtp-Source: ABdhPJx0Ja9WLXhMDJ89Idc/sHv1PbTV/zifEfvcLL+6K0fCDuGFFRfG8vhitXIXvhCy0TtD+Fimvw==
X-Received: by 2002:a05:6214:2aad:: with SMTP id js13mr896600qvb.32.1644262578716;
        Mon, 07 Feb 2022 11:36:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h1sm5945976qkn.71.2022.02.07.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:36:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9o9-000I7B-La; Mon, 07 Feb 2022 15:36:17 -0400
Date:   Mon, 7 Feb 2022 15:36:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] fsdax: depend on ZONE_DEVICE || FS_DAX_LIMITED
Message-ID: <20220207193617.GH49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-9-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:49AM +0100, Christoph Hellwig wrote:
> Add a depends on ZONE_DEVICE support or the s390-specific limited DAX
> support, as one of the two is required at runtime for fsdax code to
> actually work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Makes sense, but leaves me wonder why a kconfig randomizer didn't hit
this.. Or maybe it means some of the function stubs on !ZONE_DEVICE
are unnecessary now..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
