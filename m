Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0CD534131
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245440AbiEYQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbiEYQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:15:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF8B82DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:15:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i74so15164734ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rs7b4RffUTggYw5jr86d9uFXci48MYL3XRpA0FFOkeM=;
        b=SVRIetHcjBzh0B3HgKI57J0oa3deLYPUyX9TOKtVjUtenN7yHKKzWj3cUmTUXOv78d
         c90vOkDqZkypYtBJ0Zghlomy9eceO7rbc5k2it/yMlVeeMr46L5iN9OGKe/gdLvStV75
         BNzmBKCziTrRs36BAJ1mlKlPRsLhRJ7WeGWhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rs7b4RffUTggYw5jr86d9uFXci48MYL3XRpA0FFOkeM=;
        b=HMCGhMNb7MzhaywShjvEhuLiSwQ216QbcFt+2pfS8PzzO6ujQcGAYM6RO1+qlbS8/+
         /rwYAKrpw1YfINAA3/K8+vrWsMDfkllmMihxT7RmFXdbWruu3WyFo7EFwEPSuzxBFW+u
         DKkToWVsJKaDz5m2rTUt0uNMiXsDeAeOmCWcmfSOcbhjVWJfMzlJh6+a507kEiaxlJDb
         Un6OHYUGIyJISZsO4ZTVnyzt3U2hskiWcbgUM0gpf+aWlPzrfCi8agf+fLl1T0iHftNK
         fGKZHH/RSgbXiuK9tocEKrLsaqvtAyigBEgzzTBAn5kivy1jlQATeqxo+RU4WCJGSPgg
         ObAQ==
X-Gm-Message-State: AOAM533P6sqxWGHqwnFkYZD+31HEonH858sycBMU2DH4yy+ZfvlEp1Ng
        1vKM8dMjni8fasdsDSLcPJD2qg==
X-Google-Smtp-Source: ABdhPJz6AHn4Emgv5s+NQ+2fEBne2Fr9DmPF45/WfI9k1nfaSmD2sd7F9xhKgVW/NWMZEuLjYzP6xQ==
X-Received: by 2002:a05:6638:1481:b0:330:4470:b7a4 with SMTP id j1-20020a056638148100b003304470b7a4mr3167036jak.61.1653495339482;
        Wed, 25 May 2022 09:15:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r4-20020a02c844000000b0032e888a54f0sm4276072jao.63.2022.05.25.09.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:15:39 -0700 (PDT)
Subject: Re: [PATCH V7 3/4] selftests: amd-pstate: Add test trigger for
 amd-pstate driver
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220522115423.1147282-1-li.meng@amd.com>
 <20220522115423.1147282-4-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3596ba1a-c24c-3f24-8259-cbe18a98fd84@linuxfoundation.org>
Date:   Wed, 25 May 2022 10:15:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220522115423.1147282-4-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 5:54 AM, Meng Li wrote:
> Add amd-pstate test trigger in kselftest, it will load/unload
> amd-pstate-ut module to test some cases etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/amd-pstate/Makefile   |  9 +++
>   .../selftests/amd-pstate/amd-pstate-ut.sh     | 55 +++++++++++++++++++
>   tools/testing/selftests/amd-pstate/config     |  1 +
>   4 files changed, 66 insertions(+)
>   create mode 100644 tools/testing/selftests/amd-pstate/Makefile
>   create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>   create mode 100644 tools/testing/selftests/amd-pstate/config
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
