Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BD569BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiGGHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiGGHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:34:14 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBF27CEB;
        Thu,  7 Jul 2022 00:34:13 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id d2so30958990ejy.1;
        Thu, 07 Jul 2022 00:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k8tCCPWhXFVw0Grisrt5wFNoaTf/P1qQq3zFo+9VxAU=;
        b=rWXLdaf2OeP5L+OqvLqX7kccZvzNu/Sbm/Z5qqMCsQnFaDuAilP78E3VnRA3kTK2ce
         KeJT7AVKnDcBBdFgZsCLpMsHc34MfuO/YIoXzkooM/whrNtlHPXxyoP1nn4zfl8b7E4L
         RPTMbicDIB3nGPOc6MkjpzDi4YGasZhibkOWIh6iKGIQ36g7Nkx14ooqicAqgeS0vWHj
         3/J7OscqtBM5OSAk4+zmPSYP/vs5tYa1tnfxZteDQmlANeV1hwFLyo+Uil2Dj+dYk6j8
         CvviQerZP8lg6Yd4oVMPB3asgZhuRR1YaiBJU6b4234xfQM/42vcHHOmeJWA1hxmOHqa
         ynCQ==
X-Gm-Message-State: AJIora/5uptEBwd6GXpSYGJLFG+MWL02JX+QaqTjrIhoEWrJhRKpwY9q
        YMyL+6W4Pi6aR1fAeI15HBmkZRVJyTk=
X-Google-Smtp-Source: AGRyM1u/+uQThAQr5NmhyoCOv3AsBtJTeHBUK7T9xKARuWT3qKFBeJ52TvhvRE15BiwRm4rk1JYfkA==
X-Received: by 2002:a17:907:16a2:b0:726:abbc:69bf with SMTP id hc34-20020a17090716a200b00726abbc69bfmr42564140ejc.363.1657179252575;
        Thu, 07 Jul 2022 00:34:12 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b0043a896048basm3299207edb.85.2022.07.07.00.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:34:12 -0700 (PDT)
Message-ID: <17759c4b-5858-12bb-4beb-c4a1d58c89ae@kernel.org>
Date:   Thu, 7 Jul 2022 09:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] tty: n_gsm: fix missing corner cases in gsmld_poll()
Content-Language: en-US
To:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DB9PR10MB5881A05367C31A390EC3A042E0839@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <DB9PR10MB5881A05367C31A390EC3A042E0839@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 07. 22, 9:00, Starke, Daniel wrote:
>>> @@ -3051,14 +3051,20 @@ static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
>>>    	__poll_t mask = 0;
>>>    	struct gsm_mux *gsm = tty->disc_data;
>>>    
>>> +	if (!gsm)
>>> +		return EPOLLHUP;
>>
>> Hmm, how can this happen? It's a tty bug if it calls ld ops after NULLing
>> disc_data.
> 
> I can remove this check if it is redundant. Should I?

Sure as it makes little sense anyway. Even if gsm was non-NULL here, the 
backing disc_data would be freed on the accesses further.

thanks,
-- 
js
suse labs
