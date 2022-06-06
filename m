Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAA53F29A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiFFXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiFFXfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97A664D622
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654558502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4IezUTWggXGPOKGySEBoAtlNsKku7jiGHhVNtLr7us=;
        b=W7+49+LDuSc2/l3ffncEBCaQoMBF3H8F4jo3CHypiet9y7b0oRu2tXocYYYYjRRBHMMl57
        YhrqDJyVbeR/hY1uImhOEgEToo8kw39zr+JR3VHzQw3UenHhO/NuF6WUlb56j8uCIvwbJS
        3XaYwAK3axwwguAyXZGY9QbjdVXfqz4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-YX7i_jadODWTHeVDUt9k4g-1; Mon, 06 Jun 2022 19:34:59 -0400
X-MC-Unique: YX7i_jadODWTHeVDUt9k4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9B901C1C1A1;
        Mon,  6 Jun 2022 23:34:58 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3BD840CF8EA;
        Mon,  6 Jun 2022 23:34:57 +0000 (UTC)
Date:   Tue, 7 Jun 2022 07:34:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org
Cc:     npiggin@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vmalloc: remove the unnecessary type check
Message-ID: <20220606233454.GB234358@MiWiFi-R3L-srv>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-2-bhe@redhat.com>
 <Yp5lM0j1JdceUEjw@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp5lM0j1JdceUEjw@pc638.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/22 at 10:36pm, Uladzislau Rezki wrote:
> > In function adjust_va_to_fit_type(), it checks all values of passed
> > in fit type, including NOTHING_FIT in the else branch. In fact, it's
> > unnecessary to check NOTHING_FIT since the check has been done before
> > adjust_va_to_fit_type() is called in all call sites. So clean it up.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/vmalloc.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 07db42455dd4..b7a138ab7b79 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1418,8 +1418,6 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >  		 * Shrink this VA to remaining size.
> >  		 */
> >  		va->va_start = nva_start_addr + size;
> > -	} else {
> > -		return -1;
> >  	}
> >  
> >  	if (type != FL_FIT_TYPE) {
> > -- 
> > 2.34.1
> > 
> Why not just invoke the classify_va_fit_type() inside the adjust_va_to_fit_type()?
> In this case we do not need to rely on upper-stack checks and the split logic 
> becomes fully implemented in one solid function.

Ah, that's much better, let me post a new one. Thanks a lot.

