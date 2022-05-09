Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94B52081E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiEIXIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiEIXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:07:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829992BA98D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:03:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so374913wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyafeJfYpqQbqdoHrA1fN3LqRreGi4FxMomb25eWjK4=;
        b=26/cqxbeh4t6qAscNA3ZWelzvHUyARyEvVA+R9jdswx7ahq6O9Z+R45YsctYS5mQbd
         OuJHF8sFgU8zootMXXXCDfUZb46RI35jaZ5ysXiG4x/j35O0t0IFQA/DSXA6WOSLie6R
         YOkF3/fJnpGdGYDJ8rr92shH5DyrKC/OFmSt3OTiFRwileaOeDJ9y9rK2GpbXyvZQAFp
         LH19UhR5ky39xunEvHuIuucNXPVSLBA6KJ4qG7LQjq5ZasX3rHW3e1bVq53tml8bi1hB
         OTtl1XNDybxXIBVudyqxg+9cWdtGOf8GzIrYQdKTklMdeBZSaOW9GjRKGhhJ3xUv2v55
         sDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyafeJfYpqQbqdoHrA1fN3LqRreGi4FxMomb25eWjK4=;
        b=nbMshQRF8fNNnZs5ytkFGggIVyH5GgND3c/agqMI1op+T6ZnJWTcxXjOSecW1T4cTN
         VndYOXmQ3Sa3fjMJdzywBvfmaYGEY6p5TzwbKf76q/CHBPJ9lfGm0nwqcNmLrBTOy/6W
         nMjCqSdAEAzI31gX9N6b30qrWD1evxUk0I6x2EVTMozNRPEVkoc/y6L9sK2zq1iRP70L
         rtirLk/UKu001s6TfucQ7iLvJ7/ni5UGrxV1QYfmY78BzSW4W61FOZs/w1q0rSev71i8
         IHKYvfghl6GI4TlYkYCAjSmsGnM1ZX6W9MUEmpzWlfqltAK23uuPY1EGiNIG1InsBeRP
         yZwQ==
X-Gm-Message-State: AOAM5336p6Al+57kCubp+U+2V+FZ4IkFX79FP1t7H3rlQnuizsQ1QfnM
        Tg6X4tV0YQvRrtVz5tNWk5wFYg==
X-Google-Smtp-Source: ABdhPJx78AHOLFDMn4SydQInL+fnhbMdaYxc0HhvM4yLtjTUKgOoLV8UTlyr4RHdnrLtZVFe0dQC0g==
X-Received: by 2002:a7b:cc13:0:b0:38e:67e3:db47 with SMTP id f19-20020a7bcc13000000b0038e67e3db47mr25028508wmh.133.1652137438092;
        Mon, 09 May 2022 16:03:58 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003945237fea1sm743058wms.0.2022.05.09.16.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:03:57 -0700 (PDT)
Date:   Tue, 10 May 2022 00:03:55 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <Ynmd23nhC3KHHX1i@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
 <87bkw6cpvo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkw6cpvo.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:17:31PM -0600, Jonathan Corbet wrote:
> Phillip Potter <phil@philpotter.co.uk> writes:
> 
> > I was yes, the point I was trying to make (poorly) is that your patch
> > conflicts with Randy's patch which itself is not yet in linux-next, as
> > normally I send everything together at the start of the merge window to
> > Jens, as I don't have my own kernel.org tree yet, and usually I only get
> > one or two patches in a cycle anyway.
> >
> > This is not your fault, you couldn't have been expected to know this in
> > retrospect, and I should probably look into getting my own tree/GPG key
> > sorted to alleviate this problem in future.
> >
> > In the meantime, if you're comfortable with the idea, I can just resolve
> > the conflict myself when I send the patches onto Jens this time and
> > include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> 
> So I'm a little confused by the state of everything at this point, but
> I'm assuming that I need not worry about taking these changes through
> docs-next.  Please let me know if that's not correct.
> 
> Thanks,
> 
> jon

Dear Jon,

Yes, that's right. Makes sense for the whole series to go together, so I
will fix up patch 3 to apply alongside Randy's patch (which I see you've
taken now) and send the whole lot through to Jens as the merge window
opens. Thanks.

All the best,
Phil
