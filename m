Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25625241CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbiELBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349757AbiELBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:01:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A56FD0D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:01:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o69so3743967pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqIXbNSlHT7h2zuf3TdH1Rcr/Q2tqRr9EyF43o9ouk8=;
        b=WCMICnZ4yFop8p5BNK/Y1RabpyArV3GgkAczZYPOeEy2IHLbwvkhWqt9nL21f8Z9eP
         bS074YqvSkLwqNYEmGDVYcrTEhATtvQd2gy8wGAaGpfepZT/1JnHe4NzM2pcEYEQGqc5
         7wuukbwCLwYDl28E3aGbycnzw1XbQLrCqy2PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqIXbNSlHT7h2zuf3TdH1Rcr/Q2tqRr9EyF43o9ouk8=;
        b=5CPX4yRhYF8Syc7myU2zUB+BFBVyF3xNAFcjaYKBgaX9PlHI1YcrXXW6XnF+4Y2H5/
         qZ8jHsiKlQWonz5jHVRQ3RDYUqkA+Sov4++HIe6rrx1uEEwZXhdo2YzQVRqku9xbpEqD
         8aQXdjc+iXywTN+w2SFTsV7g6SqSyReCOnYczDk6DYhg6HnAQ+mCRkJK6m1Bx+nrBHmg
         SqyCvlc6rWtuYHaQ4eJbBiiGiLP52dKiyt9vc9im+7zZ2A+9aQyY9F7fgBpbrKcchTAZ
         wmsFinBzRjCcapPIOid8CCEZAF/fyNNcVthcF+hlLeRCVn1Xq8WIHbFPMxvdIFWjegQm
         rr2w==
X-Gm-Message-State: AOAM532PBJVECRNr/Qq+TcK1JHXhsRpk+/iIame7JhkMi2m13iYBTfyU
        TP2CF7WA4KwgqGRnDICqAHe9Dw==
X-Google-Smtp-Source: ABdhPJyWb3Um5ooWcuLBRteAU4B7JVMDphXRC9YvJHgG1ZMSWIEuPXSZuEJwCbBW1CU1QXdL/JkEnA==
X-Received: by 2002:a17:903:40c2:b0:15c:fd2a:7198 with SMTP id t2-20020a17090340c200b0015cfd2a7198mr27689039pld.0.1652317317957;
        Wed, 11 May 2022 18:01:57 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id q37-20020a17090a17a800b001da3780bfd3sm595988pja.0.2022.05.11.18.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 18:01:57 -0700 (PDT)
Date:   Wed, 11 May 2022 18:01:54 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC,net-next,x86 0/6] Nontemporal copies in unix socket write
 path
Message-ID: <20220512010153.GA74055@fastly.com>
References: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
 <20220511162520.6174f487@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511162520.6174f487@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:25:20PM -0700, Jakub Kicinski wrote:
> On Tue, 10 May 2022 20:54:21 -0700 Joe Damato wrote:
> > Initial benchmarks are extremely encouraging. I wrote a simple C program to
> > benchmark this patchset, the program:
> >   - Creates a unix socket pair
> >   - Forks a child process
> >   - The parent process writes to the unix socket using MSG_NTCOPY - or not -
> >     depending on the command line flags
> >   - The child process uses splice to move the data from the unix socket to
> >     a pipe buffer, followed by a second splice call to move the data from
> >     the pipe buffer to a file descriptor opened on /dev/null.
> >   - taskset is used when launching the benchmark to ensure the parent and
> >     child run on appropriate CPUs for various scenarios
> 
> Is there a practical use case?

Yes; for us there seems to be - especially with AMD Zen2. I'll try to
describe such a setup and my synthetic HTTP benchmark results.

Imagine a program, call it storageD, which is responsible for storing and
retrieving data from a data store. Other programs can request data from
storageD via communicating with it on a Unix socket.

One such program that could request data via the Unix socket is an HTTP
daemon. For some client connections that the HTTP daemon receives, the
daemon may determine that responses can be sent in plain text.

In this case, the HTTP daemon can use splice to move data from the unix
socket connection with storageD directly to the client TCP socket via a
pipe. splice saves CPU cycles and avoids incurring any memory access
latency since the data itself is not accessed.

Because we'll use splice (instead of accessing the data and potentially
affecting the CPU cache) it is advantageous for storageD to use NT copies
when it writes to the Unix socket to avoid evicting hot data from the CPU
cache. After all, once the data is copied into the kernel on the unix
socket write path, it won't be touched again; only spliced.

In my synthetic HTTP benchmarks for this setup, we've been able to increase
network throughput of the the HTTP daemon by roughly 30% while reducing
the system time of storageD. We're still collecting data on production
workloads.

The motivation, IMHO, is very similar to the motivation for
NETIF_F_NOCACHE_COPY, as far I understand.

In some cases, when an application writes to a network socket the data
written to the socket won't be accessed again once it is copied into the
kernel. In these cases, NETIF_F_NOCACHE_COPY can improve performance and
helps to preserve the CPU cache and avoid evicting hot data.

We get a sizable benefit from this option, too, in situations where we
can't use splice and have to call write to transmit data to client
connections. We want to get the same benefit of NETIF_F_NOCACHE_COPY, but
when writing to Unix sockets as well.

Let me know if that makes it more clear.

> The patches look like a lot of extra indirect calls.

Yup. As I mentioned in the cover letter this was mostly a PoC that seems to
work and increases network throughput in a real world scenario.

If this general line of thinking (NT copies on write to a Unix socket) is
acceptable, I'm happy to refactor the code however you (and others) would
like to get it to an acceptable state.

Thanks for taking a look,
Joe
