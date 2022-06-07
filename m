Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588F542286
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379543AbiFHBzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587878AbiFGXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6F2650
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:50:43 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h187so12750614oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e8ENrtIbjY7+ujNuh6Tj/bUga0MuFUeslU3izMPi9Q4=;
        b=5GhBg18NLPAgGo65m7wpJuE5gTzXpD4A+/+sktUFqmKGmrsnDqi5Ps9yBpdY8/7mfr
         WjlhWg4IGhf7pkmXuYjSU76/RzUbQdjfswBA8anoHeFzL+5EAcDV+8KusQxfT8bTmGe0
         OB3aXs7QSVDpQHWWahTgaGObb9eoDeY1tPORQ9M7j0b+XG5DZjxETgxJP8cLm15bCChg
         VxFWHxBhF9mjh+nfYPU4+Bp99/iSKDz9h3xQzveDxBLROCfSSSqH37SVH27JYvnA5x8o
         2trDNzCgr2VeAkpCmoXu1g1d96kCcxFgN+CfxjKF+YFuhROIiMlIYkpLov0yhhtqwilo
         Buww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e8ENrtIbjY7+ujNuh6Tj/bUga0MuFUeslU3izMPi9Q4=;
        b=P4y9NWfpo2kaZTs1RU5FfvpdCT6ai6+R9wqqf2h4E8VnENlXBsX6HGxT/emftJuWJW
         gGjKzdXjejvnWyG70dfQbXt9JTikrmxCllxe99FMfVlyw2Bv78hVGXThZUa8POCCsDEV
         HKp9HKB3axKUj7u7UuHyR6VxOBdqx0jX/K+6lJvyI1Zs4W1DPhtEJAV+07wkQVmRMsUK
         /mfMDJRKH0+r2CzFF1pwrBCnd0XaCtripoQgR/9LLpQDuU0tEOFvPtTKS+lPR/bALwI8
         2W0W4IF2V9SKga95DcrElXKOMzcLwiEmb/Bkp0AiGcFpmqSdAQFBx986gVgZ4GkMWc5m
         ZMgA==
X-Gm-Message-State: AOAM532oVRu7jl3iM9Zo463gPfKpBH3BLt5RaWtQnNiinNBIaVFCO8w8
        yVsd9ral/OJLZfA9YliQMTsnHA==
X-Google-Smtp-Source: ABdhPJyWEQTQO2zLzeUayJqxgrXyNOD6LJaalYRS/nAOx1ID2klaXccVepGxDif8A/xuMdNbwO+j7A==
X-Received: by 2002:a05:6808:308e:b0:32b:1f24:34c4 with SMTP id bl14-20020a056808308e00b0032b1f2434c4mr734588oib.147.1654642242919;
        Tue, 07 Jun 2022 15:50:42 -0700 (PDT)
Received: from [192.168.86.195] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id k6-20020a9d7dc6000000b0060bfb08741esm3409804otn.12.2022.06.07.15.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:50:41 -0700 (PDT)
Message-ID: <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
Date:   Tue, 7 Jun 2022 17:56:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220507013411.74277-1-bhe@redhat.com>
 <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 07:09, Baoquan He wrote:
> Hi,
> 
> On 05/07/22 at 09:34am, Baoquan He wrote:
>> LKP reported a sparse warning in arch/sh/kernel/crash_dump.c during
>> a kdump patchset reviewing:
>> https://lore.kernel.org/all/202204082128.JKXXDGpa-lkp@intel.com/T/#u
>> 
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse: warning: incorrect type in argument 1 (different address spaces)
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    expected void const *addr
>> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    got void [noderef] __iomem *
>> 
>> This warning happened when __iomem pointer is passed into fucntion
>> which doesn't expect it. Casting away the __iomem can fix it.
> 
> This warning was reported by lkp during one patchset posted and
> reviewing. Since it's not related to the patchset, I just sent it
> separately so that later code change on arch/sh/kernel/crash_dump.c
> won't trigger the lkp warning again.
> 
> [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20220408090636.560886-2-bhe@redhat.com/T/#u
> 
> Now the above patchset has been merged into linus's tree, please
> consider taking this patch.
> 
> Thanks
> Baoquan
> 
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Baoquan He <bhe@redhat.com>

Tested-by: Rob Landley <rob@landley.net>

Rob
