Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6654589778
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiHDFrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiHDFrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:47:22 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9860697;
        Wed,  3 Aug 2022 22:47:12 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id c24so4209557ejd.11;
        Wed, 03 Aug 2022 22:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+Qy5efYo9rDk2BsamMw6aPZr7j8DOLrxvf8t4GZMPAc=;
        b=e4j4DTK4TpZ50GqUq+QmB6n96AUftRtepLJXdnFw2973CuBoZtfN7hTjBlVwqNdp6J
         VfxMjNJgNeZVkx4kHllU3l0iNk16CAlQq6yJ2s1KZri/Bo3zrgNTT2glpQXckp04CM7x
         5DhAqGU0NjibJQP7JooDVfJq7TmKhPrKzEhZwq0fFJCS+LGysyz+CkcMDmBcLIGXHK1B
         uxPJ7ifdTSg7D2oj4zGDRNx3mQgO7a41+wODmzEN2H9cqLScDAXfp/X6kauvfBolQ4VL
         l73YyxSlOm7Xes/VQNQwcoDDXAkf88eEAuWJ5YA0ThIBM95bH88bPg74idpAzyOKrcik
         1ehw==
X-Gm-Message-State: ACgBeo2MHZtsJ5kseGfNoVT4pgTSa4U6USBfaEii6sJC2stM3hvwAya/
        FQxZ2j3FSvGYtTv4O66JcMI=
X-Google-Smtp-Source: AA6agR4oUuaNBzJoYT26uMDLtGGEjB1kpaM/SRsRVEbHpQbaFOy7rHx5Ud1iTdXfq+qFj1rrnNWe+Q==
X-Received: by 2002:a17:907:3ea8:b0:730:9756:7c81 with SMTP id hs40-20020a1709073ea800b0073097567c81mr189092ejc.726.1659592030840;
        Wed, 03 Aug 2022 22:47:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e3-20020a1709067e0300b0070efa110afcsm8002633ejr.83.2022.08.03.22.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 22:47:10 -0700 (PDT)
Message-ID: <1eb62346-304b-54d5-8a62-8a35888d51bd@kernel.org>
Date:   Thu, 4 Aug 2022 07:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: selection: Add check for valid tiocl_selection
 values
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de> <YuV9PybMPgc83Jis@p100>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YuV9PybMPgc83Jis@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 22, 20:49, Helge Deller wrote:
> The line and column numbers for the selection need to start at 1.
> Add the checks to prevent invalid input.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index f7755e73696e..58692a9b4097 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -326,6 +326,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
>   		return 0;
>   	}
> 
> +	if (!v->xs || !v->ys || !v->xe || !v->ye)
> +		return -EINVAL;

Hmm, I'm not sure about this. It potentially breaks userspace (by 
returning EINVAL now). And the code below should handle this just fine, 
right:

> +
>   	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
>   	v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
>   	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);

?

thanks,
-- 
js
suse labs
