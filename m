Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6804B58B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357100AbiBNRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:39:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344265AbiBNRj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:39:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AE965433
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:39:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so19581853pjl.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aw8mF+WCQuCaB9/3Tpm5lA7wCf3d8rvYouovhwk2liI=;
        b=YZdOeoNRmJUFmpnXwi6VxMeN/gAVhp3aZepAvS1jmy3Ru5IFPSUy0D5RPex2WNsZlB
         MTNv5L7p5UXqbefw63X8FUodHLfDc8HgWmzyDeqRDMfTRh7FZEX0vSYxwr7bBCCW7nle
         Sbp8dUjV9g1I4HvXnAbCtGm5ZCeEvsklQJG2XS5xi9z2L7xYH0D6BY6TuLaPLsq0nn9e
         +F73c+CmGdz5tuyqc8Ff9CMGFuXca/9/c7a4IjXGj/7EEWHQ1OKKtCTlMSpwG08w+gIs
         PKR0szEjlZXAZIYJWghEZCSqg8MYXrt5la4As5RlwuXDQaouBOaj6wFAuC57Z5SxZmah
         tuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aw8mF+WCQuCaB9/3Tpm5lA7wCf3d8rvYouovhwk2liI=;
        b=OKRAfebYFUfvF9t905idfaYUO3dkrv4YHeU6yJvKSvsB0HLDtTRi1l8xSiir/ETDze
         FMPtmzD/Dc66b6yAkVONq4yFY3RQloFnn+Je8nPstrAIOh1JST/TpnZ2MEEXsiG9ErFA
         qlRI3XMnQQAP1L66fOP1zr0JVVoo2JCGz51dKou/w0MpA7rqWiol3/8yoQH9LBc6CThv
         P47Bk/9CPLyi0Hj1N9lI14DiI8SOO0Nw4yDghQrmgGMQhtKamGjv5McBPtAS3Pt2om8v
         5RsvSCtuqAXhY/ncjam/VnVt6xBChy7nFdAfvlOY2LV22zUCWQRx45YmGGIhe7kXJsct
         kKug==
X-Gm-Message-State: AOAM533CfLYbMopwMyL5bWQEuvf7Ln0wXxGJS0JYxhoHgJImGZePO9Xp
        glT19tAMPIMfRHzvO1vwP/k=
X-Google-Smtp-Source: ABdhPJy7BYmp7xUiZVFfzeCmOoJj+QjXooLELoujAD3MTY9RxVQ89/cC6Bwz95ILu79FvCO34/uDAw==
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr847078pjb.244.1644860358831;
        Mon, 14 Feb 2022 09:39:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b2sm180410pgg.59.2022.02.14.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:39:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 07:39:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Message-ID: <YgqTxbu2c5yarWMu@slm.duckdns.org>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-2-imran.f.khan@oracle.com>
 <YgKm5aSCcCYWkck2@slm.duckdns.org>
 <d07546ea-0dd3-f795-ee04-e4b40db5354d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07546ea-0dd3-f795-ee04-e4b40db5354d@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 14, 2022 at 11:19:38PM +1100, Imran Khan wrote:
> > * How did you come up with the above numbers? Are they based on some
> >   experimentation? It'd be nice if the comment explains why the numbers are
> >   like that.
> > 
> 
> I did some testing using different number of CPUs with qemu and the
> above numbers were collected from there. It may not be optimum but this
> is what I could think of while doing those internal tests.
> 
> Do you think it may be better to make this configurable via Kconfig.

I think it's good as-is for now and it's super easy and cheap to increase
the hashtable size when some cases see a high contention.

Thanks.

-- 
tejun
