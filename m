Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32C520F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiEJIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiEJIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:04:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1BF26FA20
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:00:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so859611wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aUPhu+N0ItA28k7dDQcYDzQYuT2WySNBK1O7zNtW6EU=;
        b=bXB1iWb5uvrpBifr/BTTvYI3W633aMsRlH0cl2XNOsMG9ZLcLWVgM3h2y4qbvZsjr4
         y16Ir91qcMitRECmHAexV1Pp+OLkzfxBK0iUFp3suLc2YNlFDMMOueICONEhVpC9GNqN
         vF+kmt1d5aPJxKpXJ52m3vWoCQqsoXtUTP4lflWBQRb8+UoSdEu6oL1NOdTU3ERBrGEo
         L9cpS9LTjCdQ6wFTauc1eUXUrLEy3hmF4ievyQE0wO0aAzIfDJ1mQSHckJQ4iM8o1HcC
         rmT0BNsU32/K4eiMe6m0Z3RfaJia/J2sVDC7+uzyG3NwCnPK6j8LqBf6Sb0MfrQVH3CZ
         HKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aUPhu+N0ItA28k7dDQcYDzQYuT2WySNBK1O7zNtW6EU=;
        b=49LwHntQxzgSBLLga/AwF1nQ/URZA7TYiKGfBMy1XFaKJMjaev3058O/pR5P+WqAOz
         gVgwt/0/O+2+toESTlnILWZqP9cgcvboZy8eJyRYWqPLNamR29dF/Hb+60fkG7CW37br
         RJ2gg8ksK5B3a++9cBQG6MJrJSyE8fh1q1lNnz2+u1wKrwu9oN2xuHW4FrSsXaZ5lJ7C
         0sxQJufKCs/6RFJRt7GwFeaAKED8myyqAGj51UeuTIONTGuDURti6nkrvnCCchvQV5WO
         z0ogjF9hgJeyPnTOo/q49BEjmYo+AY0rEQZqc6o/yWhooQcN+m+3JUpuxgCPPJP28B2f
         l8Bg==
X-Gm-Message-State: AOAM533AQOYcIsOJ6nUQcdf0Da9xJLOUC5792lfBxRILxFei7k1cyr+J
        Jrh77kcK2u/YuZh0jTYPU7aPHQ==
X-Google-Smtp-Source: ABdhPJzG7oikaoAEOBeC538ErPaa58OsfcMyY4rlAufBxItyxwxB1odpAfdfYcFDlX4ZfE9unDssFg==
X-Received: by 2002:a1c:7307:0:b0:394:5bfe:391d with SMTP id d7-20020a1c7307000000b003945bfe391dmr26564506wmb.17.1652169603027;
        Tue, 10 May 2022 01:00:03 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id i17-20020a1c5411000000b0039482d95ab7sm1658155wmb.24.2022.05.10.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:00:02 -0700 (PDT)
Date:   Tue, 10 May 2022 09:00:00 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <YnobgCqs3nUe39XL@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
 <87bkw6cpvo.fsf@meer.lwn.net>
 <Ynmd23nhC3KHHX1i@equinox>
 <1b504dc0-a5c4-06c8-e7b2-b3a859e15ad9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b504dc0-a5c4-06c8-e7b2-b3a859e15ad9@kernel.dk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 05:17:13PM -0600, Jens Axboe wrote:
> On 5/9/22 5:03 PM, Phillip Potter wrote:
> > On Mon, May 09, 2022 at 04:17:31PM -0600, Jonathan Corbet wrote:
> >> Phillip Potter <phil@philpotter.co.uk> writes:
> >>
> >>> I was yes, the point I was trying to make (poorly) is that your patch
> >>> conflicts with Randy's patch which itself is not yet in linux-next, as
> >>> normally I send everything together at the start of the merge window to
> >>> Jens, as I don't have my own kernel.org tree yet, and usually I only get
> >>> one or two patches in a cycle anyway.
> >>>
> >>> This is not your fault, you couldn't have been expected to know this in
> >>> retrospect, and I should probably look into getting my own tree/GPG key
> >>> sorted to alleviate this problem in future.
> >>>
> >>> In the meantime, if you're comfortable with the idea, I can just resolve
> >>> the conflict myself when I send the patches onto Jens this time and
> >>> include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> >>
> >> So I'm a little confused by the state of everything at this point, but
> >> I'm assuming that I need not worry about taking these changes through
> >> docs-next.  Please let me know if that's not correct.
> >>
> >> Thanks,
> >>
> >> jon
> > 
> > Dear Jon,
> > 
> > Yes, that's right. Makes sense for the whole series to go together, so I
> > will fix up patch 3 to apply alongside Randy's patch (which I see you've
> > taken now) and send the whole lot through to Jens as the merge window
> > opens. Thanks.
> 
> I'm fine with taking these, and if they need fixing up then all the
> easier, but patches from maintainers should be sent in well before the
> merge window opens. For doc updates it's not that important, but please
> do send them in at least a week before 5.18 final happens.
> 
> -- 
> Jens Axboe
> 

Hi Jens,

Thanks, I'll make sure this gets done.

Regards,
Phil
