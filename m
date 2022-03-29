Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A94EA6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiC2Eyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiC2Eyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:54:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C753587B;
        Mon, 28 Mar 2022 21:52:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j13so16576517plj.8;
        Mon, 28 Mar 2022 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cn5Hv/ZbYD+xp2LZxzR8cBJSv3MLt46oZ80SDrAJKl8=;
        b=lIwSAhNQCFILvYvRA3aqlSYAy3KW0RcWwLptXWtg49/LUC7sNEIKiFvD1fGZUyRHjZ
         GqG5Xv0C0tMPcVrBBCqsAMrbfDndRQNSfyaFV6rHonu85Czx0Qbb0oVe0rgm4Ggd39Uq
         dmQXWlDT8wYLww7C9+rO9PDqnF42pK4jBoYQ2/dYmA/ezMVdqALjT3dc5WHwAWNDnb5d
         6y5L85zKsbvGmWR8WT0SpCOmqf8ikNOMtnyDIDhtgBK+VoRl38hGdgpbYiavmBqPQCe/
         gwqvGfHeS8TXD3d52d1ywQjXJm5NPnCHLFrIIURA+YPcmUgJ1Hwn1U+gdr4OTXr8x5NA
         hj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cn5Hv/ZbYD+xp2LZxzR8cBJSv3MLt46oZ80SDrAJKl8=;
        b=UK/z+p31ElfONkELAp4BWWt7Kd+EILzGZ3tN55Qxx6zfuS+6ZPmi0AYzHHmWcGjAFz
         kwmnwGU045MZwhscxXqrLt0TWMt+ZJC7oZ1eZ4IuEcB8rYxVHN66BCKJWhHD2NmnQbZK
         x1oliZCo0eD9Guz444Rq/i5Bvdv6yHBxTRPbz8Ki7KHdoEdy4tz+hlyMG8Q+Q08Ovwlx
         OrMiQhCQ8lTWPEqXbMIV4ot1cKz7Y/7QXlvNTCYk7uVZdsDWnjQxlMhjsjm62bM/EIoP
         3hCneUxIvHZAhcjFCs+q1Ytq60pIz7FDGrnIhmN5uts5NclEk1dJNCIbQ2VDTXrP4K7u
         1B6A==
X-Gm-Message-State: AOAM5310z/4xx5yKx4YcsQl4zt7VpEobCgKUPEhlHoEOWH/uzrMtyFQR
        KshcaRB1EeQwNxQHRS1w+/sxuQi88+A8pG49
X-Google-Smtp-Source: ABdhPJyZZH9mDfh0m8GiECnPTskINIPoRPBf+5JV6ac625BsfoWiJx1AcxN7VS3pcoT1I91gnc2XIw==
X-Received: by 2002:a17:902:ec86:b0:154:4f9:f938 with SMTP id x6-20020a170902ec8600b0015404f9f938mr28514719plg.5.1648529569775;
        Mon, 28 Mar 2022 21:52:49 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00229000b004fabe756ba6sm19327282pfe.54.2022.03.28.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:52:49 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Documentation: kernel-doc: Promote two chapter headings to page title
Date:   Tue, 29 Mar 2022 11:52:34 +0700
Message-Id: <20220329045235.11879-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329045235.11879-1-bagasdotme@gmail.com>
References: <20220329045235.11879-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Promote "Writing kernel-doc comments" heading to page title, in
accordance to kernel documentation guidelines. Also promote "Including
kernel-doc comments" heading because both headings deserve their own
chapters in PDF output.

There is no differences in the resulting output except formatting
semantics.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 79aaa55d6bcf2b..a7cb2afd799007 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -1,3 +1,4 @@
+===========================
 Writing kernel-doc comments
 ===========================
 
@@ -436,6 +437,7 @@ The title following ``DOC:`` acts as a heading within the source file, but also
 as an identifier for extracting the documentation comment. Thus, the title must
 be unique within the file.
 
+=============================
 Including kernel-doc comments
 =============================
 
-- 
An old man doll... just what I always wanted! - Clara

