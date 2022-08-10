Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A458E696
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiHJFID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHJFHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:07:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3610E83F02;
        Tue,  9 Aug 2022 22:07:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w19so25699175ejc.7;
        Tue, 09 Aug 2022 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=VbxQoe6fQMjbmMOpKGDHrB2IUNlWA7xE7c6RSpLy3Nw=;
        b=IC7qDwj3uhTT/tFcQhX0fl7EMLGTEXGn5oBMYiSuK2Mlf8TK/1vbV1vtnOGgnf5dt7
         PIW9KtfwJjkiVzT2qnmm15x0hvLxc6edoBw+yw5XxQxy4MrmKwkDrJOUsAnLN6qi8Lvh
         ygKmYs2LsXBhzP8VN0k6HSklP9GJHeSfjUveBAgL08trFsbKIp6pF4zuqiZtwQv1nR/M
         7XcLqDPUUv8/2hZbHDr+HiMz6NuhWE0aOGU9j3BZpwlgoWlFTZOrxvUeyk+wG88l0PFx
         8emfmV2xOpJa7WgWKj5xHL46rWQF4LBpc3wKzDezENR+Mwwb4q5rH6crmhQAdYfr8GLZ
         1dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VbxQoe6fQMjbmMOpKGDHrB2IUNlWA7xE7c6RSpLy3Nw=;
        b=bAUZwQyrkJz4OkfJOfpnu/ryVRqNlH0MUiUpK6xQ9jmwLrnyXcsd3Oq05Uj5eukxyZ
         UbjT1ouxEL2JmHFDChS+sRNQPFM6IN4l9MsvVgGlZn9AWfo/wN0Xwe11hFI6U9gX7UzA
         ldwvJd11ce+nr/JS0Nv1+jVzosMaJYuVR/DbEMEJUygvy9GsawsZdYz7505zDUh78twZ
         tm5lUQnFeyj9m9TMjKs0dvveNug0Kc1ACX+t7z1A+lrzZgXkllV28GR4iOY0+45MML7J
         orJuzl2TqSX42n9yzTigSEohPtCfcJWdUPHqix4JdV8PW9dARc2jo19deqaija8qjvt+
         woQw==
X-Gm-Message-State: ACgBeo0BkEPtHrZF+ZltOa1Rzh1j/lQ89KmCi6gSWW8uQrcnBMsf2x2n
        dT9DZoCxQEvtDXwgGM79W4I=
X-Google-Smtp-Source: AA6agR4Ilc9Mmk6bCf71q9Y4U7vONUnnGKet9rfY352UzgsL/7b2MdbpGf+DD7cnLyWAO/IqoW1hNA==
X-Received: by 2002:a17:907:608b:b0:731:8a9d:5a2d with SMTP id ht11-20020a170907608b00b007318a9d5a2dmr5099609ejc.443.1660108057768;
        Tue, 09 Aug 2022 22:07:37 -0700 (PDT)
Received: from felia.fritz.box (200116b826504800504e9aff21bf95aa.dip.versatel-1u1.de. [2001:16b8:2650:4800:504e:9aff:21bf:95aa])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0043bbbaa323dsm7009781edb.0.2022.08.09.22.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 22:07:37 -0700 (PDT)
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
Subject: [PATCH 0/4] update the xen config fragments
Date:   Wed, 10 Aug 2022 07:07:08 +0200
Message-Id: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear xen maintainers,

here are three patches to update the xen config fragments to the currently
existing configs.

The fourth patch is just an addition to MAINTAINERS that I saw reasonable
after get_maintainers did not point to the XEN subsystem.

It applies cleanly on next-20220810.

Lukas

Lukas Bulwahn (4):
  xen: x86: set the config XEN_512GB after config change
  xen: remove XEN_SCRUB_PAGES in xen.config
  xen: move XEN_BALLOON_MEMORY_HOTPLUG to generic config
  MAINTAINERS: add xen config fragments to XEN HYPERVISOR sections

 MAINTAINERS                 | 2 ++
 arch/x86/configs/xen.config | 5 +----
 kernel/configs/xen.config   | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1

