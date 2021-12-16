Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C689647721C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhLPMrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhLPMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:47:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6027C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np3so20443947pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBoygTa9ppwscbYcEQLWH8s3/BY3g0COlZ3ADPgKGvo=;
        b=lNJttLeyMLF+OaPanMDpzbGz9+2Cqd9Ass9aQlbYntoydW3WRuW4NcYugOg4+5pej2
         REexNq1FlOfcGGOuGuLkXN7hnLWE0CebXFEHAQaHVaqKchQrzlAdF4sTeXoi5mXbExvf
         AHctvOKA+X9/uiGqM2am3QJjc7ZK7ILxJvsb0Omt34Ju3hH9HBE67vVQiG4axrdPbV+k
         ZOORy6q0hPJHMwHTNxIlMwgxj5ut0Ao+d9T+9DOkMSDcJeV15pj4qo7cTVYrN/LNU8MM
         qrfur9oq4DGC9/QNO2A7Lbki0OMWx40ngBxhXb8NS8aSRIn8TBItg1UNyNgbt4rRL/os
         NR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBoygTa9ppwscbYcEQLWH8s3/BY3g0COlZ3ADPgKGvo=;
        b=j0kwWqYNMkhezfn1H75sAepCaSKTNAVCtxBcgcLlBtZp2SChB8Nu9I3+QGqWI4hOwg
         G3nzs361CWquNMIQRo0Y7zg1fvE58gzOwZfsXFB1UhxjnNSjbUhytJLgEPbGmjBrbHeC
         JuqX+qZdScFsPul9pLCyzdWfu+TC12L9aRItKJWPHWjNxSTe8IeCby/B/0hxWUMdJKPj
         BSgGCf9PhpwmJWptrhwfKIpp+21gBFVkMP8ucnENpbG4tmpBkSF6GWW+fFSoAER7IlLE
         hLWCpLB8h/tInbPG4IzoiJ716IqaaPvVJwsAGsZNicVLWdCAcpsHT0MKQ28lFRr2qgpg
         uRJA==
X-Gm-Message-State: AOAM531RWewLtogtx0be8amqLW43uFp9/oVaxSCeORmPIgh7RS0gFcVN
        X/0vmvqzSvhaazRAPiNvTCbeyw==
X-Google-Smtp-Source: ABdhPJzPCpxDFFpCAqwOXBWbLaCdKjszL0hQkZ6ydk8xbz35uU6aSSFaomhdVNHstYQoJQmRn/7tuA==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr5915749pjb.173.1639658832742;
        Thu, 16 Dec 2021 04:47:12 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id h5sm6154309pfi.46.2021.12.16.04.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 04:47:12 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/2] add MemAvailable to per-node meminfo
Date:   Thu, 16 Dec 2021 20:46:53 +0800
Message-Id: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series aims to add "MemAvailable" to per-node meminfo.

This series is based on next-20211215.

Comments and suggestions are welcome.

Thanks,
Qi

Qi Zheng (2):
  mm: add MemAvailable to per-node meminfo
  mm: reimplement si_mem_available()

 drivers/base/node.c    |  4 ++++
 include/linux/mm.h     |  1 +
 include/linux/mmzone.h |  5 +++++
 mm/page_alloc.c        | 44 +++++++++++++++++++++++++++++++-------------
 4 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.11.0

