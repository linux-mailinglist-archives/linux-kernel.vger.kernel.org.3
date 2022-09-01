Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2B5A9B85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiIAP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIAP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB7248F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gkJGKge+6uIm46PgUxrIJL/kWjX9EjAB7hcnEhK4b9A=;
        b=f4MRXWcjOnf/sPRzmQDY2F0qh9Kwbn1/gdsyYxHtAFf+KBucfHCYHVAP1Uq/0/VvLcrykj
        9vSKYoNhWGupWiXrkdH2w1DpQiL3W1YYauAG5MNw2LmLjqC9nUeNfHrDImrsM593FP89PX
        g2BueVSGflDWlMH58OWLIRUmuJfIMcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-XCMjSe21Pq-D-_HNjdzt6w-1; Thu, 01 Sep 2022 11:25:01 -0400
X-MC-Unique: XCMjSe21Pq-D-_HNjdzt6w-1
Received: by mail-wm1-f71.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso9984739wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gkJGKge+6uIm46PgUxrIJL/kWjX9EjAB7hcnEhK4b9A=;
        b=AAOKrfSdTWPmWUCal8kP1LvVWnbswf/MRrn1Q13fobLxWDPWSpfHEzfx3JDl3gfQm6
         DCoAVUmS3BivuNMPylteDT06rYHC3HTPppWFet/SX0F89B1Jh4zJRxHCHe88lssRGWLg
         IIzVshiN9CI+ztVm9yhauoVODasywC02ZpGuUqBr7ZpnEpP0ivMpLHYnV01Wb87U1Mkg
         W1vtdnhaydZ1H6SSOvnZcZwn0jKW6DnIEzViBnbcsaUe5INz2pb6uJYCt5wjFlWfkKbV
         4kyiwCG97KzLf0wXGRXK/9j8DVe7zuLbkg8DC0jTiuqKRbPrZHnEm2lP+SgMOzJwpuCO
         v+oQ==
X-Gm-Message-State: ACgBeo0OV4lWDWv6shcdg12TRKE6qG0PbZ8Qzf9qVBUhyyh77Q7QnE0r
        kEjNboGnQQnuG8Kj9UyxXnZMBr5hDLyMNI4Nt75X8zpxlylPYlX1IkQcr1BhVCzK/WMmEKRkJyr
        lDB6KVtWGpvIa6iKZo/BjlxE=
X-Received: by 2002:a05:6000:100b:b0:226:d51d:8a76 with SMTP id a11-20020a056000100b00b00226d51d8a76mr13300038wrx.257.1662045899744;
        Thu, 01 Sep 2022 08:24:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7D2pBQa6pfEp9i4xzRkLxHK53YKbsNFHMdsRHn9fb5ph5CjPweWQ+Tg0xAgynsLsK19y/A6w==
X-Received: by 2002:a05:6000:100b:b0:226:d51d:8a76 with SMTP id a11-20020a056000100b00b00226d51d8a76mr13300029wrx.257.1662045899488;
        Thu, 01 Sep 2022 08:24:59 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b003a540fef440sm6203845wmb.1.2022.09.01.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:24:55 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     petr.pavlu@suse.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: [PATCH v2 modules-next 0/1] module: Add debugfs interface to view unloaded tainted modules
Date:   Thu,  1 Sep 2022 16:24:53 +0100
Message-Id: <20220901152454.2394228-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Changes since v1 [1]:

  - Replaced the use of module_mutex to instead mark
    a RCU read-side critical section (Petr Pavlu)
  - Added __acquires() and __releases() to support
    sparse context checking

[1]: https://lore.kernel.org/lkml/20220823193225.2072649-1-atomlin@redhat.com/


Aaron Tomlin (1):
  module: Add debugfs interface to view unloaded tainted modules

 kernel/module/tracking.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)


base-commit: 554694ba120b87e39cf732ed632e6a0c52fafb7c
-- 
2.37.1

