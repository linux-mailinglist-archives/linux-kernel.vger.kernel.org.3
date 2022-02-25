Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7599A4C415F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiBYJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbiBYJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D282B2782B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645781074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g96ZVNvLrOLa+/sOTt4MsYn0WW+lDjtbFUs1A2su27M=;
        b=AIarqR4SaNeeJjrHTQMhSZqU1VJ2yNQg5dLjoMisGbuYc52nMqROp/X96tBToW3AEi+3om
        t0n6YmICCDaaE5pdZLSmcBD2j91XwYWDCdBDWWONW5CsVRRhY8iF5o5xEOqdEAFGTQYc9w
        baZ1dOwO1R4pPOEqEiZuByDChygLBKg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-h-507ZwMMPaldjXn7Yh9HQ-1; Fri, 25 Feb 2022 04:24:33 -0500
X-MC-Unique: h-507ZwMMPaldjXn7Yh9HQ-1
Received: by mail-ed1-f69.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso218450edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g96ZVNvLrOLa+/sOTt4MsYn0WW+lDjtbFUs1A2su27M=;
        b=mJo4yh0sHrHp2gqsgEtKmg2GYHWABJSFnK07oua4RyA7KtjdEFiNsPUxWsl1pSwTUW
         5SG+4us5MYrv0ozwt2m6Ud82ipOM2Cw7OzPgTLkGV/+upeXOT/KZALvHrybvKk1as8c2
         Ey704sdfqem+du7QMMbK0pRUvlUBMA0/mCrCTxiWIQPAmb4/4LSGVXWGjTze67L4oNnE
         awUUuDRFFVGQvNRzyphB1CD1MS7jCSyFnS4G+YPRAXSXtrGY4jEIv7UJDJIBIfEE5Nvb
         5Fb1bGRqSvNWWsWKKeGnnBsz8/y9zFViaisoBhERBK9jo2pG+YHLcF+0Ge7EKdCZiijW
         M4FQ==
X-Gm-Message-State: AOAM530iijeOT4JrHbOkj+MLzde2qtPsSgqxcqUQZXEkRrGFSshTArCU
        0URwdjPkSoI5JliUk9Pbjw3BiQp6p3PaEIcuiUxYi6wHu1T3tbHvJ+cUBPRYrq4Mr2jJNeHAOQ7
        KBKhJq40dX4oGaDM8ZTKc5WBg
X-Received: by 2002:a05:6402:4495:b0:410:a171:4444 with SMTP id er21-20020a056402449500b00410a1714444mr6216766edb.20.1645781072035;
        Fri, 25 Feb 2022 01:24:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0eYLNyrWUAkPpwNRuhHc6bulLWQnInGVAT//ekRVG8G32hyLnRX9/+ykMmoIWE+zm2NAjdw==
X-Received: by 2002:a05:6402:4495:b0:410:a171:4444 with SMTP id er21-20020a056402449500b00410a1714444mr6216756edb.20.1645781071846;
        Fri, 25 Feb 2022 01:24:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y18-20020a056402271200b0041110d6b80asm1075169edd.39.2022.02.25.01.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:24:31 -0800 (PST)
Message-ID: <f54a44e7-1ae5-1e09-9e62-2039dd5639dc@redhat.com>
Date:   Fri, 25 Feb 2022 10:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] vboxsf: Remove redundant assignment to out_len
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220225074838.553-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225074838.553-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/25/22 08:48, Jiapeng Chong wrote:
> Clean up the following clang-w1 warning:
> 
> fs/vboxsf/utils.c:442:9: warning: variable 'out_len' set but not used
> [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v2:
>   -Delete " out_len += nb;".
> 
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index e1db0f3f7e5e..7f2838c42dcc 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;

