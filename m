Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA2569BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiGGHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiGGHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E795732EE5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657179489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WX46C6SaiFZW6Bz+qhhwBvhSeitlVtlZ6EC1ewTE/2o=;
        b=QQw20igDtLWpevGMAGk2ViEIia9g2BiOaFI/8zDMoPbdF0jExwRep+cXcV3DaWwNrh4Pze
        yNXcBN7mOvcNCRCA3iSsOyoj8P+f9n5DUoCh14LL1xUeTmGwbgWVw7ayvuSExqGEiqIMA0
        ScKCZJ9+SCWJwS3ryCAUQnH6JIEnQP0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-dsD7YTwlPX-yUBiqPp2vpw-1; Thu, 07 Jul 2022 03:38:08 -0400
X-MC-Unique: dsD7YTwlPX-yUBiqPp2vpw-1
Received: by mail-wr1-f72.google.com with SMTP id w12-20020adf8bcc000000b0021d20a5b24fso3049535wra.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WX46C6SaiFZW6Bz+qhhwBvhSeitlVtlZ6EC1ewTE/2o=;
        b=AurV+zIfM4hgX2F+cXeJF0blS8pl0tkJnneKrlQPoaNh3INNFOhVo75e8rziPX85d9
         /Mj0SYtsTyfV840nDNalJuXtF6f8WED1EgXPB+93CYX/BxxqlJdeYwyRhdtP3DCr22Ct
         Xjrm3mlwCPGBHBI4l0o3x8N7x1Zu2ddGIbE65kYtjtf4WAslCso5ZO2DBVchUIdWm8IX
         5SyAUcKYzGPMa7yzdvnttgazXinN7+RrSACPqzcJXjQ7tz8t2dQ6OybPiKBSfqsGsc65
         DATntHzElhHVx+r8F+8V8jMrPEZwMRfM6HE/hXuSuGkpvnvazQEZQsGxErPSKFrWf4g+
         birQ==
X-Gm-Message-State: AJIora9Bp9GIW4RyYkc+QN3lOKO7f/XRlyLD5LRyv/oj4047SEfg0ZYP
        urG++ImgytPYPb2wnNPOhnOAs2Lp9G7zBOFZifZ2R6oA8MYROxZHFMbsuUKuLmbO5MFTSr/lIb1
        7SsSDoN48kKKGTAVesTjeGow3
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr39547895wro.603.1657179487515;
        Thu, 07 Jul 2022 00:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/vqSfo20QsMtEQluvvlGkr+1eY0n28mvYI0x+egb5SCvFuJKh+4akuhj0vO3QUCQmshva3A==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr39547879wro.603.1657179487310;
        Thu, 07 Jul 2022 00:38:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id r23-20020a05600c321700b003a03564a005sm23001766wmp.10.2022.07.07.00.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:38:06 -0700 (PDT)
Message-ID: <4a66c4b6e6d5147b7545ff3e725f76d0169d96d1.camel@redhat.com>
Subject: Re: [PATCH] net: macsec: fix potential resource leak in
 macsec_add_rxsa() and macsec_add_txsa()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Jul 2022 09:38:05 +0200
In-Reply-To: <20220706074826.2254689-1-niejianglei2021@163.com>
References: <20220706074826.2254689-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

On Wed, 2022-07-06 at 15:48 +0800, Jianglei Nie wrote:
> init_rx_sa() allocates relevant resource for rx_sa->stats and rx_sa->
> key.tfm with alloc_percpu() and macsec_alloc_tfm(). When some error
> occurs after init_rx_sa() is called in macsec_add_rxsa(), the function
> released rx_sa with kfree() without releasing rx_sa->stats and rx_sa->
> key.tfm, which will lead to a resource leak.
> 
> We should call macsec_rxsa_put() instead of kfree() to decrease the ref
> count of rx_sa and release the relevant resource if the refcount is 0.
> The same bug exists in macsec_add_txsa() for tx_sa as well. This patch
> fixes the above two bugs.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

This looks exactly alike the previous version: it still lacks the
target tree and more importantly the Fixes tag.

Additionally, we new post a new revision of a previously posted patch,
you should include a version number into the subj line.

Please read carefully the documentation under Documentation/process/
(including maintainer-netdev.rst) before your next attempt,

Thanks!

Paolo

