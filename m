Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64250467F12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbhLCVJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhLCVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:09:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8AC061751;
        Fri,  3 Dec 2021 13:06:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f125so4335707pgc.0;
        Fri, 03 Dec 2021 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGO9VcIvVBE2m6N0pRqcs519qMf/SHuCfks/jYAJHuM=;
        b=SQ4Htg19rxC8ajxfuw2S88U5TeUx9IlvmPx2/DGhqjjb8EicSnfva4T9JFFpkcrQ/2
         oATPAMhk+oFWW3IDj0LyMmcqKN4UT7I8R4mBcQ/ATRehJfwgMfYrqTrYnoYTZOYsczIn
         jUMuKPkpUta80wRnsxgo85C/jlOfPeFpmP09iW7NhjD+Gz3/c/gNR6lHXXMoVXBUS9xa
         TpE++rumR8vKUAV4lDUTLUvqP5ptuZGaPXGlDUF/i+LHOPx7uBuQPVdjOg1OM0rt6O8d
         xzyJTeRFRloafp/6tnS7ax0brRsmCgqdgPeVeNQmcK6NloUmnucWkFzEZ5z2ZGK8CsYR
         BvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGO9VcIvVBE2m6N0pRqcs519qMf/SHuCfks/jYAJHuM=;
        b=Ni8TEck4CIQ8CbkXe6CO/Z34yWQP/zRCZa/Gd60ztFWf8XCfTk/amlRt0REuDL/Vp8
         MavNhki9cnKoN1OTHZ3ap30wt92joTIhOmOTx7SsmY3msk5bjqPdjQXGYosueY+j2Pyz
         oNwSD2hpwuJ7j1TzD/koyUrmQdAlu2STA7oQZ2TFyaYMLHPVufMpp9WEFiJeftNAhxMf
         lcnE3W/89eQWDXgJDFnKNOwW8zZk76hBRW62HqpTDFeqZeFdfYdethKYT/N9qIWCbckv
         DM4aVVi0/b2HFh6qP88sz1PC2xTyJ1AzM2QHLU5AcS+1zZJiBS/pzqsS1JHYQ3WDC0H0
         LjAw==
X-Gm-Message-State: AOAM532aA5pvj9dKk++NQewgPOL1AuZRhW8VbU5ABu0kZ4iNnT2/FRCp
        Ub+Cafcz4FnEulSml7DB7JE=
X-Google-Smtp-Source: ABdhPJxdLnZMfBYdnf6LHNRIDxI05OrA2aWHDs4XVkS25qxNHeZvmuzf22pHqysTBWRBRtLRJFJl4g==
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr6225320pgh.396.1638565568948;
        Fri, 03 Dec 2021 13:06:08 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e637:aa31:c488:b6c0])
        by smtp.gmail.com with ESMTPSA id on6sm7458874pjb.47.2021.12.03.13.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:06:07 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:06:05 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <YaqGvffumIw14TbG@google.com>
References: <YaMYJv539OEBz5B/@google.com>
 <202112011112.83416FCA2C@keescook>
 <YafYvA5JWMgb6PVy@google.com>
 <202112020012.8B4C205@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112020012.8B4C205@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 12:14:18AM -0800, Kees Cook wrote:
> On Wed, Dec 01, 2021 at 12:19:08PM -0800, Dmitry Torokhov wrote:
> > On Wed, Dec 01, 2021 at 11:24:35AM -0800, Kees Cook wrote:
> > > On Sat, Nov 27, 2021 at 09:48:22PM -0800, Dmitry Torokhov wrote:
> > > >  /* Flags for sys_finit_module: */
> > > >  #define MODULE_INIT_IGNORE_MODVERSIONS	1
> > > >  #define MODULE_INIT_IGNORE_VERMAGIC	2
> > > > +#define MODULE_INIT_COMPRESSED_DATA	4
> > > 
> > > bikeshedding: adding "_DATA" seems redundant/misleading? The entire
> > > module is compressed, so maybe call it just MODULE_INIT_COMPRESSED ?
> > 
> > OK, or maybe MODULE_INIT_COMPRESSED_FILE since we are indeed dealing
> > with a file?
> 
> Sounds good to me! :)
> 
> As far as my tangent on using the crypto subsystem, I think that looks
> like a long path, so your existing routines are likely the right place
> to start. I still wonder if it might be able to use of the "acomp" API
> instead of calling directly into the specific decompressor.

I looked at the acomp and it still needs preallocation of the output
buffer, so it has to wait for your "get worst size" API additions before
it can be used. But ideally I'd have some streaming option where I could
feed it chunks of data and consume output...

Also, regarding your comment about not changing free_copy() but move
this logic to load_module(): free copy is called twice there, both in
success and error paths, and can't really be reduced to one call site
even with "jumping backwards goto", so I'd be forced to duplicate this
logic in 2 places, which is not great. Or did I misunderstand your idea?

Thanks.

-- 
Dmitry
