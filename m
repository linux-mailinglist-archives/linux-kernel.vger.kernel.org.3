Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DF4959D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378679AbiAUGUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:20:15 -0500
Received: from box.trvn.ru ([194.87.146.52]:44607 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348613AbiAUGUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:20:13 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8B36E40476;
        Fri, 21 Jan 2022 11:20:09 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642746009; bh=2CidME6x0fybVf+aalDZ4OpJwBktpzpKSQN/DQ4ehc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoJjp6uKp5z7kaCwcG6Loccy+WqAsFDffvnZ7Hjfe7a6pEz04MJx1tzsR/xUzEdy6
         EYGLSqqKCsMPJPey4sBRQDgy9xJMFuGzL8uDwOR/TpsNnX9PM+W7aLZmdKYnHg2Hnn
         h899/ZaLaJs4Y/rl5rPqpmLzJxF3UASSuC5dy9FSBoCPFXD2sq/trpNw1YEdIV0Xjy
         lk7n5/26FXQSb94dAMSLET+Qm+yzr4bLzMR9/E+D1nubXw0BTtQ8qlc28gr6KKR9Oe
         HcudSi+5mdZqQnAsOAANKLay/XJoA5pExxbZV/uqwgHezoiaz9u8wTWUi6cxBAqhhN
         68YHcKujjQdYA==
MIME-Version: 1.0
Date:   Fri, 21 Jan 2022 11:20:05 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, sboyd@kernel.org, krzk@kernel.org,
        linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: Fix node name pattern
In-Reply-To: <Yem0wtltC/6FklZu@robh.at.kernel.org>
References: <20220120161442.140800-1-nikita@trvn.ru>
 <20220120161442.140800-2-nikita@trvn.ru>
 <Yem0wtltC/6FklZu@robh.at.kernel.org>
Message-ID: <174803bf1ea1e71a0dfdd1d5365946ca@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring писал(а) 21.01.2022 00:15:
> On Thu, Jan 20, 2022 at 09:14:40PM +0500, Nikita Travkin wrote:
>> It looks like it was intended to allow two types of node names with the
>> binding:
>>
>>  - With unit address, e.g. pwm@1f000000
> 
> Yes, but the format of the unit-address is up to the parent bus which is 
> outside the scope of this binding.
> 
>>  - With a suffix, e.g. pwm-clk
> 
> No. pwm-0, pwm-1, etc. only to cover the few cases with no unit-address. 
> 
> Third is just 'pwm' as the '*' on the end means 0 or more. Though a '?' 
> would have been more correct.
> 

Oh, thanks for clarifying that. My assumption was that just numbering
the nodes is not informative enough, but if it's the agreed way to do
it, I will use this format instead.

I will drop this commit and correct the bindings to use 'pwm' with
no suffix as an example. (Though I still think that having a
meaningful suffix is nicer in the DT so one could see what the
node is used for)

Thanks
Nikita

>>
>> However the pattern regex only correctly matches the first variant,
>> as well as some incorrect ones.
>>
>> Fix the regex to match only two patterns shown above. (Either unit
>> address starting with @ and following with one or more hexademical
>> digit or arbitrary suffix stating with - and at least one symbol long)
>>
>> Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-schema")
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
>> index 3c01f85029e5..4926fe65886f 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
>> @@ -13,7 +13,7 @@ select: false
>>
>>  properties:
>>    $nodename:
>> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
>> +    pattern: "^pwm(@[0-9a-f]+|-.+)?$"
>>
>>    "#pwm-cells":
>>      description:
>> --
>> 2.30.2
>>
>>
