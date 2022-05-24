Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB210533344
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbiEXWK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiEXWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:10:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6C82140
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653430224; x=1684966224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F+feAdRIPxV0YvrrVp/PT8H8XfZ+9kRwvIudCvjphlU=;
  b=TWjIstwPbcIKB9K6xYeJeaONim5DjD0C9oGzwAZQ/WRjHuuNzyasNQnm
   CDN+963BU2R/80w8RzTbVNgxZmNr597wX4d1C/wD8dVFUD2HTAUeLVVP+
   uzzUNYyL9B194OdcOWFm6/svfGW9eSfAjp/FFc4bXS9tjPnrAHpyJuJLs
   y2wBWHlNxXEnwRGDJyFPWLHfZVwX3uqyu7odjV8yNejXun2iSTArxAdwn
   vq2/ydpvh0ww0Mt+CKa/H/4we8lEsqOtRt4FlQGHp0vVISYyV7ENL03qY
   I1fJ0cgqErTDRzm5wcP1PP6s0lxGp7vcvegxOlHEVl8Iip78D/y65iMC6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271236769"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271236769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 15:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="676596686"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 May 2022 15:10:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EE0B8109; Wed, 25 May 2022 01:10:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/3] Fix for load_unaligned_zeropad() in TDX guest
Date:   Wed, 25 May 2022 01:10:09 +0300
Message-Id: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the load_unaligned_zeropad() fix.

v3:
 - Rework load_unaligned_zeropad() fix: fail misaligned MMIO accesses
   instead of upfront exception fixups;
 - Add ve_instr_len() helper to wrap access to ve->instr_len;
 - Add Reviewed-by from Sathya;
v2:
 - Clarify RIP adjustments during #VE handling;
 - Fix early #VE handling;
 - Fix comment and commit message;

Kirill A. Shutemov (3):
  x86/tdx: Fix early #VE handling
  x86/tdx: Clarify RIP adjustments in #VE handler
  x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page

 arch/x86/coco/tdx/tdx.c | 154 +++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 50 deletions(-)

-- 
2.35.1

