Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5312659FD96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiHXOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbiHXOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0D57E00A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661352882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrZSLuJn7B95IjdTvMo0o8DoEvcK6JOywKMgoVwD7sU=;
        b=gaxgVd7BW5ZYJhHfOYahw1otJvN7J7kcnY+lmv7dtq80Gt6HohEcc0Gu9yNc79JyMP1Tej
        VwvwRqQZJSbqOx9RMkKQSgUpaYuMwHwVbGOlSdfM+SPSOygALDYnhCwklVoRrIwzW2uWuW
        3NKYscBROuhcfI6gl7ImRxhh7SNA2L8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-bQ0vFxE0OSuUiwFOPEVbIA-1; Wed, 24 Aug 2022 10:54:41 -0400
X-MC-Unique: bQ0vFxE0OSuUiwFOPEVbIA-1
Received: by mail-qk1-f198.google.com with SMTP id bq19-20020a05620a469300b006bb70e293ccso14776805qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mrZSLuJn7B95IjdTvMo0o8DoEvcK6JOywKMgoVwD7sU=;
        b=l9HoUnfQCaYvDy15iJXOzgJhJJSD9NPTgmZfaeJbVDj+U6rNUkUDgSoBk5K2jV3t14
         U82IU9NDpFzlQ+X4jQfoktqdw4IAlCkyDwlQ71nwQUP73FN4QEF5cYhi9QTbcVAnw+Jb
         29ZCIbf4ZofW4phepJ1juoAbQRaedXa4lfihCwdmtzvg9SDkg9nFO4ChbPCivHnWtuz1
         FX9S/yTgSQjSt5PWuZb2qxZVu2r7VIgcS8/C212oxPeMH5thc1tMPuAd0NZOFNDzDHHO
         BvCX4L33ixu/1+y5RfRJcxcOwy/lh7lCxpJxCiSKS7A03/iKHRj3dLkmRi0XrPgGdPWl
         FA2Q==
X-Gm-Message-State: ACgBeo1srht1c8tMMXf6UgnfY90HtO5yYQ12BYrDV7o6NIXGRSFRoRDi
        IALa+xldfmR5PNo9pasPSHvksFxGLIVK0/5e7BhG4n2RUjMOJXvFcNrquJ4WU3Vt64ypz8IPrW3
        AIOxNIx0G+g28x8CGGFn2NbX4
X-Received: by 2002:ad4:5bc1:0:b0:496:fd12:3ece with SMTP id t1-20020ad45bc1000000b00496fd123ecemr7680924qvt.27.1661352880150;
        Wed, 24 Aug 2022 07:54:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR72UV2K5dJzouj4ToPdOWBwcYlwAP0Cd9FyhdTNvGwm0EbEWDmnYH4YmbPekZsiI1DdyE3m+g==
X-Received: by 2002:ad4:5bc1:0:b0:496:fd12:3ece with SMTP id t1-20020ad45bc1000000b00496fd123ecemr7680904qvt.27.1661352879925;
        Wed, 24 Aug 2022 07:54:39 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006baef6daa45sm14408647qkj.119.2022.08.24.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:54:39 -0700 (PDT)
Message-ID: <aafa0c1e-647a-1c76-ed20-1d424d222768@redhat.com>
Date:   Wed, 24 Aug 2022 10:54:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in BONDING DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824072945.28606-1-lukas.bulwahn@gmail.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <20220824072945.28606-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 03:29, Lukas Bulwahn wrote:
> Commit c078290a2b76 ("selftests: include bonding tests into the kselftest
> infra") adds the bonding tests in the directory:
> 
>    tools/testing/selftests/drivers/net/bonding/
> 
> The file entry in MAINTAINERS for the BONDING DRIVER however refers to:
> 
>    tools/testing/selftests/net/bonding/
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
> 
> Repair this file entry in BONDING DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please ack.
> Jakub, please pick this on top of the commit above.
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ce15257725b..7d2141516758 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3671,7 +3671,7 @@ F:	Documentation/networking/bonding.rst
>   F:	drivers/net/bonding/
>   F:	include/net/bond*
>   F:	include/uapi/linux/if_bonding.h
> -F:	tools/testing/selftests/net/bonding/
> +F:	tools/testing/selftests/drivers/net/bonding/
>   
>   BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
>   M:	Dan Robertson <dan@dlrobertson.com>

Acked-by: Jonathan Toppins <jtoppins@redhat.com>

