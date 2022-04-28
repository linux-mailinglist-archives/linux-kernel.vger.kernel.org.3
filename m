Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553AF51357A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiD1Npx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347522AbiD1Npu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCA985C666
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651153354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0azy+DtovG8mvKEKgP+WR39OqwdFQEe/vQhofXRHF0=;
        b=fUkMJ/FBXy0oY2z6kFcAevNJsar8DdgfoW/8tAG3wgx2S2eSwzPnS1i/cacGrtMuxRhtYM
        oqL0sMstf1weeYfx1OQH8Xq+EVhb6LIg6HzD9icXvjanwjE8Uz2OQbSbed3kWeM8uYj1s7
        6LXB2npRD53qid+rfzqiEwZJzqVSwUo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-mkB-gVV5Nmi-avj4T-IiTQ-1; Thu, 28 Apr 2022 09:42:33 -0400
X-MC-Unique: mkB-gVV5Nmi-avj4T-IiTQ-1
Received: by mail-qv1-f70.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso3706140qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=t0azy+DtovG8mvKEKgP+WR39OqwdFQEe/vQhofXRHF0=;
        b=4xJVIelYBrWwR4mWxdWgnhk8xMPmxKsqIWYroMNGZ4YQjY/aOJMUAzV4HEeV/2CKJV
         ID3d9GJrb4Mg8Sp4RkPzSQHAClQLh/sGgANq6lSNt0/NR8VRKY8cJS4dgNYrHsM90k+k
         IUZEn6Co99TU7s0ssiErvAOuGu/+Ysl39mfPk8WA70VqRSjviwozC0V2XPpNW1Kkbetu
         kYXKgd5Hvy+cBa2C+QKvvhkxwS5kjn7qHDnrmgSub4sJncil4maE4XeGuw6z/I85cP1u
         zM6a1A27TKohC8uT0d4b7krXh5Xt01/AjAwEpQlXjQIuwD4CaHppjf6y4dotJOsCKwoz
         peKQ==
X-Gm-Message-State: AOAM533nmqk/p6rR838CIoDzV5/tzvYsPPRmgqKIkaatpMjQ2FslFyC8
        KyAA/heu6GXYh2OdyX2NvSff1GwwLfDECMCqLFbrVea0eKqywU1aXgNhGeGz+O2CCsPMW5Hj7bj
        aOdNZQNJveVZw1zWHqJF0e0WF
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id b129-20020ae9eb87000000b0069e75b36527mr19857517qkg.386.1651153352572;
        Thu, 28 Apr 2022 06:42:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzokIl/JRaWUMghhni3V9PHgnwjUAMZnI0HyVvX2aW3/E3oEUMo6luK+bXSqhBkIXI2l4/nXQ==
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id b129-20020ae9eb87000000b0069e75b36527mr19857495qkg.386.1651153352358;
        Thu, 28 Apr 2022 06:42:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-13.dyn.eolo.it. [146.241.96.13])
        by smtp.gmail.com with ESMTPSA id bm15-20020a05620a198f00b0069fb41d38e7sm42417qkb.127.2022.04.28.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:42:31 -0700 (PDT)
Message-ID: <ff39b718a1eb5a41081beeee24f2c2b57a8a1602.camel@redhat.com>
Subject: Re: [PATCH net-next 08/10] ipv6: refactor opts push in
 __ip6_make_skb()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Apr 2022 15:42:26 +0200
In-Reply-To: <3d72bc581954b5a9156661cf6957a72c5940a459.1651071506.git.asml.silence@gmail.com>
References: <cover.1651071506.git.asml.silence@gmail.com>
         <3d72bc581954b5a9156661cf6957a72c5940a459.1651071506.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 11:56 +0100, Pavel Begunkov wrote:
> Don't preload v6_cork->opt before we actually need it, it likely to be
> saved on the stack and read again for no good reason.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

It looks like most part of this series has been lost ?!? only 8/10,
9/10 and 10/10 landed on the ML. Could you please double check?

Thanks

Paolo

