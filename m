Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69888581A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiGZTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiGZTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:16:28 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4902982E;
        Tue, 26 Jul 2022 12:16:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7D13B203ED;
        Tue, 26 Jul 2022 21:16:24 +0200 (CEST)
Message-ID: <d120c72d-09d9-d78b-01ae-f5592f6a07be@somainline.org>
Date:   Tue, 26 Jul 2022 21:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 0/9] clk: qcom: gcc-sdm845: Swicth from expanded definitions
 to compact macros
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220726142303.4126434-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Probably an unnecessary nit: typo in the word 'Switch' in the title

On 26.07.2022 16:22, Abel Vesa wrote:
> Lets see where this goes.
> 
> This RFC is basically a proof-of-concept of how we could use more
> compact macros rather than expanded definitions for clocks on QCOM
> platforms. As the subject says, this is only for SDM845 GCC, for now.
> 
> Also, there are a couple of hacky solutions here that need to be
> reworked before it could be merged (if ever). One that comes to mind is
> the way the branch clock macros differentiate between having no parent,
> a parent name, or a parent HW. I'm still looking into that, so ...
> 
> I tried to make them as compact and readable from the user's POV, but
> there is some complexity needed in order to allow passing different
> types (or number) of parents. Maybe that complexity is too crazy and
> doesn't bring that much benefit.
> 
> I managed to put together some semi-automated way to do this for every
> CC, on every platform, if it's decided so. The only testing I managed to
> do so far was comparing the preprocessed output before and after. Oh,
> and the MTP does boot. I still need time to make sure that nothing gets
> broken.
> 
> Also, this series is still WIP, so everything can be reworked fast, if
> needed.
> 
> Abel Vesa (9):
>   clk: qcom: qcc-sdm845: Collapse gdsc structs into macros
>   clk: qcom: gcc-sdm845: Switch from parent_hws to parent_data
>   clk: qcom: rcg: Add macros to collapse definition
>   clk: qcom: alpha-pll: Add macros to collapse definition
>   clk: qcom: branch: Add macros to collapse definition
>   clk: qcom: common: Add macro wrapper for all clock types
>   clk: qcom: gcc-sdm845: Switch to macros to collapse branch clocks
>     definitions
>   clk: qcom: gcc-sdm845: Switch to macros to collapse rcg2 clocks
>     definitions
>   clk: qcom: gcc-sdm845: Switch to macros to collapse alpha-pll clocks
>     definitions
> 
>  drivers/clk/qcom/clk-alpha-pll.h |   61 +
>  drivers/clk/qcom/clk-branch.h    |   82 +
>  drivers/clk/qcom/clk-rcg.h       |   40 +
>  drivers/clk/qcom/common.h        |    3 +
>  drivers/clk/qcom/gcc-sdm845.c    | 3222 ++----------------------------
>  drivers/clk/qcom/gdsc.h          |   10 +
>  6 files changed, 406 insertions(+), 3012 deletions(-)
> 
> --
At first I was against it, but now I like it. Saves on LoC and clutter.
And it will hopefully finally be reviewable, without 15 levels of
indentation flashing before your eyes :D

I am also happy you mentioned a "semi-automated" way to convert things,
especially since Qualcomm will take some time to adjust to this scheme
on their downstream kernel (it's already really good, I still have
arch/arm/mach-msm flashbacks..) and of course, when it comes to platform
support, the more the merrier!

Thanks for working on this.

Konrad
> 2.34.3
> 
