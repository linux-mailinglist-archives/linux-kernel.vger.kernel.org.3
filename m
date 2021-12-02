Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CE46620D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357172AbhLBLLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhLBLLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:11:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DDDC06174A;
        Thu,  2 Dec 2021 03:08:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o13so58680040wrs.12;
        Thu, 02 Dec 2021 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD9MSEk9daW4cqdY2jf/MSQE0CWeuPy5ffaqqG4xnRk=;
        b=BBLLlm2/UMlXC7tA7IeujNzV+sYj2IHr2GZKfGC+B4MHHJJ1eLA2R1KPzVvvCunE+n
         SFisjYarrxHOwGWw1Zk3ubElnOJUUKTsNqeIU+TjdgMKPUlqudN3sdQDSCOVvfqaeQjz
         eqgxyHGZKM3F145/sSOM3FBvCLXiFj2mZOxkFgAxAwCctopJgHBHvVbGsiz8K8soJY4u
         dxegt4mqRCMR965UMTR+8MxrDztae1iUqPvPYrD4dvr4B69F1AuUntxvz73+tzaicEFT
         MeGkvCtCgoHB5fIZTHLkWMquJEz4uFEbNeYlcjghArKwOZ3wBTdikM4XkHx6YPE1ifJm
         yEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD9MSEk9daW4cqdY2jf/MSQE0CWeuPy5ffaqqG4xnRk=;
        b=BrrY6JToS4PVbG33p+CYHHWwsAswNPqSd9XkcQNh/0TtLclDx5q8aZYLWJCbyrEZsm
         YMjLRfqGHCVFIFed0Iwb0R4Qx/IRpCOWWfczzjHs8EG2fIrRZ7Pdc7jqRW4MJ5q/eXvp
         rXlux3DyXL125vMO2C00I87LBEk80JeboC4Mle9DJSdpqMfZdWkPm6YA1pi69SwsQXHF
         VlQ4OG0kUDhZwgvXxCOuk298ovqXR3CLxncWqiY3x/nmCLK+xL1BwoECg3caE0x+nt5J
         HFaZzUmsdvuwr15FoE2DZbdnGRN7A47rwU3D8mtkVpRa2XguxZ13rK3pUkmU5LtS1Exe
         iBOw==
X-Gm-Message-State: AOAM530kT6hmvD4QhAUikSLUTHYyQmevWk7V5+ZxjcZXERgBCuTZftUv
        TG0+aiQjNW4//AlMzVHkpTE=
X-Google-Smtp-Source: ABdhPJwtt+VGC514k6+e0UasR0Wv2dHoDKloWioR7kAX8xkxuaiRwzo8O7JH+CqnsvtL/1GNEc4/nw==
X-Received: by 2002:a05:6000:1141:: with SMTP id d1mr13637129wrx.342.1638443294334;
        Thu, 02 Dec 2021 03:08:14 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id o5sm2163495wrx.83.2021.12.02.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:08:13 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, peter.hutterer@who-t.net,
        roderick.colenbrander@sony.com, dmitry.torokhov@gmail.com,
        pali@kernel.org, rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/2] Do not map BTN_RIGHT/MIDDLE on buttonpads
Date:   Thu,  2 Dec 2021 12:08:05 +0100
Message-Id: <20211202110807.6783-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset implements the changes to buttonpads discussed in v1:

https://lore.kernel.org/linux-input/YacOmYorwAIB4Q3c@quokka/T/#t

I'd be great to know if maintainers are interested in migrating the
other properties to use the new function (input_set_property).
If so, I can send the patches :)

Thanks,
Jose

José Expósito (2):
  Input: add input_set_property()
  Input: set INPUT_PROP_BUTTONPAD using input_set_property()

 drivers/hid/hid-alps.c                   |  2 +-
 drivers/hid/hid-asus.c                   |  3 +-
 drivers/hid/hid-elan.c                   |  3 +-
 drivers/hid/hid-logitech-hidpp.c         |  2 +-
 drivers/hid/hid-magicmouse.c             |  8 ++----
 drivers/hid/hid-multitouch.c             |  2 +-
 drivers/hid/hid-playstation.c            |  3 +-
 drivers/hid/hid-sony.c                   |  4 +--
 drivers/input/input.c                    | 35 ++++++++++++++++++++++++
 drivers/input/keyboard/applespi.c        |  2 +-
 drivers/input/mouse/alps.c               |  3 +-
 drivers/input/mouse/bcm5974.c            |  2 +-
 drivers/input/mouse/cyapa.c              |  2 +-
 drivers/input/mouse/elan_i2c_core.c      |  2 +-
 drivers/input/mouse/elantech.c           |  6 ++--
 drivers/input/mouse/focaltech.c          |  4 +--
 drivers/input/mouse/synaptics.c          |  2 +-
 drivers/input/rmi4/rmi_f30.c             |  2 +-
 drivers/input/rmi4/rmi_f3a.c             |  2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c |  2 +-
 include/linux/input.h                    |  1 +
 21 files changed, 57 insertions(+), 35 deletions(-)

-- 
2.25.1

