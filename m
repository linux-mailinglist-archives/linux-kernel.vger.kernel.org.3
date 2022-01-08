Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938DC488625
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiAHUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiAHUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DCC06173F;
        Sat,  8 Jan 2022 12:53:32 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kd9so9447668qvb.11;
        Sat, 08 Jan 2022 12:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8wRgrjBM7Xg74cduQguANgNOGJedTRLrqER6uUYvxA=;
        b=Tvrb6onhQcujJ8Qdut2XQNqro5bS1+hAlbQqf//YU4ulzD6+8d5FSEoIV5iwDbmsOh
         9blebLHCy9KK8oMVotoddLd17vj2738Zvh90ezTsFrXDKJ/blFHYmxnsgFUmf8nKG8LP
         l6WsdeiDPExCuM0T6I/kajrN5aIQfcH67pXPfPHLVvxPwqADvZ9EmzB7FEvo+yQsdDw8
         1tqNNmjmPQ/zXxqbnIPi/Y8IIarX1axSA5W3C6zJgEdxm62IQY/HOZyhhF5+x0MJjH5X
         sQM0ekViSVVRIVz8wRQt/gEKNfnJzdgVkjHj4vP1Z3owOEZPGMDEuIpMhAxJ5nt/4jED
         62JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8wRgrjBM7Xg74cduQguANgNOGJedTRLrqER6uUYvxA=;
        b=b5yPqYyNRoZNJZ5qK8W7B2vCfy/dsKpAE9WtR3yeTqCl/eM6xJzU8cpiOrXFT0tOUs
         nVtCz1XwTHHMvz6dFQopXR+VfjZgOM1nQXTWQDk4myoYN6nsLS+A2IdzL6J9syuhgpyb
         5LCW1cSe34wOkCbRfz8SA47yzz44CTNStgn0AR3jrgz3wbtSsSTxkEadkf5uUw2/sb3L
         djgaCxVuIkR0J8mSPZ/FRnI9qgg17HZ/ELdBj1RTSJVmDJz7l4qMFijv1ddH4hkyFtAn
         FPwGqCuj9EbFw3qGx/vvU971BUfkF80m+1d1idL2axsEXW7r3teQ48Di7xsb2nW1/4BA
         JCig==
X-Gm-Message-State: AOAM5326fFG0WhPceswFPsTfxk08azZWLhJvLFr/wIYxhSZUzkvPZVKf
        papZuhbYg+h+/YAoWY0mcfA=
X-Google-Smtp-Source: ABdhPJxUsEnlYNXADnQ1ybMN8zn0ZOOoXW7z59deh2KrAC4FDr5kgQ1GeIY89koKc7uPYhftvOmz8w==
X-Received: by 2002:ad4:5f86:: with SMTP id jp6mr10425181qvb.28.1641675212060;
        Sat, 08 Jan 2022 12:53:32 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:31 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 02/16] iio: inkern: apply consumer scale when no channel scale is available
Date:   Sat,  8 Jan 2022 15:53:05 -0500
Message-Id: <20220108205319.2046348-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 021e1397ffc5..dbe13fad3cbb 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -607,10 +607,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.34.0

