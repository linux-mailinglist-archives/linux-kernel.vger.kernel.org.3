Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED28E50BC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449501AbiDVPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448102AbiDVPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:53:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3013CC1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:51:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k22so11677359wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kkx5q4bDuKIBWWRZ1iuX1/tTM3jPLbx5We3xs6gumo0=;
        b=L2VjsLIOtpktJxq3umRR7TQtnjogP9inTCc0xf3C6++XYPN3ZFi2DEEQoAd6CUfAaD
         4WZKFcd4dku3naGKn6iQZkNKRlAfbFN3wo/oknoSSfBfangVtjrtJVdrlg/cSwM76UCf
         BMT7/JMS8YxgrlPNOQ7RE+yh0LbBVcO+GFhvziU6mhyDPN9veT5tguouIvmGwZBWP+9C
         gnqaBzI1FGxkeYEbw4jJkLM01jvXMBfCF0+5IoZ/31UET+CWHMZ1q8XRTqrL25wwdcz9
         IqmASl3m8jE4BNw7mUjV5D1jYYnZQvA3Uv5JJ43jSCG8B1Ml//FhMOsa1mqpMR+hruAM
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kkx5q4bDuKIBWWRZ1iuX1/tTM3jPLbx5We3xs6gumo0=;
        b=DuNFiCeHE9n3N4w50YrpNvKBlClFlPootADF7S7vJVdYbjmJRhG81z+i2DALNThJuX
         +0nT76+anOebhm1aKELXZ/2WUzwqSxDRA7yt66WI5/Y2umWaMEbeLOPHlOqst6vHIGlo
         vDBfKSVju6+BrfgCV8qhGe7CNffcPhhxLCbND+x6S48R698cxp5sAeN7+Fz/dqGD05M0
         gGHmZeeEAyFRkm2ylGPzYgqwoJfJlqz2U/nhwbblcqN8IYfYXQiapBAHFXetYaBLngUe
         E16BzOH1JOt09zimYGkYd3ts9dT2HM0e9Msw4RDIlaox4Ph7lBHeoWlbe681/PR/SS2d
         X4mg==
X-Gm-Message-State: AOAM5339WxLSC1iY6m0+Pn7LSWBt9bss5B1m94UgzvhvMn5G7pq9CId+
        /GqC+J7z5aCgrgdYF8M7Os4rVg==
X-Google-Smtp-Source: ABdhPJw4SOIGlvN2+JSfHf5lo2bGhXRf89s6K7ZbmqtrpaHqxjTmU6l+goCUsrHOQd9TZFkN8zME9A==
X-Received: by 2002:a05:6000:1287:b0:209:16c7:16af with SMTP id f7-20020a056000128700b0020916c716afmr4368691wrx.702.1650642664100;
        Fri, 22 Apr 2022 08:51:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c19d400b003929c4bf23asm1858009wmq.44.2022.04.22.08.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:51:03 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:50:38 +0100
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
Subject: Re: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmLOznyBF0f7COYT@myrica>
References: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 09:15:01PM +0800, zhangfei.gao@foxmail.com wrote:
> > I'm trying to piece together what happens from the kernel point of view.
> > 
> > * master process with mm A opens a queue fd through uacce, which calls
> >    iommu_sva_bind_device(dev, A) -> PASID 1
> > 
> > * master forks and exits. Child (daemon) gets mm B, inherits the queue fd.
> >    The device is still bound to mm A with PASID 1, since the queue fd is
> >    still open.
> 
> > We discussed this before, but I don't remember where we left off. The
> > child can't use the queue because its mappings are not copied on fork(),
> > and the queue is still bound to the parent mm A. The child either needs to
> > open a new queue or take ownership of the old one with a new uacce ioctl.
> Yes, currently nginx aligned with the case.
> Child process (worker process) reopen uacce,
> 
> Master process (do init) open uacce, iommu_sva_bind_device(dev, A) -> PASID
> 1
> Master process fork Child (daemon) and exit.
> 
> Child (daemon)  does not use PASID 1 any more, only fork and manage worker
> process.
> Worker process reopen uacce, iommu_sva_bind_device(dev, B) PASID 2
> 
> So it is expected.

Yes, that's fine

> > Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out of
> > tree?  This operation should unbind from A before binding to B, no?
> > Otherwise we leak PASID 1.
> In 5.16 PASID 1 from master is hold until nginx service stop.
> nginx start
> master:
> iommu_sva_alloc_pasid mm->pasid=1      // master process
> 
> lynx https start:
> iommu_sva_alloc_pasid mm->pasid=2    //worker process
> 
> nginx stop:  from fops_release
> iommu_sva_free_pasid mm->pasid=2   // worker process
> iommu_sva_free_pasid mm->pasid=1  // master process

That's the expected behavior (master could close its fd before forking, in
order to free things up earlier, but it's not mandatory)

> Have one silly question.
> 
> kerne driver
> fops_open
> iommu_sva_bind_device
> 
> fops_release
> iommu_sva_unbind_device
> 
> application
> main()
> fd = open
> return;
> 
> Application exit but not close(fd), is it expected fops_release will be
> called automatically by system?

Yes, the application doesn't have to call close() explicitly, the file
descriptor is closed automatically on exit. Note that the fd is copied on
fork(), so it is only released once parent and all child processes exit.

> On 5.17
> fops_release is called automatically, as well as iommu_sva_unbind_device.
> On 5.18-rc1.
> fops_release is not called, have to manually call close(fd)

Right that's weird

> Since nginx may have a issue, it does not call close(fd) when nginx -s quit.

And you're sure that none of the processes are still alive or in zombie
state?  Just to cover every possibility.

Thanks,
Jean
