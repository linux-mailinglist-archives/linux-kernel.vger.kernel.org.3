Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C646B395
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhLGHWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLGHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:22:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC4BC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:18:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 18025419B4;
        Tue,  7 Dec 2021 07:18:27 +0000 (UTC)
Subject: Re: [PATCH 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM
 platforms
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20211207064019.61444-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5723f5bc-f721-9976-d63d-2738233f62bd@marcan.st>
Date:   Tue, 7 Dec 2021 16:18:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211207064019.61444-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, forgot to Cc Ben...

Ben, please let me know what you think about this series. I can resend 
it CCing you if you want, or you can also find it here:

https://lore.kernel.org/all/20211207064019.61444-1-marcan@marcan.st/

Sorry for missing the Cc...

-Hector

On 07/12/2021 15.40, Hector Martin wrote:
> Hi folks,
> 
> This short series adds a few quirks needed to make the card readers in
> Apple M1 Pro/Max MacBook laptops work properly.
> 
> The first patch should be straightforward; it just allows configuring
> the CD/WP polarity based on device tree settings. There is already a
> standard DT binding for this.
> 
> The second patch bugs me. I don't understand why this problem happens
> on these machines, and not on e.g. x86 laptops (which presumably work
> with this driver). 8/16-bit MMIO reads work fine on other PCIe devices
> on these machines, so it is not a generalized problem with the PCIe
> controller in these SoCs. The problem also happens when running macOS
> (it also uses 32-bit reads). Ben, is there any chance you might know
> of some vendor-specific knob somewhere that can fix this issue without
> requiring the MMIO read workaround? Interestingly, 8/16-bit writes
> work perfectly fine.
> 
> Hector Martin (2):
>    mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
>      platforms
>    mmc: sdhci-pci-gli: GL9755: Issue 8/16-bit MMIO reads as 32-bit reads.
> 
>   drivers/mmc/host/sdhci-pci-gli.c | 38 ++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
