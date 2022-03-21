Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133844E27D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbiCUNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347990AbiCUNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C32F35853
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647869989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9Yz/N5m2IUmgkpbDZQCDFxoF6QbXF0nHMv1RhuJ7EQ=;
        b=Zx6KA4Tn7yikYuuEqxQ9LID4tJuASZ+XP9Hvrm3RBIo+/W6i5VTP6gfhjbG/OYKMU6GhKf
        RZM46NjywpguKmdO25PP45QJD8xUCwPyoaLuyHoSHr4cHpAQJ3hxhW6Wa7w0vADk2adoVj
        sT7hKNlKCepZenlor+9YvDgjR6ei1T8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-u-j9h7bUNwWKnSyZstSiOw-1; Mon, 21 Mar 2022 09:39:46 -0400
X-MC-Unique: u-j9h7bUNwWKnSyZstSiOw-1
Received: by mail-wr1-f71.google.com with SMTP id a17-20020a5d6cb1000000b00203f85a2ed9so1176305wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9Yz/N5m2IUmgkpbDZQCDFxoF6QbXF0nHMv1RhuJ7EQ=;
        b=SJ8KCvRliIsEPWkmc3RvtVRokO4x5rm/+kHKkfXMWoS+WaBoRlEKYwKofZR2A1xzOE
         xSOk+pvtE+8Ao2JOvsJ7cmCSR16dZOev3VDDK6TjOgukBAtFqdJSr1nPIhu487ydWf75
         43zQYqxgmOMPZGuV2FrVSmGOKmOA7m/I12ck4F8NVrG/uvyTHG+i7seCEKXnzrJJc+Oa
         +FsvdqJRPlT3G7dx0mWayIkuXKeRlFQkFvcLblAshBJcUOh0FhxQufGVjqv7FSUPS2LZ
         YVqzI0SuzBFtYKEMaYZKwoUy8OYZGN2ocruFIHnoHV1tRAr7WiCuMHFYyUv1qXqeTe4A
         MfkA==
X-Gm-Message-State: AOAM532xeiR44mddELLZnfILZlNasYjsQKUgB1fniV3+HXgdwzkMn8/m
        IUeUKGP0Oc67MsupV0YznVklBAV3thwpUJ5p7nj+/ZYM5t84+hpQKFB9mswZVoc9swd7BdP3jQZ
        PTCDCgq/MUBIWvX6fnlf0f6M=
X-Received: by 2002:a05:600c:a08:b0:38c:93c8:36e9 with SMTP id z8-20020a05600c0a0800b0038c93c836e9mr10899973wmp.97.1647869984816;
        Mon, 21 Mar 2022 06:39:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVkVUoJJOUY7M9Nab0zaNGhzmb3ekBQCRL1ZNysNrFMu8ck2yxo2AYSL4QPYibzYPewRYeog==
X-Received: by 2002:a05:600c:a08:b0:38c:93c8:36e9 with SMTP id z8-20020a05600c0a0800b0038c93c836e9mr10899960wmp.97.1647869984636;
        Mon, 21 Mar 2022 06:39:44 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm13575059wmq.6.2022.03.21.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:39:43 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:39:42 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Maninder Singh <maninder1.s@samsung.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <20220321133942.pbv7vvkn5r62ky5x@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
 <YjDScHjMUbqYV4s4@bombadil.infradead.org>
 <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
 <YjGe961XL8GW7Qeh@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjGe961XL8GW7Qeh@bombadil.infradead.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-16 01:25 -0700, Luis Chamberlain wrote:
> I know this has been quite a bit of churn, but given Aaron's series I
> really hope we're goint to be in a better place for maintenance for
> modules long term.
> 
> I guess I gotta go automate tests to these things somehow too.

Hi Luis,

I can send a v12 now if you'd like?


Kind regards,

-- 
Aaron Tomlin

