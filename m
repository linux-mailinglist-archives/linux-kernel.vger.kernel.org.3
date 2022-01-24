Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2415449779B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiAXDLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbiAXDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:11:46 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57933C06173B;
        Sun, 23 Jan 2022 19:11:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z131so3001728pgz.12;
        Sun, 23 Jan 2022 19:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=7f6OMCJtFTLxl4ks0t6TGQoK7rbno+Jx4VF8y/4oupU=;
        b=FeJ/L4SK+FUvjr/nIxOEOd49QMgIaF+wpGxpx0wvt8vZMyU215NmKxwfOD9QgKnaeI
         uQjRyg0Blp9XeXdp2KmBK0OLU7so05kJBhkyf1tTkCWQT1ldiu71apMDtIGFhEKkM4Hp
         RmEbaakJSXYAsxf4Bu3/Cz8aWelX7eN7iUU8IXU3oXyvFPjeEGqGjNlw2cAbxATesyMo
         buFsYZEGQcbdTKJYNAg8/MmoQLpvJ2cAhs7j3UOSP5AHD7jhDQ1rv9wCW3ATpBHQU6kz
         X4VQXD1IllcvXLT3dX0fSlDhiVyOFq6yAz9i7dC/jptfYEFoykc88Mz7nAbLynJibqXn
         bJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7f6OMCJtFTLxl4ks0t6TGQoK7rbno+Jx4VF8y/4oupU=;
        b=gqM1enUiYPND4eT+I2AN7fXtZCHSvT/3pkmGRPq7RuOerXgvEXBbVzzEnAkZyd0yMK
         oyswnr1lqGj2ruoCQcpHmMlFgPFc60Lt3I7T1BGGyactweU4gEmfucXW5DGI4xlPPk7w
         0aFYEQLXcGKkv+Z+oND+Jt/P+gqTxxo67DkOkJmkEFs6WN/OX+Rb6Pa/6B2pGPy8xWnG
         LFU5yuFTxdKfWukYrX5R8sIZLu/8cPc90dB2J5R2mpVeKvOOVQBRRwH4Ss9Oyqb1vkpL
         /X1QOmPTWcyrv9zB862/DNAgRi37/Rx/p4HUYo6q0dz//tryM+WObkJL7zUZB16YMsLg
         n2OA==
X-Gm-Message-State: AOAM5324JCJ39RCGGNrSLhDVcreqLBPFLqGNH1/aqFBg4/pPUfNquQqY
        HxFGGBGKEHP4cgZnUnnaKaM=
X-Google-Smtp-Source: ABdhPJyLclQKoyYIZ6DiSIOXLFhv8CJsn0AAcNW26wdYTaBZ/q3zwKl159edSjZ1niURCx7biUzcCA==
X-Received: by 2002:a63:6849:: with SMTP id d70mr10468180pgc.116.1642993905086;
        Sun, 23 Jan 2022 19:11:45 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:5d89:db9e:1ac7:6fdc? ([2600:8802:b00:4a48:5d89:db9e:1ac7:6fdc])
        by smtp.gmail.com with ESMTPSA id y41sm1243112pfa.213.2022.01.23.19.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 19:11:44 -0800 (PST)
Message-ID: <0c4f392f-d18f-812f-b7d5-9184127c6fb7@gmail.com>
Date:   Sun, 23 Jan 2022 19:11:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 19/54] drivers/irqchip: replace cpumask_weight with
 cpumask_empty where appropriate
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-20-yury.norov@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220123183925.1052919-20-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2022 10:38 AM, Yury Norov wrote:
> bcm6345_l1_of_init() calls cpumask_weight() to check if any bit of a given
> cpumask is set. We can do it more efficiently with cpumask_empty() because
> cpumask_empty() stops traversing the cpumask as soon as it finds first set
> bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
