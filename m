Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E058450B4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446448AbiDVKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446405AbiDVKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:14:58 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0068532EF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:12:05 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-d39f741ba0so8108010fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i1wvp/rMewldxZ0rnVdiAJj3COxTfU55vw1I4L2ncZk=;
        b=dSPNUihNFKJl2Ne2hHey/V1kYCou0YMDG0mqsnp6QGgS3IqT1v9FT7iXHLIi1UcjUa
         dhy/l5XsnqM7w7fYMZAE+3yd0yy4QYaO/Ze+Y5EvauCnnwrFiwudmO6g8Yyf+vg5BXaH
         xyhUe2wG0e+gbMrUb8qRg8+jM3QlELJYsImn7saAM/rOOtYbYFqwWdo41bXCuJxcTjSo
         Vn2iLM50cI8zznVqStbswK7VHCjSef6WXDx64rdU8gmGJxV6UPgzV0Zm6WuQDb3vVImA
         3SorBuF9MrcCOD7F6Za5XYtmc1jUITF1vxOYbP6Q5M9WcfiuhSuDLKMpirrxgNGviBQm
         xJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i1wvp/rMewldxZ0rnVdiAJj3COxTfU55vw1I4L2ncZk=;
        b=sTY6rjtWEJmRpjwgpvk6ER8jTMQXdPvuk4wcHesLyNQ9ZttDY7blUKEnbP+UmvfDB6
         H27DiMgbxzEnGeRPHMTZ5lelj98VSN8NRKTRLuzSiM/4wIUt7rdEDPYmUbboIRPIUug3
         hsK8dx5ZNU2qfp4BKyHPlMlflRPbDAMMVeR880gOiNwUVy6Sf8tBZmCX9e4/CGgywcQ+
         JHDmo9Yc+S4erTD5fWqGTc97KEI3HZm+OaQ+3HuGqisHL2hrC9HJfaXphJFbqZ8Vmd9a
         +GFKSUF9d56aMABV5S6yaSuC0LrUm7lZFCwcLy/qqr9I/vGLYr3yIqv2cGgeeytxE3Oj
         AKlg==
X-Gm-Message-State: AOAM5335xhqhzNEQ8xsde2cwqUUjH0tWpXFYzRzaqBUGX21ne+DDxwpR
        6PVp+fCw2o6+638sXJAake0g/g==
X-Google-Smtp-Source: ABdhPJzZlughfLG8zc4bXFQPyY9X+tGSojEhYDQgJCScCNW6X0OFmMRS1v+Mrm+vKTlKn80ATyKA/A==
X-Received: by 2002:a05:6870:524b:b0:e5:f7a6:295f with SMTP id o11-20020a056870524b00b000e5f7a6295fmr1552227oai.89.1650622324966;
        Fri, 22 Apr 2022 03:12:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id a11-20020a056830008b00b0060546411473sm555228oto.75.2022.04.22.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:12:04 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:11:36 +0100
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
        robin.murphy@arm.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmJ/WA6KAQU/xJjA@myrica>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 05:03:10PM +0800, zhangfei.gao@foxmail.com wrote:
[...]
> > Have tested, still got some issue with our openssl-engine.
> > 
> > 1. If openssl-engine does not register rsa, nginx works well.
> > 
> > 2. If openssl-engine register rsa, nginx also works, but ioasid is not
> > freed when nginx stop.
> > 
> > IMPLEMENT_DYNAMIC_BIND_FN(bind_fn)
> > bind_fn
> > ENGINE_set_RSA(e, rsa_methods())
> > 
> > destroy_fn
> > 
> > If ENGINE_set_RSA is set, nginx start and stop will NOT call destroy_fn.
> > Even rsa_methods is almost new via RSA_meth_new.
> > 
> > In 5.18-rcx, this caused ioasid  not freed in nginx start and stop.
> > In 5.17, though destroy_fn is not called, but ioasid is freed when nginx
> > stop, so not noticed this issue before.
> 
> 1. uacce_fops_release
> In 5.16 or 5.17
> In fact, we aslo has the issue: openssl engine does not call destroy_fn ->
> close(uacce_fd)
> But system will automatically close all opened fd,
> so uacce_fops_release is also called and free ioasid.
> 
> Have one experiment, not call close fd
> 
> log: open uacce fd but no close
> [ 2583.471225]  dump_backtrace+0x0/0x1a0
> [ 2583.474876]  show_stack+0x20/0x30
> [ 2583.478178]  dump_stack_lvl+0x8c/0xb8
> [ 2583.481825]  dump_stack+0x18/0x34
> [ 2583.485126]  uacce_fops_release+0x44/0xdc
> [ 2583.489117]  __fput+0x78/0x240
> [ 2583.492159]  ____fput+0x18/0x28
> [ 2583.495288]  task_work_run+0x88/0x160
> [ 2583.498936]  do_notify_resume+0x214/0x490
> [ 2583.502927]  el0_svc+0x58/0x70
> [ 2583.505968]  el0t_64_sync_handler+0xb0/0xb8
> [ 2583.510132]  el0t_64_sync+0x1a0/0x1a4
> [ 2583.582292]  uacce_fops_release q=00000000d6674128
> 
> In 5.18, since refcount was add.
> The opened uacce fd was not closed automatically by system
> So we see the issue.
> 
> log: open uacce fd but no close
>  [  106.360140]  uacce_fops_open q=00000000ccc38d74
> [  106.364929]  ioasid_alloc ioasid=1
> [  106.368585]  iommu_sva_alloc_pasid pasid=1
> [  106.372943]  iommu_sva_bind_device handle=000000006cca298a
> // ioasid is not free

I'm trying to piece together what happens from the kernel point of view.

* master process with mm A opens a queue fd through uacce, which calls
  iommu_sva_bind_device(dev, A) -> PASID 1

* master forks and exits. Child (daemon) gets mm B, inherits the queue fd.
  The device is still bound to mm A with PASID 1, since the queue fd is
  still open.

We discussed this before, but I don't remember where we left off. The
child can't use the queue because its mappings are not copied on fork(),
and the queue is still bound to the parent mm A. The child either needs to
open a new queue or take ownership of the old one with a new uacce ioctl.
Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out of
tree?  This operation should unbind from A before binding to B, no?
Otherwise we leak PASID 1.

Thanks,
Jean
