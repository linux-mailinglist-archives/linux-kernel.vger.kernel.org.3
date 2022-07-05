Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629F5664FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiGEI1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGEI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:26:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F2D70
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657009618; x=1688545618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KRGH97hZOaK/7TS9ETvdk4aZ2Fxhku9Kw9ji7wzl4OQ=;
  b=W3qqkF5aYY7LsOjQ4T2rC0IMp6V7/Il3tXCeHh7qaBeYz6MViqWfxY0L
   V/eMzew+fjpYdKljR2DMfw6PWWX/ZeYxEO9qzoaRVQlADNlR4g1FJn/96
   gpqk981PL3aV0bowBAKlWuyfNoWj24hTNB3ak2lnHOSN+nWDfQ58hu8EG
   wV8GyRVSxZamhHJbP3J9yfVFt/PdVI4Y1lduppJQe05JJvY24GEZzXIlU
   jxcD3Ujud9j/kDy1WZDj/OCfVTmOEAJF2cclRBSaSMzJA8UMcgn/oFS40
   ugjrzFUvFGS0gsOrdrV6CGjKO8I/H/LhoxU2omnb3/nq740jXJ0QhgbeI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263713123"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263713123"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="592834120"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 01:26:56 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/6] intel_th: Fixes for v5.19
Date:   Tue,  5 Jul 2022 11:26:31 +0300
Message-Id: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are a few fixes I have for v5.19, among which are 3 new PCI IDs. Andy
provided his reviewed-bys. Please consider applying. Thanks!

Alexander Shishkin (4):
  intel_th: msu: Fix vmalloced buffers
  intel_th: pci: Add Meteor Lake-P support
  intel_th: pci: Add Raptor Lake-S PCH support
  intel_th: pci: Add Raptor Lake-S CPU support

Christophe JAILLET (1):
  intel_th: Fix a resource leak in an error handling path

Jiasheng Jiang (1):
  intel_th: msu-sink: Potential dereference of null pointer

 drivers/hwtracing/intel_th/msu-sink.c |  3 +++
 drivers/hwtracing/intel_th/msu.c      | 14 ++++++++++++--
 drivers/hwtracing/intel_th/pci.c      | 25 +++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.35.1

