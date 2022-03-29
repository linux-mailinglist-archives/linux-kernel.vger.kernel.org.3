Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC84EA659
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiC2EUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiC2EUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 158AC1FC9DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648527495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVJL4ozOwWA5aukUzGIkvdEWbtM61TZAzLEivcvQQUE=;
        b=ID3pKGvGPK1ODxMKmtcjJknQP0sFcdziuMSfO+GIjhaGRV5ePQlcwbudb+JXUQX08D19hi
        OBa278kqP2F6Q0qcI2MjxaAijALvPV4B8YPzZQ7qbHORRY4vPWkw7+lMCYrlcv2fWHGkUi
        WA/CKMmrZIcu0yLKQnGHHdfdAWmpBKw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-nGhKYxW7N8eb0x6f7g3enw-1; Tue, 29 Mar 2022 00:18:07 -0400
X-MC-Unique: nGhKYxW7N8eb0x6f7g3enw-1
Received: by mail-lj1-f197.google.com with SMTP id 21-20020a2e1455000000b0024ace13ce62so2656721lju.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVJL4ozOwWA5aukUzGIkvdEWbtM61TZAzLEivcvQQUE=;
        b=r5dBPbRYfIWTPbeSLcUvBZfC4zovvbSV4EotA9imGUM6REpjPd7enfOLM06YlE2I1I
         f3mVGXPmHfZBDBb2yAtl1lP80J0oDOsaZ04AMsFYJQHlsWe5ODM+GU/owV8pzNldcUVf
         yOyOoASZ1M39gGvX4mCnF4hXpNHrkkNBzPHCM5JkEP7xizFKhNLkawZcAb9//GlFtirN
         1wBPKwqK8kQhBkXGt+4kv+60ZFWrnCfxWyqKkP0rMoEvtOuRqmgk0OlpWFnghvDCxNHy
         6lDBOAQnyt9skvoeyJVMh55jz32ihcNmGytGifAoTBRYLlBI172CpkdZGQReTBCJAXFH
         RkAg==
X-Gm-Message-State: AOAM531izAUt3vkZRb38Dc+7HYAXqi+fwauAkGpYab683Vn1M2FVZJpR
        BlluW2V2pK1SXNNtuYhEYQstMYN9wrXWBFMahdXQqFCFuUxj7PpKVxL3zs89Urg408niEUtZjpQ
        93PZQWkleo9r1nBn2GsJ6yqdx+2TbL8t0e+1/1sSz
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id z9-20020ac24189000000b00448bc2be762mr819655lfh.471.1648527485834;
        Mon, 28 Mar 2022 21:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaY1KO8qVJ4cK/ULy7QRzOia521HxyOEE6HiQaQmTLIpFRQOw8Oc0IsataNVwt/lE/FGXuDmllt+ByEA3I5Kc=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr819648lfh.471.1648527485674; Mon, 28 Mar
 2022 21:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220329040840.3419-1-jasowang@redhat.com> <20220329040840.3419-3-jasowang@redhat.com>
In-Reply-To: <20220329040840.3419-3-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Mar 2022 12:17:54 +0800
Message-ID: <CACGkMEuRUh1qUBxKTcvuMXRkenGY53VBOf8dwabEsytnc6gFOQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa/mlx5: Use consistent RQT size
To:     mst <mst@redhat.com>, jasowang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, dunno what happened.

Please ignore this series, I will repost.

Thanks

On Tue, Mar 29, 2022 at 12:08 PM Jason Wang <jasowang@redhat.com> wrote:

