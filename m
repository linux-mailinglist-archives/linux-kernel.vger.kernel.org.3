Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6C49C624
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiAZJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiAZJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:19:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815C4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:19:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a13so24563483wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=6W0uXYBUGimlgrjGSvj7ylLW7W4DYopOCTHsVfAmY4k=;
        b=LTgwi81MnixOV81jpbU8WYduofSRLnxZ7CM0Zne4n+Wg/oyiGO3kvyOeLMnKM0S4XQ
         /ZhTYdiZOlKLZPoVTHPWaD7Cqf+sBxvnaKx16wH1LRCuANSHrYlLfP891usJo+IWQAJx
         tuMXr5msG9wWVUcBkssTOmwknn7N4js1l7enttugM55f+Yb698SB/qzRyV9IjIV9Dxiv
         iQONJ/t3pZxbqvdPZjf0PXMPeVn+SYmvVFf8KlJGem9+ODyGxb4aJduyCHYiY88BQKhz
         BVwZWWlwo488sLzlcBYrb60g5xvMYj+JrnUKS0W+tz3YYZbt+RDm3Cj347YWSao2WSSe
         u64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=6W0uXYBUGimlgrjGSvj7ylLW7W4DYopOCTHsVfAmY4k=;
        b=s3vCQjNPfUn29n4re+9EVzn7fRGLH7IfmLLS0ODZlOlR4Y2hF1uGTHXM7nh5VDqOjz
         qZjzmBa7to4GB2VNLLya74n6Fdvg2OpkjZud53mtstmaqSGnAB2It3d7hG0O1f42sQAQ
         Ku7FIP3Nb9Jotm3kbbrR8QE0HFmV091DM2wLESsKA/NhOBSSmKyp45JSN7fVbOjMzrnk
         J0sF3jkxyOrVFGki5mwcbqubjn2nRH6+rKkshf4Z6IEqFLwcPuszkelHb0eu9bn+ExZB
         vzZ8TI9kJPohXo7eKuWIIysF0g58YVOzT7GXr0lcTwZz9y+R08f/CLGWY0RnroeSXW91
         Tp7A==
X-Gm-Message-State: AOAM531a8MhAje0Bmmmjsv5O+ithvMO9b68W9dYyF+IVXp8cHqR00VkV
        QYgmrOrCylrvlKGJ3j3N1CXKyw==
X-Google-Smtp-Source: ABdhPJxM9FCgJChPOLX+3by8PdBeL6nlJYirtMLagLsdYPC8uezejMxZoY5QLWL7xfWMTeMvyPRb3w==
X-Received: by 2002:a5d:6da1:: with SMTP id u1mr1657242wrs.281.1643188775011;
        Wed, 26 Jan 2022 01:19:35 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id h8sm2913872wmq.26.2022.01.26.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 01:19:34 -0800 (PST)
References: <20220121074508.42168-1-liang.yang@amlogic.com>
 <f5a429f2-ffbc-ea03-810a-45a0f90959a2@baylibre.com>
 <6eb4f247-367b-d460-6314-fc94ccd00b89@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 0/4] clk: meson: add a sub EMMC clock controller
 support
Date:   Wed, 26 Jan 2022 10:14:55 +0100
In-reply-to: <6eb4f247-367b-d460-6314-fc94ccd00b89@amlogic.com>
Message-ID: <1jy23226sa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 26 Jan 2022 at 17:08, Liang Yang <liang.yang@amlogic.com> wrote:

> Hi Neil,
>
> On 2022/1/25 22:54, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>> Hi Liang,
>> On 21/01/2022 08:45, Liang Yang wrote:
>>> This driver will add a MMC clock controller driver support.
>>> The original idea about adding a clock controller is during the
>>> discussion in the NAND driver mainline effort[1].
>>>
>>> This driver is tested in the S400 board (AXG platform) with NAND driver.
>> Thanks a lot for providing a fixed and updated version of this serie.
>> After some chat with Jerome and Kevin, it seems the way the eMMC clock
>> reuse
>> for NAND was designed nearly 4 years doesn't look accurate anymore.
>> Having a separate clk driver designed to replace the eMMC node when NAND
>> is
>> used on the board seems over engineered.
>> Actually having the clock code you add in this serie _but_ directly in
>> the NAND looks far better, and more coherent since having Linux runtime
>> detection of eMMC vs NAND will never happen and even this serie required
>> some DT modification from the bootloader.
>> I'll let Jerome or Kevin add more details if they want, but I think you
>> should resurrect
>> the work you pushed in [1] & [2] but:
>> - passing the eMMC clk registers as a third "reg" cell
> Does it just need to define a 'reg' resource in NFC node and not 'syscon'
> here?

Yes

>> - passing the same "clocks" phandle as the eMMC node
>> - adding the eMMC clock code in the NAND driver directly
>> I'm open to discussions if you consider the current approach is still
>> superior.
>
> I don't have persuasive ideas, but really it shares the common clock
> implementation for both NFC and EMMC. and we don't need to paste the 
> same code in NFC and EMMC.

You don't need to copy everything. If I understood correctly, all the
Rx/Tx should not be needed. Yes, there is some duplication as it stands but
it allows to avoid coupling the MMC and NAND driver. We can still think
about optimizing things later on. Let's get something simply working
first.

>
>> Thanks,
>> Neil
>> [1]
>> https://lore.kernel.org/r/20220106033130.37623-1-liang.yang@amlogic.com
>> [2] https://lore.kernel.org/r/20220106032504.23310-1-liang.yang@amlogic.com
>> 
>>>
>>> Changes since v9 [10]
>>>   - use clk_parent_data instead of parent_names
>>>
>>> Changes since v8 [9]
>>>   - use MESON_SCLK_ONE_BASED instead of CLK_DIVIDER_ONE_BASED
>>>   - use struct_size to caculate onecell_data
>>>   - add clk-phase-delay.h
>>>   - define CLK_DELAY_STEP_PS_GX and CLK_DELAY_STEP_PS_AXG
>>>
>>> Changes since v7 [8]
>>>   - move meson_clk_get_phase_delay_data() from header to driver
>>>   - CONFIG sclk-div with COMMON_CLK_AMLOGIC instead of COMMON_CLK_AMLOGIC_AUDIO
>>>   - remove onecell date and ID for internal MUX clk
>>>   - use helper for functions for ONE_BASED in sclk-div
>>>   - add ONE_BASED support for duty cycle
>>>
>>> Changes since v6 [7]:
>>>   - add one based support for sclk divier
>>>   - alloc sclk in probe for multiple instance
>>>   - fix coding styles
>>>
>>> Changes since v5 [6]:
>>>   - remove divider ops with .init and use sclk_div instead
>>>   - drop CLK_DIVIDER_ROUND_CLOSEST in mux and div
>>>   - drop the useless type cast
>>>
>>> Changes since v4 [5]:
>>>   - use struct parm in phase delay driver
>>>   - remove 0 delay releted part in phase delay driver
>>>   - don't rebuild the parent name once again
>>>   - add divider ops with .init
>>>
>>> Changes since v3 [4]:
>>>   - separate clk-phase-delay driver
>>>   - replace clk_get_rate() with clk_hw_get_rate()
>>>   - collect Rob's R-Y
>>>   - drop 'meson-' prefix from compatible string
>>>
>>>   Changes since v2 [3]:
>>>   - squash dt-binding clock-id patch
>>>   - update license
>>>   - fix alignment
>>>   - construct a clk register helper() function
>>>
>>> Changes since v1 [2]:
>>>   - implement phase clock
>>>   - update compatible name
>>>   - adjust file name
>>>   - divider probe() into small functions, and re-use them
>>>
>>> [1] https://lkml.kernel.org/r/20180628090034.0637a062@xps13
>>> [2] https://lkml.kernel.org/r/20180703145716.31860-1-yixun.lan@amlogic.com
>>> [3] https://lkml.kernel.org/r/20180710163658.6175-1-yixun.lan@amlogic.com
>>> [4] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com
>>> [5] https://lkml.kernel.org/r/20180809070724.11935-4-yixun.lan@amlogic.com
>>> [6] https://lkml.kernel.org/r/1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com
>>> [7] https://lkml.kernel.org/r/1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com
>>> [8] https://lkml.kernel.org/r/1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com
>>> [9] https://lkml.kernel.org/r/1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com
>>> [10] https://lore.kernel.org/all/20220113115745.45826-1-liang.yang@amlogic.com/
>>> Liang Yang (4):
>>>    clk: meson: add one based divider support for sclk
>>>    clk: meson: add emmc sub clock phase delay driver
>>>    clk: meson: add DT documentation for emmc clock controller
>>>    clk: meson: add sub MMC clock controller driver
>>>
>>>   .../bindings/clock/amlogic,mmc-clkc.yaml      |  64 ++++
>>>   drivers/clk/meson/Kconfig                     |  18 ++
>>>   drivers/clk/meson/Makefile                    |   2 +
>>>   drivers/clk/meson/clk-phase-delay.c           |  69 ++++
>>>   drivers/clk/meson/clk-phase-delay.h           |  20 ++
>>>   drivers/clk/meson/mmc-clkc.c                  | 302 ++++++++++++++++++
>>>   drivers/clk/meson/sclk-div.c                  |  59 ++--
>>>   drivers/clk/meson/sclk-div.h                  |   3 +
>>>   include/dt-bindings/clock/amlogic,mmc-clkc.h  |  14 +
>>>   9 files changed, 529 insertions(+), 22 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
>>>   create mode 100644 drivers/clk/meson/clk-phase-delay.c
>>>   create mode 100644 drivers/clk/meson/clk-phase-delay.h
>>>   create mode 100644 drivers/clk/meson/mmc-clkc.c
>>>   create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
>>>
>> .

