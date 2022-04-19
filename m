Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342550724F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354094AbiDSP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354097AbiDSP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:58:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6B1237CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:55:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id a10so1116491oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/le8KXETSx34GVaZzbTYz4RuO3FZ33ewlVPp4yPODs=;
        b=VvCMpocizhWdbwsHWWjmQm+alPJCsZjPAJ/7/6LNDiB6A2BIfvP8MnIX+AlLN5zCWQ
         UPKlTPnfOEiojap7T8h4Q8RfF7MjoxIa+y4HM6L6Cpw1SKUBNxpKBr8Ls4U7fVbiIEIh
         mBVWYybq+1Ea00BgLDR5qycV1JQsMKYpJWh4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/le8KXETSx34GVaZzbTYz4RuO3FZ33ewlVPp4yPODs=;
        b=pxfhzmGeKedh6XVj/Su5nhGgod/xMf07rEVRaKT61zJdEg/OKcmtqwXAv02Gq+0oYs
         hOXIKvE0ZvpzLvZKeFb8p1QhfuycxLmGRiEGqtVL+BNOZFxLqdgb+eQr1SQLK2VsnamR
         YF6Ox+9S2h0kKDBYQNJw7oQrtVEozhWvgRrvL2XtHb6sfNzOxyRllcOQf8b8QaGu5ygK
         mkwZ/lNJB/E73buAGdt6BCcCN4u5kGoY61LOMa6M9TjATkCp9Jv7wrQkg/YEC08SlJJT
         KgZj+kRpWMUO0QRg7v8WmafIDNNN1Oyx3lYTwCWlAw/qiyVPc1mhd1IbQEjco7tLC5uk
         zkCA==
X-Gm-Message-State: AOAM533b5U3tBisehBh+3LelxqavS9FcXoI92t/XEqZNcLaZmO+d+zTq
        9Huekep/nhTm4hLy6seZr1/Cew==
X-Google-Smtp-Source: ABdhPJzXqSXN+kGbIZS/42HLs8sHbwloBYDrxTEIguUExymTOoDdnaU6U0Wf3H67lBu4aQspJp5nzQ==
X-Received: by 2002:a05:6808:128c:b0:2da:3751:7639 with SMTP id a12-20020a056808128c00b002da37517639mr7779946oiw.294.1650383731978;
        Tue, 19 Apr 2022 08:55:31 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm5285821oif.38.2022.04.19.08.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:55:31 -0700 (PDT)
Subject: Re: [PATCH] kselftest/arm64: fix array_size.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220419032501.22790-1-guozhengkui@vivo.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a2e53307-5aa6-54c8-8bab-695f4e2e6cc7@linuxfoundation.org>
Date:   Tue, 19 Apr 2022 09:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220419032501.22790-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 9:24 PM, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> tools/testing/selftests/arm64/mte/check_child_memory.c:110:25-26:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:88:24-25:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:90:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_child_memory.c:147:24-25:
> WARNING: Use ARRAY_SIZE
> 
> `ARRAY_SIZE` macro is defined in tools/testing/selftests/kselftest.h.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
