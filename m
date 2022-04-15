Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796DC501F65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbiDOAEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347867AbiDOAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:04:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA1AAB5E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=v2Dn6qtvKX9phF9c++5hboesgqNOkOUVB6NrTw92XNw=; b=qjfgI842dUFH+bNI1oFu9a4fJi
        17/vob0IxmH8C1n6WdZhGqOstu6pL3DY33dsJ48tiDWfJEjHhxmaxNj+Gw273XjBGPCUhuotBzCBr
        iNlqogqPRlmOFIM4Q4wsKow+BZzCDFnqt+ve9nOd8p8LcNAKn5ShUAIldrZL32xiWbhL7Qe3av3q5
        5zDpaDra5C3dTfPhcQkBwULaN7QIGMcnY+SqIvtoZT/8ivzwqZFzSzUfH/n9kEenDYrW11qjGnKxO
        nPTyHV8W8IOnWvVTgEJnmJTtDf6R+aD1xYoiBdlqZl1+gN4B+Ez/CnCUP8D9S+3PnA0UvZBW3fnbb
        Bz/Bc6Cg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf9P8-005Bn5-Sb; Fri, 15 Apr 2022 00:01:39 +0000
Message-ID: <292dcb6e-6f23-7e61-7927-5b6fe5911f97@infradead.org>
Date:   Thu, 14 Apr 2022 17:01:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next V2] sound/oss/dmasound: fix 'dmasound_setup' defined
 but not used
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220414091940.2216-1-miles.chen@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220414091940.2216-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/22 02:19, Miles Chen wrote:
> We observed: 'dmasound_setup' defined but not used error with
> COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.
> 
> Fix it by adding __maybe_unused to dmasound_setup.
> 
> Error(s):
> sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]
> 
> Fixes: 9dd7c46346ca ("sound/oss/dmasound: fix build when drivers are mixed =y/=m")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Cc: Takashi Iwai <tiwai@suse.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Change sinve v1:
>  add fixes tag
>  use __maybe_unused
> 
> ---
>  sound/oss/dmasound/dmasound_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
> index 9c48f3a9e3d1..164335d3c200 100644
> --- a/sound/oss/dmasound/dmasound_core.c
> +++ b/sound/oss/dmasound/dmasound_core.c
> @@ -1428,7 +1428,7 @@ void dmasound_deinit(void)
>  		unregister_sound_dsp(sq_unit);
>  }
>  
> -static int dmasound_setup(char *str)
> +static int __maybe_unused dmasound_setup(char *str)
>  {
>  	int ints[6], size;
>  

-- 
~Randy
