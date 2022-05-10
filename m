Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0B520F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiEJINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiEJINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:13:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8356259FB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so22633551wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRUk5QuXyb+e6oeIQBKK/KEOyP6N3x3OeCs2VE5XVDQ=;
        b=GOqJM0RjihE6RIVkZysUTvaI8Vt7rD2Zovx17G6l5DiT4UZ72dyUYT6UYEPifUUVmF
         mMJfQV/2OooWZORb+1ZBqJhH+8uAR4hA7SsjP/Upo/BxFfXdPsIfkOhk31nZjS7QGWe7
         tXy/5TKbaslsT774bDaQTybk8aJ8a9nF9kaoO5nKJ64Qre/0zAvdvyAc82KT5EjnS0WZ
         PD8iGY3UPofKGZPXP72FW4xN/EbnYnRykmfvNmRJ07PKJN5cKHj5+Fxa1biDuyL96tvr
         H51naCFYRvEqG51sF1aNBLz585zE6GMXcLFOGQ1bXXyYaiYc6GXODZ9jh1NOfsXnfbE6
         yjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRUk5QuXyb+e6oeIQBKK/KEOyP6N3x3OeCs2VE5XVDQ=;
        b=JgpqP9gIxqQ0QjiB9NAse46t8l0KZys7oNc+GAVLoiz0ohSJcKnoaKof9PbAomDk8d
         t2waSh1MWVQeDB8vZ7T+cwBinjL21h1D/HoX6WffhR2/P3rnity8GhD8KohFlTfQZY1E
         wEGsw6HgiesLzWxPsEP296m2+9gXBrrJtZuvFJgtIzXDpdxGvFqVnKF59WvQCepuE3X1
         A1FstMlDXkVkATQcQ/tgFJYbG4ijrG72Xd1Uz3+e2Ae35c4kQTVoJRMeaJJ4f/yrlbVn
         gYWrxmRubP407eMiF9QzMeDNb1ybOONvO9aL83Kk7S4pyzteSgRJzkUFj2Uk1Y6sviuf
         /ZoQ==
X-Gm-Message-State: AOAM530X8We54uF4RD4gMOp/C1D88T3QgP2ZQuvhZ7B2Bu7DZYfNURj1
        PjgZlZTtfbYW3/2R8ydMXVuwIA==
X-Google-Smtp-Source: ABdhPJy+zPAjLPGWJBYM6WgRrk2NU1ipG2bWJ/P6xpomqxnV1ExckILjFpGkyEIJIKY566RHdFm/Kw==
X-Received: by 2002:adf:e707:0:b0:20c:c422:4f95 with SMTP id c7-20020adfe707000000b0020cc4224f95mr9333254wrm.107.1652170160475;
        Tue, 10 May 2022 01:09:20 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003942a244f4dsm1698202wms.38.2022.05.10.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:09:19 -0700 (PDT)
Date:   Tue, 10 May 2022 09:09:17 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <Ynodrbf0LAh7GL1H@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
 <87bkw6cpvo.fsf@meer.lwn.net>
 <20220510055116.GB10576@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510055116.GB10576@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:51:16AM +0200, Christoph Hellwig wrote:
> On Mon, May 09, 2022 at 04:17:31PM -0600, Jonathan Corbet wrote:
> > > This is not your fault, you couldn't have been expected to know this in
> > > retrospect, and I should probably look into getting my own tree/GPG key
> > > sorted to alleviate this problem in future.
> > >
> > > In the meantime, if you're comfortable with the idea, I can just resolve
> > > the conflict myself when I send the patches onto Jens this time and
> > > include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> > 
> > So I'm a little confused by the state of everything at this point, but
> > I'm assuming that I need not worry about taking these changes through
> > docs-next.  Please let me know if that's not correct.
> 
> Same here, I'm a bit lost on what still needs to be done.

Hi Christoph,

Nothing needs doing, I will handle. Many thanks.

Regards,
Phil
