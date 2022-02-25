Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95B4C3EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiBYHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiBYHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:08:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032018BA5F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:08:16 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF9D83F1C6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645772884;
        bh=nJ9Qo3Ms5zSOBS8XZ5bLiglHuK27pu9HmmC0N63PtXY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PwaQPeVRdAs3Qbzlw7YNeFVKOXGvMKi77HbVavUU5GWZ4Mm3CjUFcEo5J6N7nTJp6
         KYjgwEM3lkHBOuzcLEiyBFn784c0/yMWw774hPcTmQWK8yUrUk/5eXJuCqgmz2Zjn6
         oBabkai0RafQ4ynFH900ZftZNJR4YHLWt6eyjZGw1RnD5QyWj+1iPCqtePydnUvyvm
         yHL2ylbV6fTz/IuWSRGgOgPsF3+jv+q6T9RQz7bJ3yI8fhB7vX879YowsgLDX7B7o8
         FCzgBoBsc8S+YntBrTplg6Pn3UAYx7Pi8Lu3CVvz5CAmcUfF1ckdXGGQUd4EppWdXE
         siQQcnLRfRptA==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso1854850edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nJ9Qo3Ms5zSOBS8XZ5bLiglHuK27pu9HmmC0N63PtXY=;
        b=qMgYUCPwov8ntdYCvHp7GJxReJDLzlnW8wv7fe8VkT5ff1bFDtkJSi2CNhWvEX9ghh
         FGsd6Es/nwPqBMifk3cxK1dpZG5eK1ymV2vJopu6+TXylRwC6CJVwT8zQSWTMGTgVfT5
         1dWCJchwksYtb8ZQSLIhae8IpEp31l8cJ2Rwn2VpbC/Yg6CuDCOawL/boWO3UHMhoj1h
         r/pnbyYwHdFVnzxCC6Os+/NRwVhbM+I6MzlzthNX0qinZzS6K2rE7PmH3/ozAgYHZkJF
         /QDTKAxMBO/DkUvcxtWjjuipuiAXCQWdl6B6cBrrySFgFwEasCFzE3gjBmWptrfKTt4W
         Aikg==
X-Gm-Message-State: AOAM533EvQcmFLdAYpEgxFzeZ1NY2FUVoD7XMp7Y0bsEWvsOArP8xGag
        gQD3to0E5gyt14m6ZbNc9ZGmcsbsslHMcccfPmq5ipLqRKr1swXvs9O9QHJOjBG1i2IlKYiNb/1
        UtKr97cvRb2jGwe3RnORTIdmfoXfkWzF2OuNNyj0gtA==
X-Received: by 2002:a17:906:6848:b0:6cf:6273:9c47 with SMTP id a8-20020a170906684800b006cf62739c47mr5229235ejs.1.1645772884456;
        Thu, 24 Feb 2022 23:08:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcHek/GgCpfJfanPqM4Y7zz/cBC0dLM8NbyjsbtX2y6e5P2doQfOf3dsBC76JOz13onBUUwg==
X-Received: by 2002:a17:906:6848:b0:6cf:6273:9c47 with SMTP id a8-20020a170906684800b006cf62739c47mr5229217ejs.1.1645772884268;
        Thu, 24 Feb 2022 23:08:04 -0800 (PST)
Received: from [192.168.0.128] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id f15-20020a50e08f000000b004134a121ed2sm899973edl.82.2022.02.24.23.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 23:08:03 -0800 (PST)
Message-ID: <3c199306-62a9-1cc6-f864-6f79869d4bc5@canonical.com>
Date:   Fri, 25 Feb 2022 08:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] ARM: dts: Update jedec,lpddr2 revision-id binding
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
 <20220224003421.3440124-4-jwerner@chromium.org>
 <ec0c90b9-58a9-669f-fe4a-73e60df335d5@canonical.com> <Yhd8OoJQer86kTZ8@orome>
 <CAODwPW9_cbsvU3Jf-9G6TSRUwHwu+HKCQug=eJ51tsRFo6HcPg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAODwPW9_cbsvU3Jf-9G6TSRUwHwu+HKCQug=eJ51tsRFo6HcPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 02:41, Julius Werner wrote:
>>> I bounced the mail to Jonathan, Thierry and linux-tegra (+Cc), so
>>> hopefully they will get it. If not, series might need resend with proper
>>> addresses.
>>
>> Thanks for the bounce. Applied.
> 
> Sorry, I wasn't sure how this was supposed to work for interdependent
> patches, I thought they would all go through the same maintainer tree.
> If you do split them up please be aware of the dependency, i.e. this
> patch should not be applied anywhere without patch 1 and 2 of this
> series landing first.

DTS changes never go with driver changes. Even if within the same tree,
these will be different branches, so you cannot maintain dependency. The
cover letter therefore should mention such dependency, so DTS won't get
applied too fast.

Best regards,
Krzysztof
