Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D05481D01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhL3O0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbhL3O0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:26:52 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:26:52 -0800 (PST)
Received: from [192.168.1.101] (83.6.168.106.neoplus.adsl.tpnet.pl [83.6.168.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C2D1B3F725;
        Thu, 30 Dec 2021 15:26:49 +0100 (CET)
Message-ID: <e6ac0b79-368b-41af-f20d-f58ddc02f05e@somainline.org>
Date:   Thu, 30 Dec 2021 15:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] clk: qcom: gcc-msm8994: Remove NoC clocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211230023101.1122588-1-konrad.dybcio@somainline.org>
 <CAA8EJprR_eNiRTXOLnHzztbdH_RYj-+Po99b=7c2Asxvop+jtQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAA8EJprR_eNiRTXOLnHzztbdH_RYj-+Po99b=7c2Asxvop+jtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.12.2021 15:06, Dmitry Baryshkov wrote:
> On Thu, 30 Dec 2021 at 05:31, Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
>> Just like in commit 05cf3ec00d460b50088d421fb878a0f83f57e262
>> ("clk: qcom: gcc-msm8996: Drop (again) gcc_aggre1_pnoc_ahb_clk")
>> adding NoC clocks turned out to be a huge mistake, as they cause a lot of
>> issues at little benefit (basically only letting Linux know about their
>> children's frequencies), especially when mishandled or misconfigured.
> I'm not against this patch, but it manifests another question to me:
> should the NoC driver set these frequencies (as demanded), or are they
> set by the hardware/RPM/etc and so are read-only to us?

The downstream driver [1] only seems to vote for 19.2 MHz on

p(c)noc_keepalive_a_clk and 40MHz on mmssnoc_ahb_a_clk and

not really care much about them otherwise in the (msm_)clk framework.


Interestingly, the voting-at-probe also seems to be true for 8916 [2],

and even more so for 8974 [3] which votes for CXO too, and I don't

think we handle it upstream.. Is it unnecessary, or did things always

work by miracle? Should we perhaps set it with assigned-clocks under

rpmcc in DT?


Otherwise, they seem to be handled by msm_bus's voter clocks, so in

our case that'll be interconnect's job. I had an old WIP driver somewhere,

but it had issues with some (well, many) paths.. I'll rebase it and try debugging

that.


Decoding ancient msm-3.10 code is not for the faint of heart, but I don't think

8994 or 8974 (which are similar in many ways) ever got a newer kernel release..


[..]


Konrad


[1] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.BR.1.3.3_rb2.14/drivers/clk/qcom/clock-rpm-8994.c#L292


[2] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.BR.1.3.3_rb2.14/drivers/clk/qcom/clock-rpm-8916.c#L168


[3] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.BR.1.3.3_rb2.14/arch/arm/mach-msm/clock-rpm-8974.c

