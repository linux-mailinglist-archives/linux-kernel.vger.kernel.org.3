Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF577480528
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhL0WmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhL0WmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:42:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513DC06173E;
        Mon, 27 Dec 2021 14:42:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l5so32044068edj.13;
        Mon, 27 Dec 2021 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwiD+8MtWY8Pqmar0N4b53PuKkAH1xe83oiwId1E51s=;
        b=VB9opFMHRwuMUj5ujn4mjXXXF05rjvg+y1luDO9AwLMjyY67cMh8vEDrzK/1BrozK/
         47JtXqkogW4i7bDay0boNAMamQLFTDMMbuY9kg5CGqMxlHp7Cj3B7qUXTP7U99Io37gM
         aBuQ/vaJbXgiQf2eISY1717j/AM5bOen8zTBG3Hm5QoSZPQWeSjRENTzLjsK04SibYJS
         vYZLgpDSVw4GmgE+CUU06prf93G745e/4YmXZl7izYSkzIV+ca+6f6YO7SvgMJur/djZ
         bVCtQeN8KJyLkTQ9HvYilymLnTBReRTLLheAFKGkNnCYqtLxJXx3OkqvmR7lmGasrKn+
         /mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwiD+8MtWY8Pqmar0N4b53PuKkAH1xe83oiwId1E51s=;
        b=knkandZCzcL26XRwZ1QZXKPnDM7yGPTBOwSzu7UxKVMxqhmLd7VhntefpslIoE+xot
         QHgm5Z6WjwA83Tn1BMs9y5UJTkhSg9oxnV0IvtkNXPh74DP6O0sn28ClPD2DvDnEaqe6
         uAIqLFKB/T0v/hDg7zOdzMSgEJmPviL8wO15gn1PVLqCbn30NZIdbi785pyQLWRqdVHk
         KVeBZeXQiFU39rMkQNJjwWfKzNCVnW9B6VlxnWHWvNcpcYl2Ux+FfD1o7oX0gI9nrmgw
         V7pBWR1h3YzYMXaNAHwqdRPS1YYZbSaMcWyCE0jfnAyZQbqqbSxSMhRbtXc/J8cDJnRW
         n/0g==
X-Gm-Message-State: AOAM533j1uY+hp/MdXoVBoNgHsq8EKVFUxG1QCVQKeWvO3gQNCXLekif
        YuNc2naGnP0nfztFhiOEyXnUAigsGQY=
X-Google-Smtp-Source: ABdhPJy/f/q7FmQyh3vK6dX3eqx8W+3Xuw54NOU+L5HR3BRMqA5EpTvci7qF1luuP5+axrVY47mEIg==
X-Received: by 2002:a17:906:9753:: with SMTP id o19mr15201632ejy.243.1640644942688;
        Mon, 27 Dec 2021 14:42:22 -0800 (PST)
Received: from demon-pc.localdomain ([79.112.215.103])
        by smtp.gmail.com with ESMTPSA id sb13sm5566806ejc.26.2021.12.27.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 14:42:22 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Add hwmon debugfs register access
Date:   Tue, 28 Dec 2021 00:42:00 +0200
Message-Id: <20211227224201.508331-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2:
 * remove error messages that are reported to userspace
 * remove IS_ERR checks that are already done by called functions
 * unconditionally define hwmon_device_{un,}register_debugfs
 * unconditionally define struct hwmon_device members
 * match hwmon_debugfs_read_reg parameter indentation with
   hwmon_debugfs_write_reg parameter indentation
 * inline hdev in reg_access calls
 * remove useless initialization of val inside hwmon_debugfs_read_reg
 * move checks outside of hwmon_device_register_debugfs
 * debugfs_reg_access -> reg_access
 * lookup device debugfs dentry rather than storing it in
   struct hwmon_device

Cosmin Tanislav (1):
  hwmon: Add debugfs register access

 Documentation/hwmon/hwmon-kernel-api.rst |  9 +++
 drivers/hwmon/hwmon.c                    | 99 ++++++++++++++++++++++++
 include/linux/hwmon.h                    | 12 +++
 3 files changed, 120 insertions(+)

-- 
2.34.1

