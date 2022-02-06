Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873964AB0C0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiBFQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiBFQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 680E7C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644166496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGN0aCaJ6VNVrO8pLls0lDkqT7d3PIX0pXAwRUixJPc=;
        b=Bkfy/5bMfK/X3aVgBorpjHaLrl3ybZb3wgkQZDXQQPpYOH7cUTr23e7X0qntvpETnUyCwp
        udQcqkPb3EtTOpWx9Vifg/Uq7/ZuYLy473dqxHij9e39wlAqLmB44olqoDSEUpcQcaSpv8
        0P+FTDCRFEERXynZj5qVGWIC0swQhu8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-7HInp5mpMxGu5pnXhyA1qQ-1; Sun, 06 Feb 2022 11:54:55 -0500
X-MC-Unique: 7HInp5mpMxGu5pnXhyA1qQ-1
Received: by mail-wm1-f70.google.com with SMTP id s187-20020a1ca9c4000000b0037bb8547d64so2075085wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 08:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGN0aCaJ6VNVrO8pLls0lDkqT7d3PIX0pXAwRUixJPc=;
        b=NCYvpgv3DLfeqJITEIXqVgHraYdA5w1aZQDEZXraOve+i5i/TAo5wC0cs6x5Qr/wkO
         dU2UokeVxuKhYYsRCSpnEBuFtQ3sRpx2Ny+UT6OCb7qMfbH3Lcfx9ZnEbP3KhPtqADWf
         vS7C5Dz2QEMZMLekdX88zxIDyY0zHuWQTr7ygyVKFYPh7XQ236wSNiMALPMhj7hppd6r
         BrNr7etH/mJ2dufQ8PbmMcyXUTJR0IvI5MrdirHcqoMapTuFWEj+whP/Rh+VT3HAmSgJ
         qy0krkGZrja94bXoGQ0iXAl8xr9oMWBeOJR3xxD6pDqv4edu0W+nhUM4T7L5SJOYLMZC
         hU4Q==
X-Gm-Message-State: AOAM532MfQn3tzU9Bj7rPM5vCbS3iYcxICvSuYPmuPo/7Lk2Ek+nw3dL
        f617z5a5Jq17fTXK2Tts3MhRb8NMtsbC3cdXTpT82/3h0rU5zmGQEzGaldqMCvmlxUgKglHNiyc
        byBv1O4+Ve5r7MAEWwpNi5Zo=
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr7346532wmq.69.1644166494012;
        Sun, 06 Feb 2022 08:54:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI7l54iRHrlfaoSdBdIIrtfn3hw3WwzyqoYLSQlDRSZBn2Zp18nT6IhyGVrbRGstkN3YzPjA==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr7346509wmq.69.1644166493777;
        Sun, 06 Feb 2022 08:54:53 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p15sm7506809wrq.66.2022.02.06.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 08:54:53 -0800 (PST)
Date:   Sun, 6 Feb 2022 16:54:52 +0000
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
Message-ID: <20220206165452.ytpk4epltqr6pgyu@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 18:01 +0000, Christophe Leroy wrote:
> I have another comment: I think patch 5 should be dropped.

Fair enough.

> Having something behave based on a CONFIG_ARCH_HAS_SOMETHING item is 
> wrong. It is not because a plateform selects 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX that the module core should behave 
> differentely than with other platforms as far as the user has not 
> selected CONFIG_STRICT_MODULE_RWX.
> 
> And the topic here is wrong. It is a coincidence if making that stuff 
> depend on CONFIG_ARCH_HAS_STRICT_MODULE_RWX works. This is just because 
> the only architectures that do the module allocation without Exec flag 
> are architectures that have also selected 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX. But it should also work on other 
> architectures.
> 
> I don't know exactly what was the motivation for commit 93651f80dcb6 
> ("modules: fix compile error if don't have strict module rwx") at the 
> first place but it is just wrong and we should fix it.
> 
> module_enable_x() should work just fine regardless of 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX.

The above does make sense, to me.


Kind regards,

-- 
Aaron Tomlin

