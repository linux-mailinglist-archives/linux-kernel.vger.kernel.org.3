Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC055285DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiEPNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiEPNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AA3D3A1B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652708911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57nX9+DJ9pzSNXCPQNiWdem4yYDcaqqFG+T6NzTRiRA=;
        b=goJD5L8FiM3FH+N1Ox1ZvwePZbPomof+x0LyWXz5jV0utOUQNXYctkwqqd43BQd7GmZtSV
        fdGWisWGoDcIpqIH9n+Tom6PWoP8E3jT/zBaNxlBuUGHnndhdB1tXHsNxRDxHjljPWLIcJ
        2wfMzzk/GUKGEUmeIfJilbTa7nzh+ss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-TCLIzhGAPxWqfM9cNb5LKg-1; Mon, 16 May 2022 09:48:30 -0400
X-MC-Unique: TCLIzhGAPxWqfM9cNb5LKg-1
Received: by mail-wm1-f72.google.com with SMTP id h6-20020a7bc926000000b0039470bcb9easo5684387wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=57nX9+DJ9pzSNXCPQNiWdem4yYDcaqqFG+T6NzTRiRA=;
        b=nDp5dm18OGyj04c91fFNp0pJTwAG+6/d6l1u2YKBFcrzBk1QFxzzi3YLjNoQgi01Q0
         FPDi4b6/77SW1KGC6fm5BSmflH1e6fD70bYrgOZL1GrlUz02FfF8xzn/ANENqYsbqNg/
         s5cvrAAfXkXZCNxrxjKmb1WriaGNANwzx1V91J0qXZXGo3zdazZJk0hoB0W5vmr9sgl7
         F8Y8/f3BXpwbg8fRgS5Ygw+XQCach0vD0ejl3E4CPQFfD+kuWu9o+wY6ZMDa+tqMBmhv
         HpttxKghAPHA9MhaNQ/9gdV6c3e3zbAlQ7Fikt2t2D/zLvotnsGjo81XfTfz5wcy5vdy
         PHKg==
X-Gm-Message-State: AOAM530zKhW3YDKbykGa4EX8VFEPBtCxrw4YO0gQHhdPKoJyXjfr7W3n
        9rhQMDQ/j6t0khRJEB9dnk8dpWwwm5gtt8tIkLJjUQDxFxpHg8+y7F629C889he3NzmI9HIAvG0
        +3M0h4TJhnkA3kB8E7/BZdnvq
X-Received: by 2002:a05:6000:1acd:b0:20c:811c:9f39 with SMTP id i13-20020a0560001acd00b0020c811c9f39mr14229565wry.482.1652708908809;
        Mon, 16 May 2022 06:48:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1N1IEJUolePSGBxQndOqX6hnOE8gJUzm1/HRPtQ5QyKNbO3nFvdniXioWurU3ZWSvtucx9g==
X-Received: by 2002:a05:6000:1acd:b0:20c:811c:9f39 with SMTP id i13-20020a0560001acd00b0020c811c9f39mr14229543wry.482.1652708908577;
        Mon, 16 May 2022 06:48:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b003942a244ee9sm10144614wmi.46.2022.05.16.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:48:28 -0700 (PDT)
Message-ID: <b9025eb4d8a1efefbcd04013cbe8e55e98ef66e1.camel@redhat.com>
Subject: Re: [PATCH net-next v3 00/10] UDP/IPv6 refactoring
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 15:48:27 +0200
In-Reply-To: <cover.1652368648.git.asml.silence@gmail.com>
References: <cover.1652368648.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2022-05-13 at 16:26 +0100, Pavel Begunkov wrote:
> Refactor UDP/IPv6 and especially udpv6_sendmsg() paths. The end result looks
> cleaner than it was before and the series also removes a bunch of instructions
> and other overhead from the hot path positively affecting performance.
> 
> Testing over dummy netdev with 16 byte packets yields 2240481 tx/s,
> comparing to 2203417 tx/s previously, which is around +1.6%

I personally feel that some patches in this series have a relevant
chance of introducing functional regressions and e.g. syzbot will not
help to catch them. That risk is IMHO relevant considered that the
performance gain here looks quite limited.

There are a few individual changes that IMHO looks like nice cleanup
e.g. patch 5, 6, 8, 9 and possibly even patch 1.

I suggest to reduce the patchset scope to them.

Thanks!

Paolo

