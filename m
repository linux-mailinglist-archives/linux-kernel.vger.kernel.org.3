Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31504AA978
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380157AbiBEOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiBEOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:36:00 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF638C061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 06:35:59 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 9so11094235iou.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NjsPCeTC6AUkI8iof6mArRIBPDUlUNHR5425CjSvoh8=;
        b=eGlpEo3z+gzLBu5G7H5LmXRPryG0RtMHZzksWu5Z/iUr1LMJoZOJyxSK7ZPWRoTf5K
         oiM26sl93ASyPjf/tAwpjhGQ63nVtJX2uWs2zKn4ZlHjaPXb83Ym4ZFi9htRPq5uc68R
         5SJT7XQROBDUeY3TBHtjwBTuQU1CbLCHYvnt9WhfItczA/nEV368DCotFvC+gWZjMHXC
         CUbKrb3rexLDXKvoZoEDViVdOLGMRCX70g0vXVoXBsbbnjGiTN6FeDgXUL2t11HyPHob
         G7SR8AvZXmK/gOwsFJHWMfkTFYRcCEdG1YJ/lV+U5C7GvVTUOyNb9HtbYn3dcEIRM7ag
         rrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NjsPCeTC6AUkI8iof6mArRIBPDUlUNHR5425CjSvoh8=;
        b=hv99Z1ygM02tQAuNzRxR06jn89XGWMgF6wwJnnftpb33xEJtETHzymir+LTTCv8Shq
         D8PAXRsOWTU9JBc55oYlweHZOR2srCU4Bqy1P3hlltEqkClM1VMg9PPmsQzl8gtRH/m6
         5AicmJQzKmYaKeRdMFZBs4WL8kl3vepGLqb7H+vcLaqZNJU3Y8yTJK9b6vKq6KSGhOD0
         jhxwXMnRjIwlVZvvr0XcqVq+rw59l2MjuQDwWP69OPuQObiSvNYY+7gYwmBDMBL8lhAM
         +NAGdN4vVETekKxtU9pMA1WenBw2BGxxUxaibfUX/+oOVuWm3rL8eFm13VSgvccboJHA
         1yAw==
X-Gm-Message-State: AOAM531NyLYtMimFv6jKIyquQOsDyPSkVukgaEWnnPk5vxQRxfxf4K6Q
        rwwD5w4nbvqjcqTWgBDOgw7yOw==
X-Google-Smtp-Source: ABdhPJysYIy8PYpFRsfsGIcf17EpGmomFVV2qtwyh3u9IcOWqh+a/JNbOKiOqv1WAIE3TsYPL25NIQ==
X-Received: by 2002:a05:6602:490:: with SMTP id y16mr1828196iov.162.1644071759212;
        Sat, 05 Feb 2022 06:35:59 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s6sm2472869ilt.16.2022.02.05.06.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 06:35:58 -0800 (PST)
Message-ID: <83c63043-dac1-2bd3-81ad-d591becf46a5@linaro.org>
Date:   Sat, 5 Feb 2022 08:35:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next 3/7] net: ipa: use interconnect bulk
 enable/disable operations
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, djakov@kernel.org, bjorn.andersson@linaro.org,
        mka@chromium.org, evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220204195044.1082026-1-elder@linaro.org>
 <20220204195044.1082026-4-elder@linaro.org>
 <20220204202336.67c95e15@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220204202336.67c95e15@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 10:23 PM, Jakub Kicinski wrote:
> On Fri,  4 Feb 2022 13:50:40 -0600 Alex Elder wrote:
>> The power interconnect array is now an array of icc_bulk_data
>> structures, which is what the interconnect bulk enable and disable
>> functions require.
>>
>> Get rid of ipa_interconnect_enable() and ipa_interconnect_disable(),
>> and just call icc_bulk_enable() and icc_bulk_disable() instead.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> We got a kbuild bot complaint here, for some reason off-list.
> Let me drop it from PW for now.

OK.  I guess the interconnect code isn't ready for COMPILE_TEST.
I'll investigate that a little more and if we can get past that
I'll send out a new version.  Not sure how long that will take
though...

Thanks, I retract this series for now.

					-Alex
