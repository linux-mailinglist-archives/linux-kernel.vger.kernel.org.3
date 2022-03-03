Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF74CB937
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiCCIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCCIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6167148926
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646296689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VbL5lT53mUztHyArx9pP7wyihmJ4M3NPqTtcvOQ2VI=;
        b=HJoIeaxiAvYYTdcRNPitEP62MHRhY66i68HZ+kTc4B7hNb0Xvu49NckOA3/Y3SUhoGIxzo
        2nLpZY95si3zdgbbmaEliWRYgM96s8Vphagj7DoE/mf+TI/bJ1qITL+JluCXgzG/i4cTFz
        eCYNz0U0Za31aXhlObTp7YCuGODK5ac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-gpn-8lVhM3GSAm8U1KkwmQ-1; Thu, 03 Mar 2022 03:38:05 -0500
X-MC-Unique: gpn-8lVhM3GSAm8U1KkwmQ-1
Received: by mail-wr1-f70.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so1746646wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7VbL5lT53mUztHyArx9pP7wyihmJ4M3NPqTtcvOQ2VI=;
        b=s+FsPCrWUYqWs970DRo+6vk4UBKqVrSELKP24T5Xt2BrUYKyBdFkzCaYUhK3sBJoh4
         rJtlpZX/3F3ALK8jl90joWbXHF3ttLX5wMUBmhjMbg0MUg6jf/0gAFr+bzOAs0e52E8P
         7lbxyIVRMGG6Ouo6z7UusbBSkZKTlM9ZcqBkLF2CL4gtTBscW2zkIhsLK4dI8jJvq56c
         G0tcsAduaaPqUxnZMBb3T1nZ9B1B0RAxTGmvFg3wkZcuwqa+eP1GFKNfUIoYjQ1fSbk6
         H+xQzUFYfDiKkceDG755StyhZ+ZOtwXsd+ZP72J4k6hvugjSlopwOM3TO9YzdLxBSQIX
         YDfQ==
X-Gm-Message-State: AOAM5307YaI4o+d3uqeej55nSIOWBY5RUZhx/sVGitHeMDH1NLPdimjf
        jXfWZEEQks8kk1xK8wCUq7pYCH/E5jlCT6IvihZXNq3CYfyAidfBVkx654DlWhtSqBx+UssNM82
        q5f61kcCNSkD8SQCSH9nqmRrg
X-Received: by 2002:a5d:47a4:0:b0:1f0:46e4:19bc with SMTP id 4-20020a5d47a4000000b001f046e419bcmr4066492wrb.601.1646296684782;
        Thu, 03 Mar 2022 00:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/AOr9kcfSCL6dEmzp2KPAxB6X5N/u/fMMDoNJCyjfqcaaRT42zcBqSgBSliGMWF1kL7ADpA==
X-Received: by 2002:a5d:47a4:0:b0:1f0:46e4:19bc with SMTP id 4-20020a5d47a4000000b001f046e419bcmr4066475wrb.601.1646296684567;
        Thu, 03 Mar 2022 00:38:04 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b001f04b96f9a9sm1338936wrd.42.2022.03.03.00.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:38:04 -0800 (PST)
Message-ID: <8cef7451-ac6a-9ca5-b521-1eec53d30880@redhat.com>
Date:   Thu, 3 Mar 2022 09:38:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH][next] drm: ssd130x: remove redundant initialization of
 pointer mode
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
References: <20220302175309.1098827-1-colin.i.king@gmail.com>
 <CAFOAJEfS9dMY5nudeFxtwchTtLnBCh7N4qKaCdqvaodnRUFKzA@mail.gmail.com>
In-Reply-To: <CAFOAJEfS9dMY5nudeFxtwchTtLnBCh7N4qKaCdqvaodnRUFKzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 19:29, Javier Martinez Canillas wrote:
> Hello Colin,
> 
> Thanks for the patch.
> 
> On Wed, Mar 2, 2022 at 6:53 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>> Pointer mode is being assigned a value that is never read, it is
>> being re-assigned later with a new value. The initialization is
>> redundant and can be removed.
>>
> 
> Indeed.
> 
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc-next (with fixed drm/ssd130x subject prefix).

Thanks!
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

