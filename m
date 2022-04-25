Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8950E7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiDYSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiDYSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:01:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35443EF9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so6134117edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6noJ6tvaokO4u8mHwJ9w/N757Ijrb2vwZu2W/LD+HA=;
        b=P7up2SYkbQdWH0attZX80NBKHV1I8wXsL/5Q6VvZaG5up02+7EiHNR9P/VRUyzP+/p
         ZzDetWi6htFL814czHR1K8VdEgaFTIStQjmSDBFJXQe7FMajvalkbjjxXifne/AEgnBd
         PgYNZmLvcD7Xskor8i7vBg4HfpOUtVQqCxvDYz08VR323XpnpYluBxHzskQzSY2UonWP
         jcdgGWTGqfq2p+Us3Oue5m9ScpYq6EKa9ngEBaprEDCaHUzk1GmFO4SFLITUEe6HTFA/
         NvmFJaxgod4WbPMGYrn04L3qY9rsJ+31QIKhFF96DsoGN8LbS9tilSaGWDPh6gXacTeD
         O24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6noJ6tvaokO4u8mHwJ9w/N757Ijrb2vwZu2W/LD+HA=;
        b=moLKReTihWCo0DVgIEkd70z+xFeszBCUjtfHrm1ZqXOJmsAWRyROPr+iLKKS6IHf7L
         hvr2xg8+sCKaMNh7q0NbHVkgIfBLxZZ4Kd3n8O5GcctoBOU/WTKW/xKzEIU5DtJ7du/t
         NZc/hbGzejVyVsKbx92EJ5/+ITmR4lN5NbG03UFGwUSMUELAnE368Sg8bILsPHfdQpLO
         3axnq2t42K4hn5UMo4aDcRJNLN7axtvmOYoB1CLLAHd7YWvf5cikg5lr372QsVvtcb4t
         +XFY1WAfV6tFukDeJOTHWfgGXCEu8ogz8Z9vxjNClVGcByfMrV064li2eJLM6h/BgAjE
         m9xw==
X-Gm-Message-State: AOAM5312uo7dRpkfbpBEd/d+mKsNydQfmSK4AQrt1YFVDgIkjMATjapH
        Y0BaSx39MbaQVfYfkCjw8do=
X-Google-Smtp-Source: ABdhPJzHtThWpw/7SNHkVA3b3CKT6+k7h7GY8DhlUIUrBaSFzmKGetmCP5AQYIPS+8BGGdzo1lILsQ==
X-Received: by 2002:a05:6402:2291:b0:425:deb5:73be with SMTP id cw17-20020a056402229100b00425deb573bemr9147572edb.392.1650909478450;
        Mon, 25 Apr 2022 10:57:58 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ia5-20020a170907a06500b006f392df973bsm1497207ejc.107.2022.04.25.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:57:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/3] binder: Use kmap_local_page() in binder_alloc.c
Date:   Mon, 25 Apr 2022 19:57:51 +0200
Message-Id: <20220425175754.8180-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmap_local_page() in binder_alloc.c because kmap() and kmap_atomic()
are being deprecated and kmap_local_page() is preferred where it is
feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Furthermore, the mapping can be acquired from any
context, including interrupts.

Fabio M. De Francesco (3):
  binder: Use memset_page() in binder_alloc_clear_buf()
  binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
  binder: Use memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()

 drivers/android/binder_alloc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

-- 
2.34.1

