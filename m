Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C14EDF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiCaRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCaRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:23:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D361F0824;
        Thu, 31 Mar 2022 10:21:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so81035wme.0;
        Thu, 31 Mar 2022 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UVRHxpu5eAfZsEs5HfhLN004uIPJF3dGsymXwYvqE0=;
        b=LNUVKXrv51q/DMVQ860JVj9trLzFV/zwqf6kbU1eIcKzFyN42aHz1+BBprVSkJ9n4D
         wDJDO/+r6UGXeIFsZx4I5xkVuCUEqYEM4wKnq9llbQX8dQpznyhHf50XTEMZdWcK23RZ
         iBWy/hiiaNOKW188/GaypOGFunHUm5wB3VAzu9KajZ8d4HsSdis+TQ/DkIW0Z9ooMnWG
         Jb/XiCsZg4rNYn7bPe5mm+fizG7LJGW4LoLMiuENFUpE6DP6SSSo8CM5twNT/nI7cSt4
         b2944laRAYHdWIm9fmq1JFdIQabTy2/8PpKig1IcLTw4Pgob6wUwIvtWP4H8Kurwnfo/
         28TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UVRHxpu5eAfZsEs5HfhLN004uIPJF3dGsymXwYvqE0=;
        b=QxIykZVGCuhYKCvABblfgrC71eV1uF2tYhTiYr768dYAl8ylKk8rOJeGXPZVn5FxIq
         So2m8BmesogrPE1/IMKz+Eqp2llUaHTjTe1DvMpM/NHsbKeTluy+mBB6AcSZt0JuEzeF
         Ip1jlPGPrxrXEuNU8Bf1QYnHS9TZNViT2fdvSWw71diCJ6vj1Jf+WKv9k9EAnjooWdKN
         tzUwWE9eUBTSERAyWeXd52b1/ID1ZWYl0dQGKu76UJCzfqIXe54uXoZNoTqLU6SewBM/
         mzyQ+qOzP1Cp2OKLnrmcVgbYaQS59rCdXzW41epISB7UzrpNq3aCtJnz1MnW+Bg0IzYn
         nI5w==
X-Gm-Message-State: AOAM533hMoGoSmp+FV0qU/bUkqhJbWhhaRxGZqHFHO9N5gHCq6BeRpVT
        Wm9c0WSnxAJeMYZ+AW0wmSQ=
X-Google-Smtp-Source: ABdhPJzq3nr8QvRZ+mF96/wzGEaUKNuBxFHKqbGBuOjhVXW3zpe6yfAWUncBSibI3awJmqeY6frabA==
X-Received: by 2002:a05:600c:35d4:b0:38c:9933:41c0 with SMTP id r20-20020a05600c35d400b0038c993341c0mr5593964wmq.149.1648747276628;
        Thu, 31 Mar 2022 10:21:16 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm8571435wmq.23.2022.03.31.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:21:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com, axboe@kernel.dk,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Date:   Thu, 31 Mar 2022 19:21:13 +0200
Message-ID: <3427592.iIbC2pHGDl@leap>
In-Reply-To: <20220331162416.GI12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com> <1787706.atdPhlSkOF@leap> <20220331162416.GI12805@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved? 31 marzo 2022 18:24:16 CEST Dan Carpenter wrote:
> On Thu, Mar 31, 2022 at 06:14:27PM +0200, Fabio M. De Francesco wrote:
> > On gioved? 31 marzo 2022 15:42:10 CEST Dan Carpenter wrote:
> > > Wenchao Hao, what you're saying makes a lot of sense but it raises a lot
> > > of questions in turn.
> > > 
> > > Fabio, did you test your patch?
> > 
> > Yes, I did, Dan. I tested it the usual way with the "#syz test:" command.
> > Obviously I have not the hardware to test code on it.
> > 
> 
> Yeah.  What a nightmare.  You posted a link to the first test.  It said
> passed but definitely introduced some use after frees but how was anyone
> supposed to know?

Maybe that a "spare-time Linux developer" like me should leave these 
kinds of bug fixes to more experienced people. But we should also note 
that I tried two or three different patches and _all_ of them passed
the tests. 

> 
> No way we would have figured this out.

I think that something should change about the way Syzbot tests patches 
and about how it provides the results. The other four or five bugs that 
I have fixed were based mainly to the fact that they passed the Syzbot 
tests. 

Perhaps I've been lucky but my patches were good and they were merged. 

However, I began to trust Syzbot too much. This is not how I should 
approach and try to solve bugs.

> I'm working to make Smatch
> understand device_put() better but this one is way difficult.
> 
> Sorry that you went through this.

Please don't be sorry :)

Believe me when I say that I cannot explain how many things I have 
learned during these days while working on this issue. I see no 
problems at all but only opportunities for learning.

Thank you very much!

Fabio M. De Francesco

> 
> regards,
> dan carpenter
> 
> 




