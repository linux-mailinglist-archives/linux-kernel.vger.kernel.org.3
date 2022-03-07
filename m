Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68414CF811
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiCGJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiCGJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 160B666FA1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646645890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hRKjru0jaANdaMFZ+K70lfTDMO4iHRVAfY2BeEn/4o=;
        b=N42A3i3pxO9M6cKBKYsoatl4B9rd65zp+uuCLEAPI/JTL4CCFSBWmlNJm4jHdi0rfU6J6/
        J5W3l7EziBREKA+XtqDpC31oO1Mzcp8XvlC4/rQNB+pU1o5uPVJHL2haStV32CT4ZvA2CU
        zKBUHRGl5uHSjjMJnPGuwkcmbSvD+TE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-R9YZlNOKMf6ZO3lB2FBNFQ-1; Mon, 07 Mar 2022 04:38:08 -0500
X-MC-Unique: R9YZlNOKMf6ZO3lB2FBNFQ-1
Received: by mail-wm1-f69.google.com with SMTP id d8-20020a05600c34c800b0037e3cd6225eso5052580wmq.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2hRKjru0jaANdaMFZ+K70lfTDMO4iHRVAfY2BeEn/4o=;
        b=dDL5oKxnVe3CdkjngNT1RB4iYW/kOxecO8cya2ti3+yK4Rl/pwfuGIs/g+60LkRWs9
         QT8GO3cHonWUdp92dghHqJyMCDm4f/OR4M6YWiCl1FYZqy50gsftIJDcPYupjupqVArz
         kCtodigFEYd8rH16gakQqKBBx6NOEo8hNoGLUTVwiaVnr5cMDBJbielVo9luB8jrEDNA
         Nu/66PgYyHj8GtkyDBiv4CYdDCghPLtGpatYycWRtDrafjRiBTIWfFeJVEiJXwjd/Yhz
         Ypy9poNFCvRUVhy1EFqezI0EOZ9zTHtOkO8KzRyuhsNm2sGMRJVjEz4Qbar62SPzSQdX
         GwXA==
X-Gm-Message-State: AOAM5302urYCqZ81D4sFvTioFOi338+iGEHiCph5HxWOlO4T18xXqLiz
        PJcibIHkPE8j1w6ENnzpIfKP6QgHzHntWoNWb5D2hLBoVn9FfH6lQTb06Ga9vGhH5VRTFuh+UMs
        R/xsR2fqOUh3wEpeD5iHBsa0=
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr7650076wrw.632.1646645887134;
        Mon, 07 Mar 2022 01:38:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYgPmZBFCYVwYlVuJ55u4vArcYAHv9y3dFz+eZ23t3tabZPf1FdajgzMXADgtlXevyUTT86g==
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr7650058wrw.632.1646645886967;
        Mon, 07 Mar 2022 01:38:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600003cc00b001f34d8c5baesm918078wrg.78.2022.03.07.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:38:06 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:38:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     christophe.leroy@csgroup.eu, mcgrof@kernel.org
Cc:     "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
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
Message-ID: <20220307093804.eor4dn5gp2dwn5jk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
 <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
 <4b00cc1c-0fc9-7348-28ee-b06de0fef3c7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b00cc1c-0fc9-7348-28ee-b06de0fef3c7@csgroup.eu>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-03-06 17:46 +0000, Christophe Leroy wrote:
> 2/ CONFIG_MODULES=y, CONFIG_MODULE_SIG=n

Christophe,

I see, I did not notice that the above is even possible.

> Case 2/, is_module_sig_enforced() is nowhere.

Understood.


Luis,

I'll send a v10 later today.


Kind regards,

-- 
Aaron Tomlin

