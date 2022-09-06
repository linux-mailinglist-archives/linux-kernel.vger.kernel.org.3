Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8B5ADFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiIFGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiIFGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:33:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0C6B16F;
        Mon,  5 Sep 2022 23:33:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v4so9749691pgi.10;
        Mon, 05 Sep 2022 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zvrfH4l9+LLpmGb/+NWA6GwTCCQXPsaauZkSnlCapaY=;
        b=hZ/dzDRq5G4WmUz1ONKN7zmYqZYMPaxMQgd8xuWpa3E7uVveuvbej0gFljqv+AODSn
         M4JDCwOHfhdI6b/OcXIUZVxDutfW6ymVfmdUOYG7y9EC+gdl6ht6I2ZSXJPoGa4KG2aW
         Qjr5DPHyDbY8YBVsVZJRFYATPDaj/CET7g8qOjaXSEHSHN8I9YoLCDTkVPl3xLGNNobR
         0QMByO/L0tHlUlqR92EhFZH8EuPf4VBd/j3XwQmRwLX+nL8wGSoJMzfuv7STJ+neo1yE
         bIkfbd2+n6OJU7Zg3i64MZNK5zsWIZiavOA1Tm4K5B/em5U3b/PG/y5hQzgghC0sdLmV
         PF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zvrfH4l9+LLpmGb/+NWA6GwTCCQXPsaauZkSnlCapaY=;
        b=bIQeD82rer8ju/OQpnuw/YOW/lM+ERKQh60ol8J7vOIe2vhBzMtUCz/RUzXGmIgTar
         ryAcPUDHJvRlX2Bb3pSOP/vCLshG0AqeyZEK1M3qdL6vTK4mRNoBSJkz0oqmjHge71fQ
         Yz9jKiZz+VvWE5VtaH+bNXUXBhmG+zHE4ZKyhns3egKyq9wSPvrwTD17DabsnYyw6m9P
         2y1YPlv8myXddyDVN/1/UnPdqdLLgZc/SFn5CvbqmrTXh6ZdxUTLRkuYj2H5kY8lmfoH
         be9YmUm7Sdkt3xx2qxdLO3nkpPEBh0pWTz/cFmDv3HXvt5SF1BqNIxxWukgBlNzSKdEx
         w8uw==
X-Gm-Message-State: ACgBeo0RnXlYLaeHRnwbRFYgh/g4WSeHuOd+5splpenhMKIlcj4cl9Yx
        X4ajfsUcxnB50E1UjRziqeI=
X-Google-Smtp-Source: AA6agR4wQ6WwNUX/EghUykxH9pNTjoTZRnLxanZrz1SMxSv/1T5qMVxyCJC4tElWoD9sJo7X0fmCLg==
X-Received: by 2002:a63:6d0f:0:b0:434:a752:8389 with SMTP id i15-20020a636d0f000000b00434a7528389mr1776782pgc.210.1662446003223;
        Mon, 05 Sep 2022 23:33:23 -0700 (PDT)
Received: from localhost ([166.111.139.139])
        by smtp.gmail.com with ESMTPSA id e19-20020aa79813000000b0052dce4edceesm9090702pfl.169.2022.09.05.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 23:33:22 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [BUG] scsi: megaraid_sas: possible use-after-free caused by bad error handling in megasas_probe_one()
Date:   Tue,  6 Sep 2022 14:33:18 +0800
Message-Id: <20220906063318.2745858-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our fault injection tool finds a possible use-after-free in the 
megaraid_sas driver in Linux 5.10.0:

In the file drivers/scsi/megaraid/megaraid_sas_base.c:
In megasas_io_attach(), the call to scsi_add_host() may fail: 
6814:	if (scsi_add_host(host, &instance->pdev->dev)) {
            ...
6818:		return -ENODEV;
6819:	}

This error is then propagated to its caller megasas_probe_one().
7414:	if (megasas_io_attach(instance))
7415:   	goto fail_io_attach;

In error handling code of megasas_probe_one(), it calls scsi_host_put():
7457:   scsi_host_put(host);

The function scsi_host_put() calls scsi_host_dev_release() to free `host`,
which contains a variable `instance`.

But megasas_probe_one() calls megasas_init_fw() before:
7372: 	if (megasas_init_fw(instance))

In megasas_init_fw(), it starts a timer:
6369:   megasas_start_timer(instance);

And megasas_probe_one() does nothing about it in error handling code. When
the timer expires, it accesses `instance`, causing a use-after-free bug.

I am not quite sure how to fix this possible bug. Any feedback would be
appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Zixuan Fu
