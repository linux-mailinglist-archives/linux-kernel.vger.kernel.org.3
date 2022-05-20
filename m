Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4752F546
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353725AbiETVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiETVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:44:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E39D4EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:44:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so8867850pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=po9hx/FFDA/6UFacoo9gPW8IQQNzUvQfbnbKwHyRNfM=;
        b=DDxHO5JVhIiDbdzCxdfA0tUrkzF7fKrRar/uMUsL1M7HdWh3OTpsIJ4fFwMJf/TKIy
         xGM5ZBcR/LSQnSGAXdweZtBtdAX9koFKgnM7X/4VUv+HqAfTch4uyhHnLrT4H2VfXxzd
         wNxTMH+58XJHuVAxzjV479+UZqDapJNvOYDW/bQNUgfi7gFSbIuj16W7xoZMJnxXCWQE
         XFDKVomXwOhErgEjEBbc199V+IgNXDMV0J5ZHfhtXOezugiMyMHfUdzVoMRek7wzECLO
         CfOGSEQ9QNtvlMlUw8E36E34uoM7LVV8SHNIJWZiuDkJYCPuVULjLI5SwbIzVSMYzbzy
         k+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=po9hx/FFDA/6UFacoo9gPW8IQQNzUvQfbnbKwHyRNfM=;
        b=wBYssEbGBKW504D72HE/egcfgZvM8+BPKS0+T78nd3RnakQVo55Zy47hXiTapI+KzQ
         /MU5nH4EwpY/P4r+nIyQDCoO01tOZ168LeNZMFtvTqhco8ehLPytOmTuT8ILXk9qUPHE
         iKo/geddV46Am9qjodJim1Ym68YOEriunUA9hl1VOso+YrIqdLXCSXHD8jgsPzlD619s
         giNbX5913wn836o0aWsoCSIx0RorFuCzE5whgFmTIkTdmWcYZmIWGBX0kjc3a4TWtLDV
         ENF/zJ04f5/NGuhkds+0RnK/wMU3fADLxifc0Nt1bqvVi/jj1ETdHCdAtY5TZOX42+E0
         7exA==
X-Gm-Message-State: AOAM532d1hUTxbK76FAlcYWUwM5gmCka/Ent1Yi/JVw6+6u8Sm0Dgx15
        W1y71aUqcwu4zEaMRtgy+fY=
X-Google-Smtp-Source: ABdhPJxqHG82SC/AOGlMVrEhzymuTl6S1INJ0XTrki35g6wNiT1n/spu0CIavILkAPi0IV+SxJwAtw==
X-Received: by 2002:a17:902:7087:b0:161:88a4:db37 with SMTP id z7-20020a170902708700b0016188a4db37mr11492775plk.131.1653083050851;
        Fri, 20 May 2022 14:44:10 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id mn2-20020a17090b188200b001df983f9a3dsm2357714pjb.29.2022.05.20.14.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 May 2022 14:44:10 -0700 (PDT)
Subject: Re: [PATCH] m68k: atari: Make Atari ROM port I/O write macros return
 void
To:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
 <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c2e45d59-4e0a-bf8a-e4db-ce3336fc9b05@gmail.com>
Date:   Sat, 21 May 2022 09:44:02 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

I wish I knew of a way to fix this mess for good... suggestions would be 
welcome.

Looks like you spotted the last remaining macros without a void cast 
here, thanks.

FWIW:
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>


Am 21.05.2022 um 02:52 schrieb Guenter Roeck:
> On 5/20/22 07:32, Geert Uytterhoeven wrote:
>> The macros implementing Atari ROM port I/O writes do not cast away their
>> output, unlike similar implementations for other I/O buses.
>> When they are combined using conditional expressions in the
>> definitions of
>> outb() and friends, this triggers sparse warnings like:
>>
>>      drivers/net/appletalk/cops.c:382:17: error: incompatible types in
>> conditional expression (different base types):
>>      drivers/net/appletalk/cops.c:382:17:    unsigned char
>>      drivers/net/appletalk/cops.c:382:17:    void
>>
>> Fix this by adding casts to "void".
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>> Survived m68k/allmodconfig.
>> To be queued in the m68k tree for v5.19.
>>
>> Removing the casts instead causes issues with functions propagating void
>> return values (return expression in void function), which BTW sparse
>> complains about, too.
>
> We live and learn. I didn't even know that this was valid syntax.
> I thought it might be easier to just fix that code, but coccinelle
> reports that there are hundreds of places in the kernel where this
> is done. Outch.
>
> Guenter
