Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9046EEB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhLIRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhLIRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:01:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11357C0617A2;
        Thu,  9 Dec 2021 08:58:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so4314439plr.11;
        Thu, 09 Dec 2021 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cbygeKK+WC/TuK20PAa0qrK7y+fucAveGuqmqniVK10=;
        b=WO5EKWF28d6Po3hrxxFq5FnPMkY0X6jUPMdWZZCvzUK6aaGOxMgagyF0LpxCFxqMBv
         9RsfVsaeQwsWxQenw1BCmCDO6YBvsBQsEdCFKrpV38zFM6RBGPUzk46JdpcKLSdMD/oD
         lLBegovyWSTTNTgDtDYW74h+r8udKDKl1NMG4mOQKuoezJvBFNpOmvTVTYalafYaHWVX
         BYgbUE0pMPa6F6/Q0jUvErGY+ZzVwqsXcBvlOUEMEUBmOCYqBJVsyNuQDMYmuNtnaqCN
         8RsNJfBUbWLCfADPCBQYSiMIbM2DsmvMGzdA6rs5jnXMKQj9QTEhg1cAPyMtlzc/5qn4
         PrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cbygeKK+WC/TuK20PAa0qrK7y+fucAveGuqmqniVK10=;
        b=PmQmIsz2xdKLR4JuAIYLAaPs1oPDQz1V5sdpYnjLZbRSCTO3Lh/thvMNRFS8baaH6f
         Mu3rsAwL6oKgPwpovdQFaKeuImhsfbOL3LbsXyc8rTjldSQ8ouHZVGQYpkxzoFJ+DJTm
         1BIwJGHFDC/Dj23P8zv/IW2+cIeXzxOuBVZFMPzvOqY/AcPoG0cDTVFqMXikosOpaZcM
         aExluoaNhtqwMcOhHye3R9TClzv3UrSumbuGUj+Lbuujhgx4f1CUE4ksATA0I3vwXEeH
         ynS+cLZ6JCKutEqmNXwrVtxMxDE7mdcD/Zrz62Orlp3cZxFtwHymM0aEIT7Cp6SUyQju
         ZtDw==
X-Gm-Message-State: AOAM531bqTXpkZ/3mEFd1y+CL8OcC9WDe5nDogienDqSKfiH9R3BEHv6
        cGwPpz3m3HkPMOu5QFzbqwqFrsTEkOc=
X-Google-Smtp-Source: ABdhPJzIcWZVgxnZpvIjvKN7PrRp3ZA0tEskNb4UgA2QzQFILM1AWR+MiPMmOzhujnk+jWNdisxY3Q==
X-Received: by 2002:a17:90b:fd5:: with SMTP id gd21mr17406975pjb.37.1639069089123;
        Thu, 09 Dec 2021 08:58:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mp12sm10303835pjb.39.2021.12.09.08.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:58:08 -0800 (PST)
Subject: Re: [PATCH] irqchip: irq-bcm7120-l2: add missing put_device() call in
 bcm7120_l2_intc_probe()
To:     Qing Wang <wangqing@vivo.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1639052506-23462-1-git-send-email-wangqing@vivo.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c27772d2-45d6-50ec-0010-02af1367ec55@gmail.com>
Date:   Thu, 9 Dec 2021 08:58:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1639052506-23462-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 4:21 AM, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> of_find_device_by_node() takes a reference to the embedded struct device 
> which needs to be dropped when error return.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

This has been submitted already with:

https://lore.kernel.org/lkml/20211109055958.130287-1-ye.guojin@zte.com.cn/
-- 
Florian
