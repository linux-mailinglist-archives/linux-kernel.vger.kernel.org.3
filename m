Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B418F495DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiAUKmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380030AbiAUKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642761732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdPdILngPzGrQBwtZZKW+7ixKah3Wpht/KCyewnhlCg=;
        b=E2QK4XXt/0wjkP32B5b/QnbINlfL7E02PHIne200FVc+8BYe3VdhMKgIhqVHnWhByIW8/Z
        cawFlFcUL24Khn0y9RkzyU6GVsWuvboEMwyCata0lDrJVJjqhryun117fRvPT6mwY+qcas
        Z8Jet5vlP6q9fTi9514oNMyvqi1ESvg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-i6yDQ0XqPf6lt13VTcsdxQ-1; Fri, 21 Jan 2022 05:42:11 -0500
X-MC-Unique: i6yDQ0XqPf6lt13VTcsdxQ-1
Received: by mail-ed1-f69.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso2505271edv.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 02:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CdPdILngPzGrQBwtZZKW+7ixKah3Wpht/KCyewnhlCg=;
        b=jBelN+uOzzB/mo16Tzg0Ob0+o9FAPnNXXSXyF5kG3ilW0ZxVkGcba91GFSa2ZcL+gc
         Kc4aATj1hplHy8kxjDsjgO+POAxQedv6Qp0vxfIgrGL6A/0/pfHoJokMqKliyx+A6aJv
         bQvuGG5cj6HtjdojCzTRx/QuwQangM7iAeqL4GejsVTIJ00sJJBSIO71atMPAm79Ywej
         6qVZtR5Kywl5Iid66HD7JxGcLV1zBlVNUZ3eYKBnLGdL3i7HWhpcJipUNgTt46xMG34u
         0dVHTL3/QksnmX8Mp6qm3FYCmDJ4l0oSPLLzAUgquBSYU09QkmtSYvrSvnOIrciDDspW
         oStw==
X-Gm-Message-State: AOAM530RIMVCPY5UhpU+NZup2VI2iMYDbHUG9C5PqAXVEbeK99VnMUCX
        tPAHJjgy3kYuteC9zlg+n5zKAYqAG1n/QAAXaQBpU4EPljpWzIsucQPTewIO/UNOL5ilhCmMJ31
        ECw0D8oETcXqpnoPHSKA5CCUo
X-Received: by 2002:a05:6402:31e9:: with SMTP id dy9mr3680088edb.65.1642761729926;
        Fri, 21 Jan 2022 02:42:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwip9Cp2oVEYL+pg2NbsXqt2zQcoTWCMHysfXzR0VjzDHu2yy8g2b0X+EK52vUarXS+yjY5QQ==
X-Received: by 2002:a05:6402:31e9:: with SMTP id dy9mr3680084edb.65.1642761729806;
        Fri, 21 Jan 2022 02:42:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id z10sm2504846edl.54.2022.01.21.02.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 02:42:09 -0800 (PST)
Message-ID: <faa591e3-19f3-1a8d-4e64-bc8cc94b82dc@redhat.com>
Date:   Fri, 21 Jan 2022 11:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211015205422.53bec93d@canb.auug.org.au>
 <20220120141851.5503b65a@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120141851.5503b65a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stepen,

On 1/20/22 04:18, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 15 Oct 2021 20:54:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the drm-misc tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/gpu/drm-kms-helpers:451: /home/sfr/next/next/drivers/gpu/drm/drm_privacy_screen.c:270: WARNING: Inline emphasis start-string without end-string.
>>
>> Introduced by commit
>>
>>   8a12b170558a ("drm/privacy-screen: Add notifier support (v2)")
> 
> I am still getting this warning.

Sorry I completely missed your original report on this between
all the other kernel related emails.

I'll prepare a fix for this coming Monday.

Regards,

Hans

