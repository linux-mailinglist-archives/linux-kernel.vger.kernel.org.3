Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F257E51C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiGVRMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiGVRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:12:41 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDE5465D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:12:39 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id z18so3776316qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5HIE2XRg2pmYksgv53CszllxeDL9cUCYZVBiJXmaPPY=;
        b=1gbtEO3vgUagzLv5nQD23z57rCYO3A72sFTrXecMzEwSJKOyYIc7oJrhZA64KL3CLc
         v7qLLxcrfNW/oExm8qqyJmASC8kGZ887g7a/x6SdNFZBpQyhxgePm1h2KRrU51UO2j8D
         4so5LucEQanO2rqBZfPgJjABOadyrha1H72QkwohJhO4lH42s2T+Wgm3ALO5tRjgqXAJ
         W30jCFuR5rvsaip7C9UmHDqjibW8K7PBxFCvRq6ySHzSM2y6lpKuhkYIcUC91Fpy3jX1
         L5ivUulwM3c7xGIV6KlSQER8DIpEX7FPqn89I1mFhBUAu/ASir5bHLJYPNN4lToDMylI
         p91w==
X-Gm-Message-State: AJIora+T5RBJwVpw56nOXAYMft0i0Df8GSZBFEwZb98zM74N4onvWBd3
        0vdLG4Hui8pAq/6BPRLPO8SBsVycoM7K
X-Google-Smtp-Source: AGRyM1vb/Yi2b2pTwi2g5I/3Hlh4uoo9GpjHqEw45DCSCLbRf0voZ3dJDwnDwSNXa64ME/af5qHvig==
X-Received: by 2002:a05:620a:4403:b0:6b5:e1ad:75a7 with SMTP id v3-20020a05620a440300b006b5e1ad75a7mr725045qkp.177.1658509958037;
        Fri, 22 Jul 2022 10:12:38 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a178d00b003172da668desm3528305qtk.50.2022.07.22.10.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:12:37 -0700 (PDT)
Date:   Fri, 22 Jul 2022 13:12:36 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3] dm-verity: optionally use tasklets in dm-verity
Message-ID: <YtrahFs5wgweeB7f@redhat.com>
References: <20220722093823.4158756-1-nhuck@google.com>
 <YtrTI/CJMoLihA/1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtrTI/CJMoLihA/1@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22 2022 at 12:41P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> We've been tying to kill off task lets for about 15 years.  I don't
> think adding new users will make you a whole lot of friends..

I don't have perspective on how serious that effort is. But ~2 years
ago DM introduced another consumer of tasklets in dm-crypt, see:
39d42fa96ba1 dm crypt: add flags to optionally bypass kcryptd workqueues

Given that, and other numerous users, is the effort to remove tasklets
valid? What is the alternative to tasklets?

Mike
