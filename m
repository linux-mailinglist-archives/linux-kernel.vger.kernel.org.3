Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECA24878B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiAGONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239085AbiAGONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641564792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2L4YEi0aDoHLNeQF/we9qhhc3irCTkuMiMi3Iny+wp0=;
        b=RXWEO5kUivo8zJtXAcXpT2aKXarUSQer69rrTu+/tOFjSWSuxIpwsePdZ37R5b63KTbQpf
        t1DZA8HOhtEsjYEj3NcBweIU3jec3cYa0OYEDB6xOoM9iCgBUlA+mIuEIz01FzRU+9NGSM
        dATu6Z2qlAjGucELUaTB927AvrSVuZw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-mABfESBkPKKWZ6Eo-7ktJA-1; Fri, 07 Jan 2022 09:13:11 -0500
X-MC-Unique: mABfESBkPKKWZ6Eo-7ktJA-1
Received: by mail-qk1-f197.google.com with SMTP id bs14-20020a05620a470e00b0046b1e29f53cso4224594qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2L4YEi0aDoHLNeQF/we9qhhc3irCTkuMiMi3Iny+wp0=;
        b=TlHMGiWIQw1P7M1LJKoRAA8v4hrrw88nyfpdo7cTmTwcoBAOURvzJF+Sa4iGYckvvc
         AmLVeEThJE3vIJf+sjTsDktVPsSBe55mz+hwmZeBi6jw+2y5pJ7RLjYfNPe2MIqYYnj5
         8Ra1PjRCy1aLlMFZZF/Xd01rMxzt7UjypRa7VRo/KOCXAts5XZl25TLUJ2yHIg0Hm2P0
         cDy6ByBW8AaVt93O+H9Js3MexftexmFsrCalyWZ7wPWQDVQfjYMtIXyZl2fHXeY4hFKk
         i4rXZQcDVdkJSMu4okqY4hRFxKT28vkpsf8PwPxTnTkDdeXyCu84Pyb6DHXAMlpTRL6s
         PVLw==
X-Gm-Message-State: AOAM532CznurqS6a2AR5VWNjwj55qC/KuCv4UeA0DUb7B7nNo6Xge4JP
        XSMAbx+f1KC4BWWn+lDBlyJ6tIxbd+YxcERKS32uYxqR4g4CjO6JWUKK4fdwj0chCF50XdqB2z9
        E7TkQlnOC3fXEzZwMFYbOkFUW
X-Received: by 2002:a05:620a:4446:: with SMTP id w6mr44672986qkp.273.1641564790444;
        Fri, 07 Jan 2022 06:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxpJ4Sg3lAOJt40+fckPzVrfV1SS+laz3cGFmL/vYslY4erIf4p5P2MVtYSxieCu2+92/1+w==
X-Received: by 2002:a05:620a:4446:: with SMTP id w6mr44672964qkp.273.1641564790148;
        Fri, 07 Jan 2022 06:13:10 -0800 (PST)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id o17sm3509317qkp.89.2022.01.07.06.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 06:13:09 -0800 (PST)
To:     David Vernet <void@manifault.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz
References: <20211229215646.830451-1-void@manifault.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] livepatch: Avoid CPU hogging with cond_resched
Message-ID: <1f1b9b01-cfab-8a84-f35f-c21172e5d64d@redhat.com>
Date:   Fri, 7 Jan 2022 09:13:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211229215646.830451-1-void@manifault.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 4:56 PM, David Vernet wrote:
> For example, under certain workloads, enabling a KLP patch with
> many objects or functions may cause ksoftirqd to be starved, and thus for
> interrupts to be backlogged and delayed.

Just curious, approximately how many objects/functions does it take to
hit this condition?  While the livepatching kselftests are more about
API and kernel correctness, this sounds like an interesting test case
for some of the other (out of tree) test suites.

Thanks,
-- 
Joe

