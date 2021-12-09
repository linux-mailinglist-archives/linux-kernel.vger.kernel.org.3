Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9E46F715
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhLIWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:55:37 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:42725 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhLIWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:55:36 -0500
Received: by mail-pj1-f46.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so6067243pjb.1;
        Thu, 09 Dec 2021 14:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bN7p0XlvZZzc+pBE4f4F2grf51ikkOotR4e1Y3vWKY=;
        b=2sVs8ymp7a7AIe/5FRsW26Kz83VFdvVoGK9aTJclV47IoDOyq+orKo3tynlT2bU5zl
         SSY9MClVjtJbexhWpn9Z5b2oaKJmRcbPelm7BbHBd773ud6ep0hPg8hijcRRuhbMEG2d
         FA13CXOf7Dg7UCYicOVfybqiyyLzTHknEPrD0DhWnzV1srJwly4+LDtM1zdGSloUmibT
         8MEBzz1vbyO1ld+Cf8IdX0x7MZhmEQ5cRNmkmJH1SBu4hDS6X8li64hOx1ojFhq2mY6H
         rurSA+cVPz39rpqJCs1Vku7ckOoKIZTc1mvl+5eZk8ejQzvcTGYeky+I9YYjr/j/yy+A
         Zy0Q==
X-Gm-Message-State: AOAM531zlDPCIXvgzM211TWbmRXXykMXNGN3nGf8+reuvcgnA68gSb/4
        vxYElW8tdAAzt9j4xcscTmGYFeNQj7g=
X-Google-Smtp-Source: ABdhPJwIeLgH3cTMLX6FlAYpzZCoSN7BQFRNcVI2vviKW6zIVvb2HidcbQm6Cn+hYAjo5T9MJrK8Qg==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr19369976pjb.142.1639090322206;
        Thu, 09 Dec 2021 14:52:02 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id rm1sm10710861pjb.3.2021.12.09.14.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 14:52:01 -0800 (PST)
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
Date:   Thu, 9 Dec 2021 14:51:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208013534.136590-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 5:35 PM, Eric Biggers wrote:
> +What:		/sys/block/<disk>/queue/crypto/modes/<mode>
> +Date:		December 2021
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] For each crypto mode (i.e., encryption/decryption
> +		algorithm) the device supports with inline encryption, a file
> +		will exist at this location.  It will contain a hexadecimal
> +		number that is a bitmask of the supported data unit sizes, in
> +		bytes, for that crypto mode.
> +
> +		Currently, the crypto modes that may be supported are:
> +
> +		   * AES-256-XTS
> +		   * AES-128-CBC-ESSIV
> +		   * Adiantum
> +
> +		For example, if a device supports AES-256-XTS inline encryption
> +		with data unit sizes of 512 and 4096 bytes, the file
> +		/sys/block/<disk>/queue/crypto/modes/AES-256-XTS will exist and
> +		will contain "0x1200".

So a bitmask is used to combine multiple values into a single number? Has it been
considered to report each value separately, e.g. 512\n4096\n instead of 0x1200\n?
I think the former approach is more friendly for shell scripts.

> +struct blk_crypto_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct blk_crypto_profile *profile,
> +			struct blk_crypto_attr *attr, char *page);
> +};

It is not clear to me why this structure has been introduced instead of using the
existing kobj_attribute structure?

> +static int __init blk_crypto_sysfs_init(void)
> +{
> +	int i;
> +
> +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> +	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
> +		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
> +
> +		attr->attr.name = blk_crypto_modes[i].name;
> +		attr->attr.mode = 0444;
> +		attr->show = blk_crypto_mode_show;
> +		blk_crypto_mode_attrs[i - 1] = &attr->attr;
> +	}
> +	return 0;
> +}
> +subsys_initcall(blk_crypto_sysfs_init);

Would it be possible to remove the use of subsys_initcall() if the crypto attributes and
blk_crypto_modes[] would be defined in the same file?

Thanks,

Bart.
