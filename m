Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411454E2E73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbiCUQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiCUQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:48:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766EC16D8CD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:46:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso10866050pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6tc3pkqZNZyKCTRozXMk87YSKEnJRwRCHnnvTYojQM=;
        b=qJLjA563ml8lhITs2zgrhf5rlbXm0bI3sjBmmEadv2kyKIgzHrhs52TsG5Q3CkEwAH
         yTbNE15rSUDyrpvTckkpN+wNAaeg2IxzpA9xLL50n93Qos3qRBJzXwLMRcTwYE3jIH0h
         MP9D3xDb63d9F2gY48267Ltq9pjZwOwY215R0Ca9vRgi4rYwHO8nkt0m7kVXrLshZ6oJ
         /MPPRk3tZQWqeUakFIbju39P0m9vw5VDuK0OpIs7w1oOjpQ5yz/+Bh0tQ8bp7j+xGTFN
         SMBHmqL8kQfy0ojMUPijx5S1RPlfFD8NQ2WOXuWy9Hsk+rIxfPAn1DwHqBdF20hVNhtg
         5fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V6tc3pkqZNZyKCTRozXMk87YSKEnJRwRCHnnvTYojQM=;
        b=CXxPd5evIXgVkFZWbMbMXLrj2oQV7pAl1zACWR/3qS5xEtzQkI5mThgkYLcK8ta6cn
         6FdcsSFN625I3qfpDJ/dt2GAJN5sXNhnS7uhjvhrHLDYcU6Duvz6MUlwwxtjn9g75As8
         YSb1R7NonB5aWBB4Jy9wfKH4RJn7M31B0H85YEijUH3ySlgA7blWF9qVlkhYCnSLtKtZ
         gr3RaVkD5KqFLs4ZMHsG6+vD/HXyHnVIhm/Km8X8rInRfvhW9uW6gF9g7N5yT0BYBfV2
         qlznnrFbk6pwBTVc51N/1frMOZB+F1pilXOmhGDOuWISpM5En36cA6KtiKaiZeDx8hzC
         M1eA==
X-Gm-Message-State: AOAM532uSMfqG4zCg6kKXcbjmub75Qb4ZwMNLsuOR4AmKafK+WasPX/k
        6m5X1m48U+R1EadvmecX1F8=
X-Google-Smtp-Source: ABdhPJw1lU/HcU+i9TJEwn7QFHAfdz7Eg7o6ONFT68y6ASLupQld+f3Hq1/sh7yxe/ZQwDtEszM2KQ==
X-Received: by 2002:a17:902:e5d1:b0:154:3319:19c7 with SMTP id u17-20020a170902e5d100b00154331919c7mr11436438plf.34.1647881216780;
        Mon, 21 Mar 2022 09:46:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 68-20020a621647000000b004fa763ef1easm11159917pfw.125.2022.03.21.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:46:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 06:46:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <Yjir/d5S3J1PTiux@slm.duckdns.org>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
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

On Mon, Mar 21, 2022 at 07:29:45AM +0000, Al Viro wrote:
...
> stabilizing the tree topology.  Turn it into rwlock if you wish,
> with that thing being a reader and existing users - writers.
> And don't bother with further scaling, until and unless you see a real
> contention on it.

Given how rare these renames are, in the (unlikely) case the rename rwsem
becomes a problem, we should probably just switch it to a percpu_rwsem.

Thanks.

-- 
tejun
