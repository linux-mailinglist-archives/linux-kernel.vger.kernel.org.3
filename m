Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15958563F57
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGBJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiGBJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFA817A92
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656755669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aY2747Hk3us9Bi14d8WdjF4WmVrxBQs7Bc7ML/SUFk=;
        b=KSFMLIqCMN5iBYZ4BxUG6yjxBsKu6bRK1fHmSpOTfVSLk5wgsNxGlwSSh8B4Hx1M1imQeY
        td82S/vITyFrxNJoFfFJ5wfqNVEsZYRCtj7oWzaZ1dj1p/9JfDa1N24po9N0oHhQ4k9Y2R
        A7LTof3IripBbuyuww8nqT7CqaRycV0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-Jhc0VF29N52WW5WJefI7OA-1; Sat, 02 Jul 2022 05:54:28 -0400
X-MC-Unique: Jhc0VF29N52WW5WJefI7OA-1
Received: by mail-ed1-f70.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso3405325edb.14
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 02:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5aY2747Hk3us9Bi14d8WdjF4WmVrxBQs7Bc7ML/SUFk=;
        b=M6NPfKUfBNMeWvP7mQlOT7vaxP+EzjurBocZAdI/Pfe65FM95vw7jf8t+G6hw4h8qa
         Q1xzmcsnT/Yq/mCZY2cI40AEnWoKgaFUkgfNOfoPATujVdP5qVfxujsHmHY735lwyLpJ
         3tPxwtH77KOedSwjwyYRs6Rnt6hAIIMEKnD3HCMfVloMZ36hRRKcJiYjQQvBARgVPKEO
         o67KEoHAT6ayD4Mm3NNJ8YevHuu69DU06s6zqN29wYwMwoA+bdJv2bXdY+qM9RSvBbJY
         M4fFY6aIH7bbHae749okaeZYS0ztdzTCgqOS71dGF95bzTxRvyATAHJqt8EKguJTm7uW
         uKbQ==
X-Gm-Message-State: AJIora9fX38iAb0cdHeQ/+t2AiXvGGGcXli+vqvvJRvbXoL0mqaEdTz4
        Z41Fka3NgI+F6ke8DlhuXxx6B8bj3d/qsCbw49pQQNrSJRa7quMdc4LfoqpXSFoCVLyiFNPDJtD
        Pr+cdO/kdJM4Y2nHayjl0apUd
X-Received: by 2002:a17:907:7283:b0:727:b4c0:b1f6 with SMTP id dt3-20020a170907728300b00727b4c0b1f6mr18578675ejc.197.1656755666984;
        Sat, 02 Jul 2022 02:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t4/6byBX8rh0oM+kgYZVCwfnRyKKcPLodPqj5yer0AXp+5bcVTNwbBRZT1aNEzCvQOsoO/KA==
X-Received: by 2002:a17:907:7283:b0:727:b4c0:b1f6 with SMTP id dt3-20020a170907728300b00727b4c0b1f6mr18578652ejc.197.1656755666790;
        Sat, 02 Jul 2022 02:54:26 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.147.70])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906308400b006f3ef214e27sm3759870ejv.141.2022.07.02.02.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 02:54:26 -0700 (PDT)
Message-ID: <ac7bfd35-203b-5002-a3ff-787ca1738a41@redhat.com>
Date:   Sat, 2 Jul 2022 11:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/4] Add Raptor Lake and PCI error recovery support
Content-Language: en-US
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/22 00:13, Gayatri Kammela wrote:
> Hi,
> 
> This patch set adds Raptor Lake support as well as PCI error recovery
> support to PMT driver. It also has a rework patch and a fix for fixed
> region handling.
> 
> Patch 1: Rework early hardware code
> Patch 2: Add support for Raptor Lake
> Patch 3: Fix fixed region handling
> Patch 4: Add PCI error recovery support to Intel PMT

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
> David E. Box (3):
>   platform/x86/intel/vsec: Rework early hardware code
>   platform/x86/intel/vsec: Add support for Raptor Lake
>   platform/x86/intel/pmt: telemetry: Fix fixed region handling
> 
> Gayatri Kammela (1):
>   platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
> 
>  drivers/platform/x86/intel/pmt/class.c     |  23 ++--
>  drivers/platform/x86/intel/pmt/telemetry.c |  18 ++-
>  drivers/platform/x86/intel/vsec.c          | 130 ++++++++++++++++-----
>  drivers/platform/x86/intel/vsec.h          |  11 +-
>  4 files changed, 136 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a

