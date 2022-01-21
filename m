Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E608495980
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378487AbiAUFjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348679AbiAUFiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:38:54 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD599C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:53 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u3so8837238qku.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgTQTKYizbMiiJlg9iRgZhRLZdDPUF/UqTzCTAQB8AY=;
        b=KQp4FN48Jpzb9vgthzu7wq2uhq9EG3YHg9UcchoJxRywIATwgEIGR6tqptig3oNUve
         9qAF5MZqX41V+d8vJes5cKZlyqoWUNB5gJuqk4hxI7PLtKIz5zyxDuyi0ipYaX7lTNo1
         SKJYRH2gM8IzixBINjvXEpZ0a5JXpsqzEhCHw4W0KKbM302CweBG4Qo+gIyNeuBrvvIp
         8WU9nE9v55/9uqndptmHoyOYgeTVs5BWpyEanl+I1BTUAkJl1KGbl+wVJEw2AmsTW2dx
         r9pSIeYiVwpZxFzbmRdAbcvt3533fyGHKklnEBlPTMPj/JdthQC15zzu3TREvAdViA2h
         /bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MgTQTKYizbMiiJlg9iRgZhRLZdDPUF/UqTzCTAQB8AY=;
        b=Zi31ZyA/lk8bkkHEE8ZDkcB03m6ZNWsPYQismQzcl6NwsqtvKsr5KuBrdFhyvwkyX3
         rD04IL2VFCuPRfv5ATEYTLsjDD3+XBf4W0K8nyH1VlgORDFN1bnBkd8CxJIjqhmT72de
         EBqe2kAqXKBU6Bl8md1LvoiKuTO4s0OHpTv78rLZdu0haHPfYptENhFwrClAtonhZ3fz
         KqhgIUG84TnVTraQMIFobQLWWBqhyEmTXQK0LvxYbAuhvTOrGM50andrKTJLbLIMTMkt
         E5xRvAV06zzfJaavGYymgZPHsyyU1jYAw9jZkr1sVwf1bsyxtC8AFg9jPYY1fgLJqtvK
         WiEg==
X-Gm-Message-State: AOAM532+OmdIscjep7F2o1BT+kg0XOUkyo64uHY8gLkUCiw8k7KiUO8g
        nFIjql0Pk5LVzgzxI280A48=
X-Google-Smtp-Source: ABdhPJzBSZ6cTE3B8BmQhwjqVfT8yC1FupKpLo1++LBeO4qhGj50pbFfhWJBK4tFXJqTVs98kD0vuA==
X-Received: by 2002:a05:620a:20d8:: with SMTP id f24mr1683474qka.96.1642743532830;
        Thu, 20 Jan 2022 21:38:52 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id y17sm2607169qtw.0.2022.01.20.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 21:38:52 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] fsi: sbefifo: Use specified value of start of response timeout
Date:   Fri, 21 Jan 2022 16:08:15 +1030
Message-Id: <20220121053816.82253-2-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121053816.82253-1-joel@jms.id.au>
References: <20220121053816.82253-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amitay Isaacs <amitay@ozlabs.org>

For some of the chip-ops where sbe needs to collect trace information,
sbe can take a long time (>30s) to respond.  Currently these chip-ops
will timeout as the start of response timeout defaults to 10s.

Instead of default value, use specified value.  The require timeout
value will be set using ioctl.

Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-sbefifo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 52328adef643..1e9b326e8f67 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -125,6 +125,7 @@ struct sbefifo {
 	bool			dead;
 	bool			async_ffdc;
 	bool			timed_out;
+	u32			timeout_start_rsp_ms;
 };
 
 struct sbefifo_user {
@@ -549,7 +550,7 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 
 	dev_vdbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
 
-	timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_START_RSP);
+	timeout = msecs_to_jiffies(sbefifo->timeout_start_rsp_ms);
 	for (;;) {
 		/* Grab FIFO status (this will handle parity errors) */
 		rc = sbefifo_wait(sbefifo, false, &status, timeout);
@@ -972,6 +973,7 @@ static int sbefifo_probe(struct device *dev)
 	sbefifo->fsi_dev = fsi_dev;
 	dev_set_drvdata(dev, sbefifo);
 	mutex_init(&sbefifo->lock);
+	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	/*
 	 * Try cleaning up the FIFO. If this fails, we still register the
-- 
2.34.1

