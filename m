Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8288155DEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiF0Mxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiF0Mxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA2EB85C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656334415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSJUUnvpeAQHv0wrzmpKB9ikE0jhSvsZydeKYwwWYok=;
        b=JcXhV4Ouab5yuQ3Ax0KUMIpZaID4pwvBpDwor8VuvYcYx1zkPQtGqh7SqR3/9pb0TS/Zet
        tn16z2Q31OR3zBZjH0nYk1cfy5D7uSVgJ7zZ1F+znrgTIJi8/D+DdSUuHH3EYCROjwTUQh
        wVz27UJBWP0CxXink7nXsa+k1X90ga4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-uii0qs_gOb6aD7g0l_a1GA-1; Mon, 27 Jun 2022 08:53:34 -0400
X-MC-Unique: uii0qs_gOb6aD7g0l_a1GA-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b003a02fa133ceso3534658wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JSJUUnvpeAQHv0wrzmpKB9ikE0jhSvsZydeKYwwWYok=;
        b=biCSvodqWqkl6YJXt6VCRI5tux6d0NbY1lssEQlhdikytZyOw+NNYBrpbIuAzQQSWy
         KbDqEkK9uVCxACBaf5oZetlK4zfmLV4KsSfpyMa+6IEUXvjjh73erv9BRq96p7ifE89B
         zNBvor7Hsu3AckE0lF+VXfpmwZgClxrYHrSHMUztM2mz0Ttj/DQ6mSlBQ4XZCG0Y5Jgi
         1W4lCtCAwU3i1Af+KN/krUAoFRkfm5s5gxJkz9VtRJzd77M2j9kgJ4Ud5CjVRcyyUJfS
         1vbeWjF0a/cTKwR00huSPUX/tfUHlC+mK6WBVVlUVzUEx0RxCVUHXDoUArIIuDR1Lv/c
         mWBQ==
X-Gm-Message-State: AJIora8lup06E0qxSxteKdR2cPupxTYo48eKkc+akNdAh2fj2YW7mqcc
        LrySGYkxN/KzS4lBRcpRxplH1/iJi0taSIL6quiQVshlqWZVE7RWZbH4Gjcu2lGg95q30NqD7RG
        sZ9mxX9tmODfQ/XjOqB8+M72N
X-Received: by 2002:a7b:ce06:0:b0:3a0:39e0:b322 with SMTP id m6-20020a7bce06000000b003a039e0b322mr20738167wmc.55.1656334413372;
        Mon, 27 Jun 2022 05:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tO72PSD1UGhCfAT59/v6LlTy0Gsa1vZu6c7xdytzrAzaVb4oRzcHRztGwZHXpsEitKn6eqQA==
X-Received: by 2002:a7b:ce06:0:b0:3a0:39e0:b322 with SMTP id m6-20020a7bce06000000b003a039e0b322mr20738144wmc.55.1656334413148;
        Mon, 27 Jun 2022 05:53:33 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b0021018642ff8sm11002992wrm.76.2022.06.27.05.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:53:32 -0700 (PDT)
Message-ID: <98a43ed9-567a-6357-2b03-c9899133ed26@redhat.com>
Date:   Mon, 27 Jun 2022 14:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
 <YrYmR+aCdO3ldORB@phenom.ffwll.local>
 <b16eba9c-30cc-c71f-ad95-eb5398f84af8@redhat.com>
 <20220627123636.GA1772666@elementary>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220627123636.GA1772666@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello José,

On 6/27/22 14:36, José Expósito wrote:
> Hi Javier, Daniel,
> 
> On Fri, Jun 24, 2022 at 11:18:40PM +0200, Javier Martinez Canillas wrote:
>> Hello Daniel,
>>
>> On 6/24/22 23:01, Daniel Vetter wrote:
>>>
>>> [...]
>>>
>>> Hey so since you have a bunch of patches merged into drm already but seem
>>> to lack drm-misc commit rights to push these yourself I think it's time to
>>> get those:
>>>
>>> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc
>>>
>>> And I guess Javier can help you with any questions you might have and make
>>> sure the request gets through by poking folks on #dri-devel irc?
>>>
>>
>> Yes, he already requested commit access and got the acks, so I think is
>> just a matter of time until he has this sorted out.
>>
>> José, please don't hesitate to ask if you need any help or clarification
>> once you have a setup to push your patches. The dim documentation [0] is
>> superb but I know that it can be somewhat stressful the first time :)
> 
> Thanks for creating my ssh account :D
> 
> The tool is really well documented, setting it up was a piece of cake.
> I pushed the patches to drm-misc-next. The output didn't show any
> errors or warnings, hopefully meaning that I didn't mess up.
>

Awesome! Yes, everything looks correct. Thanks a lot.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

