Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD85131AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbiD1K5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiD1K5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:57:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894789CFB;
        Thu, 28 Apr 2022 03:54:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m62so2706563wme.5;
        Thu, 28 Apr 2022 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a3Yf1Hu8S97WI8BsrGLjJJZAS+lKcHyHQQaVfbvW5s=;
        b=IYyFkwap8Lntoz9LtpjkKdzCRGsyHrrG6guoDqDA05V31Ugdfz9VIAIKRjtmF2Dd9e
         Llgf1gT22Mt/yuk6YioAavU65MMROxLLekLAoq/tKOCREtrdGMUF4hTiotObbQehy3d3
         CrK7OL5H+crrhGoo92swyh8gcwIoJXFKzau0ZeH329STtC61tTnGYcN/26/clO7ZrSYv
         FIpXZ2TB+VoZ7dtqNHczJDUMqkB5yKpik/62GrU5XqjcHmO6pwyA5aYuYDLwa4qFInrC
         Hatpukcbq2Yj25ycNPgmPRGWCGR7IRlxZDuBq80p6rXQ/tPYJpnvrjjVQUypRBnxR4pD
         lBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a3Yf1Hu8S97WI8BsrGLjJJZAS+lKcHyHQQaVfbvW5s=;
        b=xYo9HDqr90mH2ZvFOqWrr40Wj0hART2v3NAXqhbvQhTLziOCqt4GA/K3BFzLirjs71
         mT6xuQk9KanRgrJQ1yuPt7W52C9qWSkqH7NvHpHUPXuYt6Hjgsih+ALoN1H0SChuotJ2
         dI5Ye6vwwwiNrd/ZijrsJqtgTDhgSG3FczHIunDzW0vuizHJZoygoJZdNTvlNhD8hOSd
         vpOyIyRoNVD34PesWE9xArHywyV2jx01FQlDpaXbXGGO5BymJzQvqjocgFyvDTVdtwk8
         DAw41I/t+dKSD2irz0K23CYnkrz7/Zqz5erPrCX/WsTTKfBK2yW1S+ymf9X1BRFxP/uf
         XNlw==
X-Gm-Message-State: AOAM532zOrvNUUBbYYxl7gh5TcmBMzr2PIcmRYj8CBwPfmlfx/QGlKOd
        /KIuXLaq7b3+hb1IePEXL7g=
X-Google-Smtp-Source: ABdhPJw41un5LKHXNzYrBNA8kFLgrj/BfvnZbzXwv3WIlOC0XxIym/mK8mEI5YvoKDTe+v5h12tROg==
X-Received: by 2002:a7b:cb98:0:b0:393:f18c:8fae with SMTP id m24-20020a7bcb98000000b00393f18c8faemr13323631wmi.8.1651143258744;
        Thu, 28 Apr 2022 03:54:18 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id r5-20020adfa145000000b0020acc9de8c4sm15032619wrr.38.2022.04.28.03.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:54:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Thu, 28 Apr 2022 12:54:14 +0200
Message-ID: <2598013.X9hSmTKtgW@leap>
In-Reply-To: <YmpaUgxIk0rrwt2G@linutronix.de>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com> <20220427183821.1979-2-fmdefrancesco@gmail.com> <YmpaUgxIk0rrwt2G@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 28 aprile 2022 11:11:46 CEST Sebastian Andrzej Siewior wrot=
e:
> On 2022-04-27 20:38:18 [+0200], Fabio M. De Francesco wrote:
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -236,9 +236,18 @@ static inline unsigned long totalhigh_pages(void)=
=20
{ return 0UL; }
> > =20
> >  #endif /* CONFIG_HIGHMEM */
> > =20
> > -/*
> > - * Prevent people trying to call kunmap_atomic() as if it were=20
kunmap()
> > - * kunmap_atomic() should get the return value of kmap_atomic, not the=
=20
page.
> > +/**
> > + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic() -=
=20
deprecated!
> > + * @__addr:       Virtual address to be unmapped
> > + *
> > + * Unmaps an address previously mapped by kmap_atomic() and re-enables
> > + * pagefaults, migration, preemption (the latter was disabled only for
> > + * !PREEMP_RT configurations). Mappings should be unmapped in the=20
reverse
>=20
> Not sure how detailed you want to put it here as "reverses kmap_atomic()
> doing." might be okay ;)

No, it's not sufficient because Matthew Wilcox said that something like "It=
=20
is the counterpart of kmap_atomic() for unmapping" (or anything similar) is=
=20
_not_ what he wants to see.=20

=46urthermore, a large part of this text has been written by him (I'm talki=
ng=20
of a couple of weeks ago, when this patch was not part of this series - it=
=20
was on its own until Ira Weiny asked me to gather 4 patches in one only=20
series).

> This indicates the "migration" is disabled for
> !PREEMPT_RT which is not the case.

I read again how kmap_atomic() is defined. There are lots of 'if'=20
statements. Only if the code gets to __kmap_local_pfn_prot(), users can be=
=20
assured that it unconditionally calls both migrate_disable() and=20
preempt_disable().=20

> So maybe something like
>=20
>  * Unmaps an address previously mapped by kmap_atomic() and re-enables
>  * pagefaults, CPU migration (CONFIG_PREEMPT_RT) or preemption
>  * (!CONFIG_PREEMPT_RT). Mappings should be unmapped in the reverse
>=20
> will make it clear.

I'm starting to think that this level of detail is too much for users who=20
just need to understand how to use this function as well as =20
kmap_local_page().

I prefer something like the following:

+ * Unmaps an address previously mapped by kmap_atomic() and re-enables
+ * pagefaults and possibly also CPU migration and/or preemption. However,=
=20
+ * users should not count on disable of migration and/or preemption as a=20
+ * side effect of calling kmap_atomic(). Mappings must be unmapped in the=
=20
+ * reverse [...]

I'd also like to write the same paragraph for kmap_local_page().

What do you think of being less detailed and instead using the text I wrote=
=20
above?=20

Thanks,

=46abio



