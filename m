Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A755E99E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiF1OFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345079AbiF1OFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:05:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051631525
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:05:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id z1so2777919qvp.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZOM3EE95Jw2yJ9/XIIBxbTHYQnCb381rWlgdogJ9KlQ=;
        b=k0Cdzf7mBXmcn+YETI3IRyQBux4BQ9s7VeQ+BfD2T12fE52pbPj+u/jfNJmHzZb77W
         W0CAKnngiWcW//Bx0zkvO2ElMiTKaxX6nGVuqOhGiv4jcVwVoqZCIsEu4sVdLfCCW9Ai
         xjI5O0mwrcwqems1x105EsBkH5wArf1WaAyBlD8B4bwR99TrA1pcrH6sfgU7191W1Mo+
         w0+/WT6Yj/VCzX/noRWA8IOWcJdQfBbMzHTGFOSG066M8FgFgjbXdnbZstzk/HeyaMlu
         xoZ/gTUXAdoRbRrIdvSbnZZt1u4YlkZ4/sBsez+nkCkmGv1/XqcE2bDvF+oXQJtfyPOi
         Iejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOM3EE95Jw2yJ9/XIIBxbTHYQnCb381rWlgdogJ9KlQ=;
        b=0nmpcjdrnOwJk7EzdudLhJeOvx/Xq0EAjft1K5C12CUICb88b8lKQahoCB+L/3JXSo
         WWdMmuLYSS7R1spmnEXMPzG6TQBeCX3EbwPde5m6WdPJIMmiqEuJNLT3QeEOSanfRIhm
         R5x9lmCF6f8VZPz9w9sFXG4+YHV/syiiK3R7qwcAgn2O6r7sE0o3zhxJZDel01SHkUm0
         y5EkWh2xKhXI5Frpy64i4NcNHTf+pxt7gsE+QWKTbTot7L0mE0sKTFRVgn1g1Pmn17Jv
         GQacmLuSubxwofJiD5Zn1mCdtSLEkiaWC/3EeRCfIYe1UAk5o3FeBg9q/iersbSRc41x
         x6PA==
X-Gm-Message-State: AJIora+Erp8Nz06jOEZiGcn1Z5ptJaFpoTH9xD0zNjceZc0fBkedP2z0
        lbpNUQGn/Ps43976dh9/JZfmMw==
X-Google-Smtp-Source: AGRyM1uYIwR38LRAvNuSxxTYXZXeZWQEA4LzjVCfHlGddxqcXPCx7I5dnVjk+QuM9F5PnLwD+AE4dQ==
X-Received: by 2002:a05:622a:390:b0:306:7777:63c3 with SMTP id j16-20020a05622a039000b00306777763c3mr13617459qtx.309.1656425100423;
        Tue, 28 Jun 2022 07:05:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u20-20020a05622a199400b0031bf484079esm831914qtc.18.2022.06.28.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:04:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6Bpr-002zrC-5Y; Tue, 28 Jun 2022 11:04:59 -0300
Date:   Tue, 28 Jun 2022 11:04:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        lizhe.67@bytedance.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH] vfio: remove useless judgement
Message-ID: <20220628140459.GP23621@ziepe.ca>
References: <20220627035109.73745-1-lizhe.67@bytedance.com>
 <20220627160640.7edca0dd.alex.williamson@redhat.com>
 <7217566f-9c40-ae9d-6fd6-2ef93f13f853@oracle.com>
 <20220628130350.GN23621@ziepe.ca>
 <f7b7a7b0-9404-6b0f-99b5-346af041a479@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b7a7b0-9404-6b0f-99b5-346af041a479@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:54:19AM -0400, Steven Sistare wrote:

> >> As you and I have discussed, the count is also wrong in the direct
> >> exec model, because exec clears mm->locked_vm.
> > 
> > Really? Yikes, I thought exec would generate a new mm?
> 
> Yes, exec creates a new mm with locked_vm = 0.  The old locked_vm count is dropped
> on the floor.  The existing dma points to the same task, but task->mm has changed,
> and dma->task->mm->locked_vm is 0.  An unmap ioctl drives it
> negative.

Oh.. This is probably a bug, vfio should never use task->mm, the mm
itself should be held using mmgrab instead.

Otherwise exec case is broken as you describe.

> I have prototyped a few possible fixes.  One changes vfio to use user->locked_vm.
> Another changes to mm->pinned_vm and preserves it during exec.  A third preserves
> mm->locked_vm across exec, but that is not practical, because mm->locked_vm mixes
> vfio pins and mlocks.  The mlock component must be cleared during exec, and we don't 
> have a separate count for it.

Lossing locked_vm on exec/fork is the correct and expected behavior
for the core kernel code, the bug is that vfio drives it negative.

Jason
