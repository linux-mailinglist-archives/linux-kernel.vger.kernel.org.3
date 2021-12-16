Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF2476DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhLPJp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:45:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50962
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhLPJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:45:56 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B7DFB3FFD5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639647955;
        bh=ifKlZYGTOPdFCSDCTOtZXvFjnN1ta3FdQcJv2C1mO4Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GJPmFLjDQcjucaWLq1k2zw+A2F7pHDEGbjK18zS3nTQgV1zKkMd+Juh5o9I0xAggZ
         SDUztHaA47gUgQpMInXg2Gb9nQP/pNi8A77V+ayqnJRWb7PQOY8CJwVltqnNIsh/QP
         dPr0u/KsPCk/jftOz1FRdYUHGSL3C1u7UYNwEVjkPNp7b3x1twhgBcJHsivDCqD5He
         sHDzCOY015j//ZOWivN9ZlLzzEbrXTduBHXgiptk98pRqd7+DvxfJZFhIJt/jLWkyX
         3Zfnr18Cro465sOfwFmryPZ1L4ea8Z2TXPhrIcTwKiU3CQAdwmq5kDpwSmMer6lhH7
         B/ExagYtd3NVg==
Received: by mail-wm1-f69.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so10060677wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifKlZYGTOPdFCSDCTOtZXvFjnN1ta3FdQcJv2C1mO4Q=;
        b=Cbb6EfjgqSLHwPDytm+RauzGXvYwcOWuGlgaqcgXofTAOTLULM3cIJqoikdWykdAA2
         TAWDL+KJEMxJ079NyY5/3UhqdyeIjMxbUzei7qtvD+XIGg5Z+TA0l2d+ZtKiHRhUiKTU
         o8pjzLQaDQLdKh94MRZPX+MRA5TzvxHZc8Uio3YMCT4dipLUrSqFkaKBVhJM/LZl+hn6
         upYXF5z2ZRmryPcB4z36gExQa0RQ8U7u2jod6qutnm0OxWuvbOfUVa/jTiVYVTHtJlaZ
         Ul6dsSGU0KJ2qxUkjP9ziVGvukHWRZmF3+ayhrKkd8P0EzvmoZF18612fg0cLKFTGxcN
         7LFw==
X-Gm-Message-State: AOAM533fc2TvRAlVrYjtrPqW9tQmkxUBnXMRwzdHk72eB5gbFzsC5zwx
        IiiijtJqpMGYhZvpclp+cF5McSl2oFIU74UHNuSWSHgvdynlYaHJa+jy6mJmF/OlRo4ufzhGZWG
        L11nT6tbtA1IJZcoIHvnhPoau6HUB0v8wmsBm2o4Rog==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr8145350wrr.314.1639647955357;
        Thu, 16 Dec 2021 01:45:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzUGy/dKebedUXgoem/d6gyVVYcP7Z2hszf3HxXNiUwHW6hBLUxxafQ7sSJ/XEtEqxAbevgA==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr8145334wrr.314.1639647955104;
        Thu, 16 Dec 2021 01:45:55 -0800 (PST)
Received: from alex.home (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id t8sm4349398wrv.30.2021.12.16.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:45:54 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 1/6] Documentation, arch: Remove leftovers from fscache/cachefiles histograms
Date:   Thu, 16 Dec 2021 10:44:21 +0100
Message-Id: <20211216094426.2083802-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
References: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few references to the fscache and cachefiles histograms were left in
the Documentation and some arch defconfigs: remove them since those
configs do not exist anymore.

Fixes: 6ae9bd8bb037("fscache, cachefiles: Remove the histogram stuff")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Acked-by: Arnd Bergmann <arnd@arndb.de> [arch/arm/configs]
---
 .../filesystems/caching/cachefiles.rst        | 34 -------------------
 Documentation/filesystems/caching/fscache.rst | 34 ++-----------------
 arch/arm/configs/axm55xx_defconfig            |  2 --
 3 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index e58bc1fd312a..e59861458029 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -424,40 +424,6 @@ for CacheFiles to run in a context of a specific security label, or to create
 files and directories with another security label.
 
 
-Statistical Information
-=======================
-
-If FS-Cache is compiled with the following option enabled::
-
-	CONFIG_CACHEFILES_HISTOGRAM=y
-
-then it will gather certain statistics and display them through a proc file.
-
- /proc/fs/cachefiles/histogram
-
-     ::
-
-	cat /proc/fs/cachefiles/histogram
-	JIFS  SECS  LOOKUPS   MKDIRS    CREATES
-	===== ===== ========= ========= =========
-
-     This shows the breakdown of the number of times each amount of time
-     between 0 jiffies and HZ-1 jiffies a variety of tasks took to run.  The
-     columns are as follows:
-
-	=======		=======================================================
-	COLUMN		TIME MEASUREMENT
-	=======		=======================================================
-	LOOKUPS		Length of time to perform a lookup on the backing fs
-	MKDIRS		Length of time to perform a mkdir on the backing fs
-	CREATES		Length of time to perform a create on the backing fs
-	=======		=======================================================
-
-     Each row shows the number of events that took a particular range of times.
-     Each step is 1 jiffy in size.  The JIFS column indicates the particular
-     jiffy range covered, and the SECS field the equivalent number of seconds.
-
-
 Debugging
 =========
 
diff --git a/Documentation/filesystems/caching/fscache.rst b/Documentation/filesystems/caching/fscache.rst
index 70de86922b6a..66e31a6d1070 100644
--- a/Documentation/filesystems/caching/fscache.rst
+++ b/Documentation/filesystems/caching/fscache.rst
@@ -201,10 +201,9 @@ Statistical Information
 If FS-Cache is compiled with the following options enabled::
 
 	CONFIG_FSCACHE_STATS=y
-	CONFIG_FSCACHE_HISTOGRAM=y
 
-then it will gather certain statistics and display them through a number of
-proc files.
+then it will gather certain statistics and display them through the following
+proc file.
 
 /proc/fs/fscache/stats
 ----------------------
@@ -413,35 +412,6 @@ proc files.
 
 
 
-/proc/fs/fscache/histogram
---------------------------
-
-     ::
-
-	cat /proc/fs/fscache/histogram
-	JIFS  SECS  OBJ INST  OP RUNS   OBJ RUNS  RETRV DLY RETRIEVLS
-	===== ===== ========= ========= ========= ========= =========
-
-     This shows the breakdown of the number of times each amount of time
-     between 0 jiffies and HZ-1 jiffies a variety of tasks took to run.  The
-     columns are as follows:
-
-	=========	=======================================================
-	COLUMN		TIME MEASUREMENT
-	=========	=======================================================
-	OBJ INST	Length of time to instantiate an object
-	OP RUNS		Length of time a call to process an operation took
-	OBJ RUNS	Length of time a call to process an object event took
-	RETRV DLY	Time between an requesting a read and lookup completing
-	RETRIEVLS	Time between beginning and end of a retrieval
-	=========	=======================================================
-
-     Each row shows the number of events that took a particular range of times.
-     Each step is 1 jiffy in size.  The JIFS column indicates the particular
-     jiffy range covered, and the SECS field the equivalent number of seconds.
-
-
-
 Object List
 ===========
 
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 46075216ee6d..b36e0b347d1f 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -204,11 +204,9 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=y
 CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
 CONFIG_FSCACHE_DEBUG=y
 CONFIG_FSCACHE_OBJECT_LIST=y
 CONFIG_CACHEFILES=y
-CONFIG_CACHEFILES_HISTOGRAM=y
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.32.0

