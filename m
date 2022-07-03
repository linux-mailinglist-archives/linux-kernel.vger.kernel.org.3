Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A856480D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiGCOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiGCOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C20BA2DF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656858142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axYsTZ/q6cjrUNl4MVAJ5gd7O1k4pTmZjnHk0JetlKs=;
        b=B86XFqWhgND1V6p9F/6JhW1N6fwlYKGMhrftiCSHOQFT1HIRqCUY3mvkf3rFqp3vzkbPFT
        bYFV/xJIh1f07VbujiRhWj6h0sHybYI2Q8Ql8V2mMdXpcAdUEgLNefFaNfog5xX5EZRxDW
        7v/oqkQsaFEAMbtAOZDhgs9p3x39yA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-DEDpBmCAN2mdxnsCXaltYQ-1; Sun, 03 Jul 2022 10:22:21 -0400
X-MC-Unique: DEDpBmCAN2mdxnsCXaltYQ-1
Received: by mail-wm1-f69.google.com with SMTP id i5-20020a1c3b05000000b003a02b027e53so5978166wma.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 07:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axYsTZ/q6cjrUNl4MVAJ5gd7O1k4pTmZjnHk0JetlKs=;
        b=SS0g/wOUP+0JJgYwgFT/AFH8zYFxxNmHQPVJ5wkfpvqEiGNf4EL03/X8G+OV7PgMKj
         bO8gMdyaYmQ6D2nPfcAVeEAQ4yZggkANqBTIew1pZ/psqcYGbOFr0uvqVOtCmdYz6USk
         5456hzPob26My3/eOOJ7u/h//BP9QA7OMNTUCHTY8XGcbhKOyxq93xM8UUVQgMA2QmBD
         mNzaCNa5wsKpHhlPaF+jZfJRv5i8ecpJPxjVBsMNy7sNrerhme4sFt7edkJM3SUoLb+h
         zdwklPKcR/MsjGyjyBMQAUjaBv6lIT8y5WoqEvYOcI5YnOtQiNULAonPLVyWVzzK+IKb
         ymhw==
X-Gm-Message-State: AJIora8v4FMJaDXBdmq2POQBDfqvYV92QIngwJikdnJM3LfX2mJyUAjk
        Q75s3hD/YRculkT98VMOsGWC5C11CcCjKnFs9YMgO47+d23YAXwhYIXVRs5N9giBrr9eSCH4Jno
        2qrC5u5xgfPTZlZ9Lj2Ud05g=
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr24555761wmr.21.1656858140424;
        Sun, 03 Jul 2022 07:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sN/HF29rpcpC+6ICiQIsHeqb5vPV1E0KQ13hXXngqkdM+5+G0r9snt2h/T0duAn6byx8Hpsw==
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr24555744wmr.21.1656858140117;
        Sun, 03 Jul 2022 07:22:20 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g13-20020adffc8d000000b0021b99efceb6sm27846574wrr.22.2022.07.03.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 07:22:19 -0700 (PDT)
Date:   Sun, 3 Jul 2022 15:22:18 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220703142218.65dacvxozppgct6y@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-28 08:47 +0100, Aaron Tomlin wrote:
> On Tue 2022-06-28 05:54 +0000, Christophe Leroy wrote:
> > > -	/* Store the name of the last unloaded module for diagnostic purposes */
> > >   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> > > +	strcat(last_unloaded_module, module_flags(mod, buf, false));
> > 
> > You replace a bounded string copy by an unbounded strict contat.
> > 
> > Should you use strlcat() instead ?
> 
> Hi Christophe,
> 
> Why? If I understand correctly, both the destination and source string are
> NULL-terminated (see module_flags()). So, strcat() should be sufficient.

Hi Luis,

Any thoughts on this? As far as I can tell, the destination string cannot
be overwritten; albeit, I can use the safer option if you prefer.


Kind regards,

-- 
Aaron Tomlin

