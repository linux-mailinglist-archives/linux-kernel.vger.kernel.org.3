Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9E4CD3E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiCDMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCDMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E085A1AAA62
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646395175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hZpcrT4T8XD6Mp3T/V7L8uTti8hHiq/LHVjIVxUD8k=;
        b=AriO3XAkCa+AwvJRsu/geGCLV3traKkwcs6n74hHO+hVTLxDgIF54L99F1qt1Qo2NKwSMR
        AbwYEkm7m84M/kkJkwUvr9lavj75eWRcrhuwu+6Nmr987h05BHPWFbu28mXFfEKoBpHedI
        1Fz+GVSjplhNh6zygIDmTt/CaR8prsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-wcguayVEOPq4NfCs_GdUwQ-1; Fri, 04 Mar 2022 06:59:33 -0500
X-MC-Unique: wcguayVEOPq4NfCs_GdUwQ-1
Received: by mail-wm1-f71.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso3645578wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 03:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hZpcrT4T8XD6Mp3T/V7L8uTti8hHiq/LHVjIVxUD8k=;
        b=HWgH9EkrSmZqeoQj/4ceXxtzuwM/AQ6yGZrLLC1jcwY8VAQd1OpbdQPh6Pzzzwezfk
         hxLZJR1SFYYdt425NbGNMYeCbR82b+hw17G98xFJuMLaggBthqk7z9fhcEDlTJNx9Szj
         cO7rSFIdFpD4BmxBwGaTbPJvJz0SNLbpR4lfOvrGTWZ6fpqVUmacYU1UMEBzUw52LZYp
         PezOuJqxgEppv5ybE+4nuaYUmZlOyrIP89+g1kueGj52zW+SObezaJQxiyPi9UVxG8Wm
         FuoBc9BEBomO7UGA2rKIRG59K0hk6nZAzZDQYwDrZVqNNcbyUZhkzE+Ufzquok53wXPA
         L93A==
X-Gm-Message-State: AOAM533vwXV5co/f4KzNcxCiTYdtLilSNJP0bHSlb1slzSqPcmr5cppJ
        yvvNwHQU2/wE8qvc10DGH9UGxLH/Vt5ahIsjwQ/6LCNL25hMeQFe9F1N1DwghUNX979DXJstNYh
        sOt8gu52Bxs7t3+zOBn1rrZI=
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr30067522wrm.607.1646395172701;
        Fri, 04 Mar 2022 03:59:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfCYRYmPjKjzMoD8NXHJIbCgcjtQs9sSa52UxrnMZHRl2r2JzrHrLHUBPM8THYFCs9P4DdYw==
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr30067499wrm.607.1646395172480;
        Fri, 04 Mar 2022 03:59:32 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b001e75916a7c2sm4412880wrt.84.2022.03.04.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:59:31 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:59:30 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
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
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220304115930.vn7l3np465d6bbfc@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
 <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
 <20220304115444.jlfv6abblqgyzscj@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304115444.jlfv6abblqgyzscj@maple.lan>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-04 11:54 +0000, Daniel Thompson wrote:
> Aaron: Are you OK to add the new kdb file to the "KGDB / KDB
> /debug_core" file list in MAINTAINERS? Mostly I'd expect to just
> Ack changes and move on... but I'd like to be in the loop.

Hi Daniel,

Sure - no problem.


Kind regards,

-- 
Aaron Tomlin

