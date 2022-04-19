Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD4507156
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351433AbiDSPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiDSPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC29A387BA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650380619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wdgc8+Jlkud2HKsKZGyCgaHz11AGlGgnG09+kOT/gAQ=;
        b=KFlYm1gUwSVzTfj7nbxR1e0N0laQXkFDo7cF8HhS3lrLE5AKGseliaTsZcFPUPDpeUlrJf
        u7CMOOKcW7vfSoJJuu6YaeBdjleQ8crw2rAltjZ/vOqxWwpK1p7Clxz8rP6upjkTgykh7Z
        RWDPISRs5nyv7J21+7VEYXQz0/o3m/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-o6Jjt4BhOk210mS78vhrmw-1; Tue, 19 Apr 2022 11:03:38 -0400
X-MC-Unique: o6Jjt4BhOk210mS78vhrmw-1
Received: by mail-wr1-f72.google.com with SMTP id v9-20020adfc409000000b002079e379921so1985927wrf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdgc8+Jlkud2HKsKZGyCgaHz11AGlGgnG09+kOT/gAQ=;
        b=NiVIA1G5k0LMYQO/l6KrbqFtuC4T53gq833k3MD31x82m/eEMHPhgDKq7sZErc7IOd
         aexm79bId4fTYjF0a1zOSN/pL8ZqwveADM1GRQWXbYJQRH1Na5XhD4W5+hSvm6eN/kxn
         ArjG3eL8Jon0UtPPkCghSKIAxYu2NZ4ie7jSPNNs2TeE4sA4RbyNGKF5OLq4nbz6229j
         x2PD/FaopbmWKQOCRi5Q45dkyccEKgluqnxUHN5Lb8XzWNEx3tmIu9x/dIaEb0lLPSY+
         Yr5xShmWjwMFmz85yVESBaBItzdx1k3lPLpSO5IaOiQbb1rY5x7T9XDCCVxGJfQqpwtL
         pn9Q==
X-Gm-Message-State: AOAM532FOPl5cVM1aMDefjvRHjmytWDGyIqTeJ+BmdVSBfR7ONn13rcB
        p6BuRwRpRufXsW3jObRcYNOadBLjm6p8acdkTp+MSEZb5FrXpmne0VI+1YbT2ZjNK1oLN6k3ki5
        6igAfXBBzUUQ4aHeoNHanQYs=
X-Received: by 2002:a05:600c:1509:b0:38e:d707:90cb with SMTP id b9-20020a05600c150900b0038ed70790cbmr20523224wmg.120.1650380617408;
        Tue, 19 Apr 2022 08:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2ziGx3Lw6HBDHRjm2DJbZkMnC5LWN/djK8YHVTkTUf2U4LXgEFhnvzk761V3e1ivfpgFJgg==
X-Received: by 2002:a05:600c:1509:b0:38e:d707:90cb with SMTP id b9-20020a05600c150900b0038ed70790cbmr20523192wmg.120.1650380617153;
        Tue, 19 Apr 2022 08:03:37 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm19052973wmj.11.2022.04.19.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:03:35 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH v2 0/2] module: Introduce module unload taint tracking
Date:   Tue, 19 Apr 2022 16:03:32 +0100
Message-Id: <20220419150334.3395019-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Please let me know your thoughts.

Aaron Tomlin (2):
  module: Make module_flags_taint() accept a module's taints bitmap
    directly
  module: Introduce module unload taint tracking

 init/Kconfig         | 11 +++++++
 kernel/module/main.c | 76 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 4 deletions(-)


base-commit: eeaec7801c421e17edda6e45a32d4a5596b633da
-- 
2.34.1

