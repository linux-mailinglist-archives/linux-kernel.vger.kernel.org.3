Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A755D911
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiF1IIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiF1IIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:08:16 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D461227160
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:08:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id c13so16356524eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=18X+hex7aoFW0QzJE9v3+aXTpxiBPOEIdUGKtgp1ElU=;
        b=sEfV0UvjNHgsyFAhk176quA/9K7eaWfUTQqhX3aHhF0GVaMwgEqtGMh67ArJxF6btO
         zd1RTB4sDm0t4pD2gij6ZzwB5iWCOxIdWWgybw/x+QoAlmJbhOAR8qax3oxXI1DDvf9I
         /Hr3kHcVX3GH1S9gsysAHKO+7RcaIxSjKzNeEKaw0iXZlqtSH9H6C0nrvzCsnf7Ptc3r
         c3LCI2167uSLG47uKZUfRCpC5DIVOUSjOtnT9E71Ygy2tEWNXCxzrs1GzpnjbBjWTNal
         demKrV2jM2JoKdET3KBccYq8LjL04eTpup5pNDp2yhuZ+ykAv0Afclt77GrtsCBCA5R5
         /QuA==
X-Gm-Message-State: AJIora/gDhBcjSvcSZCqrbqOwSGYMHiyD5umgxF4iASzkgZGDh9kaZto
        jECVvgDu1fGXP3OosPQhXzz+eZepbs8ogg==
X-Google-Smtp-Source: AGRyM1tOnblXgOhZSaUBDoVv1Po5DInU2YJDWPeTw84HJM8oOSaNys9t4FgiJn74ttjhNOmSKNGClA==
X-Received: by 2002:a05:6402:330d:b0:435:95ae:9b1e with SMTP id e13-20020a056402330d00b0043595ae9b1emr20976279eda.402.1656403694332;
        Tue, 28 Jun 2022 01:08:14 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id pv1-20020a170907208100b00726abf9cd8esm1900955ejb.125.2022.06.28.01.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:08:13 -0700 (PDT)
Message-ID: <10b4e5f7-95b9-38e6-bcd5-1132d595301c@kernel.org>
Date:   Tue, 28 Jun 2022 10:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] vt: fix memory overlapping when deleting chars in the
 buffer
Content-Language: en-US
To:     Yangxi Xiang <xyangxi5@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
References: <20220627125428.19885-1-xyangxi5@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220627125428.19885-1-xyangxi5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 06. 22, 14:54, Yangxi Xiang wrote:
> A memory overlapping copy occurs when deleting a long line. This memory
> overlapping copy can cause data corruption when scr_memcpyw is optimized
> to memcpy because memcpy does not ensure its behavior if the destination
> buffer overlaps with the source buffer. The line buffer is not always
> broken, because the memcpy utilizes the hardware acceleration, whose
> result is not deterministic.
> 
> Fix this problem by using replacing the scr_memcpyw with scr_memmovew, and
> preserving the memcpy optimization when the buffers are not overlapping.
> 
> Fixes: 81732c3b2fed ("Fix line garbage in virtual console").
> Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
> ---
>   drivers/tty/vt/vt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index f8c87c4d7399..d87bff9d8ed5 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -853,9 +853,13 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
>   static void delete_char(struct vc_data *vc, unsigned int nr)
>   {
>   	unsigned short *p = (unsigned short *) vc->vc_pos;
> +	unsigned short cp = (vc->vc_cols - vc->state.x - nr) * 2;
>   
>   	vc_uniscr_delete(vc, nr);
> -	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
> +	if (cp > nr)
> +		scr_memmovew(p, p + nr, cp);
> +	else
> +		scr_memcpyw(p, p + nr, cp);

Why not to use memmove in both cases? I.e. simply switch scr_memcpyw to 
scr_memmovew?

thanks,
-- 
js
suse labs
