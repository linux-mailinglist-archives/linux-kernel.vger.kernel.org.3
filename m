Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3A505B05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbiDRPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbiDRPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D11056C23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650292743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eFN80GX/pK4ealfWSRxLS53tOefGMWydgMQThLixgU=;
        b=RDjRsQ14CdCVB9f/wrNvTzracxO43Pv3CchIEJgymncAa7VzEXpl20xaoa2rVVDHvnSCSp
        KF+etcLEanlObHNlXxnhzVfVOt/9EF7rHCskMMzFq7Ac9WEbb7gtR7IpW40Yvvqu4Q8tjE
        O3aAIVVBo2xFxeDC9ULz+472PluUjuM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-9hca2ej2MAymmip1XKEidg-1; Mon, 18 Apr 2022 10:39:01 -0400
X-MC-Unique: 9hca2ej2MAymmip1XKEidg-1
Received: by mail-ed1-f72.google.com with SMTP id cy25-20020a0564021c9900b0041d84fd5d8fso9225018edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6eFN80GX/pK4ealfWSRxLS53tOefGMWydgMQThLixgU=;
        b=IWnX+aMtPsZxpTEbHnyO8Mp7hFdMyXD2mPdqH6pjKXTezo5hfuEukzPbWI54X8HRPq
         SCf/2EO7bQG+fN+aqQC3tXu+Va2wUCSvzaohQevjxwMdmpVwYpCer4Uz7EkfaZh7H/MB
         pLzwsjowKiAz5x4QTVRBDxBUrTA2vDlryHxTdKdfGh5VVFPCPv1GvbY7b39Q78WEd6Eq
         r5sNw3q5DhOonBg5bHB45mPr2f0K2A2pv6qiHo0/zgv5lLeT9E+tILjM7ABP94vXlVdW
         HYNqseo72de+DBJ3eN1gw2Fu7DqUlWaTxLC2QJHI+Qz8/S3auRvGhFw8Gy0ZHb9EmVaO
         Nz5Q==
X-Gm-Message-State: AOAM530Hb7La2LQjybCAwKpVC++2E11hg1CrzOmrLvRH+bLBEdWHad2F
        MjWdybMNFB9UUMCyT2OjhxgZOrJ+JaR5uJkvXbn0lEqDVIhrnITkuGEdHfZYgpHe9wrJG/l/v5A
        00WAogTW7lTHdU5/OOu4IswZQ
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr8888176ejn.278.1650292740664;
        Mon, 18 Apr 2022 07:39:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeqSU/SP+la46mB3kMrIRFOElUVCRZRFHFfBw0ppp9kwuO9yg2b2SQbbcjdJFIit+C7p/ENw==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr8888167ejn.278.1650292740508;
        Mon, 18 Apr 2022 07:39:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y13-20020a50eb8d000000b0041f112a63c4sm7152871edr.52.2022.04.18.07.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 07:38:59 -0700 (PDT)
Message-ID: <35f5a3cf-879a-e5e3-437c-acb17ecdc68f@redhat.com>
Date:   Mon, 18 Apr 2022 16:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix Touchscreen X Axis inversion on Trekstor Surftab W1
Content-Language: en-US
To:     Julian Schulte <schu.ju@gmx.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210626065417.8818-1-schu.ju@gmx.net>
 <Ylx3vduFGFlCEY0F@google.com> <Ylx4n/hqBhD+PAxX@google.com>
 <CAABSQwE-NJwGrKw-6K3TYRKCZ8vgjGink-8OghCxEgQoRAbXOw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAABSQwE-NJwGrKw-6K3TYRKCZ8vgjGink-8OghCxEgQoRAbXOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, Julian,

On 4/18/22 11:41, Julian Schulte wrote:
> Hi, 
> I think this is already solved by another patch. At least I tested in the meantime and the bug was not present anymore. 

Correct, this was fixed by this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a274cd66bc6461b45a450cd3f5653473a9aaea75

Regards,

Hans


> Dmitry Torokhov <dmitry.torokhov@gmail.com <mailto:dmitry.torokhov@gmail.com>> schrieb am So., 17. Apr. 2022, 22:29:
> 
>     On Sun, Apr 17, 2022 at 01:25:33PM -0700, Dmitry Torokhov wrote:
>     > On Sat, Jun 26, 2021 at 08:54:17AM +0200, Julian Schulte wrote:
>     >
>     > Just found it in my inbox. Adding Hans...
> 
>     For real this time...
> 
>     >
>     > > Signed-off-by: Julian Schulte <schu.ju@gmx.net <mailto:schu.ju@gmx.net>>
>     > > ---
>     > >  drivers/input/touchscreen/goodix.c | 7 +++++++
>     > >  1 file changed, 7 insertions(+)
>     > >
>     > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
>     > > index c682b028f..cec5f7bdc 100644
>     > > --- a/drivers/input/touchscreen/goodix.c
>     > > +++ b/drivers/input/touchscreen/goodix.c
>     > > @@ -248,6 +248,13 @@ static const struct dmi_system_id inverted_x_screen[] = {
>     > >                     DMI_MATCH(DMI_PRODUCT_NAME, "I15-TC")
>     > >             },
>     > >     },
>     > > +   {
>     > > +           .ident = "TrekStor SurfTab duo W1 10.1 (VT4)",
>     > > +           .matches = {
>     > > +                   DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
>     > > +                   DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab duo W1 10.1 (VT4)")
>     > > +           },
>     > > +   },
>     > >  #endif
>     > >     {}
>     > >  };
>     > > --
>     > > 2.30.2
>     > >
>     >
>     > --
>     > Dmitry
> 
>     -- 
>     Dmitry
> 

