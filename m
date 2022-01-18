Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0864926E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiARNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242181AbiARNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642511662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfPcLWqi6SZLWlgUKc6INmjHHY/xRBa8vL1E7Hp3TMk=;
        b=NqRW7ef9O0rUP6VyQ/6Yjagv0YybtEmcLYf8FJ6NlDSvtv6cWG5bhSdyawsBFWOIyEfZ/v
        GC/DH/QrLlmOdVTRRc8YnpB9coe7pN76uVMtlKPGmk5IEdU2xn2TRbMuoi1NijesMaf8u3
        uHNVUwE1HrdG1ajADVDfa1SOadCbZRY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-HrvKear9P5qRb7Z9xrWqvw-1; Tue, 18 Jan 2022 08:14:21 -0500
X-MC-Unique: HrvKear9P5qRb7Z9xrWqvw-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so16980758edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UfPcLWqi6SZLWlgUKc6INmjHHY/xRBa8vL1E7Hp3TMk=;
        b=1iwREgAEhKSCBRJIMFh4sE9MC/zHh2wMs7X/HZehCLRUbERP3Ef8x/3aiMVKjpM+4P
         cYtHPYXcCP8QLx8uKQFf3UEUq1BsBKse82IkDon6AnjdKhydXKoR5kaGCfnXwrMJ+1QA
         0T1vb1ivVC9ze73TSdluCVYpEqsvvP2TV+GhU7VThqYRUXSw+pJxi7YDxCfMkulpy0wj
         NN02escPx4Zdx+HABlXjVPQz+LPpOxim81dStQjWJD9PYMidiDrcCIxPGeZc412iKD0T
         VmWvEesFTW/sfn+vNjB7wGilQ0cNXbCkZ4Dx3PLD58I/H6C4TkKswmVD5mLMUCH0iklg
         wV9w==
X-Gm-Message-State: AOAM533wheV8xJxAfghc9JGhy1TR9hMqNy4LcwVuzVttulBXkwIMz4Dl
        3WOlr+0MmOn6jfLsaRKMgnk9jtcDI3Vv4Fp03LbG6VVcKOHFycvKrTD1hmeGzLh+l5lTduPA34a
        z9eKc/32CfKs3MsDDMnwq0f35
X-Received: by 2002:aa7:c6c1:: with SMTP id b1mr25552635eds.172.1642511660069;
        Tue, 18 Jan 2022 05:14:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVXPBkyZaCbHIx/HBCeq3N73EccAH4eC6n2rvzGk7A3reUfBMaU6vShbC6aQz7gJjmFLNErw==
X-Received: by 2002:aa7:c6c1:: with SMTP id b1mr25552617eds.172.1642511659862;
        Tue, 18 Jan 2022 05:14:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? ([2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 24sm5351050ejg.47.2022.01.18.05.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 05:14:19 -0800 (PST)
Message-ID: <d8542235-01ff-e04f-84c6-53259ab845b9@redhat.com>
Date:   Tue, 18 Jan 2022 14:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next] power: supply: fix table problem in
 sysfs-class-power
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220118021522.1672-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220118021522.1672-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/22 03:15, Randy Dunlap wrote:
> Add a bottom table border to complete the table format and prevent
> a documentation build warning.
> 
> Documentation/ABI/testing/sysfs-class-power:459: WARNING: Malformed table.
> No bottom table border found.
> 
> Fixes: 1b0b6cc8030d0 ("power: supply: add charge_behaviour attributes")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Randy, thank you for the patch.

Sebastian, assuming you will merge 5.17-rc1 into your tree, this could
be merged through your tree (since this is a psy patch).

Since I've merged the original patch introducing this; and since I've
a bunch of other fixed lined up for 5.17 already, I would also
be happy to merge this through the pdx86 tree. Sebastian, please let
me know how you want to proceed with this ?

Regards,

Hans



> ---
>  Documentation/ABI/testing/sysfs-class-power |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20220117.orig/Documentation/ABI/testing/sysfs-class-power
> +++ linux-next-20220117/Documentation/ABI/testing/sysfs-class-power
> @@ -468,6 +468,7 @@ Description:
>  			auto:            Charge normally, respect thresholds
>  			inhibit-charge:  Do not charge while AC is attached
>  			force-discharge: Force discharge while AC is attached
> +			================ ====================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
> 

