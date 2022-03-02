Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A94CA614
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiCBNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiCBNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FB705D5E6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646228009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wwGzeYALfyBwg0W+DN9EfRv02WTck/Nh84p6AnYsDk=;
        b=Yxlv7miiMeDN7IlB9BprvHePGs1oM8u8OBt3+ymT3VJXIMg7MbhvJeDLWyLx9SKjOt/IrG
        eQR3XCoiBy/wx2ynOlidgY4dDPj1JkI37RpRhL1TlXw1blv//6LV6fuTLfh4YeTtjsDL+3
        LTaW29wWBs3fG7FqeIL8d4ZU9OuNwgI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-FPef2ZCmMyaFLZPFXeBbxw-1; Wed, 02 Mar 2022 08:33:28 -0500
X-MC-Unique: FPef2ZCmMyaFLZPFXeBbxw-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so1947750wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wwGzeYALfyBwg0W+DN9EfRv02WTck/Nh84p6AnYsDk=;
        b=tYPxmpzY/t3xYZ7VdMBmVdrhycXiCfWF4tNpStJ2qwPgu/udX86EzxnCaKWvwr7Nug
         46BLlrAONFa5da1VzXzoCR+RQE3VWjXvOUBWl87xPgCIOt6GhUR3CtihMSrXlRlrfZjN
         9LykTVVpvnbcahrDp/yD9hY3oknvxp0ne6GSFY12zGy1kcPJdFYeYZ5jBjtthYRki93y
         iEIW1qPMjrEswZvd8dNSezt5kY8U90Zz3u5ItzlpPLxrl8qKEPid/Wm/6sD/Z71+Ttt1
         B/jjp6irWA88PFpFBvePNBEDJ0SRKcwiSPNvuHhmdamzqb1Fcg/IuE4v4olPVAR6Mm2r
         qYJQ==
X-Gm-Message-State: AOAM533XMbGqZ5do3uqSY71ugSDC8SgmvCiGe/LjMdNwx3sstjVeYl+Y
        YIE5aWXf69cuAo2lDsIUkvqxgNAsjilfEtQArAMBxHSGDsJCQuhs1n58Sqlp6mdMgWyd/vyINsr
        WY3ZW17IzenxniZIQGT+iZHQ=
X-Received: by 2002:a05:600c:1988:b0:37c:505:d45c with SMTP id t8-20020a05600c198800b0037c0505d45cmr20369538wmq.107.1646228007645;
        Wed, 02 Mar 2022 05:33:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuOzCNkdBFaq96UmCHlYIRrcOPrm/1vUKIvqh8NhtpQcOTI3r3H44Wf3FHK32QizQKDNFadQ==
X-Received: by 2002:a05:600c:1988:b0:37c:505:d45c with SMTP id t8-20020a05600c198800b0037c0505d45cmr20369518wmq.107.1646228007454;
        Wed, 02 Mar 2022 05:33:27 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b001efd7eb7c37sm8716859wrp.34.2022.03.02.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:33:25 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:33:24 +0000
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
Message-ID: <20220302133324.dbf5vx45foxa32bu@ava.usersys.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 08:08 +0000, Christophe Leroy wrote:
> > +bool is_module_sig_enforced(void)
> > +{
> > +	return sig_enforce;
> > +}
> > +EXPORT_SYMBOL(is_module_sig_enforced);
> 
> As reported by the test robot, that's not enough.

Hi Christophe,

Thanks for testing this.

> When it was in main.c, is_module_sig_enforced() was build as soon as 
> CONFIG_MODULES was set.
> Now it is only built when CONFIG_MODULE_SIG is selected,

Agreed.

> so you have to modify include/linux/modules.h and have the stub
> is_module_sig_enforced() when CONFIG_MODULE_SIG is not selected and not
> only when CONFIG_MODULES is not selected.

Sure: when Kconfig CONFIG_MODULE_SIG is not selected.

Luis,

I can see that the latest series is in mcgrof/modules-testing.
Should I address the above as a separate patch with "Fixes:" or
provide a whole new series, with the fix within the same patch?
In my opinion, another iteration would be cleaner.


Kind regards,

-- 
Aaron Tomlin

