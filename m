Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970E14AF4AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiBIPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiBIPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F9FDC0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644418970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iyN5oXAdR+1KgWlXLwn4IxXizXoaPkpGjMVEu9vunXY=;
        b=bZ5VHC34v5Ro63LCvXEnoSZU/oFknJv2XugW1zTuu/2OLWw5sNVZiK4WYLJ3O3O6FKOndy
        AeDkybFStuuCqi47ZzaZZO2B/vS5SdMxag796TFuatuqolVdnxDgTwBYs79S+6diHx+0JZ
        v5aDnxGj4DRDR7yZ5ylqxng5xjdk24o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-CtUp0geFNTmes0EefPvr4w-1; Wed, 09 Feb 2022 10:02:49 -0500
X-MC-Unique: CtUp0geFNTmes0EefPvr4w-1
Received: by mail-qt1-f200.google.com with SMTP id s1-20020ac85ec1000000b002cf7c93d56dso1867508qtx.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyN5oXAdR+1KgWlXLwn4IxXizXoaPkpGjMVEu9vunXY=;
        b=YSCqWhXiVZtCS/mQpf9HdxO7f7IdW1DHsOklfgAEtAQe9kDEYHopYlGaaI+VBUuxFn
         jKUZujgsRkRZy1e/B/wh3WSJX57b6Yl9HoTjrWxGs7vrFsUAY38/BFnX9VyINhZkbpr2
         lOq/Sr/H5IkouadTLi1DHQ4Icew8ZyW8Gj2cu4Z2Rd4u1AFopBMhMNitWHe3veaN9XNK
         HhicvaGkMlpUh9UQn32nYouzerTskkBq/nl5kxcDs245d02tFP2cMMVewjm/hoRSpwmH
         WPCTvD6fnCNXLWDWqdnUYdhrVfDAFgQF54Nf33IHKjJ0K+huoaW9sCsRWe5KxZai/e/U
         m7XQ==
X-Gm-Message-State: AOAM530gTXOSVpkjwGvCSChHAKhX9jOscC2pUAAmgCmj+2GvBVg69L3o
        YIh0ng2tOzcd+at5VLZ56pNf6ipXPAT+g21uoegKLK3FGCWc3DhCKN/PtWuFIE6NgCzJnrGMeRB
        IevGtTsKzt4Fs1A18kdT/z1Qc
X-Received: by 2002:a37:a3d2:: with SMTP id m201mr1296740qke.207.1644418968775;
        Wed, 09 Feb 2022 07:02:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCdq/55Q1gZ9pOKmf595RR79TBJCs1r4SD6oyvo1ypUkS9q2jEpetqKV7Sf7jGQj28+QPAQA==
X-Received: by 2002:a37:a3d2:: with SMTP id m201mr1296691qke.207.1644418968172;
        Wed, 09 Feb 2022 07:02:48 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 22sm9418260qtw.75.2022.02.09.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:02:47 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, alobakin@pm.me,
        edumazet@google.com, pabeni@redhat.com, vvs@virtuozzo.com,
        cong.wang@bytedance.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] skbuff: cleanup double word in comment
Date:   Wed,  9 Feb 2022 07:02:42 -0800
Message-Id: <20220209150242.2292183-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'to'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0118f0afaa4fc..9d0388bed0c1d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -681,7 +681,7 @@ static void skb_release_data(struct sk_buff *skb)
 	 * while trying to recycle fragments on __skb_frag_unref() we need
 	 * to make one SKB responsible for triggering the recycle path.
 	 * So disable the recycling bit if an SKB is cloned and we have
-	 * additional references to to the fragmented part of the SKB.
+	 * additional references to the fragmented part of the SKB.
 	 * Eventually the last SKB will have the recycling bit set and it's
 	 * dataref set to 0, which will trigger the recycling
 	 */
-- 
2.26.3

