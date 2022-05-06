Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3D51DE79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351022AbiEFR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiEFR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:58:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE206D3A5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:54:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so11012977wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kcq1T+Nqx8mFB2lHzVEVRME11trHtv67j1PZxeJ5LT0=;
        b=0Vmol6v9SW2T8F1RJUqOV50Hg64NAKaa8/z2TdlFL5axVsWRbd9makJoz6MGcvurb6
         xIezZR0st/wumGFRqVdaYYZcPzF+MLaHvT9wU3/2//xaHihy9mNTrunY7hquu1TY+jvb
         +kSMRnNACQ9h4vce6E2G8BFmOb+poVnhvBJYxa65q8DxIY9EsgkAF2dRjsUFsoQ06R2I
         mxdUlp1qt+gRXW5s9KdFSoECeCpSfwcNr1Ib+96kx+EkQA4PqMsk5x1cTRP3gll+mUDx
         vmcQEnMK6yuMc3AIHapmcfLq3vhocZg9yVhpJBhiwz0RSOKnrgUwtXaGeNfs3wp7Vs2X
         EUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kcq1T+Nqx8mFB2lHzVEVRME11trHtv67j1PZxeJ5LT0=;
        b=iDUfWqVYtQRqZMG9LXsa9zDmUpFiehI54L0mEIukd/zXyleC0V587RgUK0aSTpwPeG
         puA+bDdh5vdVSpP6aQ+PcBPHcqYxt3cWvp5/bpUSBb8pA7SqcGJFNwV1Hf94XfRHL594
         tgW6swtQwEenwyiWy7PH5A5K/ORdLh49u5jnNaRmZgCUetbfoswmoWTD7BiXSYH2OJeM
         XguFPmoJkDIrLYSpzaeB7HrdAw6oSH49gwjfhpzPx4rHWstgIz/TSS1zyEeRRGVIRwG5
         Uv/t9mWT93vLZPdGblmIs5+0Pt/+qxg8wCnmEDbEyYAb+7EMMZwu+ZmaDZ+TkH3B3s82
         XhTg==
X-Gm-Message-State: AOAM530Ejc9/gjc6ZSqfxVrNeU/3cWKxPss0VLxmmBDUUagcBHuoBq+O
        uATUhAV5iomSwLxSxPZ+cMj93T+l2cM77A==
X-Google-Smtp-Source: ABdhPJyCxytw+tYc1+WN9LTskOYGB7TkSAzCW4a1xwRbwZDJ98z3AdUw8oErwpxGwMc95nLymqRpPQ==
X-Received: by 2002:a5d:6da8:0:b0:20c:535e:2f61 with SMTP id u8-20020a5d6da8000000b0020c535e2f61mr3744539wrs.455.1651859655359;
        Fri, 06 May 2022 10:54:15 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id e10-20020adff34a000000b0020c7ec0fdf4sm4684819wrp.117.2022.05.06.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 10:54:14 -0700 (PDT)
Date:   Fri, 6 May 2022 18:54:12 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <YnVgxEcRTQPu/DHE@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506153241.GH12977@windriver.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:32:41AM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 29/04/2022 (Fri 00:43) Phillip Potter wrote:
> 
> > On Wed, Apr 27, 2022 at 12:59:17PM -0400, Paul Gortmaker wrote:
> > > [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 27/04/2022 (Wed 08:50) Jonathan Corbet wrote:
> > > 
> > > > The Documentation/ide part of this is already dealt with in docs-next;
> > > > obviously there was more to do, though :)
> > > 
> > > Ah, I'd checked mainline master of today but not sfr's next.
> > > 
> > > Here is a delta diff against today's linux-next
> > > 
> > > Thanks,
> > > Paul.
> > > --
> > > 
> > > From ecb86eb357e5151ba5f7e7d172c65d07d88c4c39 Mon Sep 17 00:00:00 2001
> > > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > Date: Wed, 27 Apr 2022 12:45:50 -0400
> > > Subject: [PATCH -next] Documentation: remove last remaining traces of IDE
> > >  information
> > > 
> > > The last traces of the IDE driver went away in commit b7fb14d3ac63
> > > ("ide: remove the legacy ide driver") but it left behind some traces
> > > of old documentation.
> > > 
> > > As luck would have it Randy and I would submit similar changes within
> > > a week of each other to address this.  As Randy's commit is in the doc
> > > tree already - this delta is just the stuff my removal contained that
> > > was not in Randy's IDE doc removal.
> 
> [...]
> 
> > 
> > Hi Paul,
> > 
> > Apologies if I'm missing something, but this updated diff still seems to
> > conflict with Randy's earlier one. As cdrom doesn't get a lot of churn,
> > I agreed with Jens that I would usually just send on all accepted
> > patches at once to him and he would take them via his tree (I currently
> > have four accepted patches, including your two others and Randy's patch,
> > plus one other).
> > 
> > Anyhow, please could this be corrected? Or me shown the error of my ways
> > (always possible I'm making a mistake) :-) Many thanks.
> 
> Are you working off linux-next?  If not, what is your baseline and what
> are you running and what do you see?  For example, the commands below:
> 
> The ecb86 that I sent in this e-mail still applies on linux-next of
> today which contains Jens next as you can seed:
> 

I was yes, the point I was trying to make (poorly) is that your patch
conflicts with Randy's patch which itself is not yet in linux-next, as
normally I send everything together at the start of the merge window to
Jens, as I don't have my own kernel.org tree yet, and usually I only get
one or two patches in a cycle anyway.

This is not your fault, you couldn't have been expected to know this in
retrospect, and I should probably look into getting my own tree/GPG key
sorted to alleviate this problem in future.

In the meantime, if you're comfortable with the idea, I can just resolve
the conflict myself when I send the patches onto Jens this time and
include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.

Thanks,
Phil
