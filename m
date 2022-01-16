Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FCB48F9FA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiAPAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAPAXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:23:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:23:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso25829995pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=XUevpNNDykU/4ILcYiCpzemK8vBue+56hRj6RQzQGMU=;
        b=MiAgIFkxalnmcs4sv9TbjpiMgQaqwR0LrRmpbYZ1WsoAE6WXtNvj6hRowhxnmGfs5s
         ayewYOWnUmiWOIcSwa7g2hvfadQHekefJrOuwuD2rGXggBZQYSh4D3hulFSVzxkWERYe
         eOAYWEUlihEVnN5w0f0MTWo5/fVl6QsJEy2sCtrmO9Zaj++MtJWK8yAMNfbW+3V07a0m
         du8r9KfRzJgwJqdNHU9LeQQ2SI+WYojcz7bBWW7iI0tczmuOi/fehEnyTy3zNbGFZ/+H
         85xD7/MasPepPmDm+TJxjoxT4wtQQwqA4DGCScdAhD/0SPq+8qrxcp0dWz6JLrrKa8Sk
         +tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=XUevpNNDykU/4ILcYiCpzemK8vBue+56hRj6RQzQGMU=;
        b=C+4lLoq7UywtXwiPuYwxf6C5WBEkDVTPtSTMVrsIsJ27/P5aRrnYhzqGhOmtS0T7M8
         T4Rz4KmgEOrfPMhHz9eacdmtegl31XNDutIEoiJ4Nl9jbrFyTsLLW0aICNkTuGi5CRD5
         tCw7FDyiYO46e0PiHH8+ssGKGJvDYzzDBP5rxvmko+hLZMrSQ7pvZ9XQ9+Hzd8cWJBj8
         S+pgPBPg1YKiA+O9JVLrorRN1MX/g5cymQOY4kpWYvNcw3RgwSnoyB+3JxUU/NHNiFa6
         kgIWXdvFlv0eSeMPZT+GovAF5RvlOI0cJJzrlNH1dmIY+DM9OLxFKVUfeDJ55auES5AG
         FRqw==
X-Gm-Message-State: AOAM533CjOHtLaxABGn0AMNKK3pksC4NWURT5I2TsTO1LL7VShkPpel7
        7u09bTykYiJl8N3bZGqCST4=
X-Google-Smtp-Source: ABdhPJyfyEL9fNB3mhjYVVtumdJtJpoq2ElX2EhvkynF/cIBVq5utdJx0nN5McC9ot4pFcj6H5k0NA==
X-Received: by 2002:a17:90b:3607:: with SMTP id ml7mr2910363pjb.141.1642292618470;
        Sat, 15 Jan 2022 16:23:38 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id c17sm9904581pfc.163.2022.01.15.16.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 16:23:38 -0800 (PST)
Date:   Sun, 16 Jan 2022 13:23:33 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220116002333.GA23305@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116001726.GA22699@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max bit rate is dependent on which modulation is used. Previous
validation routine only took into consideration min bit rate which can
lead a misconfiguration of the rf69 chip causing the packets not to be
sent/read.

This patch enhances that input check in set_bit_rate to account for
modulation values and their respective max bit rate

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index f4ac17adcd83..70ffe291b0e6 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -229,9 +229,19 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
 	u32 bit_rate_reg;
 	u8 msb;
 	u8 lsb;
+	enum modulation mod;
+
+	// check if modulation is configured
+	mod = rf69_get_modulation(spi);
+	if (mod == UNDEF) {
+		dev_dbg(&spi->dev, "setBitRate: modulation is undefined");
+		return -EINVAL;
+	}
 
 	// check input value
-	if (bit_rate < 1200) {
+	if (bit_rate < 1200 ||
+	    (mod == FSK && bit_rate > 300000) ||
+	    (mod == OOK && bit_rate > 32768)) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param");
 		return -EINVAL;
 	}
-- 
2.25.4

