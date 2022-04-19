Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B000506C93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiDSMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348310AbiDSMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:38:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31C2E9D2;
        Tue, 19 Apr 2022 05:35:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so32619508ejb.6;
        Tue, 19 Apr 2022 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaNLhQu+QWWvZbpDFGtXSt3/5W9s0AKclZhaLjx4Bo8=;
        b=F7wPvxjsI3taT1eprbvJq5aN0oQ/3ONZTdNjhmhmAq9MYhceoNcHAeXrl2o7mHbafY
         bTZYbVi1qbJ9TFn3DtwyH540d6Ps+YRQxT4hlakrN/dkb6lKuWVS9cLgKO/ta6qLHn/a
         i2yF31VlQKf3hYHa6NOehBJNkgm00T3oUfJsOTkeAD8d8xGaYOsHy0Ax59P8OU74xTMe
         dsAJKkJ87Y5ugq0p3INoX8datsKRKAJ5Od1zeqb0RDifG8E03ApGz1uuU3CVnnfHbZ/P
         VYxSvN/vdOkoknlTL/c7CeKvMvaPmXKa6/8pK9tqimsRgBkp6Oey8IXVil+H6r4PsW5K
         zvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaNLhQu+QWWvZbpDFGtXSt3/5W9s0AKclZhaLjx4Bo8=;
        b=NRzUSVHR+7ziG/EcHZjlx6xonv3VwJKPKlcu/1bgZYYfq1u9CByTkbwP4JGwx8tmhS
         /h1tLFqf/VPhiJw8wPjuPtdcWxzIrdykCEw30i86zU7IvdPjEbaZuupTnsBqEt4ARX5j
         8y9og/DWt217WpGrJmiKQIIYV1KL4QAxDJXRFUNerBPZnrCp1qq1+F0ugK1Vwhjdjrsa
         WtEnVaDURj1baOMJav57mwDtpgSZXL+Aw0+iqwRxGKNl8tCuULlHr36T/QYh/XFxpDAH
         8KBRLWnTRM97S1FoTZxAWZwF8iwrc5sgXzbHNurr315DxgbQAFs8jGc/ULKSH6WGhHvg
         ihVA==
X-Gm-Message-State: AOAM530CFEwgm/8qZrw1+iQ+nyYpEp7Vu9ZoV7mvuI6fcg5VexfwL1YN
        x38iK1M7hIDz53G/5fODM7Q=
X-Google-Smtp-Source: ABdhPJzMKqFT9NsTEuV6XDc1/i5YPbX23EMYYcdpp9FAwsphV2nOFI2phUGBoYRO1oH977BD5TSmSg==
X-Received: by 2002:a17:907:1c2a:b0:6ef:e251:1611 with SMTP id nc42-20020a1709071c2a00b006efe2511611mr2186451ejc.532.1650371750557;
        Tue, 19 Apr 2022 05:35:50 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006e891c0b7e0sm5568898ejc.129.2022.04.19.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:35:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/vm: Include kernel-doc from highmem-internal.h
Date:   Tue, 19 Apr 2022 14:35:48 +0200
Message-ID: <2824835.e9J7NaK4W3@leap>
In-Reply-To: <Yl3Z8Qll+zGo4v/D@iweiny-desk3>
References: <20220418081740.21001-1-fmdefrancesco@gmail.com> <Yl3Z8Qll+zGo4v/D@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 23:36:49 CEST Ira Weiny wrote:
> On Mon, Apr 18, 2022 at 10:17:40AM +0200, Fabio M. De Francesco wrote:
> > In Documentation/vm/highmem.rst the kernel-doc comments are missing,
> > therefore kunmap_local() and kunmap_atomic() are yet undocumented.
> >=20
> > Add a kernel-doc directive to include the above-mentioned kernel-doc
> > comments in highmem.rst.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> I thought I saw a patch fly by which changed the comment of=20
kunmap_atomic() in
> include/linux/highmem-internal.h?  Did I miss that somewhere?

Sorry, in my other email I responded after misunderstanding your question=20
because I had just noticed a typo so that I had something else in my mind.

It looks that you are talking about the following patch and, if so, you saw=
=20
it correctly:

"[PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h" at=20
https://lore.kernel.org/lkml/20220418175638.30018-1-fmdefrancesco@gmail.com/

I forgot to send it to the Outreachy list. I'm about to resend it only to=20
this list in order to make Outreachy's organizers to know about it. For v1=
=20
already had an "Acked-by:" tag from Mike Rapoport.

Thanks,

=46abio M. De Francesco


