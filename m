Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD759A75F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352183AbiHSU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352112AbiHSU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106AFF03
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:56:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p125so5320718pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=vVnZAoDj6iosXMgacxEZIlMxCehF/3KLjohxC/w3AOc=;
        b=MBvLd0H5Ln7CTnufs25UW0Fbguo21Rc/RYtnhn+bQgV7gHIkbs8kjFOJGUVyWXQjb4
         vbTdLgja/b/1X1AjWWEIeNm4n4DVcNbTf/EA44cq7Nunu1xmONrQ49mXsPRbS/nvn6q6
         hNh1B5pyHdcZ8pq9P7vR3uS1v3mamIqagTmvjEDwiDVcK/L2MPAnlvDMxlO4Nuuvfriq
         22+AvemSIXG5ONVSrSY1cJQQOxdkSQjCi5gOJdmPIQDPlsGk1hlJHqYMNIqv35f0nNaD
         W2RBFmy+RxwEI5ddG999iRV6TXK0O0s72Ukso5eOpLN7EhnyUXDVTz9+t2p5b6tZBWvz
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vVnZAoDj6iosXMgacxEZIlMxCehF/3KLjohxC/w3AOc=;
        b=x+gJL29YRYw2mYAfa+/cCVN07Y9j5C+q/xvDHW9NNDizIu9nm/u0TkoJu5SNnJDfPV
         KdnaQXfR+zIb7AQ4Fu3DL3mJ6nFOt9X/+gKSmCmUts5IXExXXC/UwERIOzQ25Hepsj0n
         IZ8rsaTEjFpEDsSfogDLesbpZ8WHyl+Y4DN4N3atWbAXomPEh6xPJ6z/fs6NnCzx07hh
         nTvtYJ7S9fC5XTMUsSx8n1IlFM8ha9psHS7hpZkyknsUCqFSTei9ohbJSnN0357iczXk
         5nGPe0o0m5+q4Hsw1UmhFslIqfG3YGeoE/eJm0Pt1g3xPTQRgPCPIFx2LEP+Kl9hdYl4
         NQKQ==
X-Gm-Message-State: ACgBeo1tHyAF6sRa5wTvHzHX8QtnjYXRu5cM8Goj6B1gEWjUPewqg2V0
        AUiV+oihoXqFM1t4rOG9RbdTKQ==
X-Google-Smtp-Source: AA6agR4ELTuxzU7AGUSqlbX/zDb5+OvC5W9Ri0nVIlI1brZH+i8seV91Kq9Eb7sW7lAEwGETD1XPIQ==
X-Received: by 2002:a62:1d86:0:b0:52d:9df0:2151 with SMTP id d128-20020a621d86000000b0052d9df02151mr9493732pfd.33.1660942590520;
        Fri, 19 Aug 2022 13:56:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v4-20020a626104000000b005327281cb8dsm3977375pfb.97.2022.08.19.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai1@huaweicloud.com, osandov@fb.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
Message-Id: <166094258954.37536.4791587641314567827.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:29 +0000
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

On Tue, 26 Jul 2022 20:22:24 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, in virtio_scsi, if 'bd->last' is not set to true while
> dispatching request, such io will stay in driver's queue, and driver
> will wait for block layer to dispatch more rqs. However, if block
> layer failed to dispatch more rq, it should trigger commit_rqs to
> inform driver.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix io hung due to missing commit_rqs
      (no commit info)

Best regards,
-- 
Jens Axboe


