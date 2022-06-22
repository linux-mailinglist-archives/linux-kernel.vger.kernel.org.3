Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809F5555514
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376798AbiFVTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiFVTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:50:07 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14240903;
        Wed, 22 Jun 2022 12:50:06 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BDA954162B;
        Wed, 22 Jun 2022 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655927404;
        bh=EkPLoMlB5urjTl/KfgKOygiZqi6zn+K/seeJTHaMOME=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FSNbigvl5J71VArTsLrqadPIQK76Q8y+Ll+gjMoPoF4ZDMzxmEKfCIy/bUBXYuxxb
         x/PSOaQY8hS1Egjv5/a4nvocVSJO8cPuWTO83ppDM4qugJuyJvU/CX6z+O/b7aHijr
         TvChCox9Fs214d4wWnsgugtQobh3h6BOZJxelzyAQu3n/0O2Lvm/jFVlfpp0CTK0Gr
         1SY7W3OOD8HClN3PHJktYqPGA9a0C6SG3BbbBkXylsL4+OBA9xouogdOKzx4Kd0rdr
         EEL+bCJnEJMeekndLPNb3XjRoMBtMwkGyPpnAptMvgNCOeuJXjA/owdGPoLwCdrV5k
         /k38nwUDRIqXQ==
Message-ID: <3839b02b-36b2-a722-83f9-1e86e66746f2@canonical.com>
Date:   Wed, 22 Jun 2022 12:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] apparmor: Fix memleak in
 aa_simple_write_to_buffer()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220614090001.155107-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220614090001.155107-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this feel through the cracks some how.

Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into my tree and send it up with my next pull request.

On 6/14/22 02:00, Xiu Jianfeng wrote:
> When copy_from_user failed, the memory is freed by kvfree. however the
> management struct and data blob are allocated independently, so only
> kvfree(data) cause a memleak issue here. Use aa_put_loaddata(data) to
> fix this issue.
> 
> Fixes: a6a52579e52b5 ("apparmor: split load data into management struct and data blob")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/apparmor/apparmorfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 8b9c92f3ff95..0275a350dc23 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -403,7 +403,7 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
>  
>  	data->size = copy_size;
>  	if (copy_from_user(data->data, userbuf, copy_size)) {
> -		kvfree(data);
> +		aa_put_loaddata(data);
>  		return ERR_PTR(-EFAULT);
>  	}
>  

