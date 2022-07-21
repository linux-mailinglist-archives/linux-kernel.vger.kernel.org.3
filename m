Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75957CCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiGUOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiGUOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:02:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08413ED54
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Vg47MT9CYxVlKDfYeFrs6uVhxA2N7iGnYsekPSd9PLU=; b=rf4D7P6LRVg5IFDDhyBor71CZu
        3QAp6A9r7WfoW7/Clpm62SfV7wANE8oBbVcMvxtX8uSdAucHI3Y4Kts21MZHDmCSz8xvcjaRe2nCg
        X2kmJX3pxs75qo14xPEqELLjIJbnNnrOngXsIie+a1/LCclG8nMsBlQlnapHhT93PSPzBh0LJpZPg
        LnzqjMoDxahO5di8SXZ/aAXIxHy+V09bpk0+7lPzOl6tyYdi58i4ryf2HQ+mt7jpC9yH4kTdT0OL1
        64zKWXlwGkTnH6TuwNN4DX4pDaccmQ0XzAx7DOUayAtW5vxurXsudrwbBPAETOOYJN41dxERgVF/B
        op8tohbA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEWkU-007SAu-Un; Thu, 21 Jul 2022 14:01:55 +0000
Message-ID: <9d2da296-80a8-f632-27a4-42cd91cdff3e@infradead.org>
Date:   Thu, 21 Jul 2022 07:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] ASoC: amd: enable RPL Platform acp drivers build
Content-Language: en-US
To:     syed sabakareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, vijendar.mukunda@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
 <20220721061035.91139-5-Syed.SabaKareem@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220721061035.91139-5-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/20/22 23:10, syed sabakareem wrote:
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 9c2fef2ce89f..08f5289dac54 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -117,3 +117,13 @@ config SND_AMD_ACP_CONFIG
>  	 driver modules to use
>  
>  source "sound/soc/amd/acp/Kconfig"
> +
> +config SND_SOC_AMD_RPL_ACP6x
> +        tristate "AMD Audio Coprocessor-v6.2 RPL support"
> +        depends on X86 && PCI
> +        help
> +          This option enables Audio Coprocessor i.e ACP v6.2 support on

If that "i.e" is supposed to mean "that is", then it should be "i.e.".
Or does it mean something else here?

> +          AMD RPL platform. By enabling this flag build will be
> +          triggered for ACP PCI driver.
> +          Say m if you have such a device.
> +          If unsure select "N".

-- 
~Randy
