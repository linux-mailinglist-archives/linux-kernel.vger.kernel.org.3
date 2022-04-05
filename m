Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F257B4F211E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiDECWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiDECWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:22:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2231F71A2C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:17:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id b188so11875809oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IYK3K9Qzm8D7qoFu9FVNO7TkU85kFi6QdHt/GErFbBQ=;
        b=IQD+x35fF25Pz8QsjrzaiGqr+OrPtU2AEXaT+5jVjPtiyLsJYfHE07knAkxhy0OkK5
         SSBbSCqNCoRFSZ0ox+W10cBtf5dmrX4rwZdYnEEOw/N/4sNbJEa9qrgwGRwhxbIco8GY
         IKK8KtkHlZR+0DjZ25Vvm+vF4wedAP1E0rs0EQKlBriCV7zuNT0wZJjszp5yq5AFv2co
         nJpZc7HAovnqs4v1+UA791eiDoHZkKqYndP6gy88IwUUoPo9+8esFVmVrXrx4i1Vm6XY
         OwJyg41wJJeYytAwrW1ajYcZvDUE3TR2PX+w+ihYayWZy3xNote9eGFH4GHAIfewCcYR
         Mp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IYK3K9Qzm8D7qoFu9FVNO7TkU85kFi6QdHt/GErFbBQ=;
        b=e1W5g/RbihybHh7lNb5mKqJ1JR0KH0xlbbU5yIUhOyqzK9VN2r3+T3rQLpH2SlTP04
         caOD5DSKDqc1zDeHVW9Rdx4IxUJWIrKCVmY86q99XGaHcD5gQXRq8TRFGehwUouhzv0/
         G8inxAJYmMTMngFDbpGO+zjJvwgx3ZccYcRxKbde1WIYwr/WsPzYh/5lfcZI99lxjiJj
         X3Krrsla0ldPse3s0pDLweXX/ddadWth4bAkqDSOZlMjgvuAf3MdaR8zNhfeIJFAPRCW
         i8C01tWTCFbCXi+qX3gl/Quk8CJQsifAY6UPTQLib6bgokXOMcaW16k5faUZffHYQ7cL
         Ay3Q==
X-Gm-Message-State: AOAM532Dodtg14/0HQSw3CuSHE+UBusvwrQvUl0RNxUklMu+LqjuIIi+
        xBakRncSVmTIkMPYTQlrDXZEqA8ljyzPMg==
X-Google-Smtp-Source: ABdhPJzml31dkYouSC4L26dpRKz7DxXfFMkmyars/Rma+Ccuzdev21G3/VPOlitgjCa7LjCLFR5vsg==
X-Received: by 2002:a17:90a:7d10:b0:1c9:7939:c70 with SMTP id g16-20020a17090a7d1000b001c979390c70mr1051208pjl.203.1649119389101;
        Mon, 04 Apr 2022 17:43:09 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b004faa5233213sm12619660pfi.101.2022.04.04.17.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:43:08 -0700 (PDT)
Date:   Mon, 04 Apr 2022 17:43:08 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Apr 2022 17:43:07 PDT (-0700)
Subject:     Re: [PATCH] habanalabs: Elide a warning on 32-bit targets
In-Reply-To: <YksIkY0l8k7mmnzJ@kroah.com>
CC:     ogabbay@kernel.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        osharabi@habana.ai
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-2927288f-0f89-4f03-b3a2-35b92fd9d51e@palmer-ri-x1c9>
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

On Mon, 04 Apr 2022 08:02:41 PDT (-0700), Greg KH wrote:
> On Fri, Apr 01, 2022 at 11:36:53AM -0700, Palmer Dabbelt wrote:
>> On Fri, 01 Apr 2022 11:13:48 PDT (-0700), ogabbay@kernel.org wrote:
>> > On Fri, Apr 1, 2022 at 7:41 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>> > >
>> > > From: Palmer Dabbelt <palmer@rivosinc.com>
>> > >
>> > > This double-cast pattern looks a bit awkward, but it already exists
>> > > elsewhere in the driver.  Without this patch I get
>> > >
>> > > drivers/misc/habanalabs/common/memory.c: In function ‘alloc_device_memory’:
>> > > drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> > >   153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>> > >       |                                                 ^
>> > >
>> > > which ends up promoted to a build error in my test setup.
>> > >
>> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > >
>> > > ---
>> > >
>> > > I don't know anything about this driver, I'm just pattern-matching the
>> > > warning away.
>> > > ---
>> > >  drivers/misc/habanalabs/common/memory.c | 10 +++++-----
>> > >  1 file changed, 5 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
>> > > index e008d82e4ba3..f1fc79c1fc10 100644
>> > > --- a/drivers/misc/habanalabs/common/memory.c
>> > > +++ b/drivers/misc/habanalabs/common/memory.c
>> > > @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>> > >                 for (i = 0 ; i < num_pgs ; i++) {
>> > >                         if (is_power_of_2(page_size))
>> > >                                 phys_pg_pack->pages[i] =
>> > > -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>> > > -                                                                               page_size, NULL,
>> > > -                                                                               page_size);
>> > > +                                               (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>> > > +                                                                                          page_size, NULL,
>> > > +                                                                                          page_size);
>> > >                         else
>> > > -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
>> > > -                                                                               page_size);
>> > > +                               phys_pg_pack->pages[i] = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool,
>> > > +                                                                                         page_size);
>> > >                         if (!phys_pg_pack->pages[i]) {
>> > >                                 dev_err(hdev->dev,
>> > >                                         "Failed to allocate device memory (out of memory)\n");
>> > > --
>> > > 2.34.1
>> > >
>> >
>> > This patch is:
>> > Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
>> >
>> > Greg,
>> > Could you please apply this directly to your misc tree and send it to
>> > Linus at your next pull request ?
>> > I don't have any other fixes pending for 5.18.
>> >
>> > For 5.19 we will do a more elegant solution that Arnd has recommended.
>>
>> Thanks.
>>
>> Assuming this is too late for rc1, would it be possibe to have it in
>> something I can take into my fixes/for-next without too much diff?  I put
>> this on top of the offending commit with a
>>
>> Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")
>>
>> at kernel.org/palmer/habana , if that helps any.  No big deal if it goes in
>> another way, it's just nice to keep allyesconfig building on my branches
>> directly.
>
> Looks like Guenter sent in a "more complete" version of this.  I'll
> queue it up to my tree and get it to Linus for -rc2.

I'm fine with anything here, as long as it fixes my build errors ;).

Do you mind giving me a pointer?  That way I can use exactly what's 
going upstream, rather that keeping around this now-dead-end diff (I 
poked around your kernel.org trees and couldn't find anything, but I've 
not done that before).
