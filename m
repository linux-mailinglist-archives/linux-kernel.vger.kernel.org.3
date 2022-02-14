Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C934B4306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiBNHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiBNHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6B5A09D;
        Sun, 13 Feb 2022 23:38:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so12656855ejd.6;
        Sun, 13 Feb 2022 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnfc/m4b0eUi8rt1+Lbiend5PrPGvJuYvFCo7+VTsrY=;
        b=lFFqf/BNhc55z+4ipzgclhbpaTld4n6BcYri9CBiQLcOlVHI6wXALzDx3hqaolL/Eh
         2Wu4BI2lKadB+Ya0jovLoInXMtJvIInJ2jUzS707lBawzQkf8zXzPspv3rGkxKTDo2NB
         wXoUBJtrG/RI9d8PjEpXeW1N7X58/ZCVBqp2+hjCJC4XvCH3kAz96wQVl9eNxjRuwKyk
         M7UTRIYK/GsbAvaXwt3uuPcfDIJBsNJXyCHlqTYDS6+AmaY200AoW17vjTvP+9Z9+HS4
         8vyaOI1++Aj2h2pyLqWWUNX7PO5MznY7meluY/f1GC5pumN3xdeJ8ts7FawmNYajgrs9
         9TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnfc/m4b0eUi8rt1+Lbiend5PrPGvJuYvFCo7+VTsrY=;
        b=jkfV1QTO2hAjdegq1qj9sTyifj6mSVYaesf20jLENO3FcDJWkFsuWUx+ladjWQuuaG
         7PM8SgPiXe89eg5UytmbeC6ka1B2zACsmB9Y709GVHIs/xkJxKoLvsR4OMcDnxrWQJHE
         rCH6C4l+tOMOp3TkgjKEDaLgpDQdgz67E3HeO7o07bOV8hg5hio6pUUdL9LJvPO213hg
         gDPTLKBzXSJT34YOi1b2MUk58Z6qIjbbxJ5na6BUysirZAXjgPnJzSHy15ZPAOVEXVx/
         FU0wfQKewzWY6DTSH68ZLQ9RxmW7ETQf8tvn3/eHKHiWYLkwLTVKMNSjL9EcF58nfi/z
         q9OA==
X-Gm-Message-State: AOAM533ac93VHCc2J4gUNlds0RqPeqMWCM6wCbtU36BFcqNttr/mtcY6
        6kIX+hMEGPMOxe+RrWwheP0=
X-Google-Smtp-Source: ABdhPJwvUpUJ3CJFQU9+VtaM2idE0STA5Ev3Nc7FdHO4yFI+pijE6r+VFV921GgXF1zuyHGg0W8vOQ==
X-Received: by 2002:a17:907:8a1f:: with SMTP id sc31mr7529306ejc.651.1644824304224;
        Sun, 13 Feb 2022 23:38:24 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id 9sm2480065ejd.184.2022.02.13.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:38:23 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] iio: ABI: add note about configuring other attributes during buffer capture
Date:   Mon, 14 Feb 2022 09:38:08 +0200
Message-Id: <20220214073810.781016-4-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214073810.781016-1-cosmin.tanislav@analog.com>
References: <20220214073810.781016-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be impossible to configure other attributes (e.g.: events, scale,
sampling rate) if they impact the currently active buffer capture session.

On ADXL367, writing to register before 0x2E requires the device to be
placed in standby mode, otherwise the changes might be effective for
only part of a measurement.

To ensure this requirement, the configuration attributes of the IIO
device try to claim direct mode before switching to standby mode.
During a buffer capture, direct mode cannot be claimed, and the
attribute write callback returns -EBUSY.

Describe this behavior in the buffer/enable attribute description.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 41c1e3e1bf30..bc98453bdade 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1278,6 +1278,10 @@ Description:
 		Actually start the buffer capture up.  Will start trigger
 		if first device and appropriate.
 
+		Note that it might be impossible to configure other attributes,
+		(e.g.: events, scale, sampling rate) if they impact the currently
+		active buffer capture session.
+
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-- 
2.35.1

