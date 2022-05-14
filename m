Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3A527247
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiENO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiENO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:56:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A091F606
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ORKxu+U8dKVvnm4qsYa5tdS1vsCfhUpuKYTjDhWmKiE=; b=egm+lXQh8zTwtP5qgqsAZ14I9d
        bh7lZpwYFpnD8WJ1UBsZMS9nDMuJ8AtSyBTcADsAfT/S31AbCekosFCmFQv1ZAp3K6GyfQjCOhkZa
        H4a3mWObJM23KA7ruVxZJcmInrPD4xSgQLE3i/ciXa4jjmPw9DRIFDI6YjfWWFNf/4yx8j+vSLc/Y
        hVkuJ7pScXFByoz9sBTPO4vXp4nmlLHbrcnc3FWkcMon9ejmoIMgiaeZ1SVJfWuSqDAAxiDycM6qQ
        sK0YD5qPiKbEDC8vANprsKKbY6WIauEX2KE21CU/68b9IhUaLdRQnGU94IIlomgGkDAmf+C5sqOvM
        QMsmkdCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nptBR-000Nid-Ua; Sat, 14 May 2022 14:55:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82D8A980DC4; Sat, 14 May 2022 16:55:51 +0200 (CEST)
Date:   Sat, 14 May 2022 16:55:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
Message-ID: <20220514145551.GC100765@worktop.programming.kicks-ass.net>
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
 <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
 <20220514131448.GL76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514131448.GL76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 03:14:48PM +0200, Peter Zijlstra wrote:
> On Sat, May 14, 2022 at 04:01:18AM +0900, Masahiro Yamada wrote:
> > I wrote a different patch.
> > https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u
> 
> I'm not seeing that in my inbox :-(
> 
> AFAICT this way 'make tags' will not find and index the files, which is
> a total no-go.
> 
> NAK

Additionally, if you spuriously regenerate these files, you'll risk
rebuilding huge parts of the kernel through the dependencies.
