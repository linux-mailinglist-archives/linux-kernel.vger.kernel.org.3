Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40016543BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFHTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFHTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:00:19 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BD3C71C;
        Wed,  8 Jun 2022 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yeiHW5EcLA7eqe7J1MPMCRK8sfCMfurY+HyBM1CQA2g=; b=a1yaq32urq7t04nH3n0QyXBvCN
        D51rzXl8Al5tGQntxatY+oWoluSnrG8LyjSHvIDqkHkRXKfvBnQ4sb5WqdmUsqibWC3edYzV3hgya
        jjXXLi7Dy/Z76fjiDter5nkCMNkZCoARIw50FUvn2qH9aL4SXV4vQu96/V/v1jpdpRsTjnxHMEwey
        6SeeRG85DUk7IS38i59Ezo/Sfc3UIFVw3+JYNtiuf4DhM2A4ZKWK4hgbi97wI7IJKjXqubA9BftDU
        b1eKY+0CqrUbb0AjYTx4S4r/VLmJxQ+tPZfyzrMYlZqgdcXkUL+ikDb7N7df2ff3L72eXYbGbju9v
        onsMJ2OA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nz0uH-00CMkN-RA; Wed, 08 Jun 2022 21:59:53 +0300
Message-ID: <8f813d4c-f379-a6d5-1efe-8b20e3572a83@kapsi.fi>
Date:   Wed, 8 Jun 2022 21:59:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v1 00/13] Host1x support on Tegra234
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <930f3721-ab1e-4bab-de1e-eaf83982e3ea@collabora.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <930f3721-ab1e-4bab-de1e-eaf83982e3ea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 12:38, Dmitry Osipenko wrote:
> On 5/16/22 13:02, cyndis@kapsi.fi wrote:
>> Hi all,
>>
>> This series adds support for Host1x and VIC on the recently released
>> Tegra234 (Orin) SoC. It's split into the following parts:
>>
>> * Device tree binding updates
>> * Cleanup in host1x driver
>> * Add programming of new registers and old registers that now need to
>>    be programmed to a non-reset value
>> * Tegra234 device data and headers
>> * Rewrite of the job opcode sequence, and related patches to
>>    support MLOCKs on Tegra186+.
>>
>> The rewrite of the job opcode sequence brings Tegra186, Tegra194 and
>> Tegra234 support to a 'full-featured' status that is necessary to
>> support all host1x features in the future. This should not have any
>> impact on older SoCs.
>>
>> This series should be applied on top of the Host1x context isolation
>> series.
>>
>> Tested on Jetson AGX Xavier and Jetson AGX Orin.
> 
> The code looks okay at a quick glance. Please rebase the patches on top
> of latest -next. Perhaps won't hurt to merge all the related patchsets
> into a single series for 5.20.
> 

Thanks!

Yeah, I'll rebase and resend the context isolation series and this next 
week.

Mikko
