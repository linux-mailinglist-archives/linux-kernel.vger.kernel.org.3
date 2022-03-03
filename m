Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9580C4CBE64
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiCCNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiCCNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:04:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4324ECFC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:03:17 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA1AB3F4C0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646312590;
        bh=Rx4ZxbVhDyZFayUzEjmbuXvhfELZHztCqgfiHOmaXUk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=I08YoXc/4myiweY/9P4Pjj9pDXlH9vZZ8kpIE2pxxLVEnEfjMs2pLuIFVBly7XksS
         izZNfEvb3Yb2TIWjfzxk/8+fzs4f1zjYrAIrHh8K2gXKrQNB3WySbt1yU9nxCDpuRO
         LfkXFglFXOP8i2M5EYdtE1UiZRae6MWXMWIB+orHF0zUFo2JgksGJgN3p2SCrkWhtT
         yslZ1LI3Z64mP5KLlI/54E+Kw5V/IO5LBOyytUNhlvs3x0t1P6B2PUKBDwEW1Kae5i
         V9j4SjoA2l43LqDZtAHgHhaD8TugtLdtzw4DfV5gtNqvdH7/SgrfvZM4DFrgA8r3FX
         xE4V7q0qmokeQ==
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso3133676wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rx4ZxbVhDyZFayUzEjmbuXvhfELZHztCqgfiHOmaXUk=;
        b=JImfyjXst+v/KxpNmchZYeYN4iV/BcZ5l6DDKp8GnQx98ZMVVUsGB7WL7ATB7gZF94
         ORA9w69lfLUVjhvY4Sa3LipiYl302gCqfW1AQGQi72leQub7fJ/m5rO3Fr5vZaVQK+yG
         sX6BhxVYPKhfOWqalOAxbo8TDwdR5rt+tLQfANZBcPsD3Otr/gNDbpUuqVVE06kGWuPy
         O7bcM6sHbG0zPGaqhmtubZrV54IX+JcjhrBWFnDFs9geDUSXYIRSQmyduJzQAv0T6k8q
         ZyarPjNdBgbsIBhCMarhgiCRep72wTPlHBXfdviRNrgZhESTIsMZKVXCr6tBMhN0pzCZ
         Re8w==
X-Gm-Message-State: AOAM5320agEzEYDXB2uBw9B0DaULoOHfdela9TT//z8ruy36tHZ/l1qw
        T+vbTWwZC+w8/dr0+orB0oUccDeKueCRYWQdEny1DZqxDmJHzIqyAurbpdLDWP4AagqlfD0U8LT
        uaJa69/cBfmyxSe9Audbm3YYJWqQJtc8t9V9wO06WKA==
X-Received: by 2002:a5d:678f:0:b0:1f0:2471:5a93 with SMTP id v15-20020a5d678f000000b001f024715a93mr6943678wru.164.1646312590123;
        Thu, 03 Mar 2022 05:03:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtq12b/0QiPZ1UiPJj10zJ0+nXXE5RfkSxXjl3iTmlxz4AnHd2ZbB0Iubafpeh3O6Fry4k2Q==
X-Received: by 2002:a5d:678f:0:b0:1f0:2471:5a93 with SMTP id v15-20020a5d678f000000b001f024715a93mr6943647wru.164.1646312589904;
        Thu, 03 Mar 2022 05:03:09 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600018c600b001efe4a49566sm2002944wrq.78.2022.03.03.05.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:03:08 -0800 (PST)
Message-ID: <a1f26936-6522-a3a5-f812-a80a63003453@canonical.com>
Date:   Thu, 3 Mar 2022 14:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, vdumpa@nvidia.com,
        Snikam@nvidia.com
References: <202203031247.0bBX70B3-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <202203031247.0bBX70B3-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 13:31, Dan Carpenter wrote:
> Hi Ashish,
> 
> url:    https://github.com/0day-ci/linux/commits/Ashish-Mhetre/memory-tegra-Add-MC-channels-and-error-logging/20220302-164625
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
> config: openrisc-randconfig-m031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031247.0bBX70B3-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/memory/tegra/mc.c:593 tegra30_mc_handle_irq() error: uninitialized symbol 'channel'.

Ashish,

I mentioned with your v3 that it is expected for submitter to run
certain automatic tools:
"We not only expect to compile it but also compile with W=1, run sparse,
smatch and coccicheck. Then also test."

Judging by the output here, it could be that either you used old
compiler or did not run the checks.

Can you please confirm that you performed all the activities mentioned
before?

Best regards,
Krzysztof
