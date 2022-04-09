Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320614FA7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiDIM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDIM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:57:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B75F3A;
        Sat,  9 Apr 2022 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649508909; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRiJT3CDPL495Cp9n4zLCUDvz6FBFEd6LlbAeNnambI=;
        b=CUseniPcWQGjEDaJrbq/c/Jw9ZFS6UfiVFcbXE3pz59IuH+y4ENHHeBdAnOimBEgbmNK/K
        n2Hw90Dhfj01qOGNSa1JWeEU076qRJQAYNp66gx0Hd0UqS6+kvVSKD2lqDu7lbdyNOiZ+V
        giKxprTvyRqSQV1bfi9OjMPSb013q3g=
Date:   Sat, 09 Apr 2022 13:55:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 13/18] dt-bindings: fix jz4780-nemc issue as reported by
 dtbscheck
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <O7P2AR.D8D4QSYF9P8E@crapouillou.net>
In-Reply-To: <2e1495ab-2773-a3bb-0ad2-4af607cccc11@linaro.org>
References: <cover.1649443080.git.hns@goldelico.com>
        <84adfe6237cd4cfd52cb9723416f69926e556e55.1649443080.git.hns@goldelico.com>
        <036b66b2-c221-6e9e-6a56-510e7a0d20d3@linaro.org>
        <VDO2AR.XO9112UD3KYT3@crapouillou.net>
        <2e1495ab-2773-a3bb-0ad2-4af607cccc11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam., avril 9 2022 at 14:47:23 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 09/04/2022 14:37, Paul Cercueil wrote:
>>>  The true question is whether you need simple-mfd. Isn't the binding
>>>  (and
>>>  the driver) expected to instantiate its children?
>>=20
>>  I can explain that one. There is the EFUSE controller located inside
>>  the nemc's memory area, and the two are pretty much unrelated, hence
>>  the "simple-mfd" compatible string.
>=20
> I saw the efuse children and that's why I asked who is expected to
> populate them. You said that simple-mfd is required for this, I say=20
> no.
> It should work without simple-mfd...
>=20
> I am kind of repeating myself but I really do not see the need of
> simple-mfd in the bindings.

Well, it is a "simple MFD", so I don't see why we can't use the=20
"simple-mfd" compatible. Why would we not want to use it?

Besides, if the nemc driver is responsible for populating the efuse=20
device, that means the nemc driver must be enabled for the efuse to=20
work, which is nonsense, the two IP blocks being unrelated.

-Paul


