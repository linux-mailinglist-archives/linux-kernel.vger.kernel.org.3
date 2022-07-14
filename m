Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562B9575206
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiGNPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiGNPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CCCD114F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KAfZzaXnYv7OEcE1kDa0BJxr1W4FR0BFr3KGIcgK5Jg=;
        b=WU4rolIAjLcTwBBJDxJJJuW+aboNDvM9G3MbvcTVzkRKrfYPmBE9OUYf7XZgWyZWFC74eH
        lJube2V4QdgnQ0CUqk/BtsT79BikY8oaWq4Er0yEOzFGjixcZkQ+ra9BmxWNg/+zy66k+v
        D+MD1q03dUW7ZbVyK7+O1oUoHys7MIM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-OBNzKJWSOA-ASl2aeHos0w-1; Thu, 14 Jul 2022 11:39:36 -0400
X-MC-Unique: OBNzKJWSOA-ASl2aeHos0w-1
Received: by mail-wm1-f70.google.com with SMTP id r82-20020a1c4455000000b003a300020352so199404wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAfZzaXnYv7OEcE1kDa0BJxr1W4FR0BFr3KGIcgK5Jg=;
        b=iDY1OKJDs7+tDg7QxDzxzLiSl7mTnD5jd4HgUhdo1Sxi6Ff5dg5z71otBKLErWFSAp
         boWt7lFE3+GtfH9IX1eaRt8Hz3B4e0gA0DCEs2z4ZsR9Mp7oSuM2XuS+Eyt8+ozg3zfB
         vfQHx93+4Y1JdBaRIbDJ5Ier1w4NRDB4JTtZ0DocsAEMunGzePmshbtB2zjs3ezGFfNY
         /mM5kk9PCXGfMvQk8ks/WlvY/W9J58ZqtdBuTHAW56KOHL2e8aI26BIvyjPTlvYHfepZ
         hP54jY6GQtQyQxmt5kjUvL0A3gtA4b97LKg5JKtdDOzV3aNcOcVCNG9/TxIXSPo7HrQj
         bwDQ==
X-Gm-Message-State: AJIora897GskI3zjEhxY/FgtAdgwl4n1SYNI78gqDNNFa7u0TNU2SzfO
        I4UrdoGAaC8qxemSgptPwX/Z0NhMitiEvRK2RFNcOGQInoUc8XFTsNpnaUxfeJNLXv5SqUd/U4D
        YRduAAO1JX0BP3ECf5BQtzcs=
X-Received: by 2002:a7b:c4d3:0:b0:3a1:8fbf:f03f with SMTP id g19-20020a7bc4d3000000b003a18fbff03fmr15786622wmk.172.1657813174904;
        Thu, 14 Jul 2022 08:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssFje9JTaDAgNe5RdPrzlw4k+BLRSkczVLTXUldIbK9PhmS2JvLjyb0rBqD2o+5c4gi6PpSw==
X-Received: by 2002:a7b:c4d3:0:b0:3a1:8fbf:f03f with SMTP id g19-20020a7bc4d3000000b003a18fbff03fmr15786602wmk.172.1657813174719;
        Thu, 14 Jul 2022 08:39:34 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe949000000b0021d4694fcaesm1671279wrn.107.2022.07.14.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:39:33 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: [PATCH v2 0/3] module: Show the last unloaded module's taint flag(s)
Date:   Thu, 14 Jul 2022 16:39:30 +0100
Message-Id: <20220714153933.2095776-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Christophe,

In addition to the previous iteration, since this particular series does
indeed modify last_unloaded_module, I decided to use strscpy() as a
replacement for the now deprecated strlcpy().

Changes since v1 [1][2]:

  - Replaced the deprecated strlcpy() for strscpy()
  - Replaced last_unloaded_module[] with an anonymous structure
    i.e. last_unloaded_module.name and last_unloaded_module.taints
  - Ensured we modify last_unloaded_module.taints only when required

[1]: https://lore.kernel.org/lkml/20220627164052.2416485-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/lkml/20220627164052.2416485-2-atomlin@redhat.com/


Aaron Tomlin (3):
  module: Modify module_flags() to accept show_state argument
  module: Use strscpy() for last_unloaded_module
  module: Show the last unloaded module's taint flag(s)

 kernel/module/internal.h |  2 +-
 kernel/module/main.c     | 27 ++++++++++++++++++---------
 kernel/module/procfs.c   |  2 +-
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.34.3

