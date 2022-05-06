Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C049E51D532
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390826AbiEFKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390817AbiEFKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:13:34 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A6D5DA4B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651831791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLarrquML4Z2ntTSehBWvAuy0Iv5TWWpsEPFkNYG2Uk=;
        b=EsoYFGSMsucGaKbcc9kVHvnGF+Te45h8aR4OCRMJYd/0FXFXaoS0GKhlGmTO3KUUT0T8a7
        NwuHfZa5mmIcEXeqQ09JDse9Pug0V30gS3GiDy5ANz1+nHTw90J8HDKJ9SFa3GuFMBoCJd
        tmlNobfve6iYm10IknYN1CpAgwWbNYo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-IhyBaBOYPtyPUD09vlwh4w-1; Fri, 06 May 2022 06:09:50 -0400
X-MC-Unique: IhyBaBOYPtyPUD09vlwh4w-1
Received: by mail-ed1-f69.google.com with SMTP id c23-20020a50d657000000b00425d5162a0dso3755076edj.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLarrquML4Z2ntTSehBWvAuy0Iv5TWWpsEPFkNYG2Uk=;
        b=j+sf8jUcvp8C4b1JuTa1KW10Ue7mZcnzWPnBpcrMhMjE1TRN336cayRJcMzMwDvpmw
         j2DBXLFDe84ewZ41rIkj8rC8DVlDTWSDvA8H4aBGraLDE/bN/ZYEclGyjWroCYdQNX7d
         Ts0+lMrZ2aFmCfyS7v6mqaPPvbNnZIyH+DGJ77nG7GaWUfYROskiDraUY4asPYffVt0j
         QpWxB28UYHH17sHZ9J24+OIgA93Mev1+DAMufLx55ic9+MLthWTuJFy6xN9vHTplfV09
         TBEL7s9s+Yr/Rb2dPkpTD6RlihEzGDUbd0Z6PdWDouu/hGEgAzj9c7cegLQqIbuP7XYS
         BduQ==
X-Gm-Message-State: AOAM532f5BWYzPzN9JA4SsLXHP/x1jO6diaov7r2WNLiBhwF/Ozt+x6u
        Ey43cbhN6jb8L9oJ/TKAmDZ3Tb9aKd93oxg5EMWwlOqBdfUfju/WrpPjW3w5AsO/qw32ybdI6Kx
        lC/yDTuQjbOboxnBE8NGXOtnI
X-Received: by 2002:a05:6402:298c:b0:41d:6b63:aa67 with SMTP id eq12-20020a056402298c00b0041d6b63aa67mr2700624edb.42.1651831788993;
        Fri, 06 May 2022 03:09:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBFzu6xrB6D3RxqpRHkjC2nvxP0O0etd0yBB+wtSAq72a4+fJbgUlH00ZVSEP9Mw+wncftLw==
X-Received: by 2002:a05:6402:298c:b0:41d:6b63:aa67 with SMTP id eq12-20020a056402298c00b0041d6b63aa67mr2700604edb.42.1651831788792;
        Fri, 06 May 2022 03:09:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ze11-20020a170906ef8b00b006f3ef214e43sm1771125ejb.169.2022.05.06.03.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:09:48 -0700 (PDT)
Message-ID: <a07ef5c8-8b6c-f9da-ecff-f58316218f23@redhat.com>
Date:   Fri, 6 May 2022 12:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH pdx86-platform-drivers-x86] platform/x86:
 thinkpad_acpi: quirk_s2idle_bug can be static
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202205040241.QemV1sMH-lkp@intel.com>
 <YnFyjKyfnPnfpHgW@74ccfaeec2ea>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YnFyjKyfnPnfpHgW@74ccfaeec2ea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 20:21, kernel test robot wrote:
> drivers/platform/x86/thinkpad_acpi.c:322:20: warning: symbol 'quirk_s2idle_bug' was not declared. Should it be static?
> 
> Fixes: a50dfa903391 ("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>

Thanks, since the original patch was still in my review-hans
branch (and not yet in for-next) I've squashed this fix into
the original patch.

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index f385450af8647..d5431d3d4246f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -319,7 +319,7 @@ struct quirk_entry quirk_btusb_bug = {
>  	.btusb_bug = true,
>  };
>  
> -struct quirk_entry quirk_s2idle_bug = {
> +static struct quirk_entry quirk_s2idle_bug = {
>  	.s2idle_bug_mmio = 0xfed80380,
>  };
>  
> 

