Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0352F132
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351991AbiETQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351966AbiETQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:59:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B517CCAF;
        Fri, 20 May 2022 09:59:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q1so640899ljb.5;
        Fri, 20 May 2022 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJBvfnPdu1UiTW9AZ53z5eKxcWzHzbt7TdcvRrJ+xrM=;
        b=dkqbPtagJ50bTifxcJz+BjDX3UMR1q9Rv0Dx/wy3MLDYyXjVC1oQAnpTrvMc6A6790
         iyr37Su8CaNAOshghUpCPIJ7oVT62eoRpvvD6bYPLSRNqSI3pBVLzdzX9hlujm6XxEbN
         LLhPZ4/5r+fhlHCdD0NUe0xOi1T/GPOmu4eHTlQXeaW7dx5bK0sW6mY258CYgeNiXJl0
         w6WpRj7/qBAF/ouz0wTu7lzY+3DufRwQj/OEPXh0OY61tJKzyDYvLDoa/09w1fei1jmy
         Tkj0TX6RM39QnP4wYMcOikjksaqZsrB+OqxaYkz2tDCYpuGF90kU9RJ4bH0pFA0BpqZV
         FNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJBvfnPdu1UiTW9AZ53z5eKxcWzHzbt7TdcvRrJ+xrM=;
        b=Y+SZbVSYnF8llNMHO1m07MmkP+Zi1QgBqnpUZkBmkaCbfV5+TKkISEIT3hJj14KgTb
         nJvYD42CTPkPRbzvPRL9TR6yIfPW543PLP2q+m9cPBqPXNe2kp3QRf4iMJdyduO12BFw
         0JgVdsemJfzFQlrbupAooo6LTfUB0ujFY62FUiaVUVx0TBAyBistvtm0JbbC655Hs0rB
         R4J/SZ9vFZ6MyqRQEfmojg1zi7fB1+iHPeI5nmH3m1zP5I28gicGr7y7PK0HfcAvS+I4
         9XEPHdbttddJyOHfkEaenI3tEOGVyDW2dQat180ochlOZvq7menCPkieG5/ttFjryQAW
         Sh7Q==
X-Gm-Message-State: AOAM530jUkWZAFKlErypC/2Eqv9s6K4DHAHUNTMt4ZfWrXokdveEJn44
        34t1KbKllLFNJbNJY1IGx+ADjztpHZcF9w==
X-Google-Smtp-Source: ABdhPJxugmtcRscQPRqH9nkTE5Liog1rBQNicFNTFbW6maM6RQW8ZgKc5kuCHY9QRsVRbU34NqNK7Q==
X-Received: by 2002:a2e:bd8b:0:b0:253:cd2d:3098 with SMTP id o11-20020a2ebd8b000000b00253cd2d3098mr5980697ljq.234.1653065949641;
        Fri, 20 May 2022 09:59:09 -0700 (PDT)
Received: from pc ([104.28.198.246])
        by smtp.gmail.com with ESMTPSA id q15-20020ac2510f000000b0047255d21124sm726096lfb.83.2022.05.20.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:59:09 -0700 (PDT)
Date:   Fri, 20 May 2022 19:59:05 +0300
From:   Boris Lysov <arz65xx@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     arzamas-16@mail.ee, mturquette@baylibre.com, sboyd@kernel.org,
        matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: Fix unused 'ops' field in mtk_pll_data
Message-ID: <20220520195905.7ff9af3b@pc>
In-Reply-To: <c2f347cb-b887-d67f-d7be-569fbd2660d8@collabora.com>
References: <20220515122409.13423-1-arzamas-16@mail.ee>
        <ead37cb0-c841-df1a-ca10-a396b5e9951c@collabora.com>
        <20220519222755.127ebbb8@pc>
        <c2f347cb-b887-d67f-d7be-569fbd2660d8@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 10:27:45 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 19/05/22 21:27, Boris Lysov ha scritto:
> > Hello, Angelo!
> > 
> > On Wed, 18 May 2022 14:15:13 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> > 
> >> Il 15/05/22 14:24, Boris Lysov ha scritto:
> >>> From: Boris Lysov <arzamas-16@mail.ee>
> >>>
> >>> Allow to specify optional clk_ops in mtk_pll_data which will be picked up
> >>> in mtk_clk_register_pll. So far no already supported Mediatek SoC needs
> >>> non-default clk_ops for PLLs but instead of removing this field it will be
> >>> actually used in the future for supporting older SoCs (see [1] for
> >>> details) with quirky PLLs.
> >>
> >> { snip }
> > 
> >> Also, if it's just about a bit inversion and a bigger delay:
> >> 1. Bigger delay: Depending on how bigger, we may simply delay more by
> >> default for all PLLs, even the ones that aren't requiring us to wait for
> >> longer... ...after all, if it's about waiting for 10/20 *microseconds* more
> >> { snip }
> > 
> > According to the mt6577 datasheet the largest settling time is 10
> > *milli*seconds for AUDPLL [1]. In my opinion this is way too much to be set
> > as default for all mediatek devices.
> > 
> 
> { snip } Perhaps we should look into that AUDPLL matter later, as audio is one
> kind of functionality that you want to enable in the immediate term
Not gonna lie, I also though so about TVDDS, too. Because considering how
unimportant AUDPLL and TVDDS are for basic system usability, I'd rather not put
effort into them at first stages. Afaik, TVDDS is barely used even in the
genuine downstream code!
I just didn't know if it would be okay to make partial PLL support. But now...
> The top clocks should have most of the PLLs, but you can avoid adding some
> that are a bit problematic, such as that AUDPLL that you were talking
> about... in my opinion, at least, it's not a big deal if we add these PLLs
> later when enabling more functionality
...I understand, thanks!

> - I agree it's a nice to have, but bringing up the platform comes first, and
> this means the top clock controllers and eventually multimedia (to get a
> display up!).
> { snip } Try upstreaming the top, very necessary, clocks to achieve a full
> console boot, as this gives you a good chance to start landing some solid and
> critical base for your platform.
In case of (at least some) mt6577 devices a full console boot is possible even
without the clock driver thanks to the work preloader and Uboot do on that
matter. If you open https://github.com/arzam16/linux-mt6577 you will see that
with fixed-clocks in dts it's possible to start a framebuffer console and even a
simple game!
On the other hand, I believe implementing a proper mainline clock driver is a
must for further development. Hoping for the ancient UBoot filled to the brim
with proprietary components to do all the work is not the best idea.

> >> 2. Bit inversion: that can be solved simply with a flag in the
> >> prepare/unprepare ops for this driver... and if you want something that
> >> performs even better, sparing you a nanosecond or two, you can always
> >> assign an "inverted" callback for managing that single bit;
> > 
> > Not all mt6577 PLLs need bit inversion. 2 PLLs follow the common flow (set a
> > CON0_PWR_ON bit to start). 6 PLLs set this bit to 0 to start. And 1 PLL
> > (which is actually a DDS) needs to write a magic value to specific register
> > (in apmixed region) to start.
> 
> That's interesting.
> { snip }
> The top clocks should have most of the PLLs, but you can avoid adding some
> that are a bit problematic, such as that AUDPLL that you were talking
> about... in my opinion, at least, it's not a big deal if we add these PLLs
> later when enabling more functionality: that will give you the chance to add
> the PLLs that are in need of that "enable bit inversion" logic which, from
> what I understand from your words, covers 6 to 8 PLLs.
To put it clear: there are 9 PLLs in mt6577 in total:
1. ARMPLL - write 0 to enable (need bit inversion), important PLL
2. MAINPLL - write 0 to enable (need bit inv.), important PLL
3. IPLL - write 0 to enable (need bit inv.), for "image sensing" subsystem
4. UPLL - write 0 to enable (need bit inv.), not sure what it's for
5. MDPLL - write 0 to enable (need bit inv.), for "modem" subsystem
6. TVDDS - write magic value to enable, for TV-related IP and HDMI
7. WPLL - write 1 to enable, for "modem" subsystem
8. AUDPLL - write 1 to enable, for "audio" subsystem
9. MEMPLL - write 0 to enable (need bit inv.), for "ddr" subsystem
As you can see, the most important PLLs (ARM and MAIN) need bit inversion and
is why I decided to use 'ops' field. 

> That's a lot, because that makes you able to
> add all of the clocks that are in infra, top, mfg, apmixed: like that, you're
> also getting most of the IP up (timers, i2c, spi, mtk-sd for your eMMC/uSD).
Here's where it gets interesting. Afaiu mainline kernel expects me to provide
all the info on the clock heirarchy. In my case it's almost impossible to figure
out any relation between the PLLs and MUXes and clocks. mt6577 datasheet
doesn't have any meaningful clock hierarchy diagrams unlike more modern SoCs.
The downstream code works in a "fire everything up on boot and don't care" way,
it relies on undocumented registers for clock management and also doesn't have
any sane clues to figure out the hierarchy. Even the frequency of the core
fixed clock is not known clearly - it's either 13 or 26 or 260 MHz -
downstream code doesn't give the exact answer (my mainline kernel works fine
with 13 MHz, though).

This is going to be *hell* to implement in mainline. Related: [1]

[1] https://www.spinics.net/lists/linux-clk/msg65449.html
