Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95EB502A78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiDOMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351470AbiDOMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:45:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82809263A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:42:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so7055147plv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Y5lAtzXMg+ppnAbSv6Q3GxiwRfJLdMdWeI1FfICWONs=;
        b=o9fimpV6GpiP3IeJuO1eZov9gqi31/QclX7nLI3lfbAW776Q5//E67iXr7kMcV+uaF
         1WA583e0yHlyPzanmTt/VgrhVUYQtqSpaedKTpXuusp1y4gO9TKpWiksCCqO/CZTi052
         UqYxbayNcHMPdqsOI+H4yi/3jk+Q603ErV7f94mnYeFr8BNQmSJUyZcdxHckYeHRdfWi
         g2IQQYaP4wKxEy/+W83yEcCbPNqfwS8s1nKJq5zU8QQCkK2JuoVqghI+DCbvMByVk9/M
         ry7x0pkr+XlhEddS9+MgnU2sX9vwqdnsdoSC+3YYj6N5nzUBnKsrCbJRkf1/WQKqqb2B
         cXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Y5lAtzXMg+ppnAbSv6Q3GxiwRfJLdMdWeI1FfICWONs=;
        b=C7q9xQ/gpDnoD0x4ogfOYdSrWoIh202XE0Q2jR1xD4Jqpz58yYVBz2cy0O7eyo4X7v
         96PKyB6Oae/psj3u1Smc5YszWbgkUu53WaKdccGZkBCi8ylTV/aX6M4gM2lzLC5AXc6H
         BAJPbPHo5t6lUmiTHt4SHLIpouZKHKTOZ++itVM1WtuljmqggXdCs0N84f5DtThRDRJj
         hcLwX13KSdQcM8eHvJkA3HIWQv+Yc1dvAdOAdRxnCABj0Iuao+N5fBAm2pWBxN7aaoG+
         9LsiI83WABODTdrguFGI3K7EacstCUbYt3p7Rr+B7/rfZiINdyye4ZRs7V3zs1i6fpAv
         LK/w==
X-Gm-Message-State: AOAM530yYtesnJw8RachDpN18WXsWKINvWfNsJkYyTibJ76r0MufQhvh
        GeQhAZSr0p5Tq/sBRfx0YWuNl9XKzYXkqg==
X-Google-Smtp-Source: ABdhPJzwIlw9dEPKGbvN1RvyT9uWP90pu1Rx1isjkrAsInbNbT0uMnb24qKjYAMYi5vH86TpAnkLMA==
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id z7-20020a17090a540700b001bf43cef11bmr3999585pjh.31.1650026551772;
        Fri, 15 Apr 2022 05:42:31 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm2987102pfu.202.2022.04.15.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:42:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     khazhy@google.com
Cc:     linux-kernel@vger.kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220414224056.2875681-1-khazhy@google.com>
References: <20220408234707.2562835-1-khazhy@google.com> <20220414224056.2875681-1-khazhy@google.com>
Subject: Re: [PATCH v2] block/compat_ioctl: fix range check in BLKGETSIZE
Message-Id: <165002655078.10530.5825902345538532925.b4-ty@kernel.dk>
Date:   Fri, 15 Apr 2022 06:42:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 15:40:56 -0700, Khazhismel Kumykov wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
> 
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.
> 
> 
> [...]

Applied, thanks!

[1/1] block/compat_ioctl: fix range check in BLKGETSIZE
      commit: ccf16413e520164eb718cf8b22a30438da80ff23

Best regards,
-- 
Jens Axboe


