Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE6574C78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiGNLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGNLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:50:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928A5B7B5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:50:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v7so1666837pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CQZPk9dE9vYuoTW7LwGDpOSxYgTX5Xxgk1zVbgFcnVQ=;
        b=tz/MwjMQ/m7258fqxRZ0gowkQE7RWkAGL3eAPYbDgVdpBAiTy1iI4T2wXlOWzC7Gfv
         YZYHIDiCdd8nMKdNTmNI2XPqwybjPeP3ZHWQ8YqK/sgi0sIYzvLdAQlGYv+hdOWdg5Fh
         5wo623uQWse4OGljHhPFVkj8COG89DlNG5I48Ap1s/r03AEcIr5lpsfDA33/fwbb71LH
         yDNmwmBJE8ZqpTgoxkiHc/cxebT+eFhrh4jcM3Ty3DD8LyiAt8f/62inEaDKuoMwT4j1
         3ETvJHzEFbBlkwXBQFhnP9ynw3TuQLhA3Jw/G4yNYQEWECJUlJaiIzQ9A3vxeGESLY6n
         awfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CQZPk9dE9vYuoTW7LwGDpOSxYgTX5Xxgk1zVbgFcnVQ=;
        b=NhquwA3Yymbo4S+TY0h0/hAA0l9XKVFyqWGAHK2Qp01c/oDSBsPsdDXsag9UagU+oq
         7S+W2tUn6J0mnJHf3mY7nGJ8MoCQSFjidMlsapJTvUENslNfpvaCuJPbSHaL6No2RjOy
         wxNXBm2Fg0gU3cvwH8dfeHM+RMK9ZaeQ64+Wpgi0053MSYxSc2UoeYUd2B/tuFGRagXF
         PcC2fRlwUjWLmHFOQ2LlWwinucudBj7RaS7Jfac4wR+gO6OclPBQraIzxku3LdKaYle7
         JeFwdp0ozuwd0mD8pzYPwB8xmpTM7tFBQvmwUsuqC6EmTGdYJYWNUeFkf1pj0MMMN0BR
         G5xg==
X-Gm-Message-State: AJIora8wxOHO99Mwk9o0FUnBBgjLFeDGM4yRZyG2Y2Re5HIpGkaZkTGT
        rTZjiZcDclxEgay3Mfez3iinQg==
X-Google-Smtp-Source: AGRyM1vQKnkknu4D9h3B/sMfSeRdwlOZ5WFUcA/2XZOidXB+kiGFdh7lPr/KliM3+GLQhLI5vHxTgQ==
X-Received: by 2002:a05:6a00:23c9:b0:52a:cedd:3992 with SMTP id g9-20020a056a0023c900b0052acedd3992mr8061303pfc.43.1657799443278;
        Thu, 14 Jul 2022 04:50:43 -0700 (PDT)
Received: from [10.4.227.66] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s1-20020a655841000000b003db7de758besm1172938pgr.5.2022.07.14.04.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:50:42 -0700 (PDT)
Message-ID: <6541e3d2-69cc-2970-c7db-fde4d64a2f09@bytedance.com>
Date:   Thu, 14 Jul 2022 19:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 1/2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-2-zhengqi.arch@bytedance.com>
 <CAK8P3a2kgVikkKBZLa31XUopEFa9ykLS=qxiH=qiFD8HtUvw=A@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a2kgVikkKBZLa31XUopEFa9ykLS=qxiH=qiFD8HtUvw=A@mail.gmail.com>
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



On 2022/7/14 19:32, Arnd Bergmann wrote:
> On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>> are still handled in the task context.
>>
>> Since any call to local_bh_enable() at any level in the task's
>> call stack may trigger a softirq processing run, which could
>> potentially cause a task stack overflow if the combined stack
>> footprints exceed the stack's size, let's run these softirqs
>> on the IRQ stack as well.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> This seems like a nice improvement, and this version addresses
> my concern I raised on the RFC version.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your review. :)

-- 
Thanks,
Qi
