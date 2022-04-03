Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F194F0A06
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358950AbiDCNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiDCNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:52:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ADD31914
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:50:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z12so12731251lfu.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rH+nD+w/YAEr4Mpti0uLenxNEyIksOqvfR5bkd8T8k8=;
        b=HJnZ2bnWwobk856WqtLSSDhke48sE9iRsOb7r9XO4eD2yYUNJx81OuYzYsUYyb2npK
         qvf/6YYvlFP4GkV28Hcz9tCPBVXIPM/OohUl+gtdXYsqELGcrDSfcmCN+FfDb/HiJ4w8
         tVsjYZ4JW8RTymUt3dc9QOGn685aMYFSr2pNQB4l3GJIWZMF+SvsrMLHJDCF07Tjg74t
         cHVJkcFgjrq4haSPS3tsUspBseH2OwFnONqQFGpk6qdiRzWDW6dsojuKqluD/RafWZfw
         oqe6m63DesbITmx7ED64WnYcRhxVVqxd1Es88K5llqFj/l0B4P+6dfFp78Pka/ch8+gu
         /Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rH+nD+w/YAEr4Mpti0uLenxNEyIksOqvfR5bkd8T8k8=;
        b=ckHCle8zZWrKt/2eC8lCLzzplfI6lVAjiN1LCM5uXo1/+amQN/n2nPhNJ1FpO2qfXx
         b4gLUg/Fojv7o9JEw2aH/jIpFVKjRIWw5bWE8bnyz3udMlxrOl/YwHF04iuAmsG/JUdW
         5tbi3326MHfMqtZRnYWDz1jbDAPZ8LSyi01tZdw1Ntg8U8IPMAkwNARmU32VUMI+8tBz
         oveizw6ZIc5j3BKpXGRKYk+mNQsNQYk8dRN3YoP87WNXXDkscwdcgXHqO3yGyITbjzz7
         F7vCUGHt71M0uMyD30TNeT5AYQDwLc9y2hH7pM/IPAYSRbwQGA2WuEgaLWrzwV3ePImX
         TORA==
X-Gm-Message-State: AOAM530Ee8jNIpaoXz4eRBlU+msFvopdMcDjYRP8BL9gl0yIhu6Oq3uR
        GcrYYmUo83pAcchFpcZbKbfenEQJzihTINkQCoA=
X-Google-Smtp-Source: ABdhPJxuBZeu9WHR7ugNIX/VHjhJH161cvXJSa5sMBesGNqIU6sQah7GDaBBbHMgYHZpTrzJVLOX/N5gHX49nSrKKjY=
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr740681lfv.27.1648993841812; Sun, 03 Apr
 2022 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220401114635.GA567659@euclid> <YkdvzIyz/WGlm2uy@iweiny-desk3>
 <20220401224619.GA71483@euclid> <YkgTpS+pzhWPgVIh@kroah.com>
In-Reply-To: <YkgTpS+pzhWPgVIh@kroah.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Sun, 3 Apr 2022 09:50:30 -0400
Message-ID: <CAMWRUK4A2DKTaJFhT6b93OjKii=51A9eVKdD3Oov1uTqug9Ttw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: simplify control flow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 5:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 01, 2022 at 06:46:19PM -0400, Sevinj Aghayeva wrote:
> > On Fri, Apr 01, 2022 at 02:34:04PM -0700, Ira Weiny wrote:
> > > On Fri, Apr 01, 2022 at 07:46:35AM -0400, Sevinj Aghayeva wrote:
> > > > The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> > > > the first index for which the condition is true. If no such index is
> > > > found, the function returns -1. Current code has a complex control
> > > > flow that obfuscates this simple task. Replace it with a loop.
> > > >
> > > > Also, given the shortened function body, replace the long variable
> > > > name psecuritypriv with a short variable name p.
> > > >
> > > > Reported by checkpatch:
> > > >
> > > > WARNING: else is not generally useful after a break or return
> > > >
> > > > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > >
> > > Wow!  Nice find!  This is a huge clean up.  Extra kudos recognizing that it is
> > > not just the else statement which is broken here!
> >
> > Thanks! It took me a while to realize what this loop is doing.
> >
> > > The only issue for the patch is that I don't see any maintainer emailed?
> > > However, I don't see a maintainer listed in the MAINTAINERS file so ...
> > >
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > Thanks for the review!
> >
> > Greg, please do not apply this yet. After I sent out the patch, I
> > noticed the comment at the top of the function:
> >
> > /*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> >
> > So I did a git grep to find the original function and fix it as well,
> > and it looks like there are three copies of the same function in
> > different files:
> >
> > $ git grep IsInPreAuthKeyList
> > r8188eu/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> > rtl8712/rtl871x_mlme.c: * Ported from 8185: IsInPreAuthKeyList().
> > rtl8723bs/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> >
> > I will later send a v2 patch that replaces all of them.
>
> No, please do one patch per driver.  These are all different drivers
> (cut/pasted from some original source), so this patch is fine as-is.
> You can make 2 other patches as well for the other drivers.

Sure, will send two more patches.

Thanks

>
> thanks,
>
> greg k-h



-- 

Sevinj.Aghayeva
