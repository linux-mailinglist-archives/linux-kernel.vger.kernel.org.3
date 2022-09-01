Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE65A8E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiIAGOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiIAGOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:14:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559C119C50
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:14:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so16180348pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rfsc9cuS38+eZMsArKgbRqvaboPWMn5Sb1iOWK1dEG0=;
        b=OHeKchS5mkrLxzRiKenDSGUGNVkF7TxBWk+PdfKk0XY0sFxy0a5+WgWwxH8IFtpvGA
         kfkKh20BMxQrxG1Qw1Tjmj9v2mi3Y1EE/sJzq41YuMr4kwCvPX8G+yekzPfMvs+mGbXk
         6YUaLkftoNjQ1ekcaVKx13JXWBnMdY4jWxkGNEk0qda8BLv5QpmK81eWzRXqV29hOBO7
         sTIk9HB/mPcjLNTcrdYafcDYZjFS4EISTFTH0sWcVIsCqkUAgyVurb/ZlGKIwQ67BO5Q
         vON8RYWQbO6VWHqgcLI1XrS5B9efrLbiJSSOwuWE6gjAfg0UGsJilVQnJW50ErP1LlVB
         eqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rfsc9cuS38+eZMsArKgbRqvaboPWMn5Sb1iOWK1dEG0=;
        b=P9UbCYbVVl9Z5QAh+L92mz+ypKohbmqvwrRyTf5BMRZDkPR6Zc1Dntj3259MUnm0Ks
         4C82f+Q5cULrH78yZLGtbXS8uRFIr74PiAXpBXqcYaLoaF2tW1Wx0bITFU+wiYN0un22
         MYOiLCNYP+iRbHEl7tvX4LDtMEdcBSevzIV7QIqE5KrH4NO3Ckhn4F7TN8zw3Bz4dNCd
         sZu+Rr9pF1dVt7wdUWf/9TxOph6vk7+F47H+aeq+eYRgEV3Ji3DJHZqLorKoeF+WpVSg
         aonQcMgQpqtGZYIi+pPnf2W4KFZccmN6/vJLCc1jjaxOArb8Fc+B0pAo6EpotPQtp5US
         TlYA==
X-Gm-Message-State: ACgBeo1d6CFegGXrqr63RCHPpqKcjUsAPcfRbnf2sMuYIGcNE+1a6C1g
        1/p71ZU9FArp0EU5fny+aad+Qw==
X-Google-Smtp-Source: AA6agR5B/y+efKOwgbEi3ycXd7ry2ucRy8Ouz6Ur5ou+RBv9emB4J98Caq2hrdc4K1+LrVFgcIyyYw==
X-Received: by 2002:a17:903:189:b0:175:4643:f862 with SMTP id z9-20020a170903018900b001754643f862mr5641658plg.5.1662012882145;
        Wed, 31 Aug 2022 23:14:42 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id k26-20020a63ff1a000000b004307ac80cacsm581497pgi.54.2022.08.31.23.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:14:41 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Thu,  1 Sep 2022 14:14:08 +0800
Message-Id: <20220901061409.545456-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Keep original function name as nvmet_tcp_uninit_data_in_cmds()
- Add new function nvmet_tcp_free_cmd_data_in_buffers() to free CMD buffers
- Rework against http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.0
- Move nvmet_tcp_free_cmd_data_in_buffers() after cancel_work_sync(&queue->io_work).
  Hi @Sagi, if you still prefer to clear the commands that are still waiting for
  data from the wire, please let me know.

v1 -> v2:
- Separate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.20.1

