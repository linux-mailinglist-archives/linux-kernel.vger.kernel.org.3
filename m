Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8E47392A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbhLNAA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:00:56 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36574 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbhLNAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:00:55 -0500
Received: by mail-pl1-f176.google.com with SMTP id u11so12332284plf.3;
        Mon, 13 Dec 2021 16:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gaXCEipyZu56aI9wIHgM/+N0sgPXs6kh5+IxDGSIJoE=;
        b=GEK3stfMsl2IJu3DG+8cNOetODorHCPPfYJzOnm/FRgUr8KORQNBoTqb0jPSeZQ41J
         ht2WFWaO+5FGHNgGPd40uEFuejciHuoGicBuQk4ake/q7Pb5jMAphWEn+afOnyRi5/v5
         5D50nHOdjFSlu9t8l3eAaqhGgvtyrj6iMIUZ0d5jmQetak6S/CF8qSKslgG6cwYhQU1u
         S5eSn3xCCkl9G2B3/ChvCEEWBvrGAK1Tp/0RXvMimz7L2QdljsvLNSzEUj7jr37W9Ghq
         N9Dlrv8Li+tskCeKQfxeUAysF/LWWZnmw4UByc4knieXVBAV9WutCwHECy7Y9np+5GU7
         5kbQ==
X-Gm-Message-State: AOAM533DdlAm68kL8Ofa4WOsxOjRUGpNlGIiqh+W2aIInQXkor77rRI5
        C/tsl1f7UsMbKvDQHOxEGjWoxdf6HQw=
X-Google-Smtp-Source: ABdhPJzdiAzwilNSYlX+PuS/tKS1VXicchsGmVMbeWK5xbfn8B5mg7iDpBGVfKsAXKgPtC0A/Xhlpg==
X-Received: by 2002:a17:90a:72c4:: with SMTP id l4mr1652702pjk.149.1639440054082;
        Mon, 13 Dec 2021 16:00:54 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:1478:51c0:bc95:f006? ([2620:0:1000:2514:1478:51c0:bc95:f006])
        by smtp.gmail.com with ESMTPSA id x33sm14035210pfh.133.2021.12.13.16.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 16:00:53 -0800 (PST)
Subject: Re: [PATCH v1] scsi: ufs: Fix deadlock issue in
 ufshcd_wait_for_doorbell_clr()
To:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211213230045.492994-1-huobean@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <101fa5ba-6d74-6c51-aaa2-e6c6d98f6bc7@acm.org>
Date:   Mon, 13 Dec 2021 16:00:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213230045.492994-1-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 3:00 PM, Bean Huo wrote:
> Call shost_for_each_device() with host->host_lock is held will cause
> a deadlock situation, which will cause the system to stall (the log
> as follow). Fix this issue by narrowing the scope of the lock.

Hi Bean,

As you probably know I do not have access to a test setup that supports clock
scaling. Has the following patch been considered?

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6d692aae67ce..244eddf0caf8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1084,7 +1084,9 @@ static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
  	struct scsi_device *sdev;
  	u32 pending = 0;

-	shost_for_each_device(sdev, hba->host)
+	lockdep_assert_held(hba->host->host_lock);
+
+	__shost_for_each_device(sdev, hba->host)
  		pending += sbitmap_weight(&sdev->budget_map);

  	return pending;

Thanks,

Bart.
