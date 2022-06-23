Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA255577FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiFWKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiFWKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:35:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375A4AE3A;
        Thu, 23 Jun 2022 03:35:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i64so18707425pfc.8;
        Thu, 23 Jun 2022 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tVwbL6nVPQa+IvvtvNiiIvdVzr4byypsu+RDuuj+PyE=;
        b=dvotv9yYIToSOJdOkjf4z5IpXImZfcOqikT6k+4twfSS9LKaDnpuGPFZBUYjhaMUE5
         OMB5m4c3VSlHZ5Xxj/sk7diiUITXjeVwwn3T/2y1UFAloCn9DkN4P6/hVqs8GrEXXouh
         7KPVaHs3T9h8/MsDeeMcjlk5mh9/WKwgyNDGiUVXS2lb/QE+WKcZyimdMaumYyudwYrU
         uyC1IbrB7+oXV4kBGRlHjaHVlFdf2OSsZpew43fApQ1WuxsqovBB6b/6AHTz1rZPEWiU
         /WIE+5yUr2YunTCRYuFOJbQ/YQfGnkyFTfZctVeXMWjr5s5Mf46lJuYLM5DUyYBem2Qv
         8YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tVwbL6nVPQa+IvvtvNiiIvdVzr4byypsu+RDuuj+PyE=;
        b=tFMaEt3MJfPD4pLD6i6FkjxMJgZdCGgdhqtGafS5hbsVSDH9kF9ZE64BB8XfR6HIZf
         1oonTBkDlhfjdgKqKMe3wBx7QZrkWR6dqyM8IulZQVFDgoYUjjTj0jhDPhN6KMhWra0V
         RJEzX38Brb/w8IfNSVcbMsVPPtw0obSjdWfw2Zostln28ONW56tVHj1QePzuhDg73F1C
         aScbY/SVO959uI2T3mSqgJFMxml/YtRUhfJYZ0VIF6KXaixKcwiFvc9aECczOIqVYgsA
         6mYRZhvrlxH736pc4BjP61Wl09OY6foo/dIhewRZgOBeQFAV0zd+SxqjU1o0hwEO0Zx3
         vUtA==
X-Gm-Message-State: AJIora/AFiKd6/JYVj0OAinD26/4mZV3kKZaQ/u3+W7AzNJCjJl+zjK4
        PGUQ4w93I7LF7Hyxm4TeynMwnTfhH8W0yHN57q8=
X-Google-Smtp-Source: AGRyM1v7Gvnbat5ZdugL79CKL7xNN70Bp+0Cwkn/A0cLe9T7RQunDUxGQMJHTfWll14ucXktLu3hRQ==
X-Received: by 2002:a05:6a00:1a0e:b0:523:1e7c:e26e with SMTP id g14-20020a056a001a0e00b005231e7ce26emr39726732pfv.60.1655980557866;
        Thu, 23 Jun 2022 03:35:57 -0700 (PDT)
Received: from goorm.ap-northeast-2.compute.internal (ec2-15-164-162-188.ap-northeast-2.compute.amazonaws.com. [15.164.162.188])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0016a4db1342esm3026608plg.193.2022.06.23.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:35:57 -0700 (PDT)
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hps@selasky.org,
        kieran.bingham@ideasonboard.com
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>
Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
Date:   Thu, 23 Jun 2022 10:35:43 +0000
Message-Id: <20220623103543.4138-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>

The function dvb_ringbuffer_pkt_next in
/linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
which searches the idx of the next valid packet in the ring
buffer of the ca->slot_info[slot].rx_buffer at
/linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
has the following problem.
In calculating the amounts of the consumed address of the ring
buffer, if the read address(rbuf->pread) of the ring buffer is
smaller than the idx, the amounts of the searched address
should be (idx - rbuf->pread),
whereas if the read address(rbuf->pread) of the ring buffer is
larger than the idx, the amounts of the consumed address should
be (idx - rbuf->pread + rbug->size). But there exists an
incorrect logic that the rbug-size was not properly added on
(idx - rbug->pread) in the later case. With this commit, we
fixed this bug.
---
 drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-core/dvb_ringbuffer.c
index d1d471af0636..7d4558de8e83 100644
--- a/drivers/media/dvb-core/dvb_ringbuffer.c
+++ b/drivers/media/dvb-core/dvb_ringbuffer.c
@@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct dvb_ringbuffer *rbuf, size_t idx, size_t*
 		idx = (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE) % rbuf->size;
 	}
 
-	consumed = (idx - rbuf->pread) % rbuf->size;
+	consumed = (idx - rbuf->pread);
+	if (consumed < 0)
+		consumed += rbuf->size;
 
 	while((dvb_ringbuffer_avail(rbuf) - consumed) > DVB_RINGBUFFER_PKTHDRSIZE) {
 
-- 
2.17.1

