Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB49587CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiHBNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBNLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:11:00 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC0752737;
        Tue,  2 Aug 2022 06:10:56 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Aug 2022 22:10:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2284F20584CE;
        Tue,  2 Aug 2022 22:10:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 2 Aug 2022 22:10:55 +0900
Received: from [10.212.181.253] (unknown [10.212.181.253])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E6092B62A4;
        Tue,  2 Aug 2022 22:10:53 +0900 (JST)
Subject: Re: [PATCH 9/9] ARM: dts: uniphier: Remove compatible
 "snps,dw-pcie-ep" from Pro5 pcie-ep node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
 <64e3702b-f09b-5a2e-b6a5-4c8752fbad77@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <612989a2-c6c7-5f04-a3ba-2a82667d420b@socionext.com>
Date:   Tue, 2 Aug 2022 22:10:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <64e3702b-f09b-5a2e-b6a5-4c8752fbad77@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/02 17:33, Krzysztof Kozlowski wrote:
> On 30/07/2022 13:58, Arnd Bergmann wrote:
>> On Mon, Jul 4, 2022 at 2:20 AM Kunihiko Hayashi
>> <hayashi.kunihiko@socionext.com> wrote:
>>>
>>> UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep"
>>> compatible,
>>> so this is no longer needed. Remove the compatible string from the
>>> pcie-ep
>>> node to fix the following warning.
>>>
>>>    uniphier-pro5-epcore.dtb: pcie@66000000: compatible:
>>> ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
>>>        From schema:
>>> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>>>
>>
>> This sounds like a problem with the binding rather than the dt file. Is
>> this not
>> a designware pci endpoint? Should it be documented in that binding
>> instead?

In term of the binding, it seems that the current binding doesn't allow descriptions
that list two compatibles. There is something wrong with the binding.

> Depends. We had one or two similar cases, where we dropped the snps/dw
> generic compatible, because device was actually quite different and
> could not match against snps/dw compatible. IOW, if device bound/matched
> via generic compatible it would be entirely non-operational. Logically I
> think it is okay to drop the generic compatible. Different question is
> any ABI break.

In term of the controller, we can add dw general compatible if the more generic
driver (pcie-designware-plat) works on the controller.

However, the generic driver can't do the initialization what the controller
needs, so we can add controller-specific compatible only.
The commit bf2942a8b7c3 ("arm64: tegra: Fix Tegra194 PCIe EP compatible string")
removes the generic compatible for the same reason.

This patch suggests removing the generic compatible for the former reason,
though, I might suggest it for the controller reason.

Thank you,

---
Best Regards
Kunihiko Hayashi
