Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E705350B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiEZOfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347657AbiEZOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:35:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF088DDFC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:35:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x12so1463239pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DcGYY1gUAoCGOqROjGKpSX/WERbZgJex3sobfu7tDjc=;
        b=Wvtz/iawvnD/4rod5DmNCpOZ0srmkZa+PRlM1WPCC/6D0mg4BWhqBg9PgWBlBFIZS0
         XOTovjg4ZQP37/YRHStGcVDeUCixfTzxPv+DgAaVpEXDxIpTkTLhPpiNgLUTHno022Im
         ytcg0H7NxeMGPhGlnpaNDROT/7pEoABShtCPkX4gLX006oWgCEShtlL33W+OeHG9KImC
         RmZEThI0Z6K0H2nvw7VGndPwcxPB6hqma7684x9ZoXRGOaPKD78EhQnm+GMU4CSrG1n7
         2pm0EJk+ufhqWgziMviHv2Ks+IRz3elRdyye8u3RlGmlLz1Tfa8sNLy0AOguAp5ywhRR
         eHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DcGYY1gUAoCGOqROjGKpSX/WERbZgJex3sobfu7tDjc=;
        b=6KYhbvlWfE2kCvggeeWpewdZTuUHK1H6lqJ6XJ3cE6zG/avU4SZBqXkT+FSTnEl3dc
         FZLC1bwfKlVJF0xre29B3moYV+I11gmIijPo7GNIi3jvvLgnub7ck4k5Oh7CbpRMFK2V
         ynZSRo0WZg6tKkA1KNBsBrmTukEjOyNmDaSaa2wsyL04ui2CaLHcsDFBFzg8AsPjR16D
         dUohGKskRKKkg/hZ9nlHOI+OYoWDcw6Rmy2hFG+NO80oxJ5zMeF9pI+MmRmpiWLjv1CN
         VqvpgmoR7ed4dvOK0+zXpWymvqaynmz8OPu5RaXmimSeXqDSGWm3f3SpTDmMHeb/Ht3w
         5XKA==
X-Gm-Message-State: AOAM530SEbkw0nTCA0Dvh/eOcBVD8ItRNZdsEl3pXT3rdomFTuXoOq8l
        LG3yJTJexJtbg+PxO3DIFRxqctkLoUVZvEzX
X-Google-Smtp-Source: ABdhPJw/05ijqm01zqD44l/X2JbdDHrgym4tLwBUMvtpd/2K1Lt9yhwC56ckToptzpbFhuFgt6MZzA==
X-Received: by 2002:aa7:91d8:0:b0:518:4f9f:966a with SMTP id z24-20020aa791d8000000b005184f9f966amr34135538pfa.61.1653575701440;
        Thu, 26 May 2022 07:35:01 -0700 (PDT)
Received: from [172.16.4.4] ([106.39.148.251])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090331cb00b001616b71e5e3sm1615489ple.171.2022.05.26.07.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 07:35:01 -0700 (PDT)
Message-ID: <03525b88-c61e-4459-a76f-b5dc7b1b7fa1@gmail.com>
Date:   Thu, 26 May 2022 22:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] irqchip/gic/realview: Fix refcount leak in
 realview_gic_of_init
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220526074348.23972-1-linmq006@gmail.com>
 <87a6b4mo1b.wl-maz@kernel.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <87a6b4mo1b.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/26 21:17, Marc Zyngier wrote:
> On Thu, 26 May 2022 08:43:48 +0100,
> Miaoqian Lin <linmq006@gmail.com> wrote:
>> of_find_matching_node_and_match() returns a node pointer with refcount
>> incremented, we should use of_node_put() on it when not need anymore.
>> Add missing of_node_put() to avoid refcount leak.
>>
>> Fixes: 82b0a434b436 ("irqchip/gic/realview: Support more RealView DCC variants")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Instead of sending these one after the other, why don't you send a
> series addressing the irqchip drivers in one go? That'd be much easier
> to manage and review.

Hi, Marc

Thanks for your suggestion, I will do that.

> Thanks,
>
> 	M.
>
