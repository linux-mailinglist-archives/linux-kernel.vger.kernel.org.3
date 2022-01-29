Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1C4A2D90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiA2KBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiA2KBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:01:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E826C061714;
        Sat, 29 Jan 2022 02:01:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i1so8326280pla.9;
        Sat, 29 Jan 2022 02:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z8+KRmkxtX9Pn8s0WmoIqShaNO0eoxFTiuBF3Bw+8cE=;
        b=RzzUdMVC6W4uiMeG42YF6kL1iK/Jq1ElWsmi5uBTYch+feiPjWG8JcJPE1fA6mHzEP
         1xsI9YKwFvp3UEmH0K9EHZjeTBFp5BLdPO091gT+Bgkrnk8FxdlU8Gs5P/iA0f4sSOv7
         G7mhLB/3FDnYDY2pkQ9ppPmuFM5FBiWhRak/gjtdc5Dc8sB0g65H/IdLeSmHIoIWg1yx
         mkTHJeQbObqwzXsIOPXcPxOxkwC2BaErbNo2p21yCqFgAoBjDyaUnDnfe0VNuHBgtGsr
         PfjzbvZBYnARZxwEG+zI+ZuQEtw0206fV8CNFqlXVDUADFoCmWVk6bDguuThxupsE148
         8x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z8+KRmkxtX9Pn8s0WmoIqShaNO0eoxFTiuBF3Bw+8cE=;
        b=35OPRINc6Rx92I6PsA5OBdWf8sO/c+h6cgP2eoW95dwrYNeCMeL5QslyV1H2R+GWag
         WweBuvdSOVTLZFZUrL3MOJzoDDWEu0126XCUHQxmQLI0FDTF41OPO4AKauaGuNxviLGb
         j44asEPphfoSFn/j/g8KVYWpic1/xEdV0GoghZAm4WmZSU7MQXqsjQ6xqH1suq3hg0+e
         Ou7M5WVfNKPB5CoJJ6Tzu2VuJL+wFtKYqYIiLeJmUzrzS1q+PCNQC5jZs9qx1KbxXxVp
         G6IDCeQBPt5RbndJZRin9nst8mfUD3ZR/kychZaSzF/cFKoJxCzn8qeHPnIuRK8XDO/5
         7BNQ==
X-Gm-Message-State: AOAM530OHlZfU6YQehJcKlbDG/rLYYXdEMi5YNPsTsP7vD1uvzBKux91
        m+iaME7DCnRuimJdPHLU3Qq4Z/zQXV0=
X-Google-Smtp-Source: ABdhPJyTq9X/ASMu7i/VjN71kzFwZATO8/myfii0C5pmCteXY0GjxHMwsz0cG6gkADjKYULhxZKDTA==
X-Received: by 2002:a17:902:d355:: with SMTP id l21mr11632323plk.128.1643450512221;
        Sat, 29 Jan 2022 02:01:52 -0800 (PST)
Received: from [192.168.1.101] ([166.111.139.99])
        by smtp.gmail.com with ESMTPSA id o1sm13040187pfu.88.2022.01.29.02.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 02:01:51 -0800 (PST)
Subject: Re: [BUG] tty: serial: possible deadlock in uart_remove_one_port()
 and uart_hangup()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
 <YfUPlYwoWpMjhvpR@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <88c4529d-c3dc-c168-f15b-7ea01ef334cf@gmail.com>
Date:   Sat, 29 Jan 2022 18:01:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YfUPlYwoWpMjhvpR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/29 17:57, Greg KH wrote:
> On Sat, Jan 29, 2022 at 05:34:05PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the tty driver in
>> Linux 5.10:
> 5.10 was released over a year ago and over 100 thousand changes ago.
> Please redo your check on 5.16 at the oldest.

Thanks, Greg.
I will redo my check on 5.16.


Best wishes,
Jia-Ju Bai
