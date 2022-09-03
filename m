Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8075ABC2D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiICByj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiICByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1E1EAD1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662170072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/7DBGJSieMRSq3PvqiiqdK55MV/k943DFwkDvzV0EQ=;
        b=McwFvxMq/pWg841fxx+EKNODynTR7pzYZo/iKUSsPPHQEXFUJvfYsjDfSC0oLlqjUSqggP
        c20wHFjPHhhL6uHWYYBaWBdmUPzVOvj73FufWtKB+KFWHyQXRO0p0W4FMLbklreZF7Nskb
        YezD7zHc9gwnPGa8gQAqfasatKgRfhU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-6ihJcg9xM_GIPhKpbdorfQ-1; Fri, 02 Sep 2022 21:54:28 -0400
X-MC-Unique: 6ihJcg9xM_GIPhKpbdorfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC08D29AA3B3;
        Sat,  3 Sep 2022 01:54:27 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54FBB1415125;
        Sat,  3 Sep 2022 01:54:25 +0000 (UTC)
Date:   Sat, 3 Sep 2022 09:54:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <YxKzzsyK99bwnbAy@MiWiFi-R3L-srv>
References: <20220831052734.3423079-1-song@kernel.org>
 <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
 <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
 <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com>
 <YxF69izHufARLKqA@MiWiFi-R3L-srv>
 <CA+KHdyWijMSuNaT4vQ-tqyrJC_GxL++rDj-s1WZMkDi=8m3p1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyWijMSuNaT4vQ-tqyrJC_GxL++rDj-s1WZMkDi=8m3p1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/22 at 06:45pm, Uladzislau Rezki wrote:
> > > Even without this patch, the debug path would work correctly. The
> > > difference is just only in
> > > whether roots are hardcoded or passed over function paramter.
> >
> > Calling find_vmap_lowest_match() inside find_vmap_lowest_match_check()
> > will fail compilation because the function interface has been changed.
> >
> Ah. That makes sense, though the commit message has to reflect it.
> So it is only about compilation error if debug is ON.

Indeed, the current patch log sounds like an improvement or normal change.
In fact it's a code fix.

