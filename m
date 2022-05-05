Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623AD51BA89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349333AbiEEIgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiEEIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:35:57 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FD2A45785
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S96mA4Ie3bRtv9R+1bbKD4AnGf5O4BhFOs7D+b38OJQ=;
        b=DPpJfcnDjZqSTNRBjySeICGCFeCKewYFM2xOvjlAj/JmGUvQIZhrEw1rA7um88gxViPbaW
        xCFeQnMDB6AnSyrSfzgy6EQBvxjTDDsLC6o73yAY8mlD8kdxnQ5tzzvT3P/OLVi/PEJB7U
        hcA03QqDdwqwZhEfCPCrB2CmGtiZJgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-gwzsOEGhOrG2zIPsb1tWrA-1; Thu, 05 May 2022 04:32:17 -0400
X-MC-Unique: gwzsOEGhOrG2zIPsb1tWrA-1
Received: by mail-wm1-f69.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so4192942wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S96mA4Ie3bRtv9R+1bbKD4AnGf5O4BhFOs7D+b38OJQ=;
        b=0687e+S94BcRRowVLSwMkB8sOTEN7hcfsOgj3fda4R78trZC+MTs0BfvsLg0c2YkgR
         ZZstWLBR7S537Pjf2mItBEBQWdejSAvdf1JtQsmzEPC/bjmLPk+S63zWGgkUCIvVLKkh
         tEBWHfW/aFn6JcImbymUinpWcyK+MyFsWrBykMM/bbfzcQJTDB6kivf6DYJ/UvQDkyEv
         BgmIeC0J7MK1mMkgovnIBZPNurVa25IL+x1wsHOFqwWomywH6DnNzUYmf0oUsZFFywL5
         OMiUOjCmaHH7RBC60jlTqYYSpiiV7rAblV98DG7oRIZ+TSABBGY5RPAa2Evr7kas8XNq
         Fuwg==
X-Gm-Message-State: AOAM530wQpkBFoZdCUFRARrYN/NT7iXTjF7q+XkLhkdGuAT0fvurBUse
        nOzgNqV6Zx7EBYF7yBr6ngg/tO6SevckaWtZ5D+lzk1zIbnjxkbsH/b2Wy6iD8OAMEGm/+GOPbv
        XLVRjVrgAPToH2XYIkIS518JimjQOMopPwSt9V2yho5WWkSEDbHy17pF8dPH/XWt5a3HS8Qsy1E
        A=
X-Received: by 2002:adf:dc42:0:b0:20a:cf97:f1b7 with SMTP id m2-20020adfdc42000000b0020acf97f1b7mr19626863wrj.200.1651739535749;
        Thu, 05 May 2022 01:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3Wtm4DgnIJxwRdiMAj0etcbY/FRx4Rofh1acsbZWYdXjyJBptet2S8gRODazb7sgMUh1mFA==
X-Received: by 2002:adf:dc42:0:b0:20a:cf97:f1b7 with SMTP id m2-20020adfdc42000000b0020acf97f1b7mr19626837wrj.200.1651739535431;
        Thu, 05 May 2022 01:32:15 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b0020c5253d8eesm678310wrm.58.2022.05.05.01.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:32:14 -0700 (PDT)
Message-ID: <d3e60b09-caf1-d62a-c764-eb7976450ef2@redhat.com>
Date:   Thu, 5 May 2022 10:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/todo: Add entry for using kunit in the subsystem
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20220504080212.713275-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504080212.713275-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 10:02, Javier Martinez Canillas wrote:
> The Kernel Unit Testing (KUnit) framework provides a common framework for
> unit tests within the Linux kernel. Having a test suite would allow to
> identify regressions earlier.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

