Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2477C554B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355474AbiFVN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiFVN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:29:14 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC2BCC;
        Wed, 22 Jun 2022 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qos0wtffPi7SlJmjUa79jVr5513FHGhaJ2VhSYAiOiw=; b=hADOqLi7yR5iFGD8+rNuXfoc2o
        AnD8wEb6RQ8hL/0sN3gkFdOvUHZR9FvscmweapTKvkA91VCNIo/ukO06jyRN63W/MVuzckR42D/3R
        yExJEsUO/0d9fhU3YsE83frHdzP2CKi3h757rChcRPORurAyx2PP7jcxLEW/4Qmo5j9a2N9PhskLk
        J0SSzD+iVBUpmX5gBB9JOhtLG8nnQ6UcvFNmdjDNw4oa0N6NMiyQIveUSTLg9iaVirBh7PC0+0lXM
        qg56lauwwcPxKN+Pq7RkYyS9el0eDmTLMoyiiJb9qbiIUQXIj9ZJeyMvOBuV77rgmuZFQalluQ60R
        zSc+S02A==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o40Pu-000bYH-7S; Wed, 22 Jun 2022 16:29:09 +0300
Message-ID: <9e80da1f-60e9-5528-3636-6443461fb207@kapsi.fi>
Date:   Wed, 22 Jun 2022 16:29:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] arm64: tegra: Mark BPMP channels as no-memory-wc
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220622132300.1746201-1-cyndis@kapsi.fi>
 <20220622132300.1746201-2-cyndis@kapsi.fi>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220622132300.1746201-2-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.6.2022 16.23, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> The Tegra SYSRAM contains regions access to which is restricted to
> certain hardware blocks on the system, and speculative accesses to
> those will cause issues.
> 
> Patch 'misc: sram: Only map reserved areas in Tegra SYSRAM' attempted
> to resolve this by only mapping the regions specified in the device
> tree on the assumption that there are no such restricted areas within
> the 64K-aligned area of memory that contains the memory we wish to map.
> 
> Turns out this assumption is wrong, as there are such areas above the
> 4K pages described in the device trees. As such, we need to use the
> bigger hammer that is no-memory-wc, which causes the memory to be
> mapped as Device memory to which speculative accesses are disallowed.
> 
> As such, the previous patch in the series,
>    'firmware: tegra: bpmp: do only aligned access to IPC memory area',
> is required with this patch to make the BPMP driver only issue aligned
> memory accesses as those are also required with Device memory.
> 
> Fixes: fec29bf04994 ("misc: sram: Only map reserved areas in Tegra SYSRAM")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

FWIW, with this, the aforementioned patch to misc/sram is redundant. It 
doesn't hurt, but doesn't really help either. Whether or not it should 
be reverted, I have no opinion.

Thanks,
Mikko

>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 0e9afc3e2f26..9eca18b54698 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -1820,6 +1820,7 @@ sram@30000000 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		ranges = <0x0 0x0 0x30000000 0x50000>;
> +		no-memory-wc;
>   
>   		cpu_bpmp_tx: sram@4e000 {
>   			reg = <0x4e000 0x1000>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index d1f8248c00f4..3fdb0b852718 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -2684,6 +2684,7 @@ sram@40000000 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		ranges = <0x0 0x0 0x40000000 0x50000>;
> +		no-memory-wc;
>   
>   		cpu_bpmp_tx: sram@4e000 {
>   			reg = <0x4e000 0x1000>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cb3af539e477..0213a7e3dad0 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -1325,6 +1325,7 @@ sram@40000000 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		ranges = <0x0 0x0 0x40000000 0x80000>;
> +		no-memory-wc;
>   
>   		cpu_bpmp_tx: sram@70000 {
>   			reg = <0x70000 0x1000>;
