Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE24E2165
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiCUHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiCUHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:30:08 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7810D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:28:43 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id n35so6334582wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKwi5Gt3SUDc2S+WoNdkoK4orpXp7AzMXC+em5s59q0=;
        b=278+Ht5TbF3PPq795Xp2twjKXa1b2uiPjP7IAtQZOhUPQEHlsxyHrYwUT9oZzs5udn
         YDJULsXDuTE4bwej8fwdWIs8isJDtg05xs0Q7LA1Yzyfnci/gAYmJrOz7K1xLfgcdAZ4
         wHmrVoRcFcja+f+hFxi1CQJO6Q/kAlxYR/SAemtFWKLa22HsRLQPCIMkQfNyRqNCQNsV
         mojKFx8tz1/C/Xg2L9IgqTQNFl781aMgSvrVTnN//FRWbP7KirREwYw6+31MK9dlPo+e
         vcy9NpkeiM8LQ7mz8WkD+pjXXhDP0Ji7Cgg2CVpJ19M67M2ZMoDMjCug5A0t7Yo/txpG
         MKqA==
X-Gm-Message-State: AOAM530IaFZiadOnDI3vtIGqmGx0eVeh0BqDjcQHpGLQkbaNUq/dbhEC
        l3sGel8Y+HiZ0Fog6YGVNJ+9n/fl73I=
X-Google-Smtp-Source: ABdhPJxk4k774Tq4QXF72GJUR8ysMptecZogF4SZLbajuuCdI/6BeaX2cByWlZxR9G1GdLI2QZDmLw==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr18790838wml.160.1647847722004;
        Mon, 21 Mar 2022 00:28:42 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm13232779wmb.37.2022.03.21.00.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:28:41 -0700 (PDT)
Message-ID: <23d3debb-cb2c-903a-97bf-eaf3a8e5b69d@kernel.org>
Date:   Mon, 21 Mar 2022 08:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2] tty: synclink_cs: Use bitwise instead of arithmetic
 operator for flags
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, dsterba@suse.com, elder@linaro.org,
        jcmvbkbc@gmail.com, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1647846757-946-1-git-send-email-baihaowen@meizu.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1647846757-946-1-git-send-email-baihaowen@meizu.com>
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

On 21. 03. 22, 8:12, Haowen Bai wrote:
> This silences the following coccinelle warning:
> drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |
> 
> we will try to make code cleaner
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> V1 -> V2: fix title subject misspelling try -> tty.
> 
>   drivers/char/pcmcia/synclink_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 78baba5..e6f2186 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -922,7 +922,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
>   		// BIT7:parity error
>   		// BIT6:framing error
>   
> -		if (status & (BIT7 + BIT6)) {
> +		if (status & (BIT7 | BIT6)) {
>   			if (status & BIT7)
>   				icount->parity++;
>   			else


-- 
js
