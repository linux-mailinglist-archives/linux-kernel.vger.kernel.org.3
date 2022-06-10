Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855975469A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiFJPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349340AbiFJPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:43:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B66113F88;
        Fri, 10 Jun 2022 08:42:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a15so28529234wrh.2;
        Fri, 10 Jun 2022 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=adpxe2916dr9ZdckfINqW/VDd+pvv3GHwzAlINgI0C0=;
        b=I5dzn8xLp4OL/37jS3+3dhjU9FGpQeTRHgO9S18ZF1kN9v/PeLLqf21lgBRQIMBqPv
         gokjLMGpPdNCHimU3iVhLN8tzpLXcdC1Ea6kJZzz5fKcsHzBeuKiULIjb9gg1MZhx3iQ
         5FHZCcNtq+srI/uE+GYWoN+uzKnWFeceRVj2TEqFUVMkVRyZH3sbcm+5UVzhoZdZrRGD
         GI9AXPVbdnJL3NbVqNbluxo+uCFYqZGwh8LlfwVWa2GbpJiw8B7aQQYvyO1RT6QZumai
         yjHsxvznZUnO/sEdoYJa9qsKGqbowT6HzupDNlVKhetwsR4JcfU1uvYwljb9KKPuiwpA
         MAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=adpxe2916dr9ZdckfINqW/VDd+pvv3GHwzAlINgI0C0=;
        b=IToDB1cOq8n4qz1eEbXOTEtVaGnwF/+OGgEFXGsQsxpnee3wmk28GZOkpou6148DiS
         G2IaumjxUyV0hjZTCdW1pNCvd8B6zJv+v1v1lJYLPNWu9dI8ca2EY3tKZZOcYg34eu9s
         c4lVZi2rpAZdUtxuyi+PticWfhgvb01b8Bss4Hfg2LDFnsttgtl9pkgQaOPk6DfjNrGj
         NDYhEuPLc4olb9IRkUBw44we06N15lUZBdY10xWUXzS6p5D/rOjg+xFbUbu87gIEeDRY
         OUlwSadI35wirPTio3RLpQHibXbiPtfrcHqOj6h/kBBhMdhIAwUT25KId/UAKEsnpmep
         5VxQ==
X-Gm-Message-State: AOAM531Fl7acma/DV4qsgYv0ODLvuF1PYj3CO5sCIHX+2qjUEMrpvkrJ
        a4H0EzGmA0kkMFdZ94iet9o=
X-Google-Smtp-Source: ABdhPJxAELODO4RgC1p5z6ljkxgw8kqxmhvPo4D9SIWp9ZWEqBTTFSvPTND+9mkehaj8aQf3VGLZDA==
X-Received: by 2002:a5d:648b:0:b0:215:da35:3a6b with SMTP id o11-20020a5d648b000000b00215da353a6bmr35715109wri.358.1654875744124;
        Fri, 10 Jun 2022 08:42:24 -0700 (PDT)
Received: from localhost (92.40.202.174.threembb.co.uk. [92.40.202.174])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c418300b00397342bcfb7sm3159715wmh.46.2022.06.10.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:42:23 -0700 (PDT)
References: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
 <20220609224200.D1E8BC34114@smtp.kernel.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ingenic-tcu: Properly enable registers before
 accessing timers
In-reply-to: <20220609224200.D1E8BC34114@smtp.kernel.org>
Date:   Fri, 10 Jun 2022 16:43:27 +0100
Message-ID: <qONO5Rg11q4yBfTVshsrN1odktNWOtHV@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Aidan MacDonald (2022-06-03 06:47:05)
>> Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
>> so the stop bit can be cleared before accessing a timer channel, but
>> those functions did not clear the stop bit on SoCs with a global TCU
>> clock gate.
>> 
>> Testing on the X1000 has revealed that the stop bits must be cleared
>> _and_ the global TCU clock must be ungated to access timer registers.
>> Programming manuals for the X1000, JZ4740, and JZ4725B specify this
>> behavior. If the stop bit isn't cleared, then writes to registers do
>> not take effect, which can leave clocks with no defined parent when
>> registered and leave clock tree state out of sync with the hardware,
>> triggering bugs in downstream drivers relying on TCU clocks.
>> 
>> Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
>> clear the stop bit, regardless of the presence of a global TCU gate.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>
> Any Fixes: tag?

Probably 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
but I don't have docs or hardware to confirm the bug affects the jz4770,
which is the only other SoC affected by the change.

I think what caused my problem was my bootloader stopping all the timer
channels. The stop bits are supposed to be zeroed at reset, so I'd guess
the jz4770 relied on that and only worked by accident.

I'll send a v2 along shortly. Is it worth CC'ing stable as well?
