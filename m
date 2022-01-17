Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC2490621
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiAQKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiAQKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:41:01 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C1C06161C;
        Mon, 17 Jan 2022 02:41:01 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JcpNB4vD9zQjkB;
        Mon, 17 Jan 2022 11:40:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642416056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cDzYSUJDO2JROZgv4pR6tf401FGHg7SSdGbGmrMTzjU=;
        b=aLZ2cqSjG7C97vZnvs4oKTxcKb4947DUXrYjD/Cofvpy5uk2J21alb6zz7B4Nx+QLC9/SE
        SRK+K3wSLwoAn+jJ1zHIV+QS+9t++6TBqYFDkr1Ac7jAoqJBzN+/iisZ4PolJmFR4036wu
        ZIl3fv5wFcfW9GcX8YIamox6cRN68+II7zGjY2rdQ97yd2f4tZGaNjOz7bWU47ojmFeusf
        FvfzO8EnVRwqJVwuIrY3MvvgfqgcP87PUu+IQvMwzE4bH1ZmTN21vVq4hlFrWuZb9urSc0
        uBFN3Kxg2DE/i/dduzUCUlnqgZ0Qm+K+sAX89tSM1LsHw3OmJK29R+vQ+yIBtw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/4] Add max6639 regulator and devicetree support
Date:   Mon, 17 Jan 2022 11:40:22 +0100
Message-Id: <cover.1642413668.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

these patches add devicetree support for the Maxim MAX6639.
In addition, it includes optional regulator support for the fan-supply and
updates the URL to the datasheet.

Changes in v2:
- dt: Rename polarity to pwm-polarity
- Remove unused platform_data header.
- Remove regulator enable/disable calls in pwm_store due to imbalance of
  calls.
- Move to strict per channel dt configuration without defaults.

Marcello Sylvester Bauer (4):
  hwmon: (max6639) Update Datasheet URL
  hwmon: (max6639) Add regulator support
  dt-bindings: hwmon: Add binding for max6639
  hwmon: (max6639) Change from pdata to dt configuration

 .../bindings/hwmon/maxim,max6639.yaml         | 112 +++++++++
 Documentation/hwmon/max6639.rst               |   2 +-
 drivers/hwmon/max6639.c                       | 235 ++++++++++++++----
 include/linux/platform_data/max6639.h         |  15 --
 4 files changed, 297 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
 delete mode 100644 include/linux/platform_data/max6639.h

-- 
2.33.1

