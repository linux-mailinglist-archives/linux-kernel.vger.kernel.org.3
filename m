Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81430511A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbiD0Ohc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiD0OhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F22F32655A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651070048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DkvX0ilKmOtfRv4yBSGmcFhCLPyNBAdFDkeCqkWI38=;
        b=hLocA3rHFP07jbJUu0G4a4G0voXpIMKyOUQKOqp95GRYB949j9m8QFTPJBEAbgqK5QzU2r
        DyjR9Z9ut3VmIX7ykl/zwFKQoeYHpcuErPfev7Jxh9GTf6E+CaE5K+hnm8Jk9jaBo4L/Yw
        6094iP+MqDOM3Z0ijJdRm/rSIjdGepM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-ksSHSGVxPOOw2a1wtnTOUA-1; Wed, 27 Apr 2022 10:34:06 -0400
X-MC-Unique: ksSHSGVxPOOw2a1wtnTOUA-1
Received: by mail-ed1-f69.google.com with SMTP id s24-20020a05640217d800b00425e19e7deaso1105116edy.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DkvX0ilKmOtfRv4yBSGmcFhCLPyNBAdFDkeCqkWI38=;
        b=uAJ2tLE3lF8KfY8USEuVB/qD5KhjKG6YvuCEu5MPb4J1JQkTwQo+ykywykeOkeoAZ+
         nQLwhz6PIPKEs9Tt9i3bCZSo1LlUJi7eHR6vye8bdKWs6ZLMnUnAhdABDgsYmZlH/2e9
         v40vlHT2fb980JZUEZ89clTAhq4V0XP0ks9FFtAKnip+8qB6oPJoAl5DSS2zwOlrH+3F
         5lRhVAckvsmfF9yd/C9hXx6P4TdaczyClEsptl28J7KyhBQUUaoaDdgMxDHeij+cKQ/T
         kdiWA4M+Iz2Sfy6UTUgtEzN89s0KYQHw5Ox4TalkGTAuLG4UudsxW+I+vQ6yIc1CeSC6
         Dn3A==
X-Gm-Message-State: AOAM532pdY1MpN8OPmIufylGej5ZtgTCaYotWh5CVI9OcDtgJyIqmbLQ
        s92Y+7L4up+QAuAoB57Mv3WmDHBKi8FJSc/3tnqNcq1dSIXjC90zWNQjY2mx1KoL3Z0dejiQctw
        WwcJKq/on1joLnM9nHjrFO26y
X-Received: by 2002:a05:6402:34d2:b0:423:e6c4:3e9 with SMTP id w18-20020a05640234d200b00423e6c403e9mr31369767edc.372.1651070044871;
        Wed, 27 Apr 2022 07:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQdK7t3/Kg/gpQ+TC6NEm38u6Mm3Kc3AdoHzfvlT7n/SWMPjPngOiwuCqfcoL3rT9E65Gm0Q==
X-Received: by 2002:a05:6402:34d2:b0:423:e6c4:3e9 with SMTP id w18-20020a05640234d200b00423e6c403e9mr31369739edc.372.1651070044658;
        Wed, 27 Apr 2022 07:34:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm6814823ejn.169.2022.04.27.07.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:34:04 -0700 (PDT)
Message-ID: <25fbfb63-3540-2752-6070-37a69a21eba1@redhat.com>
Date:   Wed, 27 Apr 2022 16:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] platform/x86/intel/sdsi: Fixes for 5.18
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220420155622.1763633-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/22 17:56, David E. Box wrote:
> The following patches provide fixes for the Intel SDSi driver based on
> firmware updates and for one driver bug.

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
>   platform/x86/intel/sdsi: Handle leaky bucket
>   platform/x86/intel/sdsi: Poll on ready bit for writes
>   platform/x86/intel/sdsi: Fix bug in multi packet reads
> 
>  drivers/platform/x86/intel/sdsi.c | 44 +++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> 
> base-commit: b2d229d4ddb17db541098b83524d901257e93845

