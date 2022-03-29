Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C34EB6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiC2XXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiC2XXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B13E1184B57
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648596085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnEVLzN6wtV9JQalUxoL87eeycMaKfu2BZqOrOuPk4E=;
        b=NG6ek5Ue9ncyj9C4wv6UjsQb7VRWVPgP6WC2nAI3g6VM9OJVVOdsLuA7DOqlmY5k1zPWaB
        yxAF86UqkVirqcebJ9w4JIus/UrrYeFHksz6OG5T8DhaJzEWUDeG8Jii4969S3g7HUZ290
        81Rn5TBcYAzRt9oit50yoXcIWapz8kw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-RHgmY5DaOje41mcdHGvnAw-1; Tue, 29 Mar 2022 19:21:24 -0400
X-MC-Unique: RHgmY5DaOje41mcdHGvnAw-1
Received: by mail-qt1-f200.google.com with SMTP id o15-20020ac8698f000000b002e1db0c88d0so15991150qtq.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vnEVLzN6wtV9JQalUxoL87eeycMaKfu2BZqOrOuPk4E=;
        b=YMIuy9wcCtWvjUXPCZFRg/tNphwrR2zO/UUvrhXK4QSROk+WGq2HHY6e2mtvcU/CbD
         mnAkbFB2bU/iwe3L9ZaT77X35yRIajFV9AeZvLeBFcI0hYI8iR8m00YYqlcivTo7Hts3
         Sxz98r0so+2U2wQd8rMb3sg7ovI2mWoJ4SUIx6NbCVjUAVl4NnZaFDW9PNhGwbkP+PeX
         Z6giOiWjFx8sb/RcQHK7Ppp/EiTyFnyr44MJMMkbHXfS3Dswxnn49i0lpAEHmqv/pDaf
         fPzlfNiV3o26mXqI3tv3MQMD3X2FIsXKfBYV/YE4mZDA3rK2ii76o9WTiPWvRQRPH0k7
         pT8Q==
X-Gm-Message-State: AOAM533aPg0EJePC0K2yAxXI+JxNUyLV/9MMgbXIC4FW6mOdt/5yJmwR
        /fpD5jxE0RILAIB0r17Qh/ImWP6m3ZOV3LoPqSbogPBpsUglEYtoF9cDVdFcQuhsHZ44I78W10W
        481jKMnnCAdIvgRZoXWUxxsE5
X-Received: by 2002:a05:620a:1a99:b0:680:f33c:dbd3 with SMTP id bl25-20020a05620a1a9900b00680f33cdbd3mr2912678qkb.17.1648596083862;
        Tue, 29 Mar 2022 16:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaMl8cwEN02JVbghXfjiOKK5vbmlk7rHZYxrkXCYwKhBHbTy3z6OejWxFNRFl2ohGsizFJXg==
X-Received: by 2002:a05:620a:1a99:b0:680:f33c:dbd3 with SMTP id bl25-20020a05620a1a9900b00680f33cdbd3mr2912659qkb.17.1648596083595;
        Tue, 29 Mar 2022 16:21:23 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a030800b002e1c9304db8sm15819272qtw.38.2022.03.29.16.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 16:21:23 -0700 (PDT)
Subject: Re: [PATCH] media: staging: atomisp: rework reading the id and
 revision values
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, hverkuil-cisco@xs4all.nl, vrzh@vrzh.net,
        tomi.valkeinen@ideasonboard.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220326191853.2914552-1-trix@redhat.com>
 <YkN0w5NxLcBFes1b@paasikivi.fi.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2ab474d8-ee4e-44b5-ab3c-38b72135a27f@redhat.com>
Date:   Tue, 29 Mar 2022 16:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YkN0w5NxLcBFes1b@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll do a resend.

I use git send-mail, sooo not sure what went wrong.

Tom

On 3/29/22 2:06 PM, Sakari Ailus wrote:
> On Sat, Mar 26, 2022 at 12:18:53PM -0700, trix@redhat.com wrote:
>
> Hi Tom,
>
> It seems that somehow the Content-type header of your patch  is
> application/octet-stream. I.e. not text.
>

