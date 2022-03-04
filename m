Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D403F4CD3D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiCDLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCDLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:55:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97A1B1DD3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:54:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso4972164wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pKOBFhzwjYuGQ0/zLr+UcyZBkKfk85ofZ5SAsoGUAJ0=;
        b=MJENXqVgVSqsNVQcM+jrjypEcMm/DNnckjceh0/izbM1MHKLRwBaXUBJ6bnNo+0qeQ
         ymYmJPz2ro8JvSXEMhD8I2D79m2hF4iP0fj7Uc0yc8aMNpU2Vj+OwiK4eKktaeJbyXcR
         Yy4p1MRkqbtVi3TSprr3gNBPEyLlHVsudbaGLIu+yehw+47BmL0q60WePWbv9qaG+PmC
         IeWI36nXx5Ie0hlgLZdjtG8PADREqSYZDSL1D94artfKY3wbSYjFrZM0wP9+D868rxZA
         j6XDpFa3hTUG65In3LWIfHJ4Girano9Ch5oduisspMu2waChXN33kAArXomzRhgKyfrP
         xFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pKOBFhzwjYuGQ0/zLr+UcyZBkKfk85ofZ5SAsoGUAJ0=;
        b=EVjf2NtElffF2Rvu1EodJw/7le9eu7vu9VgCIeQu7NYDbgzgi/VdKqjCFb0vfslunq
         RWpvJZWnS0+LQweRpbSokjiYXN5riY61659EOo+jshfUYKE8CEGolpQpLpRwfpza0748
         omXHXO93xKGK4f72ff+KFNUhGOuWhaHRF0MhmF+cihMFH5av9HAwTuNgNxDsE/wiLggs
         HjQzq43KvwKeyHeVxevU0UbEct03etnIbNzchB4DnVZlevOGdgALDaQ+SQ6WMTsTcm2Y
         zNLl5kyK1iUo9D06/Ket2fHT3i9k5DAAQW2rrR5GosxGf+g6TLxbxLkhS6N/SKn6a/rP
         KRug==
X-Gm-Message-State: AOAM532EmkyyRM62N1oIWzzR+phoIIWsfb1dBb6AIa6V2RoqHEOp2Ymu
        agUU8wFSZAdYceTlyC5q9WkMlQ==
X-Google-Smtp-Source: ABdhPJxmR0SZDu+4BKT+TwvbIcgk+VEUhcGKw5C6sreCAxlaRBiIdimb4VL1dSnVUcg583j8iFYrMA==
X-Received: by 2002:a05:600c:354b:b0:381:7ff1:32b4 with SMTP id i11-20020a05600c354b00b003817ff132b4mr7483801wmq.134.1646394886995;
        Fri, 04 Mar 2022 03:54:46 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm6109082wrt.63.2022.03.04.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:54:46 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:54:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220304115444.jlfv6abblqgyzscj@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
 <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:12:07AM +0000, Aaron Tomlin wrote:
> On Thu 2022-03-03 05:37 -0800, Christoph Hellwig wrote:
> > On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> > > Do we really want to hide the 'struct list_head modules' from external 
> > > world ?
> > > 
> > > Otherwise we could declare it in include/linux/module.h ?
> > I'd just move the trivial code that uses it from kernel/kdb/ to
> > kernel/module/ as it is tied to module internals and just uses the
> > KDB interfaces exposed to other parts of the kernel.
> 
> Hi Christoph,
> 
> This is a great idea. I'll do this instead.

Adding this as a new file is fine for me.

There were proposed changes to this function this kernel cycle
(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) which I Acked already.
However it looks like all involved with that are already particpating
in this thread so I assume an merge issues with that are already in
hand.

Aaron: Are you OK to add the new kdb file to the "KGDB / KDB
/debug_core" file list in MAINTAINERS? Mostly I'd expect to just
Ack changes and move on... but I'd like to be in the loop.


Daniel.
