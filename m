Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C94C3381
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiBXRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiBXRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6DF1190B5B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645723328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkmUZIekJ1fYPf2/HgjluquRw8TsLiMzA6hAe+2h9H4=;
        b=ZvrwI6dAt+d5bidy5WnexHbZzRyB75TFhM4SDThPJnBjdPB5/FhUUpHwn43LegIHy3NI+D
        kKOiY1G7zsJLqVJXaWRdN++7M39Gujnqguwwb28amuru+gg4KpDcDGXOZwYaSZSjtEblvt
        pyVD+RqHoSMyQ7o2us3E2u0U56tZnl8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-aqTRcoTzMSeG7im-Vswqug-1; Thu, 24 Feb 2022 12:22:06 -0500
X-MC-Unique: aqTRcoTzMSeG7im-Vswqug-1
Received: by mail-wm1-f71.google.com with SMTP id p14-20020a05600c1d8e00b00381001316a8so108765wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jkmUZIekJ1fYPf2/HgjluquRw8TsLiMzA6hAe+2h9H4=;
        b=dOUGsTFRlCYW+59x4LRgAkIAIBTCsI+kjgIYvu5Nl5qyWfNgwE0AzO8ScSEebMeo2y
         qEnSV+l3As+zDER77wqcTfVFTtNqYjAxNpnw2tSGMyVJCc2k8866XqxonV3rLbKbqsJY
         BzD5kzVlnoA5KnatY6gB1x9tpXPWprwe3ikLEoUEhjqnOiL/jWejlrAiavgUST4Qrt86
         w1aO/Ic2fT/RwkP3QWRttRXf6w2x1He7R7fIJogqCIN3KpkSQjn35iMYbWNtUsNesfKC
         zWJ/UVyeBK/CI1GOf8gh/CqSY7I1HyG0F8HgPT+f0lmpj/QI1xvjE9FdFFQMRLS3RVXM
         pJgA==
X-Gm-Message-State: AOAM531m0Iz7s4lNrbbWX/PDUdisU4F2kN7KNDeNZpPQLHV/HhwMuTbO
        F2myI43uDtlaeZ96HaTgqB8weWd+8La9TpKxn+b+KzywEuA2q2r2/PlKQ8xq0z6al4CZeLhE7Lk
        /zEtZPicbzDxbzTrSSYL36gC7
X-Received: by 2002:a5d:47ae:0:b0:1e8:e479:fa8e with SMTP id 14-20020a5d47ae000000b001e8e479fa8emr3025551wrb.169.1645723325691;
        Thu, 24 Feb 2022 09:22:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4V+MHeIax3bYGiBqitMUg6wi4T/4JtYj3TQcKtk6C9Qbc9SPId3U/Fo4UJYI4rbxrDp7jHw==
X-Received: by 2002:a5d:47ae:0:b0:1e8:e479:fa8e with SMTP id 14-20020a5d47ae000000b001e8e479fa8emr3025536wrb.169.1645723325472;
        Thu, 24 Feb 2022 09:22:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-108-216.dyn.eolo.it. [146.241.108.216])
        by smtp.gmail.com with ESMTPSA id y12sm4174551wrt.72.2022.02.24.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:22:05 -0800 (PST)
Message-ID: <1de9e991f6c109d5986c857bc176e03d5e167944.camel@redhat.com>
Subject: Re: [PATCH] tun: support NAPI to accelerate packet processing
From:   Paolo Abeni <pabeni@redhat.com>
To:     Harold Huang <baymaxhuang@gmail.com>, netdev@vger.kernel.org
Cc:     jasowang@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 24 Feb 2022 18:22:04 +0100
In-Reply-To: <20220224103852.311369-1-baymaxhuang@gmail.com>
References: <20220224103852.311369-1-baymaxhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 2022-02-24 at 18:38 +0800, Harold Huang wrote:
> In tun, NAPI is supported and we can also use NAPI in the path of
> batched XDP buffs to accelerate packet processing. What is more, after
> we use NPAI, GRO is also supported. The iperf shows that the throughput

Very minor nit: typo above NPAI -> NAPI

> could be improved from 4.5Gbsp to 9.2Gbps per stream.
> 
> Reported-at: https://lore.kernel.org/netdev/CAHJXk3Y9_Fh04sakMMbcAkef7kOTEc-kf84Ne3DtWD7EAp13cg@mail.gmail.com/T/#t
> Signed-off-by: Harold Huang <baymaxhuang@gmail.com>

Additionally, please specify explicitly the target tree into the patch
subject.

Cheers,

Paolo

