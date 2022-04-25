Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6650E315
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiDYOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiDYOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:30:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59210CA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:27:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y21so11733651edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m51cNS74FiKcfMwaHkcE4/8logZlIaN7nu3DxMWpYFk=;
        b=R29BxhkRm53cZToxZnIGPbkKoyKLg1qgnyCzPKA444ALfVoJ7nYD6hgEJrJI1YW1OR
         YX/0osV0xmbfAaHMBN4FWmW/YiPkteEVJeUUq6DGuHZJpuNxUiwkgwKhDt1Zhx5qzS1f
         6RD7YcDdD/3om+/nZjd5xrNMGXw1ow+dFZ3mZj7UB42LISvqUxunFX3cTsq8kIaxI7XH
         ZQiY12scA00wjkQYpdBJNrQb2H944Igr0xQ5LeLmDxMLt695g1H0YfwOXzjg4nrCaqp+
         CiFg9M+I+wL3zJiJXPqpzjkEFeb744eRQ8czq4nv+EwzFGMh6AfDUq5GsiXPsOFRKS0z
         rn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m51cNS74FiKcfMwaHkcE4/8logZlIaN7nu3DxMWpYFk=;
        b=n8Wvh9kccqw2aF6SDFEkZ87zTMIYjdOPoBMBn1ZKrNHG3KJVeWedlFZNR3nseOClvg
         mCM+q62MkAc9xST29Hi2fJmUSPOYzuSAWKqhplg08TOJSaN+aKMubZ/tEeQ+qioU0Sp2
         cbRbYIoDV7Lo3/OLF4MRjHZ/vB14fFILsQsCMsWoHG/sVpQia9Kc/LhEijOxeRn3Cw/t
         LzLVIql7gatjUiFhYt516qYIHRvggUQ4qRNUEDIIwJ+AhAbN61g2eJPnZuOjf6/2O0Ar
         Fdg7eFJYVFoOZ3JHmEq85CenfE/ErrMLc3QXrMLBH+pQWm61MGQHnbm6ib0yuDLVdNcL
         RB9g==
X-Gm-Message-State: AOAM531L0CIBKgGFGy7WMRrG5W6cwRqYSgt4+5fx3lZTmg9rwugcrilw
        qrtzs5K9PbQPjMOOvO6RM049RA==
X-Google-Smtp-Source: ABdhPJyUG4cXI41631ctvg+/Z5UfjkEVnIEG1qY2UB6sVxyeDbyoRqzpV/Mr2gsARD3h7gAB8E9lnw==
X-Received: by 2002:a05:6402:430b:b0:425:f580:ec72 with SMTP id m11-20020a056402430b00b00425f580ec72mr1537433edc.194.1650896827296;
        Mon, 25 Apr 2022 07:27:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1490192ejq.12.2022.04.25.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:27:06 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:26:40 +0100
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
Message-ID: <YmavoKkVu+hd+x0M@myrica>
References: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
> On 4/25/22 06:53, Jean-Philippe Brucker wrote:
> > On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com wrote:
> >>>> On 5.17
> >>>> fops_release is called automatically, as well as iommu_sva_unbind_device.
> >>>> On 5.18-rc1.
> >>>> fops_release is not called, have to manually call close(fd)
> >>> Right that's weird
> >> Looks it is caused by the fix patch, via mmget, which may add refcount of
> >> fd.
> > Yes indirectly I think: when the process mmaps the queue, mmap_region()
> > takes a reference to the uacce fd. That reference is released either by
> > explicit close() or munmap(), or by exit_mmap() (which is triggered by
> > mmput()). Since there is an mm->fd dependency, we cannot add a fd->mm
> > dependency, so no mmget()/mmput() in bind()/unbind().
> > 
> > I guess we should go back to refcounted PASIDs instead, to avoid freeing
> > them until unbind().
> 
> Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
> nothing else simple we can do.
> 
> How does the IOMMU hardware know that all activity to a given PASID is
> finished?  That activity should, today, be independent of an mm or a
> fd's lifetime.

In the case of uacce, it's tied to the fd lifetime: opening an accelerator
queue calls iommu_sva_bind_device(), which sets up the PASID context in
the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
destroys the PASID context (after the device driver stopped all DMA for
this PASID).

Thanks,
Jean
