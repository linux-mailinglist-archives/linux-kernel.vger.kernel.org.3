Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53951DDB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443840AbiEFQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443818AbiEFQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:40:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270B60DA3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:36:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x23so6672454pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IxfEVaIASIXkXL8knX1ujN2Jx8pBG0nLkRjrhRCWVrA=;
        b=StYX5UPicuaF9n0QU9myK3qk5p3hczv1u9hC/nV0vUJuDQT5HdcagM7KezGdbpgHM/
         ObU2BvvQ/dPpoUVp3R/oQQ4jbYfufwT1B8VABslQ6hzNB3LIibSgMWLIx/e/C8P+r/iC
         2mZ6egIUiVnweCr8Jn9w6GA9EgKFha23YCwTzRtoMQl7lBb8maqmA1kA1dkQgqfuZrBr
         SsXy7B54ypA/G4EECcjIyPsyuum9NCFCqiZ1CVFojPooYkUmReUr/uhqLO5BxWPz+Bfl
         1arzZCQtQXzzuNZXwqKKxkf9gdjcFJlgCAJRxVCel7SWZ1nDE4c0hfMI410FlDabjAEo
         zOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IxfEVaIASIXkXL8knX1ujN2Jx8pBG0nLkRjrhRCWVrA=;
        b=3Jl4xbEdSwMeyA+JOpZCw87IT4H3b8+RvPeiM6ZbWtRK5ewmxPNPdyN3gfXAe36GJp
         HIB1gxQf9rWGj9iwPKCz7f79+z/xyyjqee83S4/H/Vv1F22HYHhfMdnfXuGzUb/gzrhe
         I8zlEaWW2illycOS4wOhbflJOwCnyLG0JXGnVqiBNMEFGfLSFTbatyvXG2wPASExy2sE
         Z5QkUjStFFFZrKVV5+Nr9a0VPC5hGY/pjhmlH8c+jjlyQa7z8eIx+9yWVppJhiz3k2lk
         7fH6Dxin8CasVTJMgni0D3xKv54S5Ld7RO2E+cdYhdRzZf69V1s9y76z9O3CRIABqNkK
         GRVA==
X-Gm-Message-State: AOAM530bza3LAXJDhOj7ZDzyw0jnR/4yg9Iwdwy+3E4LHgII/d/ab3T0
        c0MXz8zBbhXQaxy7fOeB8CH8arK6ty1UIw==
X-Google-Smtp-Source: ABdhPJwm7eczUYFnvi1topoIWQleGXBPYrCKhjccEQ4CcjUe1kwpr7NaCnWnS8JPl6j9DdL5rUsdVg==
X-Received: by 2002:a62:6d47:0:b0:4fe:15fa:301d with SMTP id i68-20020a626d47000000b004fe15fa301dmr4357053pfc.29.1651855013607;
        Fri, 06 May 2022 09:36:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0015e8d4eb210sm2097789plh.90.2022.05.06.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:36:52 -0700 (PDT)
Date:   Fri, 06 May 2022 09:36:52 -0700 (PDT)
X-Google-Original-Date: Fri, 06 May 2022 09:36:49 PDT (-0700)
Subject:     Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
In-Reply-To: <e3b6a7ed7dc612d7338bc95d8fbbfdfc@mailhost.ics.forth.gr>
CC:     mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-506fb56e-9288-4a73-b984-91a54e11081c@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 12:18:14 PDT (-0700), mick@ics.forth.gr wrote:
> Στις 2022-04-29 18:28, Palmer Dabbelt έγραψε:
>> On Thu, 28 Apr 2022 14:48:14 PDT (-0700), Palmer Dabbelt wrote:
>>> On Mon, 25 Apr 2022 23:11:23 PDT (-0700), mick@ics.forth.gr wrote:
>>>> Hello Palmer,
>>>>
>>>> Any updates on this ?
>>>
>>> Sorry about that, it's on fixes.
>>
>> Not sure if I just wasn't paying attention yesterday or if I'm
>> grumpier this morning, but that "RISC-V-fixes: " prefix is just a bit
>> too odd -- I know we've got a split between "RISC-V" and "riscv" so
>> maybe it doesn't matter, but even that is kind of ugly.
>>
>> I re-wrote it, but I'm going to let it round trip through linux-next
>> so I'll send it up next time.
>>
>> Sorry, I know this happened twice recently but I'll try not to make a
>> habit of it.
>>
>
> Don't worry about it, just let me know what works better for you, would
> "[PATCH -fixes] riscv:" be ok next time ?

That's generally how folks do it, but I just look for "fix" anywhere in 
the subject line.
