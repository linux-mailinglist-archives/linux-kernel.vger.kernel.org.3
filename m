Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6315D4C45CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiBYNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbiBYNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:18:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD371BE0CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w3so7362550edu.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNKQXBj9qgqKygRIGrvHkQo4UpK/y1wrxU/iY6fQwa4=;
        b=TLWMNMXg4tI9HyRuBSlw/m+fQK50Om5wgQxH/qpNFsXth/BXV2zIl28u4w/vPzEkj5
         dwgCc9Mm+6bikCp9wuvmGO4JuxC+S3nsbqpzBYVSrLhIGB3PxGTSbZZS8dOIxWBS/uKN
         h9BeV2YOvqqyTEEJ6/c9q9WRfWQ2FnCAFcri1W2cwbEHKPFrAI1znS4X92nwsZKcDH92
         UK9lNi9CPfSyxpwcLDQaF3CtNB9EgR+UGRRfmrstPVPO6+5gj9Ci6r8Vz7c5BWurFA9B
         OwOtkX9IbGK8yqMkk8YTPcG6n8wQDEpoOY9EhgpSLRIALH9Q226KJEZeAhJMC8hglnmq
         KKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eNKQXBj9qgqKygRIGrvHkQo4UpK/y1wrxU/iY6fQwa4=;
        b=kqAb6j5gdNwknOfZcXEvqxwtDuI6XO8FwZORNq+6/AebQz7U0AOarQaAcge/MILTwj
         YvOMNSt+rIEL3KgcpvwVkQEJwHw8FV9K/1zZ9HxnPRSRvJ73lgL0vkse6cmFHjAMZaQ3
         yx+njvcXVkLIi3Hw9SI+74EBdJMdu3HjTIRlR/luSMahwna3tAuTwbmvkt+BsK+fFuS5
         UZEGVFkRS0iMDqYYFDQTE9f1g6a7RdqJwvrMADGQDUTgssnuL3V2kU/DRuKiQMDYzZYX
         N4NWMCmf96Y8N08ZovZkDbnUt6p4t1pYQ5lthkJvXYTrWN4YlShfBcy+hDVik1CNRE2h
         kdrA==
X-Gm-Message-State: AOAM5306G8MjB1gyb+q8EQx4HJmMWUi/w6Vz2Y76QyoMJwYpez5iNUs1
        +yTOnk8BiiMl6U+mCw/bp0bVrY7vVxeXxg==
X-Google-Smtp-Source: ABdhPJy8YUoBRzBYaUXWPgallFSz7v+ZMk5JhndQkknmdHjnmD9NQoxygXmjhi5f+RJmVzZ/pmxdEA==
X-Received: by 2002:a05:6402:84f:b0:412:d1ef:c7df with SMTP id b15-20020a056402084f00b00412d1efc7dfmr7210532edz.210.1645795053952;
        Fri, 25 Feb 2022 05:17:33 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id fd7-20020a1709072a0700b006d022741112sm969544ejc.204.2022.02.25.05.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:17:33 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 0/2] microblaze: Add support for reserved memory
Date:   Fri, 25 Feb 2022 14:17:29 +0100
Message-Id: <cover.1645795048.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sending two patches for adding support for reserved memory nodes.
Till now architecture ignores these nodes and normally use memory for own
purpose.
The first patch is memblock dump wiring to be able to confirm that
reservation is working properly.

Thanks,
Michal


Michal Simek (2):
  microblaze: Wire memblock_dump_all()
  microblaze: Add support for reserved memory defined by DT

 arch/microblaze/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.35.1

