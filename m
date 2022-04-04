Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F54F1E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382523AbiDDVvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380054AbiDDStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:49:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7630F7F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:47:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j83so11001357oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Hoq9zXJV39q89hBa70SrMFhPx8RZY0vhEzpf12yaGE=;
        b=LSDGLhsnVOEx9ODwTEz2zHFdkwTWjGz5Yo86ybGpgs1MipIaI4GOjquCyXvF9ddLuM
         VoaKZ6VLJF53zEIJDCd4sMGtAQFALWJeU5zPvaToQUZ0owHRy3bMhnaD2Lgjr8O4sfEb
         5UuE4j3b8f5YfXQt0y6PC6UZljX+obS8xTeM5hh6Yh1d2dNhmGJE+WOdiQmqLFHTaHTB
         USikjQjDFJ2FnR/mouImDqGzIdaPd5up5AHTQvOGmZGSabhc0sAMMwcuHHitW+3Ay2TA
         QntueumZ9NdCyF/kx897lTqDNdgz9Z7lx9lwsZbIjR0B0EsRsCiWp2+gpmM5suJQGgVx
         oUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Hoq9zXJV39q89hBa70SrMFhPx8RZY0vhEzpf12yaGE=;
        b=c7+YmtNrME48wHN1tJIy12giUKBsCGndo5ZapdURT5muRgqGnvPJaAGexewbVp3mFx
         Nxk2Yzo9Pm9eXYO+iv4xNU4rZ7MQMCxyFXBd/HHlH1xrXS+d1a2Hx74r9mlKS+D/1yA7
         gD+q/I5HVv69sECHetM9D9A78Yb0f6DqdrBHmuqqD8SvwGOT22dkwfBfEKUj6QyV9Mv4
         HRX2b7NBhKK8as9732hWJLVLRAzgjyx8SsCuEQbHvYQ1EupBgJ0AxQfAg3WUP6BEWE/M
         AMQN2jw+mj6obeFvwZIkbdUAPIlpm/jhbNsVvzstuRxiw/iflUWLnAAj2d3puEpp+e5X
         qYvQ==
X-Gm-Message-State: AOAM533WZX3+IYjUwgmWLYVv8J8II2sKac9Ls8v6t7/er7d+YU27xGUa
        i1rihVepdQMpDfYA4enxK4Hx7ZCBeQE=
X-Google-Smtp-Source: ABdhPJzEjbx27tmxLs/LVr3uhQkFFqUI9HaEIAsh0oSN0nUwdqNC2wsAJHzzG7/fEE8PMynXI3Gtkw==
X-Received: by 2002:aca:2b14:0:b0:2ef:89b7:a885 with SMTP id i20-20020aca2b14000000b002ef89b7a885mr264764oik.16.1649098055299;
        Mon, 04 Apr 2022 11:47:35 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id u16-20020a056808151000b002f734da0881sm4708936oiw.57.2022.04.04.11.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:47:34 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c8461d9c-dda1-3c1e-0e3b-169073e8c4d0@lwfinger.net>
Date:   Mon, 4 Apr 2022 13:47:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] staging: r8188eu: Add line after declarations
Content-Language: en-US
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
 <19d8f316e43d16c9341f7fe94e68534cf60cc05c.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <19d8f316e43d16c9341f7fe94e68534cf60cc05c.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 09:39, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 7c664f80fa99..f7811b46db1c 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -313,6 +313,7 @@ void nat25_db_cleanup(struct adapter *priv)
>   
>   	for (i = 0; i < NAT25_HASH_SIZE; i++) {
>   		struct nat25_network_db_entry *f;
> +
>   		f = priv->nethash[i];
>   		while (f) {
>   			struct nat25_network_db_entry *g;
> @@ -339,12 +340,12 @@ void nat25_db_expire(struct adapter *priv)
>   
>   	for (i = 0; i < NAT25_HASH_SIZE; i++) {
>   		struct nat25_network_db_entry *f;
> -		f = priv->nethash[i];
>   
> +		f = priv->nethash[i];
>   		while (f) {
>   			struct nat25_network_db_entry *g;
> -			g = f->next_hash;
>   
> +			g = f->next_hash;
>   			if (__nat25_has_expired(f)) {
>   				if (atomic_dec_and_test(&f->use_count)) {
>   					if (priv->scdb_entry == f) {

Acked_by: Larry Finger <Larry.Finger@lwfinger.net>

That applies to both patches.

Thanks,

Larry
