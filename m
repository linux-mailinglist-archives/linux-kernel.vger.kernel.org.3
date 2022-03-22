Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3107A4E395A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiCVHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiCVHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:08:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAAF5A143;
        Tue, 22 Mar 2022 00:07:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w8so14685784pll.10;
        Tue, 22 Mar 2022 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rYikdF40SXf7xi+HwkY/x3YoTFSrAuyc/7qiBvixRb4=;
        b=GSEHR0RLh04Nz7yeZGkTfKjhwk+vUEXMSOxUTFD+XpigilckpbzkhnwweQjBcneuRm
         7SOmwnszgKNT7AbNYdg/8SPXTwYI/P6tkFA7PeXh1jQtE57uAkLxNriozHNklQSs3LYP
         I1r/ZEi3+n+fvfm/p/G/1ZvGbM9Uqg38l96T962cUrjCpItKlNkczdwWt6/bCfhfjuA7
         VezHs+eaMxp7ypZ6vl8VCBe1xcEBPYhw1jg5osO+FEw0xnoIjJLx1SyLH8hdYfUTjKzy
         7hcZ0y2y4lR+UM/ISw7VLZc50jKdRJ5a3WJcS32AvrnmLmH8YIcYVkUIvMTyHbIPjBLP
         i70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rYikdF40SXf7xi+HwkY/x3YoTFSrAuyc/7qiBvixRb4=;
        b=PmN5yMM47jnzUmSfefE2lAa1DpR1xYhzyi9lRzcDIkqXwFhQB/aJk8yjkPco8bXkSl
         UB1Be9BFYldScJAe5HISLuD/JGMLeXMj2YSqCSUF+WtKyLtIGF1NE5aO+7tfOiJBfvi7
         LxTGlYuDPB1IkFb0BLz8t3+B5r9uj0XrFqoC42ysAy3B1zdlwgRt89/jbZr3yYDHYewv
         mhdiW1K0RZp3SBYgouhIG2MUpmyu243i7/OAkyofSjEejJxxU25auY71AUqBG7Ergdt9
         sdMYf6XF0fBsZyrTWgiigTb3cOgbXsmXQucqo2e9QSFwCRLBfE3yiEmvUeCf+lgmac+5
         TN1Q==
X-Gm-Message-State: AOAM531dpb0Qz9WNqdCn3O0goTh5KwiBW5eMJ3Ko8ksKRoSMbqz18zCT
        9FiDF4NPr08lqShv4fEEJ2gDkG7+o4f+cg==
X-Google-Smtp-Source: ABdhPJzMsUXrymkfFa2hfXPf1i775JeLSHHiUa7Acj12ZfZTZpnz6UgO9B9bugnEtqz0+OIyBvVAmA==
X-Received: by 2002:a17:90b:3a8e:b0:1bf:7fb5:af06 with SMTP id om14-20020a17090b3a8e00b001bf7fb5af06mr3292555pjb.7.1647932836230;
        Tue, 22 Mar 2022 00:07:16 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.118])
        by smtp.gmail.com with ESMTPSA id fy9-20020a17090b020900b001c690bc05c4sm1574256pjb.0.2022.03.22.00.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 00:07:15 -0700 (PDT)
Message-ID: <4bc9b537-f0de-5b75-5418-61c1d6dca849@gmail.com>
Date:   Tue, 22 Mar 2022 15:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1647498015.git.sandipan.das@amd.com>
 <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/3/2022 2:28 pm, Sandipan Das wrote:
> +		val = x86_perf_event_update(event);

The variable 'val' set but not used.

> +		mask = BIT_ULL(idx);
> +
> +		if (!(status & mask))

Needed here ?

> +			continue;
