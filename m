Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199E4C53B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiBZE0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiBZE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:26:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D1D21D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:25:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a5so5570141pfv.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Fp8tS9Tv9uCsWH6vrg9RydV37obfExfUsNqz1M7URQw=;
        b=gAwNByTQb9WAk7MPfXqU6n8mq0gTMsBg0s07UhnpFy7iVZ7BGyO+fcZMiq1ckGgeST
         SPtN9ABVZSGJUMpwJiBgmjb+llU2FOqn0orQ/CM2hYu0upRAEc2AskxGiAkuDR4dueZ6
         GJuPYwt12mV9VHyCAbc8ZEANweruJ4SFj+zHNZm9O4vugdXzlJxPh4sr/NbtEfZ7P33y
         T7VPH9en9aAAkmXGot0rJkeLIZVA+jiz6x6dR5mZG8Vp0iPTcO01F70AHcHv1i3H8x2w
         Ht6uKu3tQ3anzoNnJ4B7D+yHxVA7G6VItDpJ+RYNo81rSW6HsGDolLaQIgap2L21yttM
         qy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fp8tS9Tv9uCsWH6vrg9RydV37obfExfUsNqz1M7URQw=;
        b=fsp9eBzO91N9BG0L2gsKUTNJhxx1uPPqUB/NjfNIWs3gzaWryc4qsTTdtngzzp/5zb
         kx6Fco8jG9nbdA1B9lA34HYwzmSNwTc5ZHPWCIngcK17RCSCiX4lgnNytAHk+EOcXI3P
         /Pqmj40Xo/tTVHznEQ2a63u6XZ4tnHmYAEf4PMqz7cl8KkFQ1duVuRo+fzQdaCKdNkDB
         jmS+82RIv/d+RcuzzGx28vzwhJUzIKP482dUGLGIM1+1NrMxKkzI+FqP9yaOURw8VPpH
         XUOlPDaelpF8CnIuVirYTe32bBTtNwh6TWr7G6DYT4g1zjUI/p2PPpdVXMoFVeLUUXyX
         ZKqw==
X-Gm-Message-State: AOAM533eHvbO5ZuVQrQuCwjWlgWQFPRrLNgUyINqnN30j820+vsfv+2J
        7I4iK7GF2WAAZ1P6cPE3kvPQl3/Qv7wXMBm1
X-Google-Smtp-Source: ABdhPJzHQLmT4p//evrcfBLw6x6Xobkv89wYpaBw12Jpf3R4cHoxj+UYFlNw9jxJJ4iXYg8goHDYUA==
X-Received: by 2002:a63:2d05:0:b0:34b:3f1d:2fa8 with SMTP id t5-20020a632d05000000b0034b3f1d2fa8mr8844216pgt.447.1645849537593;
        Fri, 25 Feb 2022 20:25:37 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79588000000b004e1dc67ead3sm4783050pfj.126.2022.02.25.20.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 20:25:37 -0800 (PST)
Date:   Sat, 26 Feb 2022 17:25:31 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: prevent uninitialized data from being
 printed out
Message-ID: <Yhmruyr2BUn0+3O3@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

local_buffer is not initialised before data is passed to
spi_sync_transfer. In case spi* function fails then the dev_dbg
statement after that can potentially print out uninitialised data

this patch initialises local_buffer array.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

- this change was requested by Dan Carpenter in a different thread:
https://lore.kernel.org/lkml/20220207100601.GF1951@kadam/

Patch dependency:

- this patch depends on the following patch to be applied first as
both of them change the same file:
https://lore.kernel.org/lkml/Yhla4a1Clpguoo2h@mail.google.com/
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e5b23ab39c69..3028018f0b45 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -782,7 +782,7 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 {
 	int i;
 	struct spi_transfer transfer;
-	u8 local_buffer[FIFO_SIZE + 1];
+	u8 local_buffer[FIFO_SIZE + 1] = {};
 	int retval;
 
 	if (size > FIFO_SIZE) {
-- 
2.34.1

