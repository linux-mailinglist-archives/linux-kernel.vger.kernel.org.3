Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F844528057
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiEPJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiEPJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C604021814
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652691822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sN8QLfN/A+UySSDA6TKtms8hsiIhhELD2bDlU4mr5p0=;
        b=Am8EOdi/2TiVOKTz99gXo2ZFhzkxYSa9snZrHRvPympEGvu7BnlqiriWby2XBPDXoYkII5
        374ZUWS3V/KDQ1jGnQdcN4aci4ifpE0WLMnoJDHYq+WIuRYwDbD8TEtg/H/Kjx5CScCclk
        WzlK8NvpGaEOSelPIYNmvvJE2Bbu7Rc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-zsGxeFvJPQSl7VnAUZGJJg-1; Mon, 16 May 2022 05:03:41 -0400
X-MC-Unique: zsGxeFvJPQSl7VnAUZGJJg-1
Received: by mail-wr1-f69.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so3725584wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sN8QLfN/A+UySSDA6TKtms8hsiIhhELD2bDlU4mr5p0=;
        b=5PMNgS/tvtie/ZYpdx2o+MI+mYSGhXwjnv4I2WnLaIHAQmbY6cARROSrSqXsk191dn
         3g/Mx2miQg5I52q8lY5vkcFVyW4RroHD0mNy5pcFA0NOy1W9D3VNmDcKlwLmgyURYktK
         GH70zFuOiYtujLHxPC9ppkpKKcARkaGUSynpJlD1t/OuBAEkesqEanTqME98/oR++wfQ
         tPJH5fizaZpQC9ru4Vcl7qWmaoeKXi2Gau5vcOwtcK0EWGgniQDC0Ll5Wa82nLSSkw/5
         f7Tk7v3hMaqyd4VZF4TDCOubZ8x8wnOjX25gmyXyupM/iid0NdbFuwN8wBG3nml6zEUO
         z6eA==
X-Gm-Message-State: AOAM533UPvOoK2pWEQMKLWy+Mh8EUezWENfqTIddHKe/f/dYNtWGJmRX
        bn/u8CmuSbzz9aeSmyJozUYQXu4vRatXZ+pAQvK8Glv1tkCkCY0j7sE+lVUcEVQIrnaQusovBwA
        1WKgwHaQmyZOUZoJO7+MsD7VU
X-Received: by 2002:a05:6000:1847:b0:20c:61a8:4dd3 with SMTP id c7-20020a056000184700b0020c61a84dd3mr13647495wri.205.1652691820505;
        Mon, 16 May 2022 02:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAsBp5KvtStVNwjEVznDkDUw7cluWHWPDWh0qjQjlcuAw2dlbUt71Dx2F3EbqPVXfIOPTe5A==
X-Received: by 2002:a05:6000:1847:b0:20c:61a8:4dd3 with SMTP id c7-20020a056000184700b0020c61a84dd3mr13647479wri.205.1652691820302;
        Mon, 16 May 2022 02:03:40 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id r15-20020a7bc08f000000b00394615cf468sm12639009wmh.28.2022.05.16.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:03:39 -0700 (PDT)
Date:   Mon, 16 May 2022 05:03:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mie@igel.co.jp
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220516045821-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au>
 <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
 <87mtfm7uag.fsf@mpe.ellerman.id.au>
 <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:10:34AM -0700, Linus Torvalds wrote:
> On Thu, May 12, 2022 at 6:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Links to other random places don't serve that function.
> 
> What "function"?
> 
> This is my argument. Those Link: things need to have a *reason*.
> 
> Saying "they are a change ID" is not a reason. That's just a random
> word-salad. You need to have an active reason that you can explain,
> not just say "look, I want to add a message ID to every commit".

So I want to go to my inbox and compare the patch as received with what
is in my tree.  What did I change? And I tweak both the patch content
when applying and the subject so these are not good indicators.  Is this
at all convincing?

-- 
MST

