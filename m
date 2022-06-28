Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6455E368
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiF1IYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbiF1IXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6E2F275DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656404587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyHqoetnxg5PCrqJPwXKQqt6t1OAl//oQoJPs5YDLec=;
        b=PX3X9TpZq8H2k4iW1RUm2LVBkB0zoo0WHaG28HABJJdTNInCM4EJNzJ/gjs1MbPkg0aTWU
        QcQIMeZyv2qHXcxJmaZf7U0J0Dhd+Hsu4LbLcqctv8rfU6yhIvoIB+Vd7h4jTJAxb/CkvH
        fkanfhsTWUDomrbgFM90wpBbG8CbzYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-2iwuEnqLO0a62vE3Fg4W2w-1; Tue, 28 Jun 2022 04:23:06 -0400
X-MC-Unique: 2iwuEnqLO0a62vE3Fg4W2w-1
Received: by mail-wm1-f69.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so6780712wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyHqoetnxg5PCrqJPwXKQqt6t1OAl//oQoJPs5YDLec=;
        b=Voi7USLRNCAKQ3vg3tyd3tbAAuUC7ZmNAyHgwLNH+BLjO+k6Tv6aJeRe+QRo97S4Wk
         QyGbWPfy1CtXEvMMFBWpsk1rQi9MBfHLnUa+2haKXT8XgZbt6OOgka2jQmSaCn71pd/G
         ecSrcX0gbJz/Xz8flzu8A06sPAQiC37YS5zm+9C1WLuQu6P5l0Sjt0iXCRBONEVRWDec
         Mw0wmKrboKs6660gEN5CeDRdhwIPIQ+4DTGGc2XSorQVlZ7SG0BwAujy0wUXdDY51nMV
         xVfD20gXVp+T1I+4IlKcF+2DRcMKZV+XRjFGCr2v/qs51sQkujeQ9uktCuSgtpnpAE4a
         iXZw==
X-Gm-Message-State: AJIora+gTU+KiAyVdu2esPb1qEeRsjLQKlbWB3SMYxUqLQnEpw1GyiX9
        Y/NlT9JQ43THxy1V574/SVzEoi5e6CjvPND2I0PEkXgaGwazuowYwVZyj+BZ4JcG3Xa29vmBeXM
        yCfLrFlqkaSaVUoAkx6zwehw=
X-Received: by 2002:adf:f2cc:0:b0:21b:9efa:611a with SMTP id d12-20020adff2cc000000b0021b9efa611amr16991142wrp.573.1656404584983;
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u+ynZvW171NUhrXsU4wk5UGlyUXWi+64Z5WVppsnvsN2YX6E0UsI+N4Og47xMumLjtD1Menw==
X-Received: by 2002:adf:f2cc:0:b0:21b:9efa:611a with SMTP id d12-20020adff2cc000000b0021b9efa611amr16991127wrp.573.1656404584830;
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bc195000000b0039c362311d2sm24102805wmi.9.2022.06.28.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:23:03 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220628082303.zelpqlluofwy2hb6@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
 <b44b2b4a-20e2-2d42-22b1-c1e44c6f999d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b44b2b4a-20e2-2d42-22b1-c1e44c6f999d@csgroup.eu>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-28 08:16 +0000, Christophe Leroy wrote:
> Are you sure you will never ever end up with a string longer than the 
> length of last_unloaded_module ?

If I am not mistaken, the length of 'last_unloaded_module' has been
increased to accommodate for: the maximum module name, total module flag
count, '(', ')' and '\0'.


Kind regards,

-- 
Aaron Tomlin

