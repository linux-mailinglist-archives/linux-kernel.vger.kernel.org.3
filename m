Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783757469C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiGNIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiGNIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:20:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6F2C662
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:20:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu1so1492933wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MmXvph4qDvcE5Q/0AKTxLYyhq1+ooc5wtUFLT+9WgMw=;
        b=AXxA3sTXL13CeHQ1gaU2jDTv2dIO4t75o05EmGnItoPCHs8hgKtQSnmlLXLPmHdx68
         Db1iwteFx7pvLBij4CxOyTDnq+xwtemVHcEWG1qlpWpJBUn4yay6h6XWxvmFhKLahxKB
         CPlaGG7r3zaPwo8kWI6nMdRwX+x5DkmB3JPzza/CI1PuRa9+TT3ztER11R8R8noqVebo
         PhBKGYYSIEYRWWSTCqzDieiYzOPgOQU6W1IHxOI8ushvsT8a1pGAqDT3/flrsqxhRgt/
         2lqwkzvygK9Pxw5FbtyvfZZBtEfndSHJcqmTiQmz0lt87018uB4o9NnMsi1v1Gi/5UAj
         Q7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MmXvph4qDvcE5Q/0AKTxLYyhq1+ooc5wtUFLT+9WgMw=;
        b=RMVd5QiF0cBSXUnN5vqgQcfi1UVp0YExIOn/TuC5i7CnuY5A7/gU3wtx2bC4a54OEn
         7yXPrXdUSaT9zV7Cem6295ompvotXrrN5S2WXNWPyhmArhFVYPzhqU4CCdJGbtHbq3nf
         BJNfM28HCvcmLIJCa6j1bcMm6vyr6vFLhYvc74sGXOfRtXAZ6JLlKHlksPqjX7Ju5qkW
         sKyO3/BbfEruG6uhfKsbq3qNCbPgduy8SF10Y8/zLXjB4DqEXJ/KaES2IBoxK73/eog9
         w7cy3zVMKgSP1TPRdRLAdECAuCM5c+v0epVtJiszxlhRqyT4toZqpGd5Hbp1kmKAl1k4
         8JDw==
X-Gm-Message-State: AJIora8p/Cs2XexA2RKV2PRwvSXuJIjAhTIqaQWb1sAmFFw1m0IKgdJc
        NJ/0VKwiLMhb+XXEMBU8P6aQrQ==
X-Google-Smtp-Source: AGRyM1ujy8Ec/0YaeU/0rX7cmiGaBgLZqnWgk7fcdvRM7Pa00bsiYqXUEbvCEmvXHoqJ5/ApZqD0gQ==
X-Received: by 2002:adf:e5d1:0:b0:21d:74fb:bb0b with SMTP id a17-20020adfe5d1000000b0021d74fbbb0bmr7238915wrn.385.1657786805815;
        Thu, 14 Jul 2022 01:20:05 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003a2e9bdfcf8sm4783656wms.5.2022.07.14.01.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:20:05 -0700 (PDT)
Message-ID: <ab363f25-0d35-c84f-ce11-c10eb32cabe2@sifive.com>
Date:   Thu, 14 Jul 2022 09:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] kernel/hung_task: fix address space of
 proc_dohung_task_timeout_secs
Content-Language: en-GB
To:     Conor.Dooley@microchip.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     sudip.mukherjee@sifive.com, jude.onyenegecha@sifive.com
References: <20220714074744.189017-1-ben.dooks@sifive.com>
 <aa78a638-a201-1a58-f168-f36a9f272fbb@microchip.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <aa78a638-a201-1a58-f168-f36a9f272fbb@microchip.com>
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

On 14/07/2022 09:10, Conor.Dooley@microchip.com wrote:
> On 14/07/2022 08:47, Ben Dooks wrote:
> 
> Hey Ben,
> Odd CC list here? I assume you're piping get_maintainer into
> send-email or something, but idk who is going to see or apply
> this patch! Ditto your other one for this file.

Since (see below) the script wasn't clear I just cc our management.

> 
> Might be worth adding some of what get_maintainer spits out:
> Petr Mladek <pmladek@suse.com> (commit_signer:4/4=100%,authored:1/4=25%,removed_lines:10/15=67%)
> Andrew Morton <akpm@linux-foundation.org> (commit_signer:2/4=50%)
> Rasmus Villemoes <linux@rasmusvillemoes.dk> (commit_signer:1/4=25%,authored:1/4=25%,removed_lines:1/15=7%)
> John Ogness <john.ogness@linutronix.de> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:10/90=11%,removed_lines:1/15=7%)
> Kees Cook <keescook@chromium.org> (commit_signer:1/4=25%)
> Xiaoming Ni <nixiaoming@huawei.com> (authored:1/4=25%,added_lines:78/90=87%,removed_lines:3/15=20%)

I think only akpm would be one of those, given no overall
maintainer I had a look and just use the kernel list and
hope someone picks it up.
