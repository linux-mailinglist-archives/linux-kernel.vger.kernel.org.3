Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BD53339B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiEXWl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbiEXWlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:41:15 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153A76552;
        Tue, 24 May 2022 15:41:11 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 805993F734;
        Wed, 25 May 2022 01:03:24 +0200 (CEST)
Message-ID: <1d602bb6-d3a4-2ec0-e3e7-d9395edec416@somainline.org>
Date:   Wed, 25 May 2022 00:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add touchscreen to villager
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
 <311a23c9-e31d-e20d-8ba9-80d3197e8d1d@somainline.org>
 <CAD=FV=WKgPWxEL+mhb9cCGOLObJEPtX_sHLQ1z3rz3usDG1m+Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAD=FV=WKgPWxEL+mhb9cCGOLObJEPtX_sHLQ1z3rz3usDG1m+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/05/2022 00:14, Doug Anderson wrote:
> Hi,
>
> On Tue, May 24, 2022 at 2:13 PM Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
>>
>> On 24/05/2022 22:48, Douglas Anderson wrote:
>>> This adds the touchscreen to the sc7280-herobrine-villager device
>>> tree. Note that the touchscreen on villager actually uses the reset
>>> line and thus we use the more specific "elan,ekth6915" compatible
>>> which allows us to specify the reset.
>>>
>>> The fact that villager's touchscreen uses the reset line can be
>>> contrasted against the touchscreen for CRD/herobrine-r1. On those
>>> boards, even though the touchscreen goes to the display, it's not
>>> hooked up to anything there.
>>>
>>> In order to keep the line parked on herobrine/CRD, we'll move the
>>> pullup from the qcard.dtsi file to the specific boards. This allows us
>>> to disable the pullup in the villager device tree since the pin is an
>>> output.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>> This uses bindings introduced in the patch ("dt-bindings: HID:
>>> i2c-hid: elan: Introduce bindings for Elan eKTH6915") [1].
>>>
>>> [1] https://lore.kernel.org/r/20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid
>>>
>>>    .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 11 ++++++++
>>>    .../qcom/sc7280-herobrine-herobrine-r1.dts    | 11 ++++++++
>>>    .../dts/qcom/sc7280-herobrine-villager-r0.dts | 25 +++++++++++++++++++
>>>    arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 -
>>>    4 files changed, 47 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> index a4ac33c4fd59..b79d84d7870a 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> @@ -134,6 +134,17 @@ &sdhc_2 {
>>>        status = "okay";
>>>    };
>>>
>>> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
>> Please drop this line, this isn't msm-3.4. It's immediately obvious that
>> if a pin is referenced by a label and it is not defined in this file
>> (because otherwise it wouldn't be both defined and referenced here..),
>> it comes from a previously included device tree.
> In general these headings specify a change in sort ordering. Without
> them then either we intersperse pinctrl overrides with other stuff,
> which IMO is overall worse or people have no idea why the sort
> ordering changes.

I get what you mean, but at the end of the day, the entire machine DT 
specifies all machine-specific changes and only machine-specific 
changes. They all are a part of a bigger picture, sometimes being 
downstream from the SoC, sometimes downstream from a common board. I 
don't think it brings much benefit if at all to separate them into 
sections like these, if in the end they all correspond to modifications 
present in the hardware. In its current form, the sorting is all over 
the place, and ideally we could have labels sorted alphabetically.

The present solution, in my opinion, causes more disarray as you first 
have to think about what is the change against and then find it in the 
corresponding subsection instead of thinking of it as a complete 
quote-on-quote diff against the parent DTSIs. Plus, most DTs don't split 
it like that.


>
>>> @@ -604,7 +604,6 @@ ts_int_conn: ts-int-conn {
>>>        ts_rst_conn: ts-rst-conn {
>>>                pins = "gpio54";
>>>                function = "gpio";
>>> -             bias-pull-up;
>> If you overwrite it where it should be overwritten, wouldn't it make
>> more sense to leave bias-pull-up here as a default configuration for
>> boards that don't have a peculiar routed-but-NC line?
> Yeah, it'd be nice.  ...but because of the way "bias" is specified in
> the device tree it means an ugly "/delete-property" in places that
> actually route the line. I believe that, style wise, the preference is
> to avoid delete-property and move the bias toward board files in cases
> like this. Bjorn can feel free to override me if he disagrees.

Ok, totally fair, it somehow slipped my mind that you have to delete one 
property to replace it with the other, I retract that comment then.


Konrad

>
> -Doug
