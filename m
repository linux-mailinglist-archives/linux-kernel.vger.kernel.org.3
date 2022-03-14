Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8E4D80BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiCNLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiCNLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:33:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03B1A41F9F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:31:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BA0A106F;
        Mon, 14 Mar 2022 04:31:52 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0E13F99C;
        Mon, 14 Mar 2022 04:31:50 -0700 (PDT)
Message-ID: <c6766e6e-3c90-f0e6-86b3-4afdf41fbbb1@arm.com>
Date:   Mon, 14 Mar 2022 11:31:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220126202427.3047814-1-pgwipeout@gmail.com>
 <3AFD1DD4-AF0A-4ECC-B4F5-E6BD6B9F1BB7@gmail.com>
 <CAMdYzYq06QSmFAwCuTmBYy4LfQAQDxzx2PGc8HOB1iEjxXHGyg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMdYzYq06QSmFAwCuTmBYy4LfQAQDxzx2PGc8HOB1iEjxXHGyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-13 12:56, Peter Geis wrote:
> On Sun, Mar 13, 2022 at 6:13 AM Piotr Oniszczuk
> <piotr.oniszczuk@gmail.com> wrote:
>>
>>
>>
>>> Wiadomość napisana przez Peter Geis <pgwipeout@gmail.com> w dniu 26.01.2022, o godz. 21:24:
>>>
>>> The hdmi-cec clock must be 32khz in order for cec to work correctly.
>>> Ensure after enabling the clock we set it in order for the hardware to
>>> work as expected.
>>> Warn on failure, in case this is a static clock that is slighty off.
>>> Fixes hdmi-cec support on Rockchip devices.
>>>
>>> Fixes: ebe32c3e282a ("drm/bridge: synopsys/dw-hdmi: Enable cec clock")
>>>
>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>> ---
>>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> index 54d8fdad395f..1a96da60e357 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -48,6 +48,9 @@
>>>
>>> #define HDMI14_MAX_TMDSCLK    340000000
>>>
>>> +/* HDMI CEC needs a clock rate of 32khz */
>>> +#define HDMI_CEC_CLK_RATE    32768
>>> +
>>> enum hdmi_datamap {
>>>        RGB444_8B = 0x01,
>>>        RGB444_10B = 0x03,
>>> @@ -3347,6 +3350,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>>                                ret);
>>>                        goto err_iahb;
>>>                }
>>> +
>>> +             ret = clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
>>> +             if (ret)
>>> +                     dev_warn(hdmi->dev, "Cannot set HDMI cec clock rate: %d\n", ret);
>>>        }
>>>
>>>        /* Product and revision IDs */
>>> --
>>> 2.25.1
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>> Peter,
>>
>> On my 5.17-rc7 with applied rk356x VOP2 v8 series - this patch makes CEC working on rk3566.
>> Unfortunately it breaks working ok CEC on rk3399 rockpi-4b.
>>
>> Reverting this patch brings back CEC on rk3399 - but rk3366 becomes with non working CEC
>>
>> I'm not sure how to move forward with this....
> 
> I was worried about that, thanks for testing it.
> Can you send me the cec_clk rate before and after this patch?

Hmm, looks like there might be a bug in the RK3399 clock driver - 
although it's treated as having mux_pll_p as parents, according to the 
public TRM the CEC clock appears unique in being backwards compared to 
every other mux of those two inputs. I'm now tempted to test this on my 
board tonight and see if I can see 24MHz on the CEC pin... :)

Robin.
