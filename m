Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A225A9B91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIAP1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiIAP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E174E38
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=F/GvseEq137pZJHZQ7hgUdLt9b3DLURYAa2xAVuvTr+40eODQKQW/W561A+1rPp+5BRpS6
        oFcAV/81cdxm8ENb6Bum0HtIK2QplkeiUsFZUfDPXPwMFLHadw17U2ymGLtPsoCDXCxpbi
        mvxfcFLd3bSosAhZF+HhbH/XXYAI/e0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-k_Sq3I8kObmnvgWCdrH6Ww-1; Thu, 01 Sep 2022 11:26:35 -0400
X-MC-Unique: k_Sq3I8kObmnvgWCdrH6Ww-1
Received: by mail-ej1-f69.google.com with SMTP id jg40-20020a170907972800b0074148cdc7baso6068786ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=JuGUHMeP8FTVnyamCettzyBLiQmQq94nHKj1b+tv6FPwnPQSDFLvxrms6VTpxUhpWW
         wtZ0ncaVus2vwkyzZPqtkxEKsXMUIqz3tXd98Qaoez0F/sbq27ln9tlshWEz7p4r7uCB
         HPLQqEZBF5JKroPuZzGNFUNkaAquGJFcfwXcTIdI0VYZ/eRgY2pRKU8oKwCmxU4grOX5
         iG4ZSOZPZVVStBHa9AfwaBCSXPauhWZDuWfutg2J5NTCZaj1Zj88ehjlg5xKUqzGcP53
         afCwdKtQhag51Ar/OhUwc53bdSqlvCbHbwoTLOV1EOO0ZRYYhLPYcgBJOzKn0y9CVUmo
         ke9g==
X-Gm-Message-State: ACgBeo28zGcyzv8J5FyZfIlFjYQYU5tOG/hmwOKUnJydxqv3TTp//y0k
        XE32ntO6oW7UFxgcrCWBVXmt+1yUFoRHHHi14C3xGUOu6nY+g3l94A8V6ASBtJ/feW5tM5hHWxe
        HiaaDTArlH/yIBaXXckWdndHo
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273243ejk.463.1662045994399;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QRSL2W4ltgrQ+2jhvMhXxgK8EO5Y0yo9Y0cYkz7dkRoZMMOmRYstqqGCjd+xE8U5lttpmRQ==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273233ejk.463.1662045994222;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:30 +0200
Message-Id: <20220901152632.970018-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of these patches is to avoid calling capable() unconditionally
in simple_xattr_list(), which causes issues under SELinux (see
explanation in the second patch).

The first patch tries to make this change safer by converting
simple_xattrs to use the RCU mechanism, so that capable() is not called
while the xattrs->lock is held. I didn't find evidence that this is an
issue in the current code, but it can't hurt to make that change
either way (and it was quite straightforward).

Ondrej Mosnacek (2):
  fs: convert simple_xattrs to RCU list
  fs: don't call capable() prematurely in simple_xattr_list()

 fs/xattr.c            | 39 +++++++++++++++++++++++----------------
 include/linux/xattr.h |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.37.2

