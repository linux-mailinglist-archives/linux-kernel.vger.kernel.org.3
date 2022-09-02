Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD95AA57D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIBCMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiIBCMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:12:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2E5A5C44;
        Thu,  1 Sep 2022 19:12:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so580457otu.3;
        Thu, 01 Sep 2022 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T7qq37umgy6ILkKn2p66Hov6G9QBZKLlte3WFGWCXUk=;
        b=kShF43PTGAVnO6M2WEQ62vKFE2hZjX+s0ksKCv0m3dl5S8SK7Jz1dRr/0kRRo3QShN
         9L7CO1GKaelow0O6Kp+3Mw8xsVjH31dgo5hQmyxrJyIlDgpDYWSXa+81rZilAv92uPYJ
         RCtoQ1coMkX3Vl7RBFTbjcBa57Gx6nSqBbvGSVvELhOJGjb0rkx7gKQ9myot+5Rxys3Q
         EygA98Q2JyxZCSOlssAY58hjIJ2ial7vtoiTgTypn+qbbpmcqL0dDCmOA9KXllk+QlZN
         fTBm+SFVDHWLmw6DEDN0JxBfx2wxEgeSfKa8aa7Fb3Gu6n5p27Szv/DCTM1uKxpV2SZh
         F1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T7qq37umgy6ILkKn2p66Hov6G9QBZKLlte3WFGWCXUk=;
        b=Tuz5o2iBla/iL9g1lkYdrR4f0ASnB0Vl7WShoDTNge0m24KxTmBaf4XNxtKAeczZ/Z
         h+4MmvLtNPx4Rw7+uVbgd4YaJYihjfWSSDEa/Wv50lcEGYR/T8DAA6PQ/EkxFjQG7Fa0
         QDvsMBUa2xwM1LeCW79tTAs3ESneKZfR96rAytI/fDcQBq+kUv8H3nwPRzW6IwzAkh3n
         hiQ5CKWBYU3h9Cv6TQD8cTVYIYuxrEeIIy5q4rqYAMKhzuiyr4vsn8WpAyaQcbrnJnPU
         kEzcZNP9bmUsFG3x4ZWkZSH5O1PH+maJaB5w4kyLLbQWXsEVeqqtOj6M3W0LYru9eoXN
         HEYA==
X-Gm-Message-State: ACgBeo1+pU/9KtSiPjaVxQQsyYPi1jlhtqRutyFgPy2ODkSoZjLCt7qJ
        IeElLhV1aWj8NWnVf/kxY40=
X-Google-Smtp-Source: AA6agR6iWK5m7HDr3+E8mKvzZRfJotVF8JW4zDXRnMAg4Z9wqwnLCN5eXp2jwPO3KSVC3xbefMevEg==
X-Received: by 2002:a05:6830:1544:b0:63b:2c65:9081 with SMTP id l4-20020a056830154400b0063b2c659081mr9134823otp.193.1662084740432;
        Thu, 01 Sep 2022 19:12:20 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 97-20020a9d036a000000b006371af665c5sm418990otv.56.2022.09.01.19.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:12:20 -0700 (PDT)
Date:   Thu, 1 Sep 2022 19:10:09 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 08/10] headers/deps: mm: Split <linux/gfp_types.h> out of
 <linux/gfp.h>
Message-ID: <YxFmAcrDkFuIsuOu@yury-laptop>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
 <20220706174253.4175492-9-yury.norov@gmail.com>
 <YxEZYUCA0b8Cd1/S@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxEZYUCA0b8Cd1/S@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:43:13PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 10:42:51AM -0700, Yury Norov wrote:
> > From: Ingo Molnar <mingo@kernel.org>
> > 
> > This is a much smaller header.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/gfp.h       | 345 +------------------------------------
> >  include/linux/gfp_types.h | 348 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 350 insertions(+), 343 deletions(-)
> 
> You move a lot of kernel-doc.  Where do you change the rst files?

Ingo - nowhere. So I did it in the next patch:

7343f2b0db4961d ("headers/deps: mm: align MANITAINERS and Docs with new
gfp.h structure")
