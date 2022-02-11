Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9614B23FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiBKLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:09:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbiBKLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CBAAE45
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644577774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8D3Rc9SIkOcfBa1vDejqDTP/HXsHXl7xRg9X0I4XWw=;
        b=UOjTLSVatDCTKGfC1iFVInXy4y8F8qTwGHzg52isyDBMSBBHaUyJSM45kKSLliOHszzKsM
        uyZ6cO64YQOVMyQQ1vHLWS3bvbRcJTt0MeJNvHhvsRb2iak++lJyN97vzBnRsdaQZyk/XF
        diyu+Rk9N2glzlq7SRiJAFbRVCpl+jE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-h_Fme-p_OPiSa0ORMPT-nw-1; Fri, 11 Feb 2022 06:09:33 -0500
X-MC-Unique: h_Fme-p_OPiSa0ORMPT-nw-1
Received: by mail-lf1-f72.google.com with SMTP id z24-20020a056512371800b0043ea4caa07cso2066478lfr.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8D3Rc9SIkOcfBa1vDejqDTP/HXsHXl7xRg9X0I4XWw=;
        b=a7AOEaaVrZhWigDK9yrsZFDPHqoTwHpOPpxpA2yJu6crEudB4uh45BRTtzFO6oFwmE
         BGZWJgfJAriZszh+jtlnuLu1vurgOaSWr+SuoY+b4m2NI83ogWLG6ExJl/YDrz45PdF0
         7Bn+wNwUoXOVARRMHPycqG7xbm7CxSKId9GqF9kmvKDTqh6Xc6usE2Vht+epAfGkOjnl
         Tep70/AWVQCSyb86p/lJdIqf5KgxuyhO3Umf1w3dnL4xYMCf1Qdu9sgYjXoJAAZOGyOw
         ftKEzeqNpXgwjacxe4+U7ll5cWqCegcqUBy1yc0CogLJR5EcTFO5YEBTaOTbf5Mg9kQ0
         hF/g==
X-Gm-Message-State: AOAM5316yZRd7ONvawt+SLPSdsaugvSoXyL5cHuzL5GKmqRxT8C3CIz5
        qEhf6FdiPaXOY2ekXiUhv/3MZhuBcz685JchHHH9nu/POgEepJ8paLQ4YKeMZkt+8m9CxZKcqlL
        AweQnWm+9PQ1cREzn4940pJvnFSM6fc45OGGTjxY=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr864295lfr.163.1644577771614;
        Fri, 11 Feb 2022 03:09:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVCcGipSaHTgyD8WUd9bl/oWYZA7dMgLK6BGOZpcOu2A9zI4r8M2jYC3Ypj+go956DgmlizCWimFSTbD3rT/0=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr864268lfr.163.1644577771401;
 Fri, 11 Feb 2022 03:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-7-atomlin@redhat.com>
 <a05710d0-3b2c-1405-df44-f1315f8fe765@csgroup.eu>
In-Reply-To: <a05710d0-3b2c-1405-df44-f1315f8fe765@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 11 Feb 2022 11:09:19 +0000
Message-ID: <CANfR36hnTVX7enuGo46qgo3PRP1LO3rT8kPVjsX+26m8M3v0mA@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] module: Move strict rwx support to a separate file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 12:21 +0000, Christophe Leroy wrote:
> This file generates many checkpatch WARNINGs and CHECKs.
> Don't worry too much about the ones telling you to use WARN_ON() instead
> of BUG_ON() for the time being, but others should be handled.

Yes, with ./scripts/checkpatch.pl --strict'.
Please note: I have used '--ignore=ASSIGN_IN_IF,AVOID_BUG' previously on
that file. Albeit, I will resolve the check violations e.g. "Alignment
should match open parenthesis" etc.

> > +# define debug_align(X) ALIGN(X, PAGE_SIZE)
>
> You can use PAGE_ALIGN() instead.

Agreed: PAGE_ALIGN(X) does expand to ALIGN(X, PAGE_SIZE)

> > +#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
>
> This #ifdef is not needed, frob_text() always exists.

I will leave this for you to remove, in your patch [1].

> > +    BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
>
> Could be:
>
>     BUG_ON(!PAGE_ALIGNED(layout->base));
>
>
> Same for all others.

Agreed.

[1]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/

Kind regards,
-- 
Aaron Tomlin

