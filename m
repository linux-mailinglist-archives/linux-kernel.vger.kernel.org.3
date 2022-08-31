Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC95A83EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHaQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiHaQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:59:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D30E0FD4;
        Wed, 31 Aug 2022 09:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1F19CE21A7;
        Wed, 31 Aug 2022 16:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38422C433C1;
        Wed, 31 Aug 2022 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661965108;
        bh=tZfN22S1Lxl3tbUEuVPncXdtkO44166H42D2+eKQcnY=;
        h=From:To:Cc:Subject:Date:From;
        b=coCKVdhzDhmWyMtp6GCC8uXi0gTkv5E/vTOeZiM83NFLAQa+E1QnzAT+QhgXmetVy
         OJWP4w0q6QzVVjKMRm5HfiGX1pzNuHirw+IO3J0mdX24lEf1sHhKlUSDFk9WWsrBXQ
         4chSataaa+BMfdqVjScabEPKjUSPmtpDB2yoHAScxWxi5wiwrkbtCIFTsIcq4T5eb5
         KA94f2rc0NK2dQBLpglTL+I5UBgx+JYOZKMxFv6Aswg54pUtOuzx/TFKDEPdR9UvYL
         dJGLeuxMsgpV2l7U06ZnikXYlLlWuRzkZkq5Y/mViKSxJaL5FHX3TLeb8oNay3vxXo
         LrS7Hw7F1FAXw==
From:   SeongJae Park <sj@kernel.org>
To:     jgross@suse.com, roger.pau@citrix.com
Cc:     SeongJae Park <sj@kernel.org>, marmarek@invisiblethingslab.com,
        mheyne@amazon.de, xen-devel@lists.xenproject.org, axboe@kernel.dk,
        ptyadav@amazon.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and flow of feature-persistent
Date:   Wed, 31 Aug 2022 16:58:21 +0000
Message-Id: <20220831165824.94815-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1
(https://lore.kernel.org/xen-devel/20220825161511.94922-1-sj@kernel.org/)
- Fix the wrong feature_persistent caching position of blkfront
- Set blkfront's feature_persistent field setting with simple '&&'
  instead of 'if' (Pratyush Yadav)

This patchset fixes misuse of the 'feature-persistent' advertisement
semantic (patches 1 and 2), and the wrong timing of the
'feature_persistent' value caching, which made persistent grants feature
always disabled.

SeongJae Park (3):
  xen-blkback: Advertise feature-persistent as user requested
  xen-blkfront: Advertise feature-persistent as user requested
  xen-blkfront: Cache feature_persistent value before advertisement

 drivers/block/xen-blkback/common.h |  3 +++
 drivers/block/xen-blkback/xenbus.c |  6 ++++--
 drivers/block/xen-blkfront.c       | 20 ++++++++++++--------
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.1

