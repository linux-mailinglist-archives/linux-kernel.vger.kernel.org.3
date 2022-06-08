Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44510542219
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiFHEwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiFHEvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E83D253FDD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654651056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeDZmjWnzyfSlyFkCkzDa5dQOySlKUE6Xhy3xS5xaC0=;
        b=NV2E9F0xO+QBdPkcmXObG2ZtGn5Gt/mJT4RNTEUVmVB6+//UWLyr1tL+IPUfxWDOKZo2/V
        zl3nzjDq90Cdz62m8W5ezRBnm/jDuth3zsbOVKaauXOq0ry0AaaHpaAJPC5Bi2SpbASOcK
        fVQvIPk4r97wBUIqJ7yKsxWeJuO66iQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-klJpFXGiNfi0VZs1VHN7uw-1; Tue, 07 Jun 2022 21:11:16 -0400
X-MC-Unique: klJpFXGiNfi0VZs1VHN7uw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83222101A54E;
        Wed,  8 Jun 2022 01:11:15 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1D50492C3B;
        Wed,  8 Jun 2022 01:11:14 +0000 (UTC)
Date:   Wed, 8 Jun 2022 09:11:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Rob Landley <rob@landley.net>, akpm@linux-foundation.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Message-ID: <Yp/3Lq03+UVs9Bpv@MiWiFi-R3L-srv>
References: <20220507013411.74277-1-bhe@redhat.com>
 <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
 <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/22 at 05:56pm, Rob Landley wrote:
> 
> 
> On 5/30/22 07:09, Baoquan He wrote:
> > Hi,
> > 
> > On 05/07/22 at 09:34am, Baoquan He wrote:
> >> LKP reported a sparse warning in arch/sh/kernel/crash_dump.c during
> >> a kdump patchset reviewing:
> >> https://lore.kernel.org/all/202204082128.JKXXDGpa-lkp@intel.com/T/#u
> >> 
> >> ../arch/sh/kernel/crash_dump.c:23:36: sparse: warning: incorrect type in argument 1 (different address spaces)
> >> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    expected void const *addr
> >> ../arch/sh/kernel/crash_dump.c:23:36: sparse:    got void [noderef] __iomem *
> >> 
> >> This warning happened when __iomem pointer is passed into fucntion
> >> which doesn't expect it. Casting away the __iomem can fix it.
> > 
> > This warning was reported by lkp during one patchset posted and
> > reviewing. Since it's not related to the patchset, I just sent it
> > separately so that later code change on arch/sh/kernel/crash_dump.c
> > won't trigger the lkp warning again.
> > 
> > [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
> > https://lore.kernel.org/all/20220408090636.560886-2-bhe@redhat.com/T/#u
> > 
> > Now the above patchset has been merged into linus's tree, please
> > consider taking this patch.
...... 
> Tested-by: Rob Landley <rob@landley.net>

Thanks for testing, Rob.

I guess SuperH arch has been in status of no maintenance, however some
generic code change may involve correspondant ARCH change so that we
have to touch arch/sh/.

Hi Andrew,

To avoid annoying warning when modifying crash_dump code, could you
pick this one?

Thanks
Baoquan

