Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB8517892
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbiEBUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387386AbiEBUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB98658B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651524669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0wKFUq13zqQdskdZIBn2gF7koYBC+NMc0iylMNjibNc=;
        b=HGrtJaOgEHSpjTNrkv7x5ilZ7yOfhSLnchKGAkj55ljGEtzNuVRtWp1xj3iXp8H/TeLZ9p
        W2I9NDp62/r26vVAyaM1NqSXo/NuzQi6a7yQoXLN786Di/sBac80HBLfhrJv/IAEBNDN+k
        wI5SiDXY9eqtdWPHNKQ5uASBo+0vm38=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-N0xI_w4KMo-xWTTB6vW55Q-1; Mon, 02 May 2022 16:51:08 -0400
X-MC-Unique: N0xI_w4KMo-xWTTB6vW55Q-1
Received: by mail-wm1-f72.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so227309wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wKFUq13zqQdskdZIBn2gF7koYBC+NMc0iylMNjibNc=;
        b=oksxq0tFEc82236HA2JyFDCuBBLfYom3CAIvq8wF81Nhjvj5myX8RsflD+kdXLlguW
         RIukar39kjjjvXeVSOftm+w8LF/AiY9ovBLde9owWa3l1TX5e2+kAUo4JQ+yAOUHIwv7
         sdUtby3+IHeXznwG3uRBKOQeSjepc1fje/YeCFND0aF/3rXh8yLWGJWtcVQFHchpfSCl
         StI7oOUUF6E1k9VQU5xZhnhUNAd76TBm15WXA/+qQgk8ciWuMVclY307c4ccRecJy1zP
         KBpm//P284LXEVTcVWv/EgIbnV+vv5PYuxqe2DhQr98FvpGUtqSmLQ8kWuGfQeHboOta
         GkVg==
X-Gm-Message-State: AOAM533hWmAr48g8q0vT9v/6ilxJ17+AysSdRRKABvtKTABm1rFGpm/p
        XT4jrZMjYi7z7xSyopIEVXT2+D4uwg6nLrTpNUMqoYhAoa/GQ7x1x7i778Y9DqvowAjCc/0HIO+
        geV4kr3pPs2sqIK+0tDbc2WU=
X-Received: by 2002:adf:9dce:0:b0:20a:c019:ad4 with SMTP id q14-20020adf9dce000000b0020ac0190ad4mr10460789wre.591.1651524667448;
        Mon, 02 May 2022 13:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfJnjFTq5nRZ3jJoTJR8UjDqs+6NIt+IXGSzebRJ4J3US39T8mwtOsKafatgXf5/RI0zAlLg==
X-Received: by 2002:adf:9dce:0:b0:20a:c019:ad4 with SMTP id q14-20020adf9dce000000b0020ac0190ad4mr10460775wre.591.1651524667255;
        Mon, 02 May 2022 13:51:07 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b0020c5253d8bcsm7802314wrb.8.2022.05.02.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:51:06 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v5 0/3] module: Introduce module unload taint tracking
Date:   Mon,  2 May 2022 21:51:02 +0100
Message-Id: <20220502205105.919523-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

This iteration is still based on the latest mcgrof/modules-next branch.

I have decided still to use RCU even though no entry is ever removed from
the unloaded tainted modules list. That being said, if I understand
correctly, it is not safe in some instances to use 'module_mutex' in
print_modules().  So instead we disable preemption to ensure list traversal
with concurrent list manipulation e.g. list_add_rcu(), is safe too.

Changes since v4 [1]
 - Moved code to kernel/module/tracking.c
   (Luis Chamberlain)
 - Used only strcmp() in try_add_tainted_module()
   (Christophe Leroy)

Changes since v3 [2]
 - Fixed kernel build error reported by kernel test robot i.e. moved
   '#endif' outside 'if (!list_empty(&unloaded_tainted_modules))'
   statement in the context of print_modules()
 - Used strncmp() instead of memcmp()
   (Oleksandr Natalenko)
 - Removed the additional strlen()
   (Christoph Lameter)

Changes since v2 [3]
 - Dropped RFC from subject
 - Removed the newline i.e. "\n" in printk()
 - Always include the tainted module's unload count
 - Unconditionally display each unloaded tainted module

Please let me know your thoughts.

[1]: https://lore.kernel.org/all/20220425090841.3958494-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/all/20220420115257.3498300-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/all/20220419150334.3395019-1-atomlin@redhat.com/


Aaron Tomlin (3):
  module: Make module_flags_taint() accept a module's taints bitmap and
    usable outside core code
  module: Move module_assert_mutex_or_preempt() to internal.h
  module: Introduce module unload taint tracking

 init/Kconfig             | 11 ++++++++
 kernel/module/Makefile   |  1 +
 kernel/module/internal.h | 34 ++++++++++++++++++++++
 kernel/module/main.c     | 24 ++++++----------
 kernel/module/tracking.c | 61 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 15 deletions(-)
 create mode 100644 kernel/module/tracking.c


base-commit: eeaec7801c421e17edda6e45a32d4a5596b633da
-- 
2.34.1

