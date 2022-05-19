Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2052CECB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiESI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiESI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:58:17 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED79D07B;
        Thu, 19 May 2022 01:58:16 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 133E03F772;
        Thu, 19 May 2022 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652950695;
        bh=6Oiy096Izr3Tq4XztfXw7/ZW6D9X51nuLlYFuMD7TmQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kV/CHRNZ8/8/6TaUJ7JvtwUlZA7u8gYrz5wx3lfB9IsTH7dtAXsVE570QpXwUiX02
         +j+DQ/CIBUVxEa0lq8el+X/LEjVo9TW3AcU47SBVQihm8HQV9dnVSFyhHVp55mnFgk
         8ZJtULDrNmGkg91iJret+rjPQZemhhiginYk7CeRCBbJT4Xfyg2sy2jL/g8xaRBjvA
         nmbJzoasZx8/ythRDbOlRBJSSi4DruV16tviuGClObbaSs2ADk7+c/hntzKr9gA1vn
         tZGUpk7SMJj48xm9gK/rh5tcw8IIRUx9W4iHiXtWRsNY5l1ItgmxNez69BQkA1t0go
         kGjY4VKSO5OAg==
Message-ID: <b217377a-8675-f17f-05d6-695e424b3d4b@canonical.com>
Date:   Thu, 19 May 2022 01:58:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] apparmor: fix reference count leak in aa_pivotroot()
Content-Language: en-US
To:     Xin Xiong <xiongx18@fudan.edu.cn>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
References: <20220428033907.1658-1-xiongx18@fudan.edu.cn>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220428033907.1658-1-xiongx18@fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 20:39, Xin Xiong wrote:
> The aa_pivotroot() function has a reference counting bug in a specific
> path. When aa_replace_current_label() returns on success, the function
> forgets to decrement the reference count of “target”, which is
> increased earlier by build_pivotroot(), causing a reference leak.
> 
> Fix it by decreasing the refcount of “target” in that path.
> 
> Fixes: 2ea3ffb7782a ("apparmor: add mount mediation")
> Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>

thanks I have pulled it into my tree

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/apparmor/mount.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index aa6fcfde3051..d0b19ab9137d 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -718,6 +718,7 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
>  			aa_put_label(target);
>  			goto out;
>  		}
> +		aa_put_label(target);
>  	} else
>  		/* already audited error */
>  		error = PTR_ERR(target);

