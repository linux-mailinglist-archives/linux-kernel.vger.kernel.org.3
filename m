Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070EC49C537
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiAZIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238378AbiAZIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643185530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=440FgkXgCHAMbKC/iYJADapl1fZnVVa+IX4xnE02Kts=;
        b=Bh14UFUNQ4txJNGG25L6y7lb7Fwyu2kUv7LeH/V0LKwi4ohwU/KQz/pg1LWGUzEOcuJF69
        4JC5T7ceT6/kxOvC90Y5Cx8FVTPHyl8eZkgMybuqwxIBqYEwngiVXcSPE2REz37cKWifoj
        I3osiyf2FzIAYzWWbNEAkxmTRljYhi4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-uxW2fC3HPH-J7vobpfJmxw-1; Wed, 26 Jan 2022 03:25:29 -0500
X-MC-Unique: uxW2fC3HPH-J7vobpfJmxw-1
Received: by mail-wm1-f72.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso2901365wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=440FgkXgCHAMbKC/iYJADapl1fZnVVa+IX4xnE02Kts=;
        b=0dib39qO0kfAqQQ0l49G2YM5qvMZ8f158SVixs2jhv/aNx9uiDLkneQzwnOC4M//vb
         lrCMmZk/PQscsuFR5kQu1/qX6DdqSFrBoMEa5wFt/CgNOueytRI6d5PPf/xYxg1xjlSP
         tIMDIXjSpgAOOVmhq9D5AbE3C/KgThzPAZy80Jm2vIQ+x91gxwW2CEK+qYzEOaQoZHjk
         oT+Phy1mRIfd2Ek7vYGLBUfN3qsPVf0cNLeZb+XR6aqpr6FbCtTRyB2cGtTHCVVbVOv1
         jB+VmYCOvEtdvIxrlCaIlR4UGFgj9yV4KnbvUlY1Z3kJQmBfIxPir2G/zNTDk9Pmlw1u
         fg1g==
X-Gm-Message-State: AOAM5315Oi3CRTkRMsaq8tRVQrRfW8djb3xq/AslYu/iXhvJeK0e0n44
        4TujtPGphwTNaNkxyw6wgDRK+DyHOMNjb/d5zqEWkQ+fldunQW0YN0Te3A4IOYjWY9jYc/e+WGa
        fR7P7cNTeIvHGrNxUoAx9dbYv
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr6313723wmq.97.1643185528365;
        Wed, 26 Jan 2022 00:25:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0nxSgDr+rHQJ5DkmXXci2WlnMO5CxSppdclohkfn2HjF1BS+q4gY8ypCYaCWOtCjmbykX9Q==
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr6313701wmq.97.1643185528090;
        Wed, 26 Jan 2022 00:25:28 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j13sm12984562wrw.116.2022.01.26.00.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:25:27 -0800 (PST)
Message-ID: <6fdcfbcf-0546-6b4f-b50f-cf2382ad746f@redhat.com>
Date:   Wed, 26 Jan 2022 09:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/panel-edp: Allow querying the detected panel via
 sysfs
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>, jjsu@chromium.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
 <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com>
 <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 00:25, Doug Anderson wrote:
> On Tue, Jan 25, 2022 at 2:55 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>> Should this new sysfs entry be documented in Documentation/ABI/ ?
> 
> I'm not sure what the policy is here. I actually don't know that I'm
> too worried about this being an ABI. For the purposes of our tests
> then if something about this file changed (path changed or something
> like that) it wouldn't be a huge deal. Presumably the test itself
> would just "fail" in this case and that would clue us in that the ABI
> changed and we could adapt to whatever new way was needed to discover
> this.
> 
> That being said, if the policy is that everything in sysfs is supposed
> to be ABI then I can add documentation for this...
>

I also don't know the policy, hence the question. But in any case, I
think that it could even be done as a follow-up if is needed.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

