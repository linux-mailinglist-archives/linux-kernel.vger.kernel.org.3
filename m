Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E688F50E271
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiDYN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiDYN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:57:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B96C956
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:54:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so14167722wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ju3MNG0l6PZT3NlPuxMjxhTveM28nyA7MnYp02HrA3g=;
        b=c2XdBLBOlfmLEWkJaYwfFywTyfskFCw6bpnjcfeqXhyBmEqmUQjwPOV4AyIggXagiD
         wzbWZxTpH9r3DOzhbxg/99dGPHgdmS7G6aaQOo6gNeyvelEh9kNT4uPxd9Z3fIJVbjDv
         1fgHdpRRPrpYkpZZ/ehfVQYYOrTkk727CPzkR2PczdmVc0zgqan189Bu3CV6+ledwkUm
         8gnLVa+acEhbE8q59GCjNiopmnkAZhjUwfsAw7wH8xszCr1FVSxY8y+/STArB0DN2OLL
         mD4bmmHVRXPEkOUcwIR5fe4iZhXszr8h0kAleiNz0H98aT9Qq55L3b+WKDDrRLitbGXy
         G1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ju3MNG0l6PZT3NlPuxMjxhTveM28nyA7MnYp02HrA3g=;
        b=0/yMGqSJlEx83lfjsGdd2zqhAFE3BScfWvRUSHRYf5wQFW/Jf5AqjhkHd4IFVim0b3
         Z6B04KC51LAjM7yXnzj8BtO7Ey48PSBuXTluWDZwyJTDJaYbBzSPn9flvSNKotMDxnYi
         1Gxf4447ApWNYdMEUkXdaSGugyhLJt6GNTEVSBEaNDkgy6RwDo9U2nGRI/lR2s97Gfcg
         ijIJh3Ndp6WCbOM9AyJ2CuAsxhydZ8oBAt1R1BwhSKETHIKU1SMAgnBqnt3UUEk3aUS8
         mWkbwRly+WPnRZDQqbHMhyowMLndXy79S4RNHGogUMXdPcer8BL4hHW+h2pbOf5GALkX
         S3sg==
X-Gm-Message-State: AOAM531kKmChyKmFIzFyaSrvnh5OzsyHnL0UQp3zm8kOGNtpSxMA2rgb
        QimjptvEkoFT80rfjW6uzgCB7w==
X-Google-Smtp-Source: ABdhPJz+1hYJkj+HhnpfpVFJ6D5wdXQQNaTjTH0Nimfg+P2+HGw1UFJpbD4CnfWYJewGKpHqxsVDQg==
X-Received: by 2002:a05:6000:49:b0:20a:da03:951f with SMTP id k9-20020a056000004900b0020ada03951fmr4757075wrx.519.1650894849681;
        Mon, 25 Apr 2022 06:54:09 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q15-20020adfaa4f000000b0020ac7bd4affsm11029272wrd.0.2022.04.25.06.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:54:08 -0700 (PDT)
Date:   Mon, 25 Apr 2022 14:53:42 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <Yman5hLomw9/c+bi@myrica>
References: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com wrote:
> > > On 5.17
> > > fops_release is called automatically, as well as iommu_sva_unbind_device.
> > > On 5.18-rc1.
> > > fops_release is not called, have to manually call close(fd)
> > Right that's weird
> Looks it is caused by the fix patch, via mmget, which may add refcount of
> fd.

Yes indirectly I think: when the process mmaps the queue, mmap_region()
takes a reference to the uacce fd. That reference is released either by
explicit close() or munmap(), or by exit_mmap() (which is triggered by
mmput()). Since there is an mm->fd dependency, we cannot add a fd->mm
dependency, so no mmget()/mmput() in bind()/unbind().

I guess we should go back to refcounted PASIDs instead, to avoid freeing
them until unbind().

Thanks,
Jean

