Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51C8575692
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiGNUsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiGNUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:48:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B66D54F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:48:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w16so1132112ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQy/2ot6jk8ItOxruR7MYpbiBmcSneiVOpTfpIP/4Vg=;
        b=NDhsQOqIVtkTO8KKEKShcxUmo19SmDyguUXGeUBq1N8zfnxEbt6/P73mEBZO/0QqTo
         7NTaanMBS8pOhxXYtfXyNKXVcppSVkCtZLoiscTMoR+2iEtTtN0+IXMdLKvXH3BQM61a
         oFTxSslrNsDW0BmQJKiFt9ODwa7+RKgYH/Yd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQy/2ot6jk8ItOxruR7MYpbiBmcSneiVOpTfpIP/4Vg=;
        b=KDLEdybP10AQTE5mdN3PbKPve6ECm/QH587fMqGcVy3Dpy2FR1FyF0ItGtHqC+F+y4
         xkf2CvAZRRj/lc3giEAkMIxNNTBHLUgysdk/3gTvEA2vJ2DTZdwOfAWML05vjyd8Mieo
         DhqZiNgZrVCgCPJuSQPbjfoLwZtlJmeUyYNvSA9xAa+NaTOkyIvvRtoxsRtdPG8vqCMW
         aWBUWt4EJZGMRbnv2dQDpYAftrljPRZ5C0Im9ksftE4QNzXLVWkvwIa81HuzxHchepnQ
         1UPUahKWOKS1SliZWP8Fk2gUDOAQSyNi2Lkb/a1l946o6N/GLWFk/ZXxJjfeiB6X5CFn
         ZNyg==
X-Gm-Message-State: AJIora9p5tBBmjET7YL2cVTj0nFcqY30XYSoDy1awHNiIy67psfYmpLX
        lXwxJ5Dn+7ePFzmhoJQL8kGWzQ==
X-Google-Smtp-Source: AGRyM1upTNUmPJnrQYUi7ROJy/rLrnWkgEXy2DQojINP9ojm45Tia9BKqLanbQ4x7/eb4PDyjmH+xA==
X-Received: by 2002:a05:6e02:11a2:b0:2dc:3cef:d430 with SMTP id 2-20020a056e0211a200b002dc3cefd430mr5536322ilj.279.1657831690873;
        Thu, 14 Jul 2022 13:48:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g16-20020a926b10000000b002dc1f1a7cc2sm983321ilc.31.2022.07.14.13.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:48:10 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: timers: clocksource-switch: add 'runtime'
 command line parameter
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220714185721.48125-1-wsa+renesas@sang-engineering.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f65df4d-ee70-f08c-3385-ab09a65a47a8@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 14:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220714185721.48125-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 12:57 PM, Wolfram Sang wrote:
> So the user can decide how long the test should run.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: John Stultz <jstultz@google.com>
> ---
> 
> Change since V1:
> * added the new parameter to the help printout
> 
>

Applied to linux-kselftest next for 5.20-rc1 with the rest of
v1 patches in this series.

thanks,
-- Shuah
