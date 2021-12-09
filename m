Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71CF46E8E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhLINRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhLINRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:17:45 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7408C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:14:11 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so5057264pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=4WGL4ccmA0pO2Hx3UfijQbiapb8oWzN9kFKTdy3330A=;
        b=LZKFw+NFq2TYrJZcq8ffZXrXphuL++v0N/ht3MKFb9VS+Gcsm0SW6yHXDaaR/heb0F
         DE5VykkAXULXRtOb0Lyyp9KFCN1gZxd6kwLHThIrIWag2yAQEeZ2hTRv7PQSJWk3w+wT
         zZDpgkIooszphpt4bz25byxWXdLupD6Z4LkSqJ/uBZ8fmchj65rwWKm7sI91oRLUeltH
         Juhj2kVwKWnjuLsjL8KB5RmcFPdLwgsuidJqJDoI2o0cjx/U7I4weXTGiPI7OveeqnKX
         hsZt9V+0gVLjUwjtPy8r4z3+/mCa98cvBqgzncANVA9R8MAHZ82l3fyNfZ1Ie3iQt8rt
         ha/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=4WGL4ccmA0pO2Hx3UfijQbiapb8oWzN9kFKTdy3330A=;
        b=F+BO82DwI9sND0uMXlKYaaqMtA4AKBp45Q30cPzzhKg/ec5ESI0A/Bu5IvQ6dU1qWg
         Dq0/u6+Hq8PJiJTlu3sPEGOmyZHHnm/atdYsj8fe6tMc8Ga8BQ0kNFx8qVPRKHk0o+Es
         7Ce6yg1+vdnjah7jo1ieCG1efhBnOw3va85AVHuokYcZoSD3YK84wYMSQDN1+/+M2xMS
         Ez7lhTCWJTzf5unuMX/TV90+jqZ/33mtiDlrpjQZkhnbF/1ojeC2ytpYzyTYypodJYMA
         1Abxf5QGFJ1wj6XO1T9qFfgfZyttiTfxKDNKSS+qacadFHcv1HgbBWcRErmA9YLv/Rq5
         4dAg==
X-Gm-Message-State: AOAM530Q3Kv4QbAo6z2m1t5RmIuqn1aVbw09NWm4H5WjIOjG0AQ8OG2Q
        j2ByPoXbO+WJt4FSm2NLbGdAX5EuR9dTy8IE
X-Google-Smtp-Source: ABdhPJxBFPYluJRzV3dctEOPxxReCR8tJbqMgSt1q1oZ95O26VLCAu0ou5adBndmiNs0hAUWlbDbqw==
X-Received: by 2002:a05:6a00:2387:b0:49f:af00:d5d0 with SMTP id f7-20020a056a00238700b0049faf00d5d0mr11691395pfc.1.1639055651362;
        Thu, 09 Dec 2021 05:14:11 -0800 (PST)
Received: from [10.200.203.229] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id j16sm8480051pfj.16.2021.12.09.05.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:14:10 -0800 (PST)
Message-ID: <b32b91a9-7cd8-e24b-b608-8bf55a8abe16@bytedance.com>
Date:   Thu, 9 Dec 2021 21:14:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
To:     john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        yanghui.def@bytedance.com, brookxu.cn@gmail.com,
        paulmck@kernel.org, luming.yu@gmail.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
References: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

How about changing clocksource_watchdog from classical timer to hrtimer?
hrtimer is more accurate and stable, and makes it much easier for us to 
deal with misjudgments.

-- 
Thanks
Gang Li

