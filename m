Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F152DDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiESTbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbiESTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:31:38 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184B3193A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i15so4321832ilk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7g6euCKE+7q5Ox2jpPllfW6d7KKGiiqeH8j5vdWY+s=;
        b=N7NIB1hfv7kMBYGjw2dBZbEdrBpIGXIk5gzB/cZvz/i253ghXK4GL2DQcq0eEC2Q2t
         wbxmx8bfr9APB9d4nv+7cucnZSN96HPRUrJz6AYTAa6ct+rhIEtvyBQGtEfKPXGfVtnm
         rCUlMFF+d1/SlHOOp+0w3ovqK+79SZoK4zEKPpQgrjCc5+CAbdzVdwONY9x68Wzck/Fq
         /gHehPWmfLyuIQ/+JyxU8vWaWrlEKrzjuOrExzqc2AHVL9GzFflj/QxwQLnn6MCYE2/m
         2OQ1J99fSQAGxjdQxX4Rzcyb6flIaA7azO5EbJUffPbJdFDT5/oKHpWpQpRwGwxub9/j
         kFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7g6euCKE+7q5Ox2jpPllfW6d7KKGiiqeH8j5vdWY+s=;
        b=tGgy6dT+hCc9/wWSg0EyYHDjA/JAYevhbVFZtC/E95ys5Di0iEw7yubpE7LHbHwTe4
         EazVkcU8M65VkGtwuN2NvdBp7q3qXj+WUmf1Lso+di4Itbix19RR/WvGHP8etGO1nD+V
         0DZ4knCoao9LSiFbhlDQ2mwlcnR8jNgv6aXeOzmlDxnsztR0X8F9iYypQY+lguVfBqwX
         +aCy7h+JDAxztXphHNkPTVPBIzUs4TavoCnBGtwrp0WwZub6J9cGBbRJcg0NIF3RMuDz
         fiXdbHuTXpQe/v74xjLxqbjObTKAlNnBPHskiuUjdIUQgDb2dCEWAL1rbnHqgPlGssqN
         o7xQ==
X-Gm-Message-State: AOAM532AdLC3pfIBudnW3kuOnhFOvnuWe2OzHY0QVH6fGO9O+vj7qHd5
        Bc+2BfuijDT/Zt4ccynl8nhLrw==
X-Google-Smtp-Source: ABdhPJwPPPIXWws6N66It7ZFWF1qMeHYSSEGBvvfH53dhg21KoJ7062tWY975Qy+w5tpGKDl+saung==
X-Received: by 2002:a92:6409:0:b0:2d1:1bab:a9ab with SMTP id y9-20020a926409000000b002d11baba9abmr3542173ilb.105.1652988696511;
        Thu, 19 May 2022 12:31:36 -0700 (PDT)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y10-20020a05663824ca00b0032e7456da06sm134390jat.15.2022.05.19.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:31:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org
Subject: [PATCHSET 0/2] Fix splice from random/urandom
Date:   Thu, 19 May 2022 13:31:31 -0600
Message-Id: <20220519193133.194138-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We recently had a failure on a kernel upgrade because splice no longer
works on random/urandom. This is due to:

6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

which already has more than two handful of Fixes registered to its
name...

Wire up read_iter handling and then hook up splice_read for both of
them as well.

-- 
Jens Axboe


