Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04458E69C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiHJFIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHJFHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:07:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1631E83F01;
        Tue,  9 Aug 2022 22:07:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m4so25710475ejr.3;
        Tue, 09 Aug 2022 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=bCpmS8+/1egQCooQQ3as3vVr8d5Z062qoLdPw2AMxfk=;
        b=Ws0xIKbmOrSvv/GU3aU4TtHDjsGwi+4skIXyJw1BB+aefIIdDylvwl0J33PfZddEEa
         cY7EIfT1zmqNkz600Slda0hXQmBlzKpV4vuYYKTfHpTlxAVm2JJM7+JSNeNeXMcY53WA
         gKyAZsDBJy0O27RxhqyDKd9oEf/UCClgw/3dTvFesuPv/n/lcO4ZbhOzG1+RXc0vcpNM
         qQHVWNT1KDJ3++qnF0AJ9TX5xfO+TZYYoC/jjoAtfF+qxRAYpCpk3EjU+kh8/fiVPXI4
         KQW6MG4hh2wIcyiNYXkP7F8p5wSaXuNYH83KuLRYE0Po0OlLVusocwqAmLD5EHKP/xAZ
         ji2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=bCpmS8+/1egQCooQQ3as3vVr8d5Z062qoLdPw2AMxfk=;
        b=TD/MecD7GF5J2y6eRdbDTZWEtb4/a67m8+TZXAvh0YBZ0G1mpBEQRYjg9sKy0Oq6ut
         9JHFr+2c62InpG79UiVk59hMDGi6mOhHm4f8yACmQyijKZaUo9pj6TTp0F6Xtk0HlPIz
         QeINU7xQklq/grAaGpZOtDoiQ6zMcuEgV+3cvOPQv+kTIZR5gexHU471XhkeqEbYxGpJ
         wASSxJZa57FPt8FO/87d6BJKpuYQhv8YsWxA9mA5oj/U/njuqPtL/Xun6iEb1kx1wf0T
         8Jn1ujtxja89BYX/zwZRGzu07WoJv0BEK+iucUHeJ7KDhwMp7YL9F9Q8y0M8UEINNTt8
         RuCw==
X-Gm-Message-State: ACgBeo3E2Sw70QhhEL2pnZsz13BYDYJxgvhTSsvcDfje20R4l3/v34fs
        P9rfmXrXZzetXk+2IaBGcKc=
X-Google-Smtp-Source: AA6agR7A6pJB4+cJg9xZ39GJFciYKDsagwONe95BcFa0P2gL4hJaNt7U60kSZRtiOudoecQhFipbpA==
X-Received: by 2002:a17:907:6da8:b0:730:8ed5:2df8 with SMTP id sb40-20020a1709076da800b007308ed52df8mr19323388ejc.75.1660108065630;
        Tue, 09 Aug 2022 22:07:45 -0700 (PDT)
Received: from felia.fritz.box (200116b826504800504e9aff21bf95aa.dip.versatel-1u1.de. [2001:16b8:2650:4800:504e:9aff:21bf:95aa])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0043bbbaa323dsm7009781edb.0.2022.08.09.22.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 22:07:45 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/4] xen: move XEN_BALLOON_MEMORY_HOTPLUG to generic config
Date:   Wed, 10 Aug 2022 07:07:11 +0200
Message-Id: <20220810050712.9539-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing arch/x86/configs/xen.config, I noticed the following
note in this file:

  '# depends on MEMORY_HOTPLUG, arm64 doesn't enable this yet,
  '# move to generic config if it ever does.
  CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y

Commit 6c6685055a28 ("kconfig: add xenconfig defconfig helper") in June
2015 adds this note. Fortunately, commit 4ab215061554 ("arm64: Add memory
hotplug support") from December 2018 adds the memory hotplug in arm64, so
the precondition of this note above is now met.

Move setting the config XEN_BALLOON_MEMORY_HOTPLUG into the generic
xen.config now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/configs/xen.config | 3 ---
 kernel/configs/xen.config   | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/configs/xen.config b/arch/x86/configs/xen.config
index 8a6c88f48e75..024817bc4f0e 100644
--- a/arch/x86/configs/xen.config
+++ b/arch/x86/configs/xen.config
@@ -23,6 +23,3 @@ CONFIG_XEN_ACPI_PROCESSOR=m
 CONFIG_XEN_PCIDEV_BACKEND=m
 # x86 specific frontend drivers
 CONFIG_XEN_PCIDEV_FRONTEND=m
-# depends on MEMORY_HOTPLUG, arm64 doesn't enable this yet,
-# move to generic config if it ever does.
-CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
diff --git a/kernel/configs/xen.config b/kernel/configs/xen.config
index 436f806aa1ed..ea84d5b3122d 100644
--- a/kernel/configs/xen.config
+++ b/kernel/configs/xen.config
@@ -34,6 +34,7 @@ CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
 CONFIG_XEN_SCSI_FRONTEND=m
 # others
 CONFIG_XEN_BALLOON=y
+CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
 CONFIG_XEN_DEV_EVTCHN=m
 CONFIG_XEN_BLKDEV_FRONTEND=m
 CONFIG_XEN_NETDEV_FRONTEND=m
-- 
2.17.1

