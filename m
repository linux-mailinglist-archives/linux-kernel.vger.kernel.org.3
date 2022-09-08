Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253E5B2401
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIHQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiIHQyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8175EA623
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662655897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNh2wsY4IxMQjekgSqZPVoaPVCS81OVMRnhStiHObk4=;
        b=a+990+U+OdEYTcHCDEwpIlJKjDQJ7oYcYvHrxFxB8FamRrfry2Wy1TvcRxqr85fiJRJxcQ
        mVMwJRMHIcfNmdt+58IYpVUfQJWRqcdShtHpKCOfZp9j4aJEr2T5V50KK+6UPFxfsv9PoK
        eN2bKcaWB5hp3fApCpg1L0jZ9e0PIOw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-OuFi7UHWM-afG4COqkT-Kw-1; Thu, 08 Sep 2022 12:51:34 -0400
X-MC-Unique: OuFi7UHWM-afG4COqkT-Kw-1
Received: by mail-qv1-f71.google.com with SMTP id mx9-20020a0562142e0900b004a1ddfe8ee3so9566188qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=dNh2wsY4IxMQjekgSqZPVoaPVCS81OVMRnhStiHObk4=;
        b=IbxVrZwGmY6GdvoZCTsPojHWYE2aM9GwgFbXQb1zSkUSdmyFw89d08BfFy7DiHj5BW
         VXOwlcfnIceqSSxJeIFb3joLLPRWogzM2RiyTwX97taXUlB1zizfI149CTsuMoPfGw6r
         5Ew1/MslY2OU9WPHlVEs7Py18JLyq49juEmQQlzEGkT5pIQv0yzTkEVt0eqPXKkHcWzi
         oBlufOdmwDf+CVSQ1yplXDJXXq+nHPJg0gKQIqa94pluh77vWWa2nXPggkfuZx1JTtIk
         2/v3YrjOBGYi9GmiPYMcFzM7WLZnu1JC8mi827zd3nYZZNpvKH/zL/CetNKKkY6NOob/
         GElA==
X-Gm-Message-State: ACgBeo2x/Wt+xpcjH/rOr+Gjirv0b12LN7jZXszueOUlfd2qHnZEik+K
        WH5/Kd17rnne+krSj+8WvfJYPfOCjWIXijIru6aWLRPJ0hhzUfqWQnY/86ummZBAAcqtacTOThB
        U++cIZMFDJ9fKWcdpqmhLSA8F
X-Received: by 2002:a05:620a:244a:b0:6bb:3f0d:266e with SMTP id h10-20020a05620a244a00b006bb3f0d266emr7195599qkn.523.1662655893771;
        Thu, 08 Sep 2022 09:51:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Z2eNaP3DCHJ8+tjZJtITHMDf/XhwQlBzqISksbgSQDlgBH4MU39Mg63+k/bNgKpL9uxgVSA==
X-Received: by 2002:a05:620a:244a:b0:6bb:3f0d:266e with SMTP id h10-20020a05620a244a00b006bb3f0d266emr7195579qkn.523.1662655893495;
        Thu, 08 Sep 2022 09:51:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id cq5-20020a05622a424500b00344f7cf05b4sm14774138qtb.14.2022.09.08.09.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:51:32 -0700 (PDT)
Message-ID: <e2f6425ee577f2ae6c5ec83bbb77494acd4034de.camel@redhat.com>
Subject: Re: [GIT PULL] Networking for 6.0-rc5
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:51:29 +0200
In-Reply-To: <166265523782.4080.15618867285882380321.git-patchwork-notify@kernel.org>
References: <20220908110610.28284-1-pabeni@redhat.com>
         <166265523782.4080.15618867285882380321.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 16:40 +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> This pull request was applied to netdev/net.git (master)
> by Linus Torvalds <torvalds@linux-foundation.org>:
> 
> On Thu,  8 Sep 2022 13:06:10 +0200 you wrote:
> > Hi Linus!
> > 
> > The following changes since commit 42e66b1cc3a070671001f8a1e933a80818a192bf:
> > 
> >   Merge tag 'net-6.0-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-09-01 09:20:42 -0700)
> > 
> > are available in the Git repository at:
> > 
> > [...]
> 
> Here is the summary with links:
>   - [GIT,PULL] Networking for 6.0-rc5
>     https://git.kernel.org/netdev/net/c/26b1224903b3

In case someone is wondering... this is just the bot being confused by
the net -> net-next merge while the PR was still in PW. Next time I
should clean PW before handling the merge.

Cheers,

Paolo

