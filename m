Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A25A68C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiH3Qu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiH3QuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:50:04 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66550E2C41;
        Tue, 30 Aug 2022 09:49:40 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.5.6])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oT4Qh-0069aK-2x; Tue, 30 Aug 2022 17:49:35 +0100
Message-ID: <c2f86a2a-a30e-5fac-de6c-6a28edc5bcee@codethink.co.uk>
Date:   Tue, 30 Aug 2022 17:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
To:     Conor.Dooley@microchip.com, ben.dooks@sifive.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
 <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
 <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 14:49, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 13:58, Ben Dooks wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 30/08/2022 13:56, Conor.Dooley@microchip.com wrote:
>>> On 30/08/2022 13:51, Ben Dooks wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> With newer cores such as the p550, the SiFive composable cache can be
>>>> a level 3 cache. Update the cache level to be one of 2 or 3.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>>> ---
>>>>     Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 +-
>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>>>> index 1a64a5384e36..6190deb65455 100644
>>>> --- a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>>>> +++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>>>> @@ -45,7 +45,7 @@ properties:
>>>>         const: 64
>>>>
>>>>       cache-level:
>>>> -    const: 2
>>>> +    enum: [2, 3]
>>>
>>> Do we want to enforce the cache level like we currently do for
>>> interrupts and cache-sets?
>>
>> Not sure on that, for the P550 cores the ccache is going to be level3
>> and my colleague has said it does confuse some tooling if the level is
>> not set correctly.
> 
> What I meant was:
> Currently we enforce the correct cache-sets & interrupts based on the
> compatible string. Adding enum: [2, 3] relaxes the enforcement of the
> cache-level for existing compatibles and does not prevent someone from
> setting an incorrect cache level for p550 cores.
> 
> I think that on top of adding the enum, we should add some enforcement
> so that the cache is not incorrectly configured for both existing l2
> caches and for the new l3 versions.

Ok, we can add some enforcement once we add the new bindings, but I'm
not ready for that today and I'd rather get the current queue sorted
out first before we come in with newer silicon which hasn't hit the
market uet.

> @Zong, could you please incorporate Ben's patches into your V2? it
> would make it a lot easier to review what's going on here. It may
> also make sense to add the compatible for the p550 cache while we are
> at it...
> 
> FYI, there is also this patch here outstanding against the l2:
> https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/
> 
> I intend taking this into 6.0-rc5 or so as a fix, so if you could
> rebase the series on that so it is not lost in the dt-binding rename
> that would be great.

Do we need someone to take charge of this series?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

