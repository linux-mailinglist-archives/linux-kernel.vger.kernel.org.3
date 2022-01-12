Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED848BFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351528AbiALIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:17:36 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:56092 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351524AbiALIRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:17:35 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAAH6RWNjt5hKiMSBg--.14500S2;
        Wed, 12 Jan 2022 16:17:17 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] mmc: sdhci-of-esdhc: Check for error num after setting mask
Date:   Wed, 12 Jan 2022 16:17:15 +0800
Message-Id: <20220112081715.692436-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAH6RWNjt5hKiMSBg--.14500S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rCr1fKw1UAF1xAF1xGrg_yoW8AF1fp3
        yFgwn0yrs5WryF9rsrZw1UAF4YyrWrArZ8twsxWa42v3s8Crn0kr18Kan0qF1DCFn3Kw4I
        vrW2y3WUG34qqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIzuXUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 02:45:13PM +0800, Adrian Hunter wrote:
>> Because of the possible failure of the dma_supported(), the
>> dma_set_mask_and_coherent() may return error num.
>> Therefore, it should be better to check it and return the error if
>> fails.
>> Also, the caller, esdhc_of_resume(), should deal with the return
>> value.
>> Moreover, as the sdhci_esdhc_driver has not been used, it does not
>> need to
>> be considered.
>
> Apologies, but that last sentence I don't understand.  Can you clarify
> it a bit.
> What doesn't need to be considered and why?

Thanks, because the original esdhc_of_enable_dma() only returns 0, the
caller may not consider to check the return value.
I also notice that the esdhc_of_enable_dma() is assigned to
sdhci_esdhc_le_pdata and sdhci_esdhc_be_pdata, which is only used by
sdhci_esdhc_driver.
And now the sdhci_esdhc_driver only have 'probe' and 'remove', without
other action.
So we should not consider to check whether there is a caller for
esdhc_of_enable_dma() in sdhci_esdhc_driver.

>>  	if (ret == 0) {
>>  		/* Isn't this already done by sdhci_resume_host() ?
>>  		--rmk */
>> -		esdhc_of_enable_dma(host);
>> +		ret = esdhc_of_enable_dma(host);
>> +		if (ret)
>> +			return ret;
>> +
>
> This is already done by sdhci_resume_host(), which assumes there can be
> no
> error if DMA has been enabled previously i.e. -> enable_dma() is called
> at setup and the return value checked then.  If it is possible that DMA
> support can disappear later, then it would be better to address that in
> SDHCI so that all SDHCI drivers get the benefit.

Fine, since it is already checked in setup, I think it is no need to
check later.

I will send a v2 without the change of esdhc_of_resume().

Sincerely thanks,
Jiang

