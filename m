Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBC573DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiGMUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGMUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:40:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FE31219
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:40:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g4so11519760pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2izuw3b6CY3C2bpErtejUyL+XN/ca0tS3/ecJTr2WVg=;
        b=FS/DlMzuhgtjp0FHhoNu179kPvuygez5Dc/AJShi2OgnfLzoX5s05ZNQBfdDYCRJGg
         SWrcCQEMxT78B3DpYT1S3YeFk02QXViEEDJs8Fhs9yBAjROVYAhAWpeGbZot9RxyPr+y
         eUnRcHdX/ieWg6zojOCBfEGVwfUP2QO4StpNJnmPzHC5ZdtMwMyN1iq561V8gl/3KrfY
         Nyx8U8NxdY60ZFrMk5UMGQ8GXd+ydDVD0MYl3PsFefG2RF8L3yQr+qSYyoDzJgwsRiFG
         elj2/WYKbnsAPTUehRfq52gsV7XvvSInQCSbyNgx2KJj5KvCpQt+15S5beOcvs+/XpDC
         WQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2izuw3b6CY3C2bpErtejUyL+XN/ca0tS3/ecJTr2WVg=;
        b=JkaNeSxuB7QgdelpVRgMNy0jPS8tx5i4fmyI69OWCxuaUprGBAJycDgF9rjz+bFlYx
         xaR99+5bgZ3yGydV8tRuOimLc5O1PJ88zE3uHhBm8LEwF8RxzzzeGYv//VlLWiLPaaNE
         XgxWMe9EkTDW9uxa4nMk5w0sOiZrtbP2scW+yn7Phw91nTEEKr3LBRgYvh2AcRwHiQxP
         o8E4p/U0Qj9t1uFLln5zaAgpUKcVxFUUkDJC4fE1nTQOUkNwIFIktQg6DusA2w+f+Cph
         qg6lPupxdG6ak/vzGgSi5TJoXTD5kBQX9tcUWKy/vG11qJhQOZ7lEUOCwN0Urgt2aJzU
         WFMA==
X-Gm-Message-State: AJIora/5T6QYa03B8rLFJ4wKnZz8MZ4ggcwsNEyO/4eQ3uXNWNLoY0DZ
        ysFC7Rut7/a+NERCESkLs86X1B//aQU8dA==
X-Google-Smtp-Source: AGRyM1uK17h0xK/cQK0JEnNk5fEEoDCzli9QA+bpk8q7ElV5jpQTvkPfmTAKCTkF9cn76KYhdbTBMA==
X-Received: by 2002:a63:e552:0:b0:419:8dfb:386e with SMTP id z18-20020a63e552000000b004198dfb386emr4373697pgj.143.1657744844703;
        Wed, 13 Jul 2022 13:40:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b0016c2da4e73fsm9226144plb.106.2022.07.13.13.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:40:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
Date:   Wed, 13 Jul 2022 13:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc6
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 13:21, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> There may be a patch that solves that, but it's never been submitted to
>> my patch system:
>>
>> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> 
> That patch looks sane to me, but I guess Guenter would need to check
> ... Guenter?
> 

That patch is (and has been) in linux-next for a long time,
as commit d2ca1fd2bc70, and with the following tags.

     Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
     Reported-by: Guenter Roeck <linux@roeck-us.net>
     Tested-by: Guenter Roeck <linux@roeck-us.net>
     Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

So, yes, it fixes the problem. I don't know where it is pulled from, though.
I thought that it is from Russell's tree, given his Signed-off-by:,
but I never really checked.

Guenter
