Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5454DA429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiCOUnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351778AbiCOUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:43:20 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE958E7B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:42:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e22so157132ioe.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=3LYA3F2vS7/qRcuHKgfo+jK9meyWqLhonxVb0i4Hx5E=;
        b=JeaFSWMAHkn88CJQ7Mt1LcJQgY6H3z7RzwGpe0n8y3L0NI06u9lVkivHPoeAw0zRmZ
         K2qGAtbPX8jksaz032oREYbw/0yMTOWJhCv2Or9dsjzcHDEVojzLbdykPuNgiqjKwMni
         B5OCnDwbIszh/wytrjATI/83XWdwSWil+C/TGz27DNTT/v9TUDHl4qNC7+9tkisJI9ao
         KtIYrS0WF5D7th0tM1ik+R3w1SV00MX9jDR9O8GENmNV1Bq5JIr6CQU93gUQGVQuynrf
         aJMq10vY9CPJfe4rDbeT+Q2Y36j2zYZBvWPNct8SlYtiSSs1WsUUsm8RJy+MUE3WUYQQ
         P+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=3LYA3F2vS7/qRcuHKgfo+jK9meyWqLhonxVb0i4Hx5E=;
        b=IKhIs4JSabJxw7z0Vq1FBBu4wvdk9NofbiN62pE30bYiYZll33zo8KL/FiwXKtxUTq
         YNGLKJ2vLcgRzcswNyD6WuKcecL5noJi1Wz8YOWx/sO+dyyMnWUc1ThMdEFRzqIeVOkq
         Kq4tGuR096P7budVPXHugRBXlXpYyRXT09KV+oXzVLtP/sHUS4aSuzi493q5lshpRC3L
         boynMn8SQMNrJApG1FfU4XkMAcMMgCiwpID95VxMjLRHeVmxQRyV5cujv8/qah/C7tsO
         xNgxJBmzx3HEJ0KIc7l9bXB9Lp5HA3IIH3jKYFLY/jbsE0qOJEJT9hSDAfqsrgcBDvrQ
         ZzCA==
X-Gm-Message-State: AOAM533KyzV4bztodIKDBWMvsIYEev/r5Jf/bMQbngDpynD7QhmA0X86
        0C0pGt25S7hO0iiAGfYr04AjNQ==
X-Google-Smtp-Source: ABdhPJxyYA1foZ099T/TN7q5N1/aFnC/sZVxSPSTvM5nF2IoFH3QbFH+2gatQLGEz+Ob6ehjUf8AyQ==
X-Received: by 2002:a05:6638:259:b0:319:e237:b6f9 with SMTP id w25-20020a056638025900b00319e237b6f9mr16110035jaq.186.1647376927106;
        Tue, 15 Mar 2022 13:42:07 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d97c5000000b006412c791f90sm10260598ios.31.2022.03.15.13.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:42:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
References: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] sr: simplify the local variable initialization in sr_block_open()
Message-Id: <164737692606.34720.13651107602467649811.b4-ty@kernel.dk>
Date:   Tue, 15 Mar 2022 14:42:06 -0600
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

On Mon, 14 Mar 2022 16:03:21 +0100, Lukas Bulwahn wrote:
> Commit 01d0c698536f ("sr: implement ->free_disk to simplify refcounting")
> refactored sr_block_open(), initialized one variable with a duplicate
> assignment (probably an unintended copy & paste duplication) and turned one
> error case into an early return, which makes the initialization of the
> return variable needless.
> 
> So, simplify the local variable initialization in sr_block_open() to make
> the code a bit more clear.
> 
> [...]

Applied, thanks!

[1/1] sr: simplify the local variable initialization in sr_block_open()
      commit: 79d45f57a19537a1ec6ebf836944e968b154f86e

Best regards,
-- 
Jens Axboe


