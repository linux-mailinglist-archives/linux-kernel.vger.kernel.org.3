Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B084EA9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiC2JCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiC2JCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFC4F1FDFED
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648544419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZylkwDNOWe6e6R7uXB7q4+lY1W7o3pOApgQGglCQI0=;
        b=LXFytq8LjGHpNwwa3/LJdd2X8BXWgdBd8kMsjecygdT1fWnHapVMOVLZFffzyWyZpzugtO
        wanRAjv/fNa3bMOsI/E8AStGxHtyydijECy1kXw2zmM94KT18jkj68emGsm3oKW0H8UUsg
        4wm5Mmd2ipEo+RKtUIItBAh35yiO6rY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-1zG8-5s-MzC0YFoQ6pYUgA-1; Tue, 29 Mar 2022 05:00:18 -0400
X-MC-Unique: 1zG8-5s-MzC0YFoQ6pYUgA-1
Received: by mail-wm1-f69.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso957058wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BZylkwDNOWe6e6R7uXB7q4+lY1W7o3pOApgQGglCQI0=;
        b=COAX1zljd6nm6r0mmXkRtsiZzLOOwBksBjRnJgogUwMSkzhbZiE3xBsmnWSpP4pmgE
         gqgScq/0NpLdXt9hmmqnwexPKSAyj2+cd50zv1ov+nsj5VpGeobOdX13aSAWdT2gpT+l
         lJaT3jMNIeu7/alWBg9Uhzdue/i2/7zBccg73PUm3JShbpZV7RENDr7S51RD1ehFlLTD
         /dpAcck1+UAHxVOeDGYjybKFeNO/MC3z042SqmdeTGCpx8JqEmSuuMmpgQhYo3etQU8J
         9H3LelP0BU8Ytnz3sh5TlQIR/C6uyXStvg5j9+w9lY4ZM4g0Pi9OqvuZ8nvyycd4rSB9
         GmMg==
X-Gm-Message-State: AOAM533S1u4/sjQcwbCmZDQKApNBwjcAOG+h4uaEBSyK4Ay7dFUXLbdV
        B9cQr97SZlfaAoSdnnHCY3m7Zx736IeQMe9xeQNCiosD3f/OMt+zdyI//mfktsI1Z0gFK/dzou0
        ENh4BZdILq2hz1KznFWMpcRTs
X-Received: by 2002:a5d:4151:0:b0:203:d18a:7df4 with SMTP id c17-20020a5d4151000000b00203d18a7df4mr29578168wrq.1.1648544377519;
        Tue, 29 Mar 2022 01:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk/uKkQuY+BB/xxmjorEaGszDLMJCBjD37SToz6PVCtw9xGEDXjzxCY84COrYP7HDbzNJkjA==
X-Received: by 2002:a5d:4151:0:b0:203:d18a:7df4 with SMTP id c17-20020a5d4151000000b00203d18a7df4mr29578142wrq.1.1648544377297;
        Tue, 29 Mar 2022 01:59:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b0038ce140fec1sm1644657wms.16.2022.03.29.01.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:59:36 -0700 (PDT)
Message-ID: <b4d4ee6c553f9cd983d12f88eb6a12ca3cb39962.camel@redhat.com>
Subject: Re: [PATCH] net: dsa: felix: fix possible NULL pointer dereference
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com
Date:   Tue, 29 Mar 2022 10:59:35 +0200
In-Reply-To: <20220329081214.124061-1-zhengyongjun3@huawei.com>
References: <20220329081214.124061-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-03-29 at 08:12 +0000, Zheng Yongjun wrote:
> As the possible failure of the allocation, kzalloc() may return NULL
> pointer.
> Therefore, it should be better to check the 'sgi' in order to prevent
> the dereference of NULL pointer.
> 
> Fixes: 23ae3a7877718 ("net: dsa: felix: add stream gate settings for psfpq").

It looks like the fixes tag has been corrupted (trailing 'q'). Would
you mind posting a v2 with that fixed ?

Thanks,

Paolo

