Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0D5A167E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242988AbiHYQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242980AbiHYQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:15:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021E15FF4;
        Thu, 25 Aug 2022 09:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74FC1B82A21;
        Thu, 25 Aug 2022 16:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C59FC433C1;
        Thu, 25 Aug 2022 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661444120;
        bh=XyBLgn4uCh2rzAZM0VjsQj/nGaK5vZjLuP0BYgrnjyM=;
        h=From:To:Cc:Subject:Date:From;
        b=grFS/aMrCjdFegM+Ml+ScBgzeRNF4Xyvl1oPuxKLCoLPjMk6M3mKMe1zkZliXk/fr
         mltiLJUpC7/eM61LfFLCM9XlvZuzU+5fzI+NVz36p8nhj4S6cssk6SHODopLV/SlA/
         nW36rVQ/WTj80LXFyiNBVJKU8n+9q4m/jWQBPItuS239gW0bmW5T8vPSRgjFlet32R
         iTiCUuP6cgTi7kxNUmHNTOXyiZY64V1KYu3ZJ5P/D5XMLiNVereZROTcmTor8ygLBs
         WekZG7relWUBrdvm0mgicofCNSm5g2vlQrGOEb+b7rKTc/D50xwlaVBbRmHCH027gF
         oMZ/eSvVlXgaw==
From:   SeongJae Park <sj@kernel.org>
To:     jgross@suse.com, roger.pau@citrix.com
Cc:     marmarek@invisiblethingslab.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/2] xen-blk{front,back}: Advertise feature-persistent as user requested
Date:   Thu, 25 Aug 2022 16:15:09 +0000
Message-Id: <20220825161511.94922-1-sj@kernel.org>
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

Commit e94c6101e151 ("xen-blkback: Apply 'feature_persistent' parameter
when connect") made blkback to advertise its support of the persistent
grants feature only if the user sets the 'feature_persistent' parameter
of the driver and the frontend advertised its support of the feature.
However, following commit 402c43ea6b34 ("xen-blkfront: Apply
'feature_persistent' parameter when connect") made the blkfront to work
in the same way.  That is, blkfront also advertises its support of the
persistent grants feature only if the user sets the 'feature_persistent'
parameter of the driver and the backend advertised its support of the
feature.

Hence blkback and blkfront will never advertise their support of the
feature but wait until the other advertises the support, even though
users set the 'feature_persistent' parameters of the drivers.  As a
result, the persistent grants feature is disabled always regardless of
the 'feature_persistent' values[1].

The problem comes from the misuse of the semantic of the advertisement
of the feature.  The advertisement of the feature should means only
availability of the feature not the decision for using the feature.
However, current behavior is working in the wrong way.

This patchset fixes the issue by making both blkback and blkfront
advertise their support of the feature as user requested via
'feature_persistent' parameter regardless of the otherend's support of
the feature.

[1] https://lore.kernel.org/xen-devel/bd818aba-4857-bc07-dc8a-e9b2f8c5f7cd@suse.com/

SeongJae Park (2):
  xen-blkback: Advertise feature-persistent as user requested
  xen-blkfront: Advertise feature-persistent as user requested

 drivers/block/xen-blkback/common.h | 3 +++
 drivers/block/xen-blkback/xenbus.c | 6 ++++--
 drivers/block/xen-blkfront.c       | 8 ++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

