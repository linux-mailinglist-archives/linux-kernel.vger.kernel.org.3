Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEE5200A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiEIPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiEIPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:06:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C23403DA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:02:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q23so19873216wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5D+7YOUX/BbYyXU7j9leMetgcXcP++cXNdjZ9nYajuk=;
        b=kXPcRKLSpMppbzKAJxk80Bn1imqlSkeewx9AM6pUJZyEYn3hyf7lo0JnOw0l6L0Fc3
         npkP8zDB1AXJZKAX8BTyU26F/dbaQJD6H07XdLR5jyfoDrT8lIZrVHw9EDDA3IO1qqXm
         2yJY7rSZQEBIPphnBW7r4lpm1r4RD4gek0YLweu0cwsWdSzWgxOAml7CBQKOvQZ+oO0i
         B/YAfSLWAOL1S9KQfhkeaMYpOAD+O8yfBzBq+Jym2gfZCAUWJ+x6maP6Cyc8IboADdCE
         DtRi34BIrMqmo9R8HmMQdJLW9ALh7cxkxQD4imAxGW78HCfD1SJRD0v575WGg60wrZew
         yzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5D+7YOUX/BbYyXU7j9leMetgcXcP++cXNdjZ9nYajuk=;
        b=l5IRLKOdfNkcqivTJDE16bAPck+7dg1dm6rt6PaJE11gfEc631kY6sQ5tmESwmq5rS
         qxMfMk0ZORja+kv/rDBW0KqYxEj0I8Su1BhOlQUF2ucvmqSUuNS2bdBHlG1+XB3Xk647
         gyBIX7ZZbjTuy1HQLqozP8J8ewNsva+xPXeYmxKS0IyF+W9AxymlPmxFp/znfTOlz8TH
         rwax9xI+sOhdUpPhzSnVm04NZZP8v8kAjcec9ya7SfbC9qeK+3T0dqvS6mrZtHByzmG2
         qvrAgn8FdohFKqAUwGvliZNAjxzB5iXXBRICIpBzgDQz1082XbqqyKFxjxgry+RFUrFq
         2Hiw==
X-Gm-Message-State: AOAM531R052NP1aIBFG1OcPG1wvYpnTurLb+lKLOUNQUV8MfTveCI3AK
        pShd5PQCgqtDH3yj+4HeH9M7e5WX6Iz8tIyv
X-Google-Smtp-Source: ABdhPJwWiy4UFFaMeMgS2dlxifonKh1K4y3qdnqTGVqfMkuy90RHFw4LvtKnKXxxH8L22kuDCbHyvw==
X-Received: by 2002:a5d:4f8b:0:b0:20c:6970:fb3c with SMTP id d11-20020a5d4f8b000000b0020c6970fb3cmr14313394wru.554.1652108569340;
        Mon, 09 May 2022 08:02:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b0038eba413181sm17488890wmj.1.2022.05.09.08.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:02:48 -0700 (PDT)
Date:   Mon, 9 May 2022 16:02:24 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] core/urgent for v5.18-rc6
Message-ID: <YnktAONWLGsd/1Q8@myrica>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <CAHk-=whj6m0B9ys4XyE4AAPPoXE7XpBtxL7mD3Rk6EYX1=Ugng@mail.gmail.com>
 <CAHk-=wiEC-Jdx4iTP5NQ0a8stsU+SL0DjbTwhQ+mvPGNBXyMag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEC-Jdx4iTP5NQ0a8stsU+SL0DjbTwhQ+mvPGNBXyMag@mail.gmail.com>
X-TUID: khSyPKKmr9ko
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

On Sun, May 08, 2022 at 11:36:23AM -0700, Linus Torvalds wrote:
> And yes, the mmu notifiers do then take that mmgrab reference to the
> mm, so it all works.
> 
> But it sure looks horrendously ugly. Saving off a 'struct mm_struct'
> pointer with having basically an accidental reference to it is WRONG.

Yes it is fragile. We're currently reworking iommu_sva_bind_device() to
factor more code into the IOMMU core and to add explicit mmgrab/mmdrop, so
once this lands we won't depend on mmu_notifier_register() anymore to hold
the mm reference.

https://lore.kernel.org/linux-iommu/20220502014842.991097-9-baolu.lu@linux.intel.com/

Thanks,
Jean
