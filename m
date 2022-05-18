Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F252C426
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiERUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiERUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:21:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEF74DDE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:21:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so2848733plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1YyneiqAhP2skYJhZG2vdelPFXsdfsTJ3CJYnzR02Y=;
        b=mXJwCdTGU/Ox9qVjYl4IfaSVZDN0CPcyG5aS9Q0Gl2sPg5O9wSmomrc8Jy+lMxH3o/
         zU+yGjQMVDiCfodJ++RAp9K1TsdHxUzF2BARh4MtL/gv0/DPxasbQvp48pI5TU5BYKm9
         bnGRyfqDMA4iwhSUwTXkxpKse6PQVxaFMecg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1YyneiqAhP2skYJhZG2vdelPFXsdfsTJ3CJYnzR02Y=;
        b=fZOWtktLt+L2rI7YBLSWLykw+2yv0oqOjLw6NIGk5HfLrXc89kjh4Vy8EaUHRKZjDN
         bITXoH+4V/9f1eu8GQQZb34fLpEhHtDnYLNdGp/UZWMERNt1lUpzRJSQhTkHE2Bgn5Zt
         4iPyRwe2ARarSK0Uwxx8cCXNFweqMka3tg0hM7EtGOub10Tu+iBADREWQJuNTyLitqT/
         c31fo3AHHyl1zN4LeTDSApQgpXirLbhwZy6PF8WGx/7J/KXE0AaCifvChLDTa7mpLYw6
         sf4ZDoAZJ9vlbeJAVQ0Rb7HmQicnWm9t9vhzuBMtrgrRGds0zEVq3VmNyKptl78r7mwR
         ijKQ==
X-Gm-Message-State: AOAM530FydnDPGNSvBM/lzB/vjY2UpmwsXwMQ121iyt2RHiHNKtneRYu
        RZVjmsnz9nFF+/fRs0aqc9SOFg==
X-Google-Smtp-Source: ABdhPJzHz3qqkVHEieBNuWdEWbta0GSniXSx+soddHqy7nGvnJNH9ZWx1lfGNk/h2UWWPq9ty3hseg==
X-Received: by 2002:a17:90a:530e:b0:1db:de96:dff5 with SMTP id x14-20020a17090a530e00b001dbde96dff5mr1228602pjh.22.1652905268636;
        Wed, 18 May 2022 13:21:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015eaa9aee50sm2089590pla.202.2022.05.18.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:21:08 -0700 (PDT)
Date:   Wed, 18 May 2022 13:21:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
Message-ID: <202205181229.E12F85BBBE@keescook>
References: <20220517210230.864239-1-keescook@chromium.org>
 <2692904.1652861114@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692904.1652861114@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:05:14AM +0100, David Howells wrote:
> [...]
> I don't want to do the following, say:
> 
> 
> 	struct afs_vnode {
> 		struct netfs_i_c_pair ni;
> 		...
> 	};
> 
> as that would then require a lot of s/->vfs_inode/->ni.vfs_inode/, but maybe
> it would be better to include a struct inode in struct netfs_i_context, and

Right; that's why I kept the struct internal -- the implicit ordering of
inode and netfs_i_context is already present in all the users.

> On the other hand:
> 
> 	warthog>git grep '[>.]vfs_inode' -- fs/{9p,afs,ceph,cifs,nfs} | wc -l
> 	181

That seems painful. Maybe _new_ users of netfs could be written to use
the proposed netfs_inode:

> so maybe a mass change to, say:
> 
> 	struct netfs_inode {
> 		struct inode vfs_inode;
> 		...
> 	};

Better yet, netfs can define a macro helper. I'll send a v2...

-- 
Kees Cook
