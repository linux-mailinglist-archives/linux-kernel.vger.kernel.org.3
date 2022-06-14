Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCC54AB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355574AbiFNIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354344AbiFNIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAF49393CC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655193988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGYP/gsEMh//AeAqwdzOtmRdYfkNCUr6/AfFkII/HEA=;
        b=S/Bu2GYz2M2y0OO2lmQG7YFHLyCjdqA/XC5qcm76olnGNhy/1bSWquP427T6omRU859T7Y
        kNpxsShYU8NUUbcdtJpe1LDieP7sb+o/iB9E63o3jQAq8HB1eOasQz9MUEb4NTr9SjSV82
        rAkO8NfiokkR38jphZlCN1XEEpmP1Sk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-R25dj8l5NsWJUTnhU3V7AA-1; Tue, 14 Jun 2022 04:06:25 -0400
X-MC-Unique: R25dj8l5NsWJUTnhU3V7AA-1
Received: by mail-qv1-f71.google.com with SMTP id gw7-20020a0562140f0700b0046c1b8431d5so5497032qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KGYP/gsEMh//AeAqwdzOtmRdYfkNCUr6/AfFkII/HEA=;
        b=AJA2c6yFVILrZan6vkH8I2CFds+a0ujomWoIrGBxykqqeKsznwtCedpr2HFDxEcubU
         C3RV7jxkYLZL681HMOxjwLIZZIRIPhcSmu7msmsjL7fh6AKSrlj++ihzJWGUoF5B52Nr
         HbIXHWCJxuUzBMoeT7h/PX3IuuLTvebv7gJIixEeCS3TIhZZt1ND1nb+0osqKGheEVgG
         Ax8EWV2jDz/nnYaTSovvFDoZhsp+8qRSnYRfLiLkOWeVtz8KGFstwwiwEk8H34LAoWJ/
         znvRqMggXA+w6d2Jaukd/ZHHPcYyTQHSp/j5LuKOjYKZEaxk5l+vR0xP5vPWJq4UtoKU
         lPgw==
X-Gm-Message-State: AOAM532WA1gmw1qjQd0IJkptH5jPCJy+/UWWrg7pPWhdqHS4dLmMPTfb
        tF/qa8agtlgLlyJsVUFCx3JVArtRVyf1k3grlJl+kt27J3IYWN0hPV8L+kmMFGSjNhbgBOhQPyA
        sOza+o3qBceiQvXfbVfWoyqBU
X-Received: by 2002:a05:622a:1906:b0:305:9fd:d39a with SMTP id w6-20020a05622a190600b0030509fdd39amr2975221qtc.25.1655193984980;
        Tue, 14 Jun 2022 01:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuCfeLE1J508wXY7hwu7w8PlPhBQNYCDFrlG7u0oQIZ5uVWbwIZyQPijEgSci6cc1tk/iQWA==
X-Received: by 2002:a05:622a:1906:b0:305:9fd:d39a with SMTP id w6-20020a05622a190600b0030509fdd39amr2975201qtc.25.1655193984687;
        Tue, 14 Jun 2022 01:06:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id l188-20020a37bbc5000000b006a6bbc2725esm8265998qkf.118.2022.06.14.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:06:24 -0700 (PDT)
Message-ID: <289be1e1392d5a0c9a90486be44ad09d10b70752.camel@redhat.com>
Subject: Re: [PATCH 1/1] l2tp: fix possible use-after-free
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        Tom Parkin <tparkin@katalix.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 10:06:20 +0200
In-Reply-To: <20220610051633.8582-1-xiaohuizhang@ruc.edu.cn>
References: <20220610051633.8582-1-xiaohuizhang@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 13:16 +0800, Xiaohui Zhang wrote:
> Similar to the handling of l2tp_tunnel_get in commit a622b40035d1
> ("l2ip: fix possible use-after-free"), we thought a patch might
> be needed here as well.
> 
> Before taking a refcount on a rcu protected structure,
> we need to make sure the refcount is not zero.
> 
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>

I'm sorry for the late, trivial feedback, but we need a Fixes: tag
here. Since you need to repost, please insert the target tree
explicitly into the email subj.

Thanks!

Paolo

