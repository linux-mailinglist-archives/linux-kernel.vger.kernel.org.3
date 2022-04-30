Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6523515992
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382002AbiD3BW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiD3BWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:22:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17708021D;
        Fri, 29 Apr 2022 18:19:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i1so2375639plg.7;
        Fri, 29 Apr 2022 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IbTkL+PKsaZcJ0raDuP0S5EWrvaEu0x3ypUjmK3lkS8=;
        b=iHLBiUDEjrdIDKI6r3SYygsWK4PtHbZDZ1SnDLW6YF4z4+qbVBhPnNHG47ozsigie6
         WMuOWUFYMhxV3fFeY5oQE+v/VwtGlM1FwXDxlL4SYYXPUgvR1o8w9TTqp5Dj3Mjf9gEd
         rIy1eo1N4UANbNnaMFv/3/51iaaB75nmVZlie805eIYlev23WiDvEzlGI1PQQOvcQHyo
         yfSOopb72Z6wjuJUEckMTicnKHWrNDCFfaHK/F2nfCmphJjdFT3BWWRbmIpl1Vln/Z0C
         TL28fiRtptNGkGaQRJD89pp6Tr4NDAT2KGV1Vu6SG4wsn0Q6cw2V+HB557/cSEHyjmcW
         lgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IbTkL+PKsaZcJ0raDuP0S5EWrvaEu0x3ypUjmK3lkS8=;
        b=72ZIY3I0uYUIsVubc8ovUYGIGbouGcmOGG0yvvcWnSnPuzMd5A1DXePLeImZydk1cJ
         HVL3zbWo1rRvJ0PFRppc9s7ukPNrm4BJVdpKYybxixAdNR7Q+kH7SMXTgPQ6u30GBvaS
         eCwAD4uGwDLQGDqCHB7gc7jx0J/Br/8GYkrjpR6zzK2LSe4D0+C0Hc3JnXNBBw6I6DqV
         TSQpevNV75J0CJF1qQbbRK4eLhZCHHjncJgVXwZXsmzhWlIalJH29vtPGKVZguwwl2oL
         19wZr01y6wmHaTjt4AGpQHLXttdHgdIM106nNuaveraL3v3TwtgokDTa4mDlzj92d1IW
         wivg==
X-Gm-Message-State: AOAM530zsMzQtMBxkD46vJV9HFQLC9db/S5tLbZc7iGiqeO9BJERGbjo
        F1Wch36/7KFyhnYwMC3AjIHOTpjRtWc=
X-Google-Smtp-Source: ABdhPJwn7ooL9K9Cu0D1h9m0kR4zy6mNCc6whTETZFkr2MwPNrmkkUcxG/VEO+78KDJnzTDCucs/UQ==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr1922669ple.157.1651281545282;
        Fri, 29 Apr 2022 18:19:05 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b0015e8d4eb207sm219447pls.81.2022.04.29.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 18:19:04 -0700 (PDT)
Date:   Sat, 30 Apr 2022 10:19:03 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 11/17] openrisc: account for 0 starting value in
 random_get_entropy()
Message-ID: <YmyOh/YbgGJ3DK79@antec>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
 <20220429001648.1671472-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429001648.1671472-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Apr 29, 2022 at 02:16:48AM +0200, Jason A. Donenfeld wrote:
> As a sanity check, this series makes sure that during early boot, the
> cycle counter isn't returning all zeros. However, OpenRISC's TTCR timer
> can be rather slow and starts out as zero during stages of early boot.
> We know it works, however. So just always add 1 to random_get_entropy()
> so that it doesn't trigger these checks.

Just one nit, you might want to qualify that this is related to simulators/qemu:
 * "However, in simulators OpenRISC's TTCR timer can be rather slow..."

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v6->v7:
> - Add 1 to cycle counter to account for functional but slow-to-begin
>   counter on QEMU.
> 
>  arch/openrisc/include/asm/timex.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> index d52b4e536e3f..a78a5807c927 100644
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -23,6 +23,9 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> +#define get_cycles get_cycles
> +
> +#define random_get_entropy() ((unsigned long)get_cycles() + 1)
>  
>  /* This isn't really used any more */
>  #define CLOCK_TICK_RATE 1000

Thanks,

-Stafford
