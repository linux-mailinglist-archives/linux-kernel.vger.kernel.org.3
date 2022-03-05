Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070C4CE705
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiCEUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiCEUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B13A9FF8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646512681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTq2l8ofz9rdVgsUXAyYiBJlx/2wq7tGHGb9qgHLPos=;
        b=Na7IWn8d4p3kFHKi7aGUaDrYwKML0YsJX4BIt+EtF6qT6lAQsrGdu0icoNRQy1ZlzbeNCk
        w8SIt4L/YMfDHIOdu6HzZ2rDOe1iSTbRWZwQgB8APnhPtL0dY8qVLPZUMwN+2INGxnnf+B
        4XlRrdNSrCGW0BEZC6SATS/teab2fj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-XDigI6JDMom-MOAFdr8-pA-1; Sat, 05 Mar 2022 15:38:00 -0500
X-MC-Unique: XDigI6JDMom-MOAFdr8-pA-1
Received: by mail-wm1-f69.google.com with SMTP id o207-20020a1ca5d8000000b0038977354e75so1750473wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 12:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LTq2l8ofz9rdVgsUXAyYiBJlx/2wq7tGHGb9qgHLPos=;
        b=Q2lQGA0FZWPHIP16BSWHSpFg7vt1KEr2ifmhdN8Azl484435/PBTnaQWZjT3N+2+Sp
         flY1q+WA3J8u4aC4oJO8gJ0iZXIFQv/QNFHcoKC7eeyHkgnd+qop6xpI4725vsU/rnbk
         MuHFhyajKkGeVqJG8YDTZd0qYzCegp78g0pPYPINCPSyqUCLXPG+lHwVg0Bf4NtVHgIJ
         ECqfUAzSuFRMicxnbKF1BDRQvsIrM+MTIR2bhWUtCa1/YvJgxX7ymXDfCgxKvlLPGht+
         iYIybkim6pmdtli2dJgJdjh/0wGvX38tTH68fbDesD9Ec79En1y37ZeFI7IeWZ3Mso1X
         LuZw==
X-Gm-Message-State: AOAM533rX3WO0Ozg3L+HKHLNA5+TMFC/Hk2r1znIr5DO7HlGSa1Smkhl
        ZN44lF9dUbrIt04GNpHrECTNyRV9Qa7M4UqrI3N6ErNi0HJ1kuz/sDRvycucR+fqqKMuR0PO8Cx
        m6rwF5eannHTDHYuNOY9FFWs=
X-Received: by 2002:a5d:6da8:0:b0:1f0:4c26:3f57 with SMTP id u8-20020a5d6da8000000b001f04c263f57mr3501213wrs.460.1646512679062;
        Sat, 05 Mar 2022 12:37:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzV1YoK0tLxXR6swa6/8fXMxsqZhiV8WJMWAsr0QJnH+uc8+sh3Wp/MtpytQyrJNwH1BzNGwQ==
X-Received: by 2002:a5d:6da8:0:b0:1f0:4c26:3f57 with SMTP id u8-20020a5d6da8000000b001f04c263f57mr3501203wrs.460.1646512678803;
        Sat, 05 Mar 2022 12:37:58 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b003816932de9csm15206434wmg.24.2022.03.05.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:37:57 -0800 (PST)
Date:   Sat, 5 Mar 2022 20:37:56 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v9 07/14] module: Move extra signature support out of
 core code
Message-ID: <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 08:08 +0000, Christophe Leroy wrote:
> When it was in main.c, is_module_sig_enforced() was build as soon as 
> CONFIG_MODULES was set.
> 
> Now it is only built when CONFIG_MODULE_SIG is selected, so you have to 
> modify include/linux/modules.h and have the stub 
> is_module_sig_enforced() when CONFIG_MODULE_SIG is not selected and not 
> only when CONFIG_MODULES is not selected.

Hi Christophe,

Looking at this again, perhaps I'm missing something. If I understand
correctly, Kconfig CONFIG_MODULE_SIG cannot be selected without
CONFIG_MODULES; also CONFIG_MODULE_SIG depends on CONFIG_MODULES, no?
So, what is present is enough right i.e. the stub when CONFIG_MODULES is
not enabled?


Kind regards,

-- 
Aaron Tomlin

