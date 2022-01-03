Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1F483116
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiACMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiACMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:38:40 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47BAC061761;
        Mon,  3 Jan 2022 04:38:39 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w184so78842984ybg.5;
        Mon, 03 Jan 2022 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bLnja4l85nY7sG9mMjzxhaWHBfXUtbh2pLdWbEvQT2M=;
        b=m4CUYDwwYGiBfH4j8fRGpV7WzjTeq6n6WgqFCAqLuacnUYGG+YJ8TCG+iuxNy+pSdq
         MG6esO8rGS5DMqZWLdSneFAoX1677MpUP/IP6CXbNuI46zQv5DTlEQrJV23B89peuNXj
         AVQch7sIfT0BLA2mfBu40WNwdVJgGpxdchG1g7z9fBk2gwrDpWWjCBr3S9wRj0cjgMEO
         jlckqsAib8eKoGLX3GigP/bm0kWvfsAa76H3GT8j+3Ccy5b3bepMdJsrMAkjdqFKPUy/
         IITm7l+6xloMLl/NAxLASRMLp0RirC0qBJHj260BWBGNNwwPJLYSmlNIDs4x2diUpZMU
         fdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bLnja4l85nY7sG9mMjzxhaWHBfXUtbh2pLdWbEvQT2M=;
        b=hbDIrNl3UHAox1Sux23ykPv1ta/noMSYoV/0qbGwxpzBoEfiN3QH/gnlqOkL8WDia/
         xxAkQJrOoGfoPQNiDr36KrkxH4MT2vHaWtLdIpJPq3rYPUStMCPwogzmF89RkRkOR829
         NVi4I9IuIk4Eb5v5X5J4ug8VjY75nvCjqoLVWUwhixqWu53WdZ1X+4Toj/QJTtt6Oynf
         0/Yo7VNQwAI+P5LvwDbKuBS+h21qVQrh/34iP6d1m87/UUiAKz8WpMN40Qp4dEKjVVG2
         QWYHJJ9E5neQ663dvTIusr8w/OyKhca/PDJqnpFgbCuGoUMSmng762YNBAprJyWbQFQV
         z2fQ==
X-Gm-Message-State: AOAM532Wn9zDzjIVpuFA5YXIkYZW2oKzReoOfOvI5pkiJpCjpBoEDttU
        4GDLA/zRDbG15YUhub4lfGTrAswkD7YNzBCsSm5VHBF/MOY=
X-Google-Smtp-Source: ABdhPJwdM3ZmHEBgBAOasDIn6DTwku2MFxMojwFtTshOEa88VdPAVXEVQwwrD/l8q8VtG5eC8Gu9lgQd/OKoDv/CcDY=
X-Received: by 2002:a25:bccd:: with SMTP id l13mr15586329ybm.767.1641213519001;
 Mon, 03 Jan 2022 04:38:39 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 3 Jan 2022 13:38:28 +0100
Message-ID: <CAKXUXMy=M42hapfG1S4ZT1v5WEdH2KYiF8Cgukmf48=FKFCyJg@mail.gmail.com>
Subject: Potentially broken error path in bio_map_user_iov()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christoph,

in the function bio_map_user_iov() in ./block/blk-map.c, there is an
error branch for unlikely(offs & queue_dma_alignment(rq->q)), where
the supposingly expected error return value of the function is set,
i.e., ret = -EINVAL;. However, the variable ret is unconditionally
reset by the blk_rq_append_bio(...) call below, so that this 'ret =
-EINVAL;' assignment has no effect.

I am unsure which control flow you expect for this error case through
the bio_map_user_iov() function. Maybe you just want a patch like this
below to return the error code if it is at least once set?

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..4a3f6703f46f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -235,7 +235,7 @@ static int bio_map_user_iov(struct request *rq,
struct iov_iter *iter,
 {
        unsigned int max_sectors = queue_max_hw_sectors(rq->q);
        struct bio *bio;
-       int ret;
+       int ret = 0;
        int j;

        if (!iov_iter_count(iter))
@@ -296,6 +296,9 @@ static int bio_map_user_iov(struct request *rq,
struct iov_iter *iter,
                        break;
        }

+       if (ret)
+               goto out_unmap;
+
        ret = blk_rq_append_bio(rq, bio);
        if (ret)
                goto out_unmap;

I know too little about this function and its intent to create a
proper patch, though.

I also looked at the previous versions, but the error code of this
error branch was really never effectively returned before either (as
far as I grasped the earlier versions of this function). So, this
error path probably never worked as intended.


Best regards,

Lukas
