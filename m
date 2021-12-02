Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48770466566
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358592AbhLBOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbhLBOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:41:06 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B851C06174A;
        Thu,  2 Dec 2021 06:37:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d11so72802ljg.8;
        Thu, 02 Dec 2021 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHd4uDOoDpp481WlQjKmedLGPvUzvZxsrzyo9XGV9zw=;
        b=BkvNYGzwVC3HoFD2GgyAwC2nX0ycLgDMBrE45Ojt+JAtpwrF0Zi3Qw+6hhDlFFZsQz
         4Jfet2bHdRHmuFWQgV8f63uwXwRPb7o3AogAXqkuXK8tPuRZ0Fxf//OWfoAQ8QUaBh1a
         Ul3cmIzN9PUVdiAduG/AfFRn0cCqcPEQvvr/AGWG4taP3hgdf33VWfBHkbCgxDN6o3Cj
         EPT9mx+/AJnIA05yRjZAImfPyk+s1o+ZmAXZ5C9sOm7HMGu5jwoJtjCj3jgvElcd3W2j
         zgRE3+dw0GhtCyQmJspVpWeOcqZq95ncqO4S4WdTTnrgqe/M12TRaXnUWtg8XiWk9bE2
         Bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHd4uDOoDpp481WlQjKmedLGPvUzvZxsrzyo9XGV9zw=;
        b=5FNO+3bhE/g1oD4lp+Y67MAL48hW45EHHsopvxP2Ee0WaA0hQ+R06H62MndGGvwAgd
         Fh6u3TEKsj271TcKnL1kRDvCQxXnkXMC40UIhu6UZOSWvUBpO79786IOEYpOjQqr23mE
         r+MqxkYMcB+Le7xGMyk3hqBxF7Bs3g6Rs5CFGdcFMVkS0eZYo662zK/M7RPA5VFZEIoU
         H0tfKQ2S0mfHf7iyWDulJUYUX4d1KoDWv3lXRStEpo9JJLqIR86Dmh6729M7NAE7V3j5
         TurRfBqpnb1z+QEJyezm+ztqqES6XrL+Jz2ylYh7RFKavk9RU5R4LIbCbQdFbDrfqbEv
         Tx3w==
X-Gm-Message-State: AOAM531cgyzgMw+qp7PzGhaz5vjX9AqsQXv+6wnVohuK13xYfFk6i6eK
        7nH6VXbrat/At8/1vtKF1dDpNqqLYic=
X-Google-Smtp-Source: ABdhPJz0d8fvX4UsuAHrK8vB3kVrtuMVdQzl0w6S9vqnevdNFPShz7jVAKWiKfROIg9laybG138AvA==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr12042443ljj.205.1638455861937;
        Thu, 02 Dec 2021 06:37:41 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id f19sm368976lfm.119.2021.12.02.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:37:41 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/2] powercap/drivers/dtpm: Constify static ops structs
Date:   Thu,  2 Dec 2021 15:37:32 +0100
Message-Id: <20211202143734.101760-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static ops structs that are never modified, to allow
the compiler to put them in read-only memory.

The first patch constifies one powercap_zone_constraint_ops and one
powercap_zone_ops. These are only passed to powercap_register_zone()
which accepts const pointers.

The second patch constifies dtpm_ops. In order to do that, we need to add
const to an init function and in the dtpm struct, which is ok since noone
modifies the struct.

Rikard Falkeborn (2):
  powercap/drivers/dtpm: Constify powercap_zone_{,constraint_}ops
  powercap/drivers/dtpm: Constify dtpm_ops

 drivers/powercap/dtpm.c     | 6 +++---
 drivers/powercap/dtpm_cpu.c | 2 +-
 include/linux/dtpm.h        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

