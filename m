Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F595261A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380194AbiEMMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380173AbiEMMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BC515BD27
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouGdyRe8UyIVf/HXw4oa1UwTNpHx7ZaHNy4q5Gp7oU0=;
        b=OiNeMSm22kSdxruKPntjTG0EwQGW/EbM4Ntodww58ZQlzfiZWH9R3hlQEVqh9aN2zAK6JR
        QvO99wTTqNhTZr8Z78ogDC6TRqF2vBhVKJYJZ9zEjlnD587vRiiqjruzGFyoeL/lSmNdEj
        JycdjW61wvH+chCO9QfsF8vb9eT2lX4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-MGXoFZDGNBSo76eC4SLI6w-1; Fri, 13 May 2022 08:16:59 -0400
X-MC-Unique: MGXoFZDGNBSo76eC4SLI6w-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso5875986wmc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ouGdyRe8UyIVf/HXw4oa1UwTNpHx7ZaHNy4q5Gp7oU0=;
        b=3XSUeFvR7vySja+DGFYlsSH8gmnHNpKo8miFmgJ/7Xp1iYbTHbIVrt9bL97g9h6lts
         QQptFXhQhFkDO9S4+47cy33Cwk0jxP468vtqrlBK2fgpv5DQ9Ph8OBxPNoef2FrxbApS
         cZinwIt9Kc/HgCmpZf+wbHNX7qxH5DGFU7WAMvAwy9+lmS8GjaxrxCVEzKerv2rlK/qa
         5KeOVyM74b93fcRrMZxqTt4wqaf+jUSeR8MERaa9tfsUH0vDlKkEQOub8/ACAhSsseos
         BCwrKBJz3Ixbe04LNz88S7WO6b9rbUo3+CKgeZLwSwa0+ZcUgVOzuzT16iaJi9XjKMay
         mVwA==
X-Gm-Message-State: AOAM531aYsRi3ViR+GkufD29jYU2hkgXYzkEesrgth6NwP065VZjDvpI
        V3rTinHsB2bpC4amGN4Y61BEo0J27NpLBOJflUUESKuz3GlZq0qWNXsC6dSRiu4yl1R9VvlIfky
        QMHSGoydLph0I6mKENm4hRQxQ
X-Received: by 2002:a05:600c:358c:b0:394:8522:e28 with SMTP id p12-20020a05600c358c00b0039485220e28mr4317116wmq.92.1652444218261;
        Fri, 13 May 2022 05:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcCkLBgswrm9r0RR11RPAgrWbq6nMU8hzJ6+dShUaXBgNrjxY30r+aEHSeNuC11eC8S0NYpw==
X-Received: by 2002:a05:600c:358c:b0:394:8522:e28 with SMTP id p12-20020a05600c358c00b0039485220e28mr4317096wmq.92.1652444218049;
        Fri, 13 May 2022 05:16:58 -0700 (PDT)
Received: from redhat.com ([2.53.15.195])
        by smtp.gmail.com with ESMTPSA id r15-20020a7bc08f000000b00394615cf468sm5266090wmh.28.2022.05.13.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:16:57 -0700 (PDT)
Date:   Fri, 13 May 2022 08:16:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mie@igel.co.jp
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220513081456-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <Ynuq9wMtJKBe8WOk@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynuq9wMtJKBe8WOk@8bytes.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:24:23PM +0200, Jörg Rödel wrote:
> On Tue, May 10, 2022 at 11:23:11AM -0700, Linus Torvalds wrote:
> > And - once again - I want to complain about the "Link:" in that commit.
> 
> I have to say that for me (probably for others as well) those Link tags
> pointing to the patch submission have quite some value:
> 
> 	1) First of all it is an easy proof that the patch was actually
> 	   submitted somewhere for public review before it went into a
> 	   maintainers tree.
> 
> 	2) The patch submission is often the entry point to the
> 	   discussion which lead to this patch. From that email I can
> 	   see what was discussed and often there is even a link to
> 	   previous versions and the discussions that happened there. It
> 	   helps to better understand how a patch came to be the way it
> 	   is. I know this should ideally be part of the commit message,
> 	   but in reality this is what I also use the link tag for.
> 
> 	3) When backporting a patch to a downstream kernel it often
> 	   helps a lot to see the whole patch-set the change was
> 	   submitted in, especially when it comes to fixes. With the
> 	   Link: tag the whole submission thread is easy to find.
> 
> I can stop adding them to patches if you want, but as I said, I think
> there is some value in them which make me want to keep them.
> 
> Regards,
> 
> 	Joerg

Yea, me too ... Linus, will it be less problematic if it's a different
tag, other than Link? What if it's Message-Id: <foo@bar>? Still a
problem?


-- 
MST

