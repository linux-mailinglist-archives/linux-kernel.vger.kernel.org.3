Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAE50E606
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiDYQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiDYQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:44:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109EB59
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:41:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s21so7012761wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ymNzkfcwSel6W8oV5nbBFFpf/bYmdkm3nOTuaQdreqA=;
        b=ICWq7cr4ucppx5XucKZHwI5K0L+l66C2e5zf8FcME7SWTF8q3l4ieOw0iYBZTw6Kfd
         15KBldbHsftFoe8HtHhKoZHqH7NfgyWzFJk/eOY8YqcMjKCKpc+21puAkQR9bgj/uWH6
         IsZqrY3Eq9uTd41tsfR1xxs47GhlJxQIIj9qNyeYSPqlGf6pbELs/07SuejLtIIeujyB
         MVvFCYgptLOMBEP5u/vxGElDNbHJv851+mT6TjP0LLNRv/nRYNVdfQfEcnyL75xu72FI
         4D/zLtoHu3tq/AtZatkQ1fWMw3bUvAomwyh0AtlA6xBMAyGykTQ85Rp9fo27bP7bjtrg
         8oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ymNzkfcwSel6W8oV5nbBFFpf/bYmdkm3nOTuaQdreqA=;
        b=p7gxtfbrMuqpsvPmjmxjpfdT8ER+GQftua1PiVB5p8jb4BbhtpuIbb3uE1y88zCJrM
         KSxm5Y1BT7cNseoDzw1A7GT++oNQqM7P/2urh5kvO/xl2ue8LGU2FvXX5ok99PcJbZit
         wFbKc/mFNMu4VqU7yc6TqEc5suq8rrYZVg/nFTaqp0ga1MvNBWqd5qKgn06XuUDsszrl
         B9HprEVfM961upGwLZw09Hqv8KeLqKo/8el/otsRGsottrwAzRi4jXYbEcxxN8Kg9Ift
         BD+PfSeQ1is4D16u0lQcEJZHf8xPTK+xgtNq6tjXv1iAsQpyQJBMZWwfR3he10W506l/
         JSOw==
X-Gm-Message-State: AOAM5301OqqsaQv3drdZN3jZVO4OBCpS2quzWBE48sYgQt+CJM7c2icV
        KP3cRNbouxZQ1aw16WdxstH7ow==
X-Google-Smtp-Source: ABdhPJzonWudjlF5ybkAb3XI8W6P1lpxDyOefHSgtMu9zNuZlAC3h+6zbaDQmLFjuGi6AtK+kVhPBg==
X-Received: by 2002:adf:ce89:0:b0:20a:d917:5234 with SMTP id r9-20020adfce89000000b0020ad9175234mr6155874wrn.265.1650904858533;
        Mon, 25 Apr 2022 09:40:58 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm9341132wri.106.2022.04.25.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:40:57 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:40:30 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmbO/l5IwfBCHrl8@myrica>
References: <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:55:46AM -0700, Dave Hansen wrote:
> On 4/25/22 07:26, Jean-Philippe Brucker wrote:
> >>
> >> How does the IOMMU hardware know that all activity to a given PASID is
> >> finished?  That activity should, today, be independent of an mm or a
> >> fd's lifetime.
> > In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> > queue calls iommu_sva_bind_device(), which sets up the PASID context in
> > the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> > destroys the PASID context (after the device driver stopped all DMA for
> > this PASID).
> 
> Could this PASID context destruction move from being "fd-based" to
> happening under mm_pasid_drop()?  Logically, it seems like that should
> work because mm_pasid_drop() happens after exit_mmap() where the VMAs
> (which hold references to 'struct file' via vma->vm_file) are torn down.

The problem is that we'd have to request the device driver to stop DMA
before we can destroy the context and free the PASID. We did consider
doing this in the release() MMU notifier, but there were concerns about
blocking mmput() for too long (for example
https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
though I think there was a more recent discussion). We also need to drain
the PRI and fault queues to get rid of all references to that PASID.

At the moment we disable (but not destroy) the PASID context in release(),
so when the process gets killed pending DMA transactions are silently
ignored. Then the device driver informs us through unbind() that no DMA is
active anymore and we can finish cleaning up, then reuse the PASID.

Thanks,
Jean
