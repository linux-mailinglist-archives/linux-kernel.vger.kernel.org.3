Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC474E3B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiCVJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCVJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D430127FD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647940525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmhepZpNoMhFjymrVWQUWcEooZC4Ac4AFImCN6bnAxo=;
        b=c0uJvhIcKSLOcZ7xPld/lFuGXKXqiG3xVIbhBmkXf0MpbQkWeI9DQq/3ThDTLNmUDItjNk
        rot7B/RI2QdQDZGLeYl0Tp+GVj3e7lbDGCuuXkhQ5vDdr8cArEAuOoyQyXOyp4HZOZmhv/
        hLrkI7SjMUJf0soZ9k5n/UrPQVOFCfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-vJkWZ8JCMeCWcAfHKveUnw-1; Tue, 22 Mar 2022 05:15:24 -0400
X-MC-Unique: vJkWZ8JCMeCWcAfHKveUnw-1
Received: by mail-wm1-f71.google.com with SMTP id v2-20020a05600c214200b0038c7c02deceso563002wml.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FmhepZpNoMhFjymrVWQUWcEooZC4Ac4AFImCN6bnAxo=;
        b=VdLV4ZUqATGRmBj7Bap+t0qf0tDhnOZtV4sqvfnDBBn5X2mHoa65kMLVKUidLfmzKp
         zmTVcCrVapcxAQ1hXcgXujc2bsrs7HaYkSew1WoEqDYKWhgJUS/G8CpmuGQ5VSrG6I6t
         7pjGXt5fdFX43rPShga1n578HXzH6J5S0IfuU04E7k95DMnGGkUJVFmOnyvIEjlAG4l9
         fpg+DgQbhevgXeKHt9+7ONwY7hsNvb4GrtH46yUDnmPI01SAZzUfEU6J6IHxGhH5quxr
         wcW02bB8YmwPljk1ew2X1vzEcdV6jIxvVuc9eoaXPmD2Cmb0lWgba13tsKF4jSetTP/H
         C7kg==
X-Gm-Message-State: AOAM5322TS/e1Ufoer1OIPaeK+gA42JSgeDDrt/cm/R9vfrhZtguDEOu
        wKR1W2On8kOEn6W/gMLoRMoLuWkqRxr2jKtFUBq5y0XvF37SMoyOhDNkv3AVFFRvDpXBjzHaS3j
        WNe6rHOVzbO2svr/DQZ+kCHT2
X-Received: by 2002:a05:6000:1807:b0:203:fa3c:8556 with SMTP id m7-20020a056000180700b00203fa3c8556mr14751934wrh.111.1647940523032;
        Tue, 22 Mar 2022 02:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPaHlIFn/rp1+V6Idtk6EeRqqqGrcrjxgsYn2qBRDu/+hhScaZwqzM0pzQDnwKJ9naT/G2QA==
X-Received: by 2002:a05:6000:1807:b0:203:fa3c:8556 with SMTP id m7-20020a056000180700b00203fa3c8556mr14751914wrh.111.1647940522744;
        Tue, 22 Mar 2022 02:15:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm4914900wrs.26.2022.03.22.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:15:22 -0700 (PDT)
Message-ID: <9e2b850b81c44e41c3cc8dbd8c4ab61e516b85b8.camel@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] net: ipvlan: fix potential UAF problem
 for phy_dev
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org
Cc:     edumazet@google.com, brianvv@google.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Mar 2022 10:15:21 +0100
In-Reply-To: <cover.1647664114.git.william.xuanziyang@huawei.com>
References: <cover.1647664114.git.william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-03-19 at 17:52 +0800, Ziyang Xuan wrote:
> There is a known scenario can trigger UAF problem for lower
> netdevice as following:
> 
> Someone module puts the NETDEV_UNREGISTER event handler to a
> work, and lower netdevice is accessed in the work handler. But
> when the work is excuted, lower netdevice has been destroyed
> because upper netdevice did not get reference to lower netdevice
> correctly.
> 
> Although it can not happen for ipvlan now because there is no
> way to access phy_dev outside ipvlan. But it is necessary to
> add the reference operation to phy_dev to avoid the potential
> UAF problem in the future.
> 
> In addition, add net device refcount tracker to ipvlan and
> fix some error comments for ipvtap module.

This is pure net-next material, and we are now into the merge window -
only fixes allowed. Please repost in 2w, thanks!

Paolo


