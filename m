Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886351F1A4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiEHUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiEHUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:41:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355665F60
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B4bamqMAO3dZ75ve9mJEU+0G2wDM1FM8qNboJ8U7p4w=; b=ZuSQINXidG6Y16ezDyl6FoU0C5
        YDTSTgA/ApbR3DRXq9epJTZofYSVqyTw1kkAgTKRA5TkhYZAuDJgE20oN+0ENDRirDm4v56hli+6a
        AU0cTUzayoDWjZVvRvcjlPjzOzKpv5pDElHMLQZNvQYP9p/P/GZbUnv+DItfltBnhw+AMZy+Y9T9q
        6Uj1WoZAkFXqTvikhQYy6WfvE+tsw62js9ps0GtAHMYxtkd76v0U6dWbStRifRxWCdREcyKqnKstG
        3wQr4ALxxutm1WnuBpDuGhytLMFwBzXulkNDZ3KLnHAJSXKqTTK+ZGBFtZJ9NQH+HhPMAhNQLBT20
        qyg/SOlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnneY-002oI0-R0; Sun, 08 May 2022 20:37:18 +0000
Date:   Sun, 8 May 2022 21:37:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm] tracing: incorrect gfp_t conversion
Message-ID: <Yngp/g2RYgnsdOJH@casper.infradead.org>
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
 <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
 <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
 <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
 <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
 <20220507160010.aa2077e28c4710400e144bfb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507160010.aa2077e28c4710400e144bfb@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 04:00:10PM -0700, Andrew Morton wrote:
> On Sat, 7 May 2022 15:48:35 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > I did the below.
> > 
> 
> Silly me, doesn't work.
> 
> > 
> > --- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
> > +++ a/include/trace/events/mmflags.h
> > @@ -13,53 +13,57 @@
> >   * Thus most bits set go first.
> >   */
> >  
> > +#define FUL __force unsigned long
> > +
> >  #define __def_gfpflag_names						\
> > -	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
> 
> Can't expand FUL here within the macro definition.

Can we do something even better?

#define GFP_NAME(flag) { (__force unsigned long)flag, #flag },

... with one or more layers of indirection to satisfy the arcane
rules of C macros?
