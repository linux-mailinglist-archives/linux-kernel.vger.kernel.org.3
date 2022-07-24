Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF14E57F6FD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiGXUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiGXUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 063A625F2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658693711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZz4b5LoajqAvsUTBnBgNSgY5TJeL+gVGY7SLqZJsYs=;
        b=hquihfS/37wY+Dek6VkgEtddJHF9p1GGFoOfMKSTmRyEVKYqxN8OznUi+HlO9NuSElTTbE
        PZw/HfV+xM8jGrTjveWXiJxixqGrPIHijuXU0uywIi7Hno6wX54QGgceSgO1tX3nyZn0WT
        NDm3C7zi9wEP23EbnpPX5UfyqlqK900=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-O6FkCqEuOl61U3soYR6ZTQ-1; Sun, 24 Jul 2022 16:15:07 -0400
X-MC-Unique: O6FkCqEuOl61U3soYR6ZTQ-1
Received: by mail-wm1-f69.google.com with SMTP id h65-20020a1c2144000000b003a30cae106cso7562797wmh.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZz4b5LoajqAvsUTBnBgNSgY5TJeL+gVGY7SLqZJsYs=;
        b=EJs01S0llEoXKgDoDUiw3wzujRWgqQ7SOXcKk6M+SmjVCZ+uEUC0J/gSovEUEJnPpl
         1fiUvFfapJLv0zNV6SYTcT54BXmsqeN1kIdItwcRqVfFDJCP0mCFpMU9x657OHTAKIEi
         H5/1D4L2EXzS8gx86FOctsT+X0Vzkkt2C8jNcqaqcQKGsAhGnmtyh5RJfy9loYZ81VOZ
         bmml3yahcqCNiPpU0RCX09amkG+VDp5vMNrwyRxRxWd7lDmUxj/eWaMLN1/kAkfOOh7B
         ZDJU79V8GowHd/zt//L1n8ifoTfoO2COg1uS1XPO9i864uWAP0sIJ/Vx7BR7vK8+FHX5
         GKQQ==
X-Gm-Message-State: AJIora/6ue0uCP0V6y8GOFaUpkTs5P7nSNOLp2sOiew2BnyBBVpYmjo1
        SAr3NN0HA2uN8Ar35mp5fOVaD9oEavFNuiaXw7BtVzOs5y0azQEvkdKBCc7rq1buuxnDrL+A87D
        cTvBvJ/4cVXbK9w9NwH4hNZx8
X-Received: by 2002:a05:600c:4e94:b0:3a3:4448:62cc with SMTP id f20-20020a05600c4e9400b003a3444862ccmr6292854wmq.108.1658693705161;
        Sun, 24 Jul 2022 13:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uuRx/wU5NQqtwBn5eDMRUu4h4Xzgsm5XmvnoiDQbrqTXU/ISSTDKN57eKI3H4AHbrm5rUtyw==
X-Received: by 2002:a05:600c:4e94:b0:3a3:4448:62cc with SMTP id f20-20020a05600c4e9400b003a3444862ccmr6292836wmq.108.1658693704845;
        Sun, 24 Jul 2022 13:15:04 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c4e0c00b003a2fde6ef62sm12180954wmq.7.2022.07.24.13.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 13:15:04 -0700 (PDT)
Message-ID: <efcccedb-58e0-13a8-5c21-2e519e9fc335@redhat.com>
Date:   Sun, 24 Jul 2022 22:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/msm: Make .remove and .shutdown HW shutdown
 consistent
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
References: <20220724111327.1195693-1-javierm@redhat.com>
 <CAA8EJppEpPe4nfZ_kvNen6shSvgyUoL3adSQfhhCGCS2VmVZhQ@mail.gmail.com>
 <6b3f98db-83bf-41cd-b23d-79b455a06ebd@redhat.com>
 <630a6654-0305-f3a8-e062-f13a0074d35a@redhat.com>
 <CAA8EJpr1xf9mkfT-FhK9M58syMnWCFXozWHH9L_gxtXOqgh0yw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAA8EJpr1xf9mkfT-FhK9M58syMnWCFXozWHH9L_gxtXOqgh0yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 22:10, Dmitry Baryshkov wrote:
> On Sun, 24 Jul 2022 at 22:51, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> On 7/24/22 20:47, Javier Martinez Canillas wrote:
>>> Hello Dmitry,
>>
>> [...]
>>
>>>> Now there is no point in having this as a separate function. Could you
>>>
>>> The only reason why I kept this was to avoid duplicating the same comment
>>> in two places. I thought that an inline function would be better than that.
>>>
>>>> please inline it?
>>>>
>>
>> Or do you mean inline it as dropping the wrapper helper and just call to
>> drm_atomic_helper_shutdown() in both callbacks ? I'm OK with that but as
>> mentioned then we should probably have to duplicate the comment.
>>
>> Since is marked as inline anyways, the resulting code should be the same.
> 
> Yes, I'd like for you to drop the wrapper. I'm fine with duplicating
> the comment, since it will be in place where it matters (before
> checking ddev->registered) rather than just stating the contract for
> the wrapper (which can be easily ignored).
> 
> (And yes, I do read patches and commit messages before commenting.)
> 

OK. I'll post a v3 tomorrow doing that then. Sorry for the misunderstanding.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

