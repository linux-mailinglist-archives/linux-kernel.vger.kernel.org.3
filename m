Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA9531614
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiEWT36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiEWT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:28:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0548127191
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:08:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so135034pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HGhI/hoYXnrfglg09HC05okNiQVh1y2D3mnwrysSE4A=;
        b=ysjlmrGopFKUcPSX99OGODaZLKvyI89cuGY8gLks9Oz3mcdgI18SscvRDxk1+hJjWz
         pva2qKrF4BJtHjmz+liv6ovyRiZg3UYpPwTgd9Rf0r83QbXny3hLxOB2GofL1gUbb2eZ
         WTErs4APngwBOl0IGJgkvYmV5c6QW5mfq6wZCL50aDWGoXvznfj7IO2dGbIrFXrHR/uO
         AvRsZLJYnyDXUxeVm1wICAf2+aivo4Oe3EeFrBpHrm9g9UG6viBXcUWBhR0DpUrVeLlJ
         kI6RvwFJfU8F5yIg/8pQRfvbMJHydllRIRka3IwUtB8+9IhYW9siTO96YmUVIG3FzCBj
         v1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HGhI/hoYXnrfglg09HC05okNiQVh1y2D3mnwrysSE4A=;
        b=h3zofIGE9awm1G/mAUpoqBBtVCvGt1TmUsQ1xa30Lt1kRIdWhaBlTDuyNzzATDSPNh
         IAGlZBgJhMtyIdxmdVEJgjXwmc9IJTy9ot3PXcWFQVPj41+ga3mqrr4MZs8fnMc3YpbF
         withWXRTzqWExMTfXFC7zEzr3HfJHMJLSSXcb5EdN74R+5ErByronoSWtTJqxfnYFKS/
         zzgLYW+h8AI7cb79LDOVO4eNDXUjJCcVdXkBhDt8TiOoZB50/oAANLSk2U2Mnyfd751y
         H4fIRAme8SfPQ7ozI+8AEki6Ji0bhkaWwOSjHg7N9beAd4SyBJ/pQRwfpiuOxIKv0j/3
         M5xg==
X-Gm-Message-State: AOAM533BfHK1HXXlgW2n3vK6tc5AXe/xST0GRAq9RkFbPcoV7MX7R8wH
        hCEA/i0CyPdxJUbdh+6UEailjA==
X-Google-Smtp-Source: ABdhPJyUaT0BfeqpIVsU6nOQC5jWSr1s3TNCPpHen+8iEx2oV5/BKMOUxOfXkdSNVF43CdBspItnNA==
X-Received: by 2002:a17:90b:1c02:b0:1df:d8b8:6eb1 with SMTP id oc2-20020a17090b1c0200b001dfd8b86eb1mr484106pjb.90.1653332902056;
        Mon, 23 May 2022 12:08:22 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b0015e8e7db067sm5513766plc.4.2022.05.23.12.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:08:21 -0700 (PDT)
Message-ID: <7bbf2792-355b-65a7-e239-879b3f928384@linaro.org>
Date:   Mon, 23 May 2022 12:08:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
 <20220520164255.GB17335@blackbody.suse.cz>
 <6ac66e89-2063-c5e8-df15-f77b76befc05@linaro.org>
 <YovaKZV7IzQgCo9E@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <YovaKZV7IzQgCo9E@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 12:02, Tejun Heo wrote:
> Can you try holding an extra ref in the killed path?

Yes, I can try that. Should that be with or without the extra work_struct?

-- 
Thanks,
Tadeusz
