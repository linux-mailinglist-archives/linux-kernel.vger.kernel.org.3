Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB74FE45B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356846AbiDLPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbiDLPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:12:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2C5D654
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:10:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e8so11767532wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dEtehde5cjGV9pdbeDZJ5mEUZSUw1tlthJqoKML+g0Y=;
        b=s8XYPFWdR/OTPJ6iEZkbBH/vpqPUQtbWi53fsalJbS859W1hri0trBZxuGteCEYa+i
         yy+syBRWikaBvxxDHOjBHYOaH/4JLGAETkbrCESo9iBj3GZi64wKtbfrViJ6egTOpQJi
         JUB9ZzMp6x7pza38q9oZ61TQrEeiXBBXFhKrd6nitj2xpI2tOoaWqG3UnsQC0oknQmVe
         PUYBNANDe28bVNmPEVgLFbVxK6SuLDBwsRgtCXcJRLJJNb2biW3TG/KISgWWHLyqdEH6
         oZ82VifUj+zzzeGeV+76S1jOksa4ffRMIP31I7YQzYWcffdhE/cvx6JxVqj9uN5P3a+b
         jsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dEtehde5cjGV9pdbeDZJ5mEUZSUw1tlthJqoKML+g0Y=;
        b=jKYADLe4RFPO0/nNCT996aLpwQo5cl6TyR8GsDxoMKp6Yugnz5cTnTMaY7SBTcm2GT
         /macxk7sF9Y4piOfSDfDYSP9SNY/8VG8bcyVFnKCo94/1JUc2pq4dWoXD4uFfOabLajT
         ghYf2zQodeS82yypU2sVaV69Fqbs8bpFRznXPEQGe0NPDXE3uVonn3MO+XSc5PJyB3tY
         2lJtX6jhdv6ELAy1V3ShHw5s8n368gqkwzBBphfV8y4CNfhea/YbpIXkv/68BHIHZ+Ik
         bSQgPsP0dY/5hERHfz95i8n+p6DM3u36GYYolVjYqi3wZFC9MN+vOu2hBm/9Fn/SjYEq
         RhVw==
X-Gm-Message-State: AOAM531Tr9dbK5WMpJkt5SZr638bY7tlpnDmun/azE+rdDikHlXK5Pvk
        2z3rJXsPCwBKVdYsdCKwqde4Sw==
X-Google-Smtp-Source: ABdhPJxARVef1Vp4HZQigFUbuclyFy1JIKJ4EXgGWuOZuSSbfh2u5nsKVKaKRtyYqKkM3QIJpO8maQ==
X-Received: by 2002:a5d:434f:0:b0:205:f514:8955 with SMTP id u15-20020a5d434f000000b00205f5148955mr30114394wrr.73.1649776237535;
        Tue, 12 Apr 2022 08:10:37 -0700 (PDT)
Received: from larix (2a02-8428-1671-f801-d2dc-0c7f-2134-46d0.rev.sfr.net. [2a02:8428:1671:f801:d2dc:c7f:2134:46d0])
        by smtp.gmail.com with ESMTPSA id s1-20020adfb781000000b002060d4a8bd9sm24787772wre.17.2022.04.12.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:10:36 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:10:34 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YlWWavIDMNpbD3Ye@larix>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 07:36:21AM -0700, Dave Hansen wrote:
> On 4/12/22 00:04, zhangfei.gao@foxmail.com wrote:
> > master process quit, mmput ->  mm_pasid_drop->ioasid_free
> > But this ignore driver's iommu_sva_unbind_device function,
> > iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So
> > driver does not know ioasid is freed.
> > 
> > Any suggestion?
> 
> It sounds like you're saying that the device is still abound to the
> PASID even though the mm has exited and freed the PASID.  This is
> essentially a use-after-free for the PASID.  Right?
> 
> The right thing to do here is to have the PASID code hold a reference on
> the mm.  The mm "owns" the PASID for its entire lifetime and if anything
> needs the PASID to live longer, its only recourse for doing that is via
> an mmget().  I _think_ mmget() is the right thing as opposed to mmgrab()
> because the PASID users actually need the page tables to be around.
> 
> This would still be nice to confirm with some traces of fork()/exit()
> and the iommu_sva_{bind,unbind} and ioasid_{alloc,free} functions.
> 
> I wonder if the Intel and ARM IOMMU code differ in the way they keep
> references to the mm, or if this affects Intel as well, but we just
> haven't tested the code enough.

The Arm code was written expecting the PASID to be freed on unbind(), not
mm exit. I missed the change of behavior, sorry (I thought your plan was
to extend PASID lifetime, not shorten it?) but as is it seems very broken.
For example in the iommu_sva_unbind_device(), we have
arm_smmu_mmu_notifier_put() clearing the PASID table entry for
"mm->pasid", which is going to end badly if the PASID has been cleared or
reallocated. We can't clear the PASID entry in mm exit because at that
point the device may still be issuing DMA for that PASID and we need to
quiesce the entry rather than deactivate it. We can only deactivate it
once the device driver has properly stopped the device, at which point it
can call unbind(). There may be other issues but I can't check it
thoroughly until next week.

Thanks,
Jean
