Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2558AB2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiHEM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHEM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03722BD1;
        Fri,  5 Aug 2022 05:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CACD3B828BD;
        Fri,  5 Aug 2022 12:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E78C433D7;
        Fri,  5 Aug 2022 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659704269;
        bh=XY/seUO2FBE4LU769qrgj31/ob2I4U4o5EZgccv/cEU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZzvNB/E6ZhpeCFStq9xeHuoZr0khrgjwoLQWhDmbtKdH8lNiRX16PvyeWnIR/Gi/G
         IYM+CBQd5trG97Rn4z2XrGZpefngNCDyy2Y88taKDJVSCs8ijhg/f0Nxm+TsUvWBBt
         iqTT4Sek9KWgSGDG3xKGlVTk3JC5waxw8dXMPOstr91YTqyH+F42OYW7DaYYZoRult
         OwRpSq9TuwjHHHXYN3XZ0TKsSPWfUOIHuFAscHiYwBp2vkYAE2gnJTih/zPgaGGikH
         NARvcCCGT+gf87Wtg6xWeyvOsdUXmuCuBS6tYwYpfwC3JAi9Kv3T2Taj4ll2bnzWHi
         jEPzf0blRGblg==
From:   broonie@kernel.org
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nathan Huckleberry <nhuck@google.com>
Subject: linux-next: manual merge of the device-mapper tree with the origin tree
Date:   Fri,  5 Aug 2022 13:57:44 +0100
Message-Id: <20220805125744.475531-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  drivers/md/dm-verity-target.c

between commit:

  b6c1c5745ccc6 ("dm: Add verity helpers for LoadPin")

from the origin tree and commits:

  ba2cce82ba1ba ("dm verity: conditionally enable branching for "try_verify_in_tasklet"")
  5721d4e5a9cdb ("dm verity: Add optional "try_verify_in_tasklet" feature")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/md/dm-verity-target.c
index 4fd853a56b1ab,981821f18a18c..0000000000000
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@@ -16,6 -16,6 +16,7 @@@
  #include "dm-verity.h"
  #include "dm-verity-fec.h"
  #include "dm-verity-verify-sig.h"
++#include <linux/jump_label.h>
  #include <linux/module.h>
  #include <linux/reboot.h>
  #include <linux/scatterlist.h>
