Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9A508766
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378273AbiDTLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbiDTLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99D23F301
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650455581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OVnNCEb7L0hrjdhIhz7OebiuARPHiBJqLMHyxn+21sA=;
        b=g+DVwHRIP047UkHCqBNIdWsY2qVi+rGFelv2woe9sckqtxdR4hbzAh/QDHexMb0/EJAfYZ
        mEUPoHPtHcWeTkR7uDzk8STgq+CTyG9jP3UprF34z+Vj7ZfzHiFdUd12aR0B3H3BT9ILOB
        yASPnhnvP2pRfb68oP+mNf4OHfJL134=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-mIPkFa1AOkKfpzYXUYMxmg-1; Wed, 20 Apr 2022 07:53:00 -0400
X-MC-Unique: mIPkFa1AOkKfpzYXUYMxmg-1
Received: by mail-wr1-f69.google.com with SMTP id w22-20020adf8bd6000000b0020aaff5af82so329095wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVnNCEb7L0hrjdhIhz7OebiuARPHiBJqLMHyxn+21sA=;
        b=36UcVJgBvMtI6H1y2FNaWykIKp6yNh3VN+znHgPFLYDD3mJJXdLU9SxJe9X/odIpQf
         icH6GSODef8EV4oA29PkRQraGpyJOmQA2L4Lqq0MzMmZZoH0LKdhrLn0TLLUnJzFdtAc
         todhRiZrBJSraX2Q46fF4Y6te67rPJckAJ+6YdLquMSuK5j0e2vZ9h/yuqqn5lFE9aMz
         V2z8iiVcYYh0B9bEdy938LFgzFrOlL6uZLOVQpIkc8D1QJ8cEdx2i4dUXwUlbYSh7OiX
         IptYTLJR1K4Q+zVZEdTaPZiTk/R4s8Wtc38DYiy6HFjWtdd8HlgOeR+oK8Gp03vO9OEM
         oYuw==
X-Gm-Message-State: AOAM531NhcCtipCgV7AXqU2K3QzJzyzbHY651erkZNI333suR9FGRkWO
        a41ZOf0LQN8zZvl9lSEqJzZkP4VugK2UfLDuNSQaBpft0HGXGN3pF7hTw9HOrmTYe49J8NsZIjB
        4TMaSNyc3LvOK+kKqqpNrCvo=
X-Received: by 2002:adf:c805:0:b0:209:e1aa:87a5 with SMTP id d5-20020adfc805000000b00209e1aa87a5mr15116091wrh.701.1650455578891;
        Wed, 20 Apr 2022 04:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSPFT2VihyC2dyGb+74bH0OQQ7z7xm71J18Jj65SdA4jY9feHX55aLZJU+cLoZ46QUukeQ0w==
X-Received: by 2002:adf:c805:0:b0:209:e1aa:87a5 with SMTP id d5-20020adfc805000000b00209e1aa87a5mr15116067wrh.701.1650455578720;
        Wed, 20 Apr 2022 04:52:58 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m65-20020a1ca344000000b0038ec75d90a8sm18524191wme.2.2022.04.20.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:52:58 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v3 0/2] module: Introduce module unload taint tracking
Date:   Wed, 20 Apr 2022 12:52:55 +0100
Message-Id: <20220420115257.3498300-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

This is based on the latest mcgrof/modules-next branch.  I have decided
still to use RCU even though no entry is ever removed from the unloaded
tainted modules list. That being said, if I understand correctly, it is not
safe in some instances to use 'module_mutex' in print_modules(). So instead
we disable preemption to ensure list traversal with concurrent list
manipulation e.g. list_add_rcu(), is safe too.

Changes since RFC v2 [1]
 - Dropped RFC from subject
 - Removed the newline i.e. "\n" in printk()
 - Always include the tainted module's unload count
 - Unconditionally display each unloaded tainted module

Please let me know your thoughts.

[1]: https://lore.kernel.org/all/20220419150334.3395019-1-atomlin@redhat.com/


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

