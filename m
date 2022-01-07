Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9967487A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbiAGQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiAGQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:30:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD8C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:30:11 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q5so7735988ioj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azdtjei8H3F887uLBWbFbfAT3uLSkbk5K45L3Vv9UNo=;
        b=oar8YcEKO/COWlgFuXb3nooULxnsMpGkYuMr34pFSHEtrUZsQekiucGTIVGP4RS8ko
         +aoGTNOUTSLTD5wdEjge7hBYwQDOweusgoNZZ5V0A+yhArWPRfdQtBkO+0WIg5fDIh+C
         8/W/8GLHxLA87SCCW8gWC5CE6wBwafjIsEQZKNDQxKJMih1uyGS4B1YTgGYajboLH/Qv
         k5GFGEepJhg6p5A7XIgsXt0qyAtXfM6FYFgd0lBLNd2plTZrYLDBiU2geokWSskj2LGW
         CvUfmE0r9bbJ162GbUAylxCP33LlaPioBYvKwWmbBc9+lxiUkbh0hhnIrc5RiOf/SSVk
         lY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azdtjei8H3F887uLBWbFbfAT3uLSkbk5K45L3Vv9UNo=;
        b=aym/VXbjDYww33+InJtmeCsYkNa6Ja/GvFnGVYNSZWPDXMLL4RtDl+PrQaXUPsGDlO
         6yS60IPZ4J0vu2FF8T1V0xgeHYiJFvpu1YDW0CsqJH6sQi0QeNqZM/ibCj9RrRX030Gw
         rfZ1zVT0T+sB+g8fqILBkoBhTL4XUSrzqN0O5iDYZw3s2OCummUIBo1M0fcTkvW9WagQ
         he6vP31Al4+X3rsYoQHr+Cq154OLusbeys2hDJgROR8CCnU+UR0AcK8v0VU9aogmgTc0
         OKwys7udaFSoPwCu/wn/M5LWqAk7HBOFvLikBzO2ZCkcSFXNYtTwqe7cul1U438zy87q
         LkCQ==
X-Gm-Message-State: AOAM533FjxfzPMTgVHJL01W1ruSfadSQFEqst41C8QkX/dHRJKnoZDkY
        bFmiHO1nbs76gUafWXwb5QCCYRKr+g+XQA==
X-Google-Smtp-Source: ABdhPJxbza27yeTR8GJEgOpvPtoqzcXCBD4fj/B7QHvAlTTKfaGtPL6pEK0zjtljPEq9RF6WNxHFXQ==
X-Received: by 2002:a05:6638:3449:: with SMTP id q9mr29247379jav.218.1641573010200;
        Fri, 07 Jan 2022 08:30:10 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e16sm3079421iom.51.2022.01.07.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 08:30:09 -0800 (PST)
Subject: Re: Special regressions report for the pending 5.16 release
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Song Liu <songliubraving@fb.com>, wsa@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0a6a5fa-3a4e-2269-4f43-aee8e81b6641@kernel.dk>
Date:   Fri, 7 Jan 2022 09:30:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 3:59 AM, Thorsten Leemhuis wrote:
> * This fix afaics is not yet mainlined:
> 
> [PATCH] md/raid1: fix missing bitmap update w/o WriteMostly devices
> 
> https://lore.kernel.org/all/20220103230401.180704-1-song@kernel.org/
> 
> 
> 
> But I'm pretty sure Jens (CCed) will send it onwards soon:
> 
> https://lore.kernel.org/all/499b185d-ff9a-934e-7768-ec796244fa1a@kernel.dk/

Going upstream today.

-- 
Jens Axboe

