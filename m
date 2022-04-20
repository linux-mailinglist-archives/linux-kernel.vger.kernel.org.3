Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854C5093A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383248AbiDTXiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383244AbiDTXiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824A2E9CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03DDBB821EE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AADC385A0;
        Wed, 20 Apr 2022 23:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650497717;
        bh=CeEIAtnp46ZiHfA8IgNltR02etk9Kcs/s6j4PZaHb/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ug/4EZiK5prmSe9zK6mMYPhX5ds4QhfqPJO9wPuRdrNxdH24UhyPcc/3mrBJ+Wg+9
         5Cw+lJow+azopnbtNjBNBOkm5y0sJUAjWdd4GeMGLQVbHd+Vq8qrx6szVQq0fb9+oh
         5BzpqiZvYZzH+GVMkVIDvQmoOlQO2z2eLjQpQYtM=
Date:   Wed, 20 Apr 2022 16:35:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Message-Id: <20220420163516.ab713a22af375788a541f045@linux-foundation.org>
In-Reply-To: <87ee1rxrn1.fsf@nvdebian.thelocal>
References: <20220420043734.476348-1-apopple@nvidia.com>
        <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
        <87ee1rxrn1.fsf@nvdebian.thelocal>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 09:21:06 +1000 Alistair Popple <apopple@nvidia.com> wrote:

> >> As the wait_event() condition is true it will return immediately. This
> >> can lead to use-after-free type errors if the caller frees the data
> >> structure containing the interval notifier subscription while it is
> >> still on a deferred list. Fix this by taking the appropriate lock when
> >> reading invalidate_seq to ensure proper synchronisation.
> >>
> >> ...
> >>
> >> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
> >
> > Do you think fix this should be backported into older kernels?
> 
> Yes, I forgot to cc stable sorry.

So we have actually seen these use-after-free errors?

Some description of the end-user visible impact is always helpful when
deciding which trees need a patch.

> Do you want me to resend with
> 'Cc: stable@vger.kernel.org'?

Thanks, I added that.
