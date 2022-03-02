Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830F4CA35F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiCBLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbiCBLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78B47DFC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646219867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2X8GxD21SAhhZdIvnCz2edJioDnTkcdOU0+RAKaTdzc=;
        b=aexadk79nwkCvwRfFdsZaHNVwOVBYPI3al8Hgzqxw5dhQtfY2sxTb4WqsOsZmBJQjU79Me
        Ae+1PJQ5hl23bALc+cYsPpR3t0F/QBrr2Q02EPt0nu6JDG6xOyQMgwB20N5pz7biLqkr6R
        C5m8lQN9dd3Bcm23dbWNqM76FQnJFPQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-0uXEaCaROHuKE-0DarhYAg-1; Wed, 02 Mar 2022 06:17:46 -0500
X-MC-Unique: 0uXEaCaROHuKE-0DarhYAg-1
Received: by mail-ed1-f72.google.com with SMTP id eg48-20020a05640228b000b00413041cd917so812500edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2X8GxD21SAhhZdIvnCz2edJioDnTkcdOU0+RAKaTdzc=;
        b=gASE7zh+KHgB7f/GOhKDondJQyKcAMcbtQtHsB6ZKL0F65GwewUiqaOomSZrzl8OPf
         Rhpj9OhQuIpe+xbt+Pcd9k3P2bSm6/y6hWlTlQ0bBVafdfJbqJKu/yghzewKnVZOocIj
         xn6u4D6UFy+conpJfpHKYiooATfT17t8silqRMOTIwZ3tKE1eI46tE1pjxDStKHSpsa1
         s4oUTw4FnMDPhYGsL9xIfxps0iMPiQZEVPJaSSL7nRB+SKwGlyKFANW9aGjAfMCZBCaO
         QrgzqAkz3LJEXcvexnqroFpp8XyhCuoZTZJJd9J6ipzW+y74BJc+0uajc4Yy5l/UyCXO
         AoRA==
X-Gm-Message-State: AOAM530f517Nrd2uUb2y8uO1oE8YVYkYi+InPIVJXQ9JNke8yAkUawZH
        7ohJBAD3yTM/dJdYAYLqCEzdAZz9+1+/YEFKsuxXnVoXKYmyZU6HcbX1eXqYfcORp2FhnAObSJo
        zJ12kEY9YEYhfT4rbYCUb01HW
X-Received: by 2002:a17:907:6218:b0:6d1:c74:1507 with SMTP id ms24-20020a170907621800b006d10c741507mr21510157ejc.670.1646219863303;
        Wed, 02 Mar 2022 03:17:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsTsxQNCAG5cKHcFCRXeY/VSbYV9NrBdf6waIPCETjWZYNACuoETSJGfJgl1eix5EDeno8LQ==
X-Received: by 2002:a17:907:6218:b0:6d1:c74:1507 with SMTP id ms24-20020a170907621800b006d10c741507mr21509896ejc.670.1646219858312;
        Wed, 02 Mar 2022 03:17:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id qb30-20020a1709077e9e00b006d6f8c77695sm1341642ejc.101.2022.03.02.03.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:17:36 -0800 (PST)
Message-ID: <eed70d81-0781-576f-7f88-9046d23c5bfb@redhat.com>
Date:   Wed, 2 Mar 2022 12:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220302081752.7fb5afd3@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220302081752.7fb5afd3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 3/1/22 22:17, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   646f429ec2de ("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup")
> 
> Fixes tag
> 
>   Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup"
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses

Thanks. I've fixed this and done a forced push to drivers-x86/for-next with
the fixed commit.

Regards,

Hans

