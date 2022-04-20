Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B7507EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348554AbiDTCN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiDTCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:13:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDBC27B2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:10:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s17so447319plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=uZGu9RNlkQA5TxlgtGTOVTUwj4eEvcthrzrpgoifV9k=;
        b=WZhL8aw9yFZMmP9R1VXUsEDGLakvn6P1Xp5YQGN/v0yw5da28V1sHmvbDoiY/lBUqp
         uCdnjNXZRox8wkubowjn8QgFHLDacFGGrcDnJ6h3PzRhQmE1kQrBV+RklAXsdT/7u5mJ
         xbTwrlxFAejgYA5jCACvtKfbMtS3YO2BQEtRUhOHGHGPBhRZt8o5sbMynidMCL/LFeDl
         VTLMPq2Pn2sxJd+P6XIayzcdZy6lJxzdVoBd8GV5vsMtgf5io8G1RUwkJ+/E7Dbhny2b
         D6sfFH64D9SibJ7mxYEUvNssJOWGSRLaVJ7d7P9YPxn65FHwimER3tHaMC2dUp38mULD
         OFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=uZGu9RNlkQA5TxlgtGTOVTUwj4eEvcthrzrpgoifV9k=;
        b=cfOElrNXDQ1YnE7nKndNkwfyd6dihA+2Frlc+O91TvLgeQINBo0lkjntPbqEpxDqaq
         v7UBi/Oi9rSIX9+kgZRu7aEPSd8YVhHs6nUmAHPEnQyLirOQG/SYp97N/HckAe9Rfamk
         0Jn7EDf8ez/K22l0OLc+P2C8sW4Vw8VaYGhZyHEJJ5UQkQbcPkIrPvr7NgEO5nuRN5vM
         aywLBpn9kahxPtyf0ZM5jhbmB+TFuvlzLhaPfh0z91wkNu/bhEVG/NbLIqhqCIhESMbT
         2V4eN/t5ufeBRphGXFbVHNp9nt/cKI6k7acDIaVlNSkcEd+eQRoSAjyfX08T86EiVRzr
         Qxiw==
X-Gm-Message-State: AOAM530KD5n4gxWT7hxOkV6QXkc4V4hnH4CNeL3ZsqWUEnv9D5BXTTwn
        FsUi/LshTdE4QP1PPs1UoYTT1gyAf8qu9hZq
X-Google-Smtp-Source: ABdhPJwUA7+DodBugI4u3AXpqcq2kJK+3iemOUKLhX1NDo2Q8G5TEdc2+E6ouT86C8NQRrNgeNqw4A==
X-Received: by 2002:a17:90a:cc6:b0:1d2:9a04:d29e with SMTP id 6-20020a17090a0cc600b001d29a04d29emr1765286pjt.136.1650420641309;
        Tue, 19 Apr 2022 19:10:41 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a138200b001cb6512b579sm17032313pja.44.2022.04.19.19.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:10:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415035607.1836495-1-yukuai3@huawei.com>
References: <20220415035607.1836495-1-yukuai3@huawei.com>
Subject: Re: [PATCH RESEND] blk-mq: fix possible creation failure for 'debugfs_dir'
Message-Id: <165042064016.532249.4832316049346088891.b4-ty@kernel.dk>
Date:   Tue, 19 Apr 2022 20:10:40 -0600
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

On Fri, 15 Apr 2022 11:56:07 +0800, Yu Kuai wrote:
> 'q->debugfs_dir' is created in blk_register_queue(), however, it's not
> removed in blk_unregister_queue() and is delayed to blk_release_queue().
> Thus it's possible that del_gendisk() is done and blk_release_queue()
> is not called yet, and in the mean time blk_register_queue() is called
> for the new device with the same name. In this case, kernel will
> compalin about creation failure for 'debugfs_dir' like following:
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix possible creation failure for 'debugfs_dir'
      commit: a87c29e1a85e64b28445bb1e80505230bf2e3b4b

Best regards,
-- 
Jens Axboe


