Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2684684ED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384990AbhLDNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:09:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:44677 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355001AbhLDNJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:09:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="261138332"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="261138332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 05:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="461262120"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 05:05:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtUje-000J1h-Bp; Sat, 04 Dec 2021 13:05:50 +0000
Date:   Sat, 4 Dec 2021 21:05:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [RFC PATCH t-kristo-pm] HID: hid_prog_ops can be static
Message-ID: <20211204130518.GA65440@f51396ba56c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hid/hid-bpf.c:151:27: warning: symbol 'hid_prog_ops' was not declared. Should it be static?
drivers/hid/hid-bpf.c:184:31: warning: symbol 'hid_verifier_ops' was not declared. Should it be static?

Fixes: 1995666cad0e ("HID: initial BPF implementation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 hid-bpf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-bpf.c b/drivers/hid/hid-bpf.c
index 8792cb5eacd20..fd12a2059d66f 100644
--- a/drivers/hid/hid-bpf.c
+++ b/drivers/hid/hid-bpf.c
@@ -148,7 +148,7 @@ static int hid_bpf_prog_query(struct hid_device *hdev, const union bpf_attr *att
 
 }
 
-const struct bpf_prog_ops hid_prog_ops = {
+static const struct bpf_prog_ops hid_prog_ops = {
 };
 
 static const struct bpf_func_proto *
@@ -181,7 +181,7 @@ static bool hid_is_valid_access(int off, int size,
 	return true;
 }
 
-const struct bpf_verifier_ops hid_verifier_ops = {
+static const struct bpf_verifier_ops hid_verifier_ops = {
 	.get_func_proto  = hid_func_proto,
 	.is_valid_access = hid_is_valid_access
 };
