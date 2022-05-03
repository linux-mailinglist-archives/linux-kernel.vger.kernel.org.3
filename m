Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5838A517F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiECHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiECHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:53:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E16B2BF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:50:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so8318636edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wp+HuhCzVQcbpzvT/sQrzmDjeIdh00lZI9oDxB6WyTs=;
        b=MaRFzGoMD1a278grMU14/yYlEhePHu15Lav8QNQrQHkccVbXPqgmvM1VFUtuC9Fjf4
         uJ3Rgbif7K6L8Ar8zRmKbftuhHKSa1UQ3SwebB9FJsDSmAGIbAM/w9B4Pma+MsXx73Av
         tBlw/wqeYyPZWnubeZzUsmbpdMPm/M0Fs/b6h3BmrufAJfacj89ELyGunz7ZfLR4dbcQ
         8fzP9L7Ut+fKZrCPOpNjXsoKndESVxRp91TmVHnheF4t6Z5QCcAfvoUrYdJaBATgzHK4
         L7wiHAO+Kbyg/3nyOqSVZr5kgTn+lepmUGIj3npYWsgp9O3lwfGl0Qx957ysvk/ZK+xQ
         ksgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wp+HuhCzVQcbpzvT/sQrzmDjeIdh00lZI9oDxB6WyTs=;
        b=WLv+2Y9PrPJ2x0Cbl/1fSdPwz3JbysVBu82OX/slK4bLzLDX/hWkk3leSFOf+G/F4d
         SATsKcEBVwydJXX7LpN/UCZic9fEmfHkYWsjRitDLkh9vstZ2lmo2wBwXGJvrCf8sH5+
         6G+d0oRKhs7F7bdbw2idQSrod7LQLH/G8ZzbXHA/mRGD/+3rgNSGW6u/yk55ILMrSLDX
         QyrHCe/wCc0HYHqYiPCXRKl7jvKHx0vhFTLNkO/CB69AAV335gHlFdljWcsZgGZJzuoC
         4TbasBliQ2DLo5heBJYskzWC/qtYfVMScoCmDHItsIfUP//o0rMzWGWWhjbg5PclRLtH
         0tSA==
X-Gm-Message-State: AOAM531XnncA5nZA2OlmOH439+Y83c+ICUpUrYQGaohE1AUFF+fstIrH
        YH8k35TkQtQezyXRimlM2loZxw==
X-Google-Smtp-Source: ABdhPJyVyq4b/kVlB63u3UarpBNZnJKtF6IDLyaW7pS64uWqHVVg2cH/YhsdXpfIKhYgli0kY9qkQw==
X-Received: by 2002:a50:f1c5:0:b0:425:dd04:b7a9 with SMTP id y5-20020a50f1c5000000b00425dd04b7a9mr16790672edl.388.1651564218903;
        Tue, 03 May 2022 00:50:18 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id cw27-20020a056402229b00b0042617ba6387sm7464883edb.17.2022.05.03.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:50:18 -0700 (PDT)
Date:   Tue, 3 May 2022 08:49:52 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YnDeoGjv/dZnu+YQ@myrica>
References: <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
 <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
 <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 03:33:17PM +0800, Baolu Lu wrote:
> Jean, another quick question about the iommu_sva_bind_device()
> 
> /**
>  * iommu_sva_bind_device() - Bind a process address space to a device
>  * @dev: the device
>  * @mm: the mm to bind, caller must hold a reference to it
>  * @drvdata: opaque data pointer to pass to bind callback
> 
> This interface requires the caller to take a reference to mm. Which
> reference should it take, mm->mm_count or mm->mm_users? It's better to
> make it explicit in this comment.

Agreed, it's mm_users as required by mmu_notifier_register()

Thanks,
Jean

