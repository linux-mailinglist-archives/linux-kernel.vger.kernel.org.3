Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB645AA676
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiIBDjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiIBDjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B10CF0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662089985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=reUzAghh98Vj3d4jHbhqMfDzoVvANcNSdRbekokO7F0=;
        b=KzD+Z1Ph+9lWm+BZkTHaCD3B7b5XQKg9kacElWsP1mCGtyZ5IuU9vhHBod897tdord2AqH
        l6Mx/rXQOGhAJJzCMAeDO51yUgQQqR5osrVJrWYQg9CfyTpibS5VU6JSi3BK6Q/0AtaJYa
        nA0fO1GxrSbFML7W/Weh7NV34uC4m1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-lkQYvhtMPtqoTIIFP8I-dA-1; Thu, 01 Sep 2022 23:39:40 -0400
X-MC-Unique: lkQYvhtMPtqoTIIFP8I-dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE06D85A589;
        Fri,  2 Sep 2022 03:39:39 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E61DA1121314;
        Fri,  2 Sep 2022 03:39:38 +0000 (UTC)
Date:   Fri, 2 Sep 2022 11:39:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <YxF69izHufARLKqA@MiWiFi-R3L-srv>
References: <20220831052734.3423079-1-song@kernel.org>
 <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
 <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
 <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/22 at 02:16pm, Uladzislau Rezki wrote:
> This is only for debug purpose.
> 
> Even without this patch, the debug path would work correctly. The
> difference is just only in
> whether roots are hardcoded or passed over function paramter.

Calling find_vmap_lowest_match() inside find_vmap_lowest_match_check()
will fail compilation because the function interface has been changed.

> 
> On Thu, Sep 1, 2022 at 2:47 AM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Aug 31, 2022 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 30 Aug 2022 22:27:34 -0700 Song Liu <song@kernel.org> wrote:
> > >
> > > > find_vmap_lowest_match() is now able to handle different roots. Make
> > > > similar changes to find_vmap_lowest_match_check() and
> > > > find_vmap_lowest_linear_match() to handle different trees.
> > >
> > > What are the runtime effects of this change?
> >
> > The code is gated by DEBUG_AUGMENT_LOWEST_MATCH_CHECK. It
> > is only compiled when the developer enables it explicitly. Therefore,
> > there isn't
> > any runtime effect.
> >
> > Thanks,
> > Song
> 
> 
> 
> -- 
> Uladzislau Rezki
> 

