Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EFA4B4F86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352107AbiBNMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:00:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:00:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841ECFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:00:04 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u20so1521740lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1soBarvyGYEO2s/ygy+VNECztQ8yHUAApb2QrCHbwz0=;
        b=3CxAsSDTY4mfLl78v0BjFrbWZ1ZwflUPwWg8cKfolovebAEwpWx/Tf95FPm//pLUUC
         zuFCYYc2HcKLMWlp3C0cyobG4fZu7+fPiQPqDslEcDf5HjLEHBBP1gprQirjK1QISfAv
         I8Z64lqLPDnssmf/A1mAWqNsZWEZ9bIgmXPTe32rcRMK64uJvTc9dalE53Jh220+qccH
         QIKLDk9AcP/sE1k0JEFkow0JxnpUecxjnFkXBtBv9D/0Tni3VT45Aa7wL9BxlPQDvbpH
         nvW/RJ3wFvjFitwFDF78qJV7cTG5/HbCgtvEbyN6pFNJez+daQ2eBHQjZXphPTULSZRg
         uDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1soBarvyGYEO2s/ygy+VNECztQ8yHUAApb2QrCHbwz0=;
        b=JxXTvNAI+khCfWpwT8a1XfvV5u19p0prYT/kGYVOZwah2iD5NO20yL8E+d/KdJ5yjf
         FcVEHV8VbRY3K6TtcOf3I2aYVE1DPZro0ZAZ/C3pqMWW4xUU42NQEhELB9XDCxoY1OYG
         nVwXEwnhWwD/pWphhOKJn4wBpccpJk8AbybmMZ79aiCmREIfnA9W5tIbbGNtR/Z+Fpco
         QMk9BG5LFS+/9QtMpSjcQtc0aVqSh4LaOJMU5sfmZnUEYeLXOTnHp9e1crIUny9/6L8L
         FX4/fmOPw2UjQgpvi0MeDf7nkw+6WHX07gj/AUbHIYvkNxSRUpjwKTrWO97jBrt2rVdC
         1Lxw==
X-Gm-Message-State: AOAM531bXUAoX23KMqozTBwABpaoiIP6BXLeVprh+KTLIZxEALYo0wKz
        RTrh6vFcijeMOHAe5WXEWtpmrQ==
X-Google-Smtp-Source: ABdhPJzyQYnHIxZnKEtoj/FwNDQtqU+sRMQ3ROYdR8cEw34ogvBZWf6hZa2n/d8J3b7HljbygcPNAA==
X-Received: by 2002:a05:6512:3042:: with SMTP id b2mr10466866lfb.208.1644840002506;
        Mon, 14 Feb 2022 04:00:02 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id q16sm614047ljc.66.2022.02.14.04.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 04:00:02 -0800 (PST)
Message-ID: <8e341c5e-018b-f176-1b68-a412a9cf4906@cogentembedded.com>
Date:   Mon, 14 Feb 2022 15:00:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <YgpAfVVhkNljJhJY@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Adding more potential reviewers.
> 
> On Thu, Jan 06, 2022 at 10:43:02AM +0800, Jiasheng Jiang wrote:
>> Because of the possible failure of the dma_supported(), the
>> dma_set_mask_and_coherent() may return error num.
>> Therefore, it should be better to check it and return the error if
>> fails.

Indeed, most uses of dma_set_mask_and_coherent() in the kernel do check return value.

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
