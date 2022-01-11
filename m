Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11F048B19E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbiAKQJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbiAKQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:09:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BFDC06173F;
        Tue, 11 Jan 2022 08:09:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 30so67566656edv.3;
        Tue, 11 Jan 2022 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5b2WCfiLE/Bx4/dpY4C6bJT06fNP89i6/fpYE4KF+0=;
        b=BsAav0femDyQhXoH3aCMW31pO7HR6N3Mci21EVYSzTUEX9SjrmUXjTAZ7HhUDPdu75
         5tTVDG1bN4PR12EX0Od67iPpzIYE72jnXoYTouvz4e0RaHZyRRMHvkC61erMzu89h1rY
         AtpErAP5/Jl0cvBWEZBQwMyZ3KPUNcWazC5J3JEEuNHbttKXvBY3yDKevX0G+PXsv39j
         i6K3RAl2yfLzu85qDxYPgLp1P9XwQmk6eyqPGwuIHJFm3Lwk4VWopnTAXQ2e7wrLJ55L
         ofgjkDWveKjeqtiiCalAJPRoXiBki6L2UtbafS3pZl6moEqecoY6gIb31dVIkP3mEt5V
         BtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5b2WCfiLE/Bx4/dpY4C6bJT06fNP89i6/fpYE4KF+0=;
        b=AistNlUFpX640+jvqJt0JJMIy7RXRNWGdsVUva5lpu2E4/ecFSqnfANEG5rKWIoR+4
         yag2TZIhrw5B63Y3nXc2eMqxGy7e0lsmb9eAeb65NtkjzE80FeYdQUQi4VdlHPyVhr9I
         Ze5MaK2hGbiYA6Uvxe0LDxtpQVJpnEOJ9oyGTlXOq9icjdj28wE9ZzbvDBkTIEOlqF1N
         VXvh3ephAhthH/8OhefkgHxHAQJA2MCMqUiQrHYrog1JsZIBBgX1VmB0xAyoM1GrRNMA
         Y/SmKQq0buKgs+rwldT3ev+2AmoVN838+8s+UUniIExnoUZeSYcLByPm6xZVcfHmA45F
         gIwQ==
X-Gm-Message-State: AOAM530EURFCY/HHSbwENM0nSiKy+0GxkeHAC5rG1eaDSnKL+r/y1quP
        OCxbhihHiZzvuHZmQRl3o1BfEYm90AXUUQ==
X-Google-Smtp-Source: ABdhPJy/CsJN4YuqQxpJKoXySd+4SVxR7dx+q7ZQmxn5CJTLlnQMo465RmjphVRqEbmXZQGHRym6lg==
X-Received: by 2002:a17:907:a41e:: with SMTP id sg30mr4144806ejc.249.1641917356745;
        Tue, 11 Jan 2022 08:09:16 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id s4sm3790158ejm.146.2022.01.11.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:09:16 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: PATCH v3 ASUS EC Sensors
Date:   Tue, 11 Jan 2022 17:08:51 +0100
Message-Id: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
    - Removed BIOS version checks and BIOS version dependent mutex path.


