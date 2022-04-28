Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20337513568
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347496AbiD1Nnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiD1Nn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:43:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148601FA49;
        Thu, 28 Apr 2022 06:40:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b12so4391966plg.4;
        Thu, 28 Apr 2022 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J6PdeDybWktJ3VOINyxTrk1DVabwU+Bt41DCAGyrJqw=;
        b=IPsajGJEOyFy0KXi5MbqNqA+B6gzB8xNg++FY3nWAd50+XLHI3IiiXgHM0D0hOvAGP
         NHzF/Fmjx3BKNr25mf0LCvUD+BlCo9/dmB2/lCRjW51Eam0ExUwFK3YH7YMSti0A4ZZd
         xEcKqHyrldXKx9tcqf+yWyAzrg4cetWf1poIiq59krbuM8OrRi/cvudto62nFlc/aWbk
         VsWQAj+C5W8ABz7FdqFhorEwMN6BDyPdq5A590Zmk4vzVVXSN0QQbskvoIT0LCXuVqwX
         BMeO8voLLYnahizk2FNYrugh1ix+nJ07EM4TTaj80NJn1xQL7mAjorMIdiY2reS7pEos
         TqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J6PdeDybWktJ3VOINyxTrk1DVabwU+Bt41DCAGyrJqw=;
        b=pFIaISZuLVNtC9oxx6qyQW03KrRpszL4YwWPrup9S2I375shOfrNU1PasuPi9TBsQB
         vTjP5KgAnk4UExzKfq8qtoZ2hAqEzV0jTkEwL72d/oAPs9ozAlrt7eaEuw8fBwgySe/t
         +AxrgszU25SBZ1O8YWWPXZA34jUwU/c00itxH0gj4X1+yulErccQvZwfAS2SZ4exwrH3
         6a2Hee55SdE55nBClST7qqF2cHXRFovItiONFJ1kKk2A6ELx1eHYgTNW8z8s7l18ita/
         5i7PENJGUNcIiCE19VUpI4BRO38bVdIxTMd3fHww6latZ3oNBRDKErmu4QXTJSzeSqdF
         ey1A==
X-Gm-Message-State: AOAM530rQ6FMFwaDEFho/Ub9sSI1BgFXcl2xAZpZyj7OlHtP347SN9sr
        MRqpHhScuduroFC+dkz87H0=
X-Google-Smtp-Source: ABdhPJx25FcLG2JQe24kaXZecI9BCEFvz9z8SheCmciK7YDm8iNJkM8WfVpRJ48uQcNgOpHj2YG0Yw==
X-Received: by 2002:a17:902:d54d:b0:15d:2ff:b0e2 with SMTP id z13-20020a170902d54d00b0015d02ffb0e2mr23275845plf.131.1651153213528;
        Thu, 28 Apr 2022 06:40:13 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.119])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm21177011pfw.168.2022.04.28.06.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 06:40:13 -0700 (PDT)
Message-ID: <5c227ef8-72d2-9254-f061-128974a6dc7d@gmail.com>
Date:   Thu, 28 Apr 2022 21:40:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <6bb3a6de79afbdb1ebc1b804fb8c2002c00cbaee.1651058600.git.sandipan.das@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <6bb3a6de79afbdb1ebc1b804fb8c2002c00cbaee.1651058600.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/4/2022 7:31 pm, Sandipan Das wrote:
> +static inline void amd_pmu_ack_global_status(u64 status)
> +{
> +	/*
> +	 * PerfCntrGlobalStatus is read-only but an overflow acknowledgment

If wrmsrl PerfCntrGlobalStatus, remain silent or report #GP ?

> +	 * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
> +	 * clears the same bit in PerfCntrGlobalStatus
> +	 */
> +
> +	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
> +	status &= amd_pmu_global_cntr_mask;
> +	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);

If rdmsrl PerfCntrGlobalStatusClr, does it return 0 or the value of 
PerfCntrGlobalStatus ?

> +}
