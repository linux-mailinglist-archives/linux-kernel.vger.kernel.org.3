Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9865A1B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiHYVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiHYVfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:35:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D526C0E60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:35:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y18so16316054qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fSLO/axDczLseKKtJtifYKWpwYEJ29T8xmpeH5kEScE=;
        b=bxS8ZRf2KFP7bxgAzArusqJ4jGUEBuK+nEKWF150IBmfPIZjIk0YXm5Jy7U+8uqhSv
         ZFSNlYirIc5DuWpuJcxAqDphcjw97x3sh/31D3sspPtEUeco6zDGGG/0WmfUlphcTorE
         Y4p2gJ2RKu7CJp39zBkfP5r1zab4B5iojt8T0bU47aor0EGF0E6aOam6m+k6F0qQXs5C
         6ZMINH6nv4oSIYSkl7G3LnE4XS/THW8fDXVgpgdaF/7llgZLm16YBmjFv3QLIgzAuK6S
         La2OnYeiEvE/Vcx0pWm8HImjwOkOfVoz0AbiCEV4tNIxMp/J1Y5Ha72kEVp7Sxy4XdLU
         xhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fSLO/axDczLseKKtJtifYKWpwYEJ29T8xmpeH5kEScE=;
        b=WwA6gnGAJoZekGoREJKt9GMLsX5kLrxm11Si16Z7Q2jv7Up6bufyFVOdDecOwG6fWm
         GT7/K8X8ebgW3PZzZQm+2JtRK7kUPDwKiLAKD4EVszkjEl+GEnzSxKFfiirelGA5xxRZ
         xz44AQbi3PgeQ9pu/rYYNusXlSzxLfexvrKstKYPm3svAIs+4ronmKWjDtbikgRdnWAX
         tU3ZR4v8ZsMWQL98X64HhNiKrLo94eLXxY72AmZ9fjTBXnS5Z0rvo5KBEQhnVah4mXC9
         ijMi0MSaIwHPSRNJF+KbOcPUbJ6T2XyYswf/mrVOBmxtfwQ/L7wWMO4TyYAMhcLanzaA
         WrdA==
X-Gm-Message-State: ACgBeo2dPrHsrfwB1AlLL6lZIcAtsWDfBykKZJNDRNBbFv5nufBrS7Nb
        eyn+3Ip/ugUZYgE+Vv/rQAopgw9HkiI=
X-Google-Smtp-Source: AA6agR5j5AHUTjXarM6BEKs7SS/vIMcHupLSKazuC39sW/ZSNdC8mzKtvhKMuopbsLHxTJ/2MjjlrA==
X-Received: by 2002:a05:622a:178e:b0:344:56a8:25da with SMTP id s14-20020a05622a178e00b0034456a825damr5417075qtk.375.1661463348110;
        Thu, 25 Aug 2022 14:35:48 -0700 (PDT)
Received: from sophie ([45.134.140.164])
        by smtp.gmail.com with ESMTPSA id q20-20020ac84114000000b00341a807ed21sm26140qtl.72.2022.08.25.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:35:47 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:35:46 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] memblock tests: update alloc_api to test
 memblock_alloc_raw
Message-ID: <20220825213546.GA13624@sophie>
References: <cover.1660897732.git.remckee0@gmail.com>
 <48cfb01ba417895f28ce7ef9b99d1ce0854bfd5e.1660897732.git.remckee0@gmail.com>
 <d65cf9fe-e22c-7698-0313-879685f1319b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65cf9fe-e22c-7698-0313-879685f1319b@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:49:46AM +0200, David Hildenbrand wrote:
> On 19.08.22 10:34, Rebecca Mckeever wrote:
> > Update memblock_alloc() tests so that they test either memblock_alloc()
> > or memblock_alloc_raw() depending on the value of alloc_test_flags. Run
> > through all the existing tests in memblock_alloc_api twice: once for
> > memblock_alloc() and once for memblock_alloc_raw().
> > 
> > When the tests run memblock_alloc(), they test that the entire memory
> > region is zero. When the tests run memblock_alloc_raw(), they test that
> > the entire memory region is nonzero.
> 
> Could add a comment stating that we initialize the content to nonzero in
> that case, and expect it to remain unchanged (== not zeroed).
> 
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  tools/testing/memblock/tests/alloc_api.c | 98 ++++++++++++++++--------
> >  tools/testing/memblock/tests/common.h    | 25 ++++++
> >  2 files changed, 90 insertions(+), 33 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > index 65bff77dd55b..cf67687ae044 100644
> > --- a/tools/testing/memblock/tests/alloc_api.c
> > +++ b/tools/testing/memblock/tests/alloc_api.c
> > @@ -1,6 +1,29 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  #include "alloc_api.h"
> >  
> > +static const char * const func_testing[] = {
> > +	"memblock_alloc",
> > +	"memblock_alloc_raw"
> > +};
> > +
> > +static int alloc_test_flags = TEST_ZEROED;
> > +
> > +static inline const char * const get_func_testing(int flags)
> > +{
> > +	if (flags & TEST_RAW)
> > +		return func_testing[1];
> > +	else
> > +		return func_testing[0];
> 
> No need for the else, you can return directly.
> 
> Can we avoid the func_testing array?
> 
> 
> Persoally, I consider the "get_func_testing()" name a bit confusing.
> 
> get_memblock_alloc_name() ?
> 
> 
> > diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> > index 58f84bf2c9ae..4fd3534ff955 100644
> > --- a/tools/testing/memblock/tests/common.h
> > +++ b/tools/testing/memblock/tests/common.h
> > @@ -12,6 +12,11 @@
> >  
> >  #define MEM_SIZE SZ_16K
> >  
> > +enum test_flags {
> > +	TEST_ZEROED = 0x0,
> > +	TEST_RAW = 0x1
> > +};
> 
> I'd have called this
> 
> enum test_flags {
> 	/* No special request. */
> 	TEST_F_NONE = 0x0,
> 	/* Perform raw allocations (no zeroing of memory).
> 	TEST_F_RAW = 0x1,
> };
> 
> Further, I'd just have use #define for the flags.
> 
Do you mean use two #defines instead of the enum? I thought enums were
preferred when defining related constants.

> > +
> >  /**
> >   * ASSERT_EQ():
> >   * Check the condition
> > @@ -63,6 +68,18 @@
> >  	} \
> >  } while (0)
> >  
> > +/**
> > + * ASSERT_MEM_NE():
> > + * Check that none of the first @_size bytes of @_seen are equal to @_expected.
> > + * If false, print failed test message (if running with --verbose) and then
> > + * assert.
> > + */
> > +#define ASSERT_MEM_NE(_seen, _expected, _size) do { \
> > +	for (int _i = 0; _i < (_size); _i++) { \
> > +		ASSERT_NE((_seen)[_i], (_expected)); \
> > +	} \
> > +} while (0)
> > +
> >  #define PREFIX_PUSH() prefix_push(__func__)
> >  
> >  /*
> > @@ -116,4 +133,12 @@ static inline void run_bottom_up(int (*func)())
> >  	prefix_pop();
> >  }
> >  
> > +static inline void verify_mem_content(void *mem, int size, int flags)
> 
> nit: why use verify here when the other functions "assert". I'd have
> called this something like "assert_mem_content()"
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
Thanks,
Rebecca
