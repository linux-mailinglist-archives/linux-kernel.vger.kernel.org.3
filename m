Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1140050DC11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiDYJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDYJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B2DC8BF6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6IxRjRB41v18WEn6vHUhiDMX+StIsa+8fu/06wlL/FY=;
        b=ciNbIcj3IjZKc9uJZb3A/NyPLlH6I7kgONAATqDIp5/PF4f4WDRAYS+GibA6UnhbOAJL9H
        61HT1Z5mvu+psyVfvAKyosCznlSifmym+TGYvzPR+dKEmA+pHb2t1xZyvx6xAVpi1Ie4bR
        huAawmUCnA+WymXRDdfTzBFCNHO+AhI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-OR44A3qOO1WOWK-3s2oN-Q-1; Mon, 25 Apr 2022 05:08:44 -0400
X-MC-Unique: OR44A3qOO1WOWK-3s2oN-Q-1
Received: by mail-wm1-f69.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so10016820wmh.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IxRjRB41v18WEn6vHUhiDMX+StIsa+8fu/06wlL/FY=;
        b=H/8/UCpEkjIzfnsObB1GgDpcbT+zGlTKrosQx18KSsQnTIVL7kWopWDfOnQWoLhzQM
         uMy1wxxwWy6gs1C9slVxwHmXd5s9TrzDMVIyLvnO8k/lkx2xrNdxONd+vah3MW8kVGrS
         aVfMNO0ycXscDszgpjuOfiuti9GI+E1YupQK6HkhzBjqnK/RJb8ltfcODGvHjNiHaqBi
         M5Rx+fZid5zHCa/oRUJ7EOCiq+DzUJH6OH6bnlDP7zB202zbRV6q9ZTwTbzs9CLVNjIK
         FTKaKoxkgWK9ybl7UsDLve2CIPBNDRX+OjiXTXFxUdBUQZyltPAD/q8doo54WuwvW7cQ
         AOjg==
X-Gm-Message-State: AOAM533zDPJ4claeMnBWYqTiiHzPOdb7R06mA76VqcaQYw1tE04+ATm4
        afUE9mNeYZiaTKUSISz58qC/kL7ynts+LZBHV1Y2Ic5WH44IGDpt8P14jLSE/0fWJZCeuhgozBa
        8oTry38eErt3PoY9SHAolPgY=
X-Received: by 2002:a05:6000:156e:b0:20a:9665:ca9d with SMTP id 14-20020a056000156e00b0020a9665ca9dmr13504094wrz.172.1650877723540;
        Mon, 25 Apr 2022 02:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5w7x5QuM84CUzQqovJHH6U4GRE8z7DR6dwYK8V1xZOrSNBrv7RxqjfOXMeGvFJZL3N/Q+cQ==
X-Received: by 2002:a05:6000:156e:b0:20a:9665:ca9d with SMTP id 14-20020a056000156e00b0020a9665ca9dmr13504079wrz.172.1650877723288;
        Mon, 25 Apr 2022 02:08:43 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd849000000b00207b8b1cb0dsm8063898wrl.112.2022.04.25.02.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:08:42 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v4 0/2] module: Introduce module unload taint tracking
Date:   Mon, 25 Apr 2022 10:08:39 +0100
Message-Id: <20220425090841.3958494-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v3 [1]
 - Fixed kernel build error reported by kernel test robot i.e. moved
   '#endif' outside 'if (!list_empty(&unloaded_tainted_modules))'
   statement in the context of print_modules()
 - Used strncmp() instead of memcmp()
   (Oleksandr Natalenko)
 - Removed the additional strlen()
   (Christoph Lameter)

Changes since v2 [2]
 - Dropped RFC from subject
 - Removed the newline i.e. "\n" in printk()
 - Always include the tainted module's unload count
 - Unconditionally display each unloaded tainted module

Please let me know your thoughts.

[1]: https://lore.kernel.org/all/20220420115257.3498300-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/all/20220419150334.3395019-1-atomlin@redhat.com/


Aaron Tomlin (2):
  module: Make module_flags_taint() accept a module's taints bitmap
    directly
  module: Introduce module unload taint tracking

 init/Kconfig         | 11 +++++++
 kernel/module/main.c | 73 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 4 deletions(-)


base-commit: eeaec7801c421e17edda6e45a32d4a5596b633da
-- 
2.34.1

