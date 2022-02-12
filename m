Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76284B32F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 05:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiBLETu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 23:19:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLETs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 23:19:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4022B1C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:19:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k25so26589438ejp.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p7X05HIHlgua5QT03cwmvP2qXsowDMd5jVQ2Nq7kxys=;
        b=Wpijvd421OFBuVYF431Fmi7Ze13lqR9HCjLI+tGr6Que+4+k5eetxRxPIK8MUAgyQk
         Q2BXg6TGtESf3m5lBpDEqfcpxCdCa1KT94JGG+JlieZVx+6nU5crjs2blpzWSXK7xn0I
         JFqIhoKBO/d6gU7Lln9zNEzZqZ883++rtE7hTMJjU5Jfsq2fPivNKrlyOZ6stAgGa8MX
         yn+IqnZoX7PngInCmcd8I+NC24Rwg5zV5EKrRr0LNINqkfphnGH2qqIy7gcHjSkYhUtg
         UcTUCZ8Ft4rNvjK4nuFCPuR9Pesb4hc8mKDsYEvN+78t/435oULr9rZ4ara0Hmq1/qJ/
         1sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p7X05HIHlgua5QT03cwmvP2qXsowDMd5jVQ2Nq7kxys=;
        b=qkVhuDcOEFRkTCeqE3kbVrt0ZmprPhxvLvJQHVctnGl8Ugu2aeEGPitrgm4ohOqPk8
         6/aDNkoxnneWVT6G+kvb/fZhdvAffXG8+9nolsv90MpAVCPPqxo5ZXcUjIf8m8AVT8WD
         +lpVK9RtsGSaGKeoq4/27PAlqRjZpPqtEkzrp9yJ/G59bdFVTznNioebksBlYtKEBqws
         Xkp/6eg30ZSzQbWGbBUkgOh6bbGPTt5MW6U18cLvapf4/NqXp9RiUnYPUXL5rbgDdh+R
         8hPJo+hTTBQ4WXvowY3q0c94VBmNTUbjPE8/5eBPWDG3bh4CZ6oMPUjisyETWfLdrRB7
         hLNw==
X-Gm-Message-State: AOAM530UaCQtXz2uoR8jcGyXgPLx31en7HEXbbtVYT71I8g01fP2kbyw
        V9932LsHYQzi99cjZgHj1tat8g==
X-Google-Smtp-Source: ABdhPJyMYSrRWUtGrCZyMqVLTyz2rtvX46h43uMrcgvkEOKz+ARG+74NeG39H938HbzX63ZBtYJI+g==
X-Received: by 2002:a17:907:868d:: with SMTP id qa13mr3740651ejc.508.1644639574621;
        Fri, 11 Feb 2022 20:19:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id eg11sm10340818edb.17.2022.02.11.20.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 20:19:33 -0800 (PST)
Date:   Sat, 12 Feb 2022 12:19:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
Message-ID: <20220212041927.GA763461@leoy-ThinkPad-X240s>
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
 <20220128210245.4628-1-alisaidi@amazon.com>
 <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German, Ali,

On Fri, Feb 11, 2022 at 04:31:40PM +0000, German Gomez wrote:
> Hi Ali,
> 
> On 28/01/2022 21:02, Ali Saidi wrote:
> > Hi German,
> >
> > On 28/01/2022 19:20, German Gomez wrote:
> >> Hi Ali,
> >>
> >> [...]
> >>>  };
> >>>  
> >>>  enum arm_spe_op_type {
> >>>  	ARM_SPE_LD		= 1 << 0,
> >>>  	ARM_SPE_ST		= 1 << 1,
> >>> +	ARM_SPE_LDST_EXCL	= 1 << 2,
> >>> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
> >>> +	ARM_SPE_LDST_ACQREL	= 1 << 4,
> 
> Wondering if we can store this in perf_sample->flags. The values are
> defined in "util/event.h" (PERF_IP_*). Maybe we can extend it to allow
> doing "sample->flags = PERF_LDST_FLAG_LD | PERF_LDST_FLAG_ATOMIC" and
> such.
> 
> @Leo do you think that could work?

Let's step back a bit and divide the decoding flow into two parts:
backend and frontend.

For the backend part, we decode the SPE hardware trace data and
generate the SPE record in the file
util/arm-spe-decoder/arm-spe-decoder.c.  As we want to support
complete operation types, we can extend arm_spe_op_type as below:

enum arm_spe_op_type {
        /* First level operation type */
	ARM_SPE_OP_OTHER        = 1 << 0,
	ARM_SPE_OP_LDST		= 1 << 1,
	ARM_SPE_OP_BRANCH_ERET  = 1 << 2,

        /* Second level operation type for OTHER */
        ARM_SPE_OP_SVE_OTHER    = 1 << 16,
        ARM_SPE_OP_SVE_FP       = 1 << 17,
        ARM_SPE_OP_SVE_PRED     = 1 << 18,

        /* Second level operation type for LDST */
        ARM_SPE_OP_LD           = 1 << 16,
        ARM_SPE_OP_ST           = 1 << 17,
        ARM_SPE_OP_ATOMIC       = 1 << 18,
        ARM_SPE_OP_EXCL         = 1 << 19,
        ARM_SPE_OP_AR           = 1 << 20,
        ARM_SPE_OP_SIMD_FP      = 1 << 21,
        ARM_SPE_OP_GP_REG       = 1 << 22,
        ARM_SPE_OP_UNSPEC_REG   = 1 << 23,
        ARM_SPE_OP_NV_SYSREG    = 1 << 24,
        ARM_SPE_OP_SVE_PRED     = 1 << 25,
        ARM_SPE_OP_SVE_SG       = 1 << 26,

        /* Second level operation type for BRANCH_ERET */
        ARM_SPE_OP_BR_COND      = 1 << 16,
        ARM_SPE_OP_BR_INDIRECT  = 1 << 17,
};

IIUC, Ali suggested to directly reuse packet format to express
operation type and don't need to redefine the operation types like
above structure arm_spe_op_type.  I personally bias to convert the raw
packet format to more readable format, a benefit is this would give
us more readable code.

For the frontend, we need to convert Arm SPE record to samples.
We can explore two fields: sample::flags and sample::data_src, for
load/store related operations, I perfer we can fill more complete
info in field sample::data_src and extend the definitions for
perf_mem_data_src; for branch operations, we can fill sample::flags.

So I am just wandering if we can set the field
sample::data_src::mem_lock for atomic operations, like:

    data_src.mem_op   = PERF_MEM_OP_LOAD;
    data_src.mem_lock = PERF_MEM_LOCK_ATOMIC;

The field "mem_lock" is only two bits, we can consider to extend the
structure with an extra filed "mem_lock_ext" if it cannot meet our
requirement.

> >>> +	ARM_SPE_BR		= 1 << 5,
> >>> +	ARM_SPE_BR_COND		= 1 << 6,
> >>> +	ARM_SPE_BR_IND		= 1 << 7,
> 
> Seems like we can store BR_COND in the existing "branch-miss" event
> (--itrace=b) with:
> 
>   sample->flags = PERF_IP_FLAG_BRANCH;
>   sample->flags |= PERF_IP_FLAG_CONDITIONAL;
> and/or
>   sample->flags |= PERF_IP_FLAG_INDIRECT;
> 
> PERF_IP_FLAG_INDIRECT doesn't exist yet but we can probably add it.

Yes, for branch samples, this makes sense for me.

Thanks,
Leo
