Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD535642FE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGBV7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:59:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08703BC98;
        Sat,  2 Jul 2022 14:59:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l14so4722228qtx.2;
        Sat, 02 Jul 2022 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRmpJqPfR2Ffc8HgrJVdi9vtvYXJmh3FYn3557q1NwE=;
        b=IM5wTLBzQjNlhxRrQd9duTSaviX9W642sXlAB85N1J/s7j5rmEna+8IABQod6CKWwf
         idRQLlJu1V3fyKxBBgZT8orNNwSfG3ldK93UWDDfwO+2whPF1ZAxLA40DoQvxU5BfMNp
         3lBbbYWyQlIivNwXQikzuuHqR4sZAigx4GkkKHfZlqHeuEoeLfDb/PifXKGZipSv/aeN
         Cynt/+Yyu7uFh0AOVPy3Vsn+npnyt9GaCOHUIl2GPSlPaA5FV2+u3jZ48DmkHJn3sw2W
         Qhb1WicuxCijgoIjMRw1yzx8xh+1vtZ7swikn0STs41+ERPMsE0gL2i/YGW133S/wqfx
         tCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRmpJqPfR2Ffc8HgrJVdi9vtvYXJmh3FYn3557q1NwE=;
        b=T0G+dQhirx6pMpv6mtLkHI/dUe5RVHkkRe6seN7e+R3mu0mqlvcIPlgjs3ZE+IH5Tw
         jYfF7XDb+V3+rS+U0in4wV7Qncr2TmwewpRFldF2Rf95vCxctzaFzL2FsUs8m3sVu2xm
         dMkcErRaqj+jvdS4g6JkGfv+KV1jjwf/7oprIoKpECkgvDc52seMtbs5rYGbd4AeBfIp
         9VB104VKOy3wUnU+23sX7QunpTOp8V0kQuL2WJ+4amE6icUns6gIQ/pf36ntuVoQztuk
         5FTfX3ZMXKm002olqSsZJlcgP1HWNaGBik5EazBl65M7RqNHyqnvVXvn0TrNKuT1MK37
         UNxA==
X-Gm-Message-State: AJIora8BqgRNTGYurxnMARa7m8oH6G1kSLS3G0G9G/pTBu1Imd7ixZW9
        AKMn7YZnsOpMSVC5SMudJus=
X-Google-Smtp-Source: AGRyM1vsKaZ4Q845hwAJdZ+Iup3JowgDZtmbhIizUAD0kSH6BZk1L5rQHvQIxX0hZopZgMtlLU/zgg==
X-Received: by 2002:a05:6214:c6e:b0:472:edeb:f694 with SMTP id t14-20020a0562140c6e00b00472edebf694mr2331526qvj.90.1656799178059;
        Sat, 02 Jul 2022 14:59:38 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003177f0fb61esm16496345qtn.75.2022.07.02.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:59:37 -0700 (PDT)
Date:   Sat, 2 Jul 2022 14:59:37 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/8] lib/cpumask: change return types to unsigned where
 appropriate
Message-ID: <YsC/yRH1HLHvDlIS@yury-laptop>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-6-yury.norov@gmail.com>
 <YsAzU3g2QpgmIGre@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsAzU3g2QpgmIGre@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 03:00:19PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 01, 2022 at 05:54:27AM -0700, Yury Norov wrote:
> > Switch return types to unsigned int where return values cannot be negative.
> 
> ...
> 
> > -int cpumask_any_and_distribute(const struct cpumask *src1p,
> > +unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
> >  			       const struct cpumask *src2p);
> 
> It breaks indentation of the second line.

I'd prefer to keep 2nd line untouched to not trash history for
nothing.

> 
> ...
> 
> > -int cpumask_next_and(int n, const struct cpumask *src1p,
> > +unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> >  		     const struct cpumask *src2p)
> 
> Ditto.
> 
> And seems a lot of cases in the series like this.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
