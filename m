Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB94C00A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiBVR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiBVR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0ED8B16DD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645552629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJzZgeDzNY7zmhhmPD8Ts6QhadgVuW+LtnZrIEdFmk4=;
        b=T1Y9hBwCAp+Zn3JT6xpWEyfR1QnIkNsNMbNa0BCflRWedtGlB462I+lGaEoHcP4V1TJhZP
        Y/fNCDutTY6NhAhdkWT4fTVio5jQVUpuUgVhph/TgUp+maViTvhK5FviAofX6b0fK7h1Pn
        LxXWOO54mMx53cPpxdj5kuGVmMfpA3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-BrnfhZnFNfStLgExgCTjhA-1; Tue, 22 Feb 2022 12:57:07 -0500
X-MC-Unique: BrnfhZnFNfStLgExgCTjhA-1
Received: by mail-wr1-f71.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so7251573wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJzZgeDzNY7zmhhmPD8Ts6QhadgVuW+LtnZrIEdFmk4=;
        b=DIQ4ozBjDtTGxpo5hvUvuliIFPEokbimG/qQQC7X6p3kxZGneJrGbZkdZwNUuZlMZM
         ehbAPYtDBNZ1i+LCY9wakR4IbY5nsf+ylsQa99xw/DZlnhYa0SvxkyX0kxt26eCFtnUB
         /aHxlO9Yo7xlNsksA8gr642KyLsJTJSIDkdbuR84NZAa+ffCBlakcO4Wq8rF2fjuqvFB
         PTCggHuFuS7QMnkcB8YVPARwp6dZoNarcSM+U/VANbWHyd0VDAT7/fG/EdkMJ1I/pSgd
         IPZkkB/rQAW1ASfc5mJ093oPJw8FEzPz/hVv6jm0OVDLaJ/xfFTVYfQ+kPnyCdf/toMf
         rrLQ==
X-Gm-Message-State: AOAM5330sd711GFiQNu9CIXAH7XK/joFBKve4ZLgIHmSExYPvau5jiP5
        aHbe35WvgeoTIavH9fl+XpE5ClnKQZ9jR3gyHiTQqEAXK66HJEllEoFca+8BUZZD9fAX+THYJey
        vBO0VN1t48daXZhWKbZhB3qM=
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20431444wrz.329.1645552626670;
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBLqieyLWhR9YxZvOyFiDe21CGa5pv2+OROhVCjx6WLj1pEI28rUPcGkTq6FUILDxoAizVhQ==
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20431432wrz.329.1645552626509;
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e7sm33021244wrg.44.2022.02.22.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:57:05 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v5 1/6] module: Always have struct mod_tree_root
Message-ID: <20220222175705.ryqmhhrpokx7xbgv@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <cover.1645541930.git.christophe.leroy@csgroup.eu>
 <c9584f48abce748e62e65e6757ceb23800f15380.1645541930.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9584f48abce748e62e65e6757ceb23800f15380.1645541930.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 16:00 +0100, Christophe Leroy wrote:
> In order to separate text and data, we need to setup
> two rb trees.
> 
> This means that struct mod_tree_root is required even without
> MODULES_TREE_LOOKUP.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/module/internal.h | 4 +++-
>  kernel/module/main.c     | 5 -----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

