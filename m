Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B2572783
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiGLUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGLUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:40:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D2CC790
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:40:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so177647pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=aX97FT52LcXsTBCiBL5hq7AYEJzsuUqnsB+OeO5wNUI=;
        b=ISNO/DvKwrzvLX+I3lt4LSTitlFeuCDsXxg7l0bOqQrLfTda0AaH7JwUwddV3ZXjtY
         NsOyVdJCBRvz26jArgXSzLHTq2NF6SdRNfj7PWjfhVDlJxFudzKCZMZx20MHK1Y1knq0
         /9u8jaX5Z291rmQYVGsyY/uxj9NpYGX5ej9ij7Sy5K3oUeWcRy+WFVyI8FKD0BQf7t0Q
         Hp09wJ6te5WZp9BUQS9FOOj1Xgk6kHejMeI4YdsNG8Zpb851rS8W0+UEsMeTSGmFgOeA
         +ZKnmH7ZNxajWMDHPJy8ocCWothlzQY43DBWcQCx71CFqz+kGTstfski/wZ1zNhCrXUA
         msXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=aX97FT52LcXsTBCiBL5hq7AYEJzsuUqnsB+OeO5wNUI=;
        b=7suMEluya9M3R2LactgcHztohN1t59sEd1Pm1gBTspVxwfVWN4MyjtD112+parabBS
         XNJwy3o9r40gJw0hXKcNwUSglQ0lLzmpPCN8OqTS8cxZZDVhuhx4jRxQs1O/2qdl1Z1w
         aSp8oVOEg3ssWFTo0CN6QbgHXk5PTgXL2I1srv0UEG6DydKtlB/4UOnDjsxNDOTtiscM
         oeGHXry/EwXlj/yV1mT1JhahMbQbUER5QrHeN86JaLnuyCsy06kbQmGO551XZYHC111P
         p5Zq4nABxLY1i1+uY8SMXHqf5X2rKBVFkd9bnkVvAAkfaKF0UJ+TD9POedAMjth5YirB
         kSVQ==
X-Gm-Message-State: AJIora+WNVKG+tonc5rR5T1bMjphzCBOm3OzivS5v1/ROLzwK/6FpI5b
        fZLZWhAz4IIVPY/gxtDxd1BDx+IEudB1/A==
X-Google-Smtp-Source: AGRyM1t6x1Ab7heabJRf35mE4oK6fvMWsvfp1HSbfdON5u+tBveeyFBGQ4hJxCuNCdDcPgjTKuMiBA==
X-Received: by 2002:a17:902:f60d:b0:16a:1a7f:a22f with SMTP id n13-20020a170902f60d00b0016a1a7fa22fmr25715932plg.13.1657658401528;
        Tue, 12 Jul 2022 13:40:01 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016c0c82e85csm7245012pln.75.2022.07.12.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:40:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, ubizjak@gmail.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220712152741.7324-1-ubizjak@gmail.com>
References: <20220712152741.7324-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] block: Use try_cmpxchg in update_io_ticks
Message-Id: <165765840073.44296.3101525406707231315.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 14:40:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:27:41 +0200, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> update_io_ticks. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related
> move instruction in front of cmpxchg).
> 
> No functional change intended.
> 
> [...]

Applied, thanks!

[1/1] block: Use try_cmpxchg in update_io_ticks
      commit: 939f9dd040fe1063d884f8f0f89b037093fe2341

Best regards,
-- 
Jens Axboe


