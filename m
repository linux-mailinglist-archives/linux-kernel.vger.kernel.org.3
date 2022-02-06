Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E067E4AB0C5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiBFQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiBFQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9466C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644166655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nj8ZhaWyrNgsbixCTI1WPw5NYTJpZ/GvO+OBOf7Xfj8=;
        b=b5KRWbuKRP3SJDY7FrwIiv7cNaw3lMbfdeu+tMLFtF4XjzCe/UUC1Ra4iGluQHIVHEcJ/y
        zDWjRls8YYnit/dcp+4UiRTSCVoGIg49oBw3eu7+mcg34YNIUmfOF123855kLDru+o4isa
        xScOfcIcAGbP7B9hC9imrLeiZdyVwqk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-K6IwTr3SN4mzcKWOLfgRrg-1; Sun, 06 Feb 2022 11:57:34 -0500
X-MC-Unique: K6IwTr3SN4mzcKWOLfgRrg-1
Received: by mail-wm1-f70.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso4451976wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 08:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nj8ZhaWyrNgsbixCTI1WPw5NYTJpZ/GvO+OBOf7Xfj8=;
        b=orMezs1+q7SiF1KXZBCmqC176bfBZUJ0OOOK3edp8DVC2o06v1jNlL+zBdOgyDmM+P
         aCVgG2tHIgW9sLQZ3LaiROnh+Djh27zjia8QCdHXVfOYge11VREPb8t91MpThb2XHn27
         yCfWznvem5MgoNqAHOuqTtGzlwMsSErDBanB8tO8FdwMIlIbMLDtb3vX2hPWEivP+bd+
         Z9LRkEkXyD25vWfgQbMIE1UydReg+bqYOr/ParB6/xgb2I8pwa3O4Qz3EV4w42tAoR7M
         TZ5b0K1TDMxbHSa1+ZUNHPGiJ7Mgl9bENUjqn9grolRy1bwovWDeF/6OZfEpbB4Jexrq
         wPGQ==
X-Gm-Message-State: AOAM531Hj8ev1gtQYG9UDnVPOpfDTXFigVx8/1GFrv2wqUs/FE1ibgl8
        HD8O2r7QvaFR5CL86TpBsFbg+ODLsYXDhwWyPHaJgEmWFVX5IX9QLj/SC58Hq6+nooIWoXa3bwv
        zDdBsJWtpjwwZEgw3GMwcjtk=
X-Received: by 2002:adf:e196:: with SMTP id az22mr7022632wrb.113.1644166653398;
        Sun, 06 Feb 2022 08:57:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX0n3HHySvpcKHUlPDvRzl6SK5emiCLQSwfdUs9Vi2BoUh+o91qWVC6WJC5r45HbYobbBtFA==
X-Received: by 2002:adf:e196:: with SMTP id az22mr7022607wrb.113.1644166653192;
        Sun, 06 Feb 2022 08:57:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g20sm20634047wmq.9.2022.02.06.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 08:57:32 -0800 (PST)
Date:   Sun, 6 Feb 2022 16:57:32 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
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
        "joe@perches.com" <joe@perches.com>
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206165732.fjge6teag2hf3cc4@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <be5db28e-ead0-4bed-d826-06ffba1e96f7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be5db28e-ead0-4bed-d826-06ffba1e96f7@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 18:15 +0000, Christophe Leroy wrote:
> I also have the feeling that a lot of stuff like function prototypes you 
> added in include/linux/module.h should instead go in 
> kernel/module/internal.h as they are not used outside of kernel/module/

Agreed - this will be reflected in v5.


Kind regards,

-- 
Aaron Tomlin

