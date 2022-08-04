Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739D58972D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiHDEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiHDEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:51:08 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F32A949;
        Wed,  3 Aug 2022 21:51:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3263D2A219C;
        Thu,  4 Aug 2022 04:51:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A3D6F2A1DC2;
        Thu,  4 Aug 2022 04:51:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659588660; a=rsa-sha256;
        cv=none;
        b=taDfojgxfMtJTwFzsjsjC1c7NpuRDuORitNtaAWsPTGEeneJLwWU3ykkbsy1bCCSOENYvu
        bM5bFLMzMQmr7Z3K3V3XWZCG9N4iPHQyAGhPIWl88iilZ/WEFZdYPPFHQ/hLsmFSgBo3sU
        QoxRRBeBl9+ppg/MoWrP4QB7N+/t/IFTgm9arJ0wfpuSnuSJ0E3wuO83pnUoD+zoiPEkHa
        c5lEfOpZ7JO4C6o5KIUNaMluKocOThBiMZfW/itWfhP/k8kzz2HusBvD+6vH7ZGctSzYd7
        imVcNJnRRZeVVNF6JWgwf4fyfE4Z2Rv08p4UeDq1LziHNE24FhoUtel07vCL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659588660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=iCmPQoYRvy04G/hCSh521jn34l0VwQZYcXz6/uc2hjg=;
        b=uR2qpiSwj0E5CEH2k8BR4Fjl3SHTZBkKtf0xDE9RUbHpDjm01FgJDeLFU2ePWm3b4B2Xie
        w8wbDnd1kCxBsLNErmJgxpY4sJ1QxCJ25faFGftgokbNSxRKRLOHf6sMc4xe4mZtrcSTTM
        Rc8LNv60QnB7Lfb4TWiDaEAo1CdzkbUqCwGqlY1DWluGD0VoJc84KJsGk6rkb47U8JwEMA
        FVLuD68BLwvkTYZmz3e5lFFiLkzb/W3p5KdmeOaTShwjpdW2xg5xFZlsjWmjP8d8Rt50pP
        HQw9N6wjr0gRK8KyBk9f1r2LuBDL4M5BKl1WonxssHQUuG2hmal5g5TDajHw5A==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-n5hjn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Hysterical: 0e75192f67ff8f37_1659588661050_1260050735
X-MC-Loop-Signature: 1659588661050:1963300385
X-MC-Ingress-Time: 1659588661049
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.133 (trex/6.7.1);
        Thu, 04 Aug 2022 04:51:01 +0000
Received: from offworld.. (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4LyxBW51LCz2t;
        Wed,  3 Aug 2022 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1659588660;
        bh=iCmPQoYRvy04G/hCSh521jn34l0VwQZYcXz6/uc2hjg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=fxhygYR52m8OLblEPBjVczxowbeBvJy7GF12yTgCizN4IgGOcQZfd5Xhr/EeGQrnH
         B+YXMVOKIT3PhfeJaZgEMUPpxLOE5F4HDL1zBOPfaaFY+QUPwbl7ktZJ7/ws9x9zLo
         VyymOlb3cOmCH0OZapgthR3TlUnQ+Le9GRXl/cvPJT9uH+UCex2/VXAaOY7PcpNMYv
         1XMy3no+XPX41TCy24lpsy3/VgLjpcwUSa6VNzMv7mvkYO+UI5gNASRYLj3C6ZJotZ
         Nv7gBjgmK03LWEmx2pFJLrEkNOjQD16Qx9h+oLMFCEORtG39B6o3HTw+ENYBGqV7kS
         D0ZrWa3Zt0Xiw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, mcgrof@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] cxl: BG operations and device sanitation
Date:   Wed,  3 Aug 2022 21:50:27 -0700
Message-Id: <20220804045029.2905056-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following is a followup to some of the discussions around CXL device security
and sanitation[0, 1]. It is marked as RFC mostly to see if the background handling
will satisfy all users, not just sanitize/overwrite. For example there has been ideas
to avoid command hogging the device and/or interleaving scan media regions instead
of all in one, etc. More details in each patch, but:

Patch 1 adds the required background cmd handling bits. While this is currently
only polling, it would be good to know if there are any fundamental blockers for
supporting irqs (beyond just background ops) between PCIe and CXL. For example,
are there any requirements/difficulties that is not the standard MSI/MSI-X PCI
vector allocation + devm_request_irq()? I have not looked at this into details but
it the topic has come up in the past as delicate', iirc.

Patch 2 implements the sanitation commands (overwrite and secure erase).

As for testing, while I used the mock device to test the secure erase command, I
ended up hacking up a prototype[2] for qemu to support overwrite and bg commands.
So while the some of the paths this series introduces have been exercised, there
is of course a lot more to do.

Applies against Dave's cxl-security branch[2] which deals with the pmem-only bits.

Thanks,
Davidlohr

[0]: https://lore.kernel.org/all/20220708172455.gi37dh3od4w5lqrd@offworld/ 
[1]: https://lore.kernel.org/all/165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com/
[2]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-security

Davidlohr Bueso (2):
  cxl/mbox: Add background operation handling machinery
  cxl/mem: Support sanitation commands

 Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
 drivers/cxl/core/core.h                 |   2 +-
 drivers/cxl/core/mbox.c                 | 304 +++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  58 +++++
 drivers/cxl/core/port.c                 |   9 +-
 drivers/cxl/cxl.h                       |   8 +
 drivers/cxl/cxlmem.h                    |  65 ++++-
 drivers/cxl/pci.c                       |   3 +-
 drivers/cxl/pmem.c                      |   5 +-
 drivers/cxl/security.c                  |  13 +-
 include/uapi/linux/cxl_mem.h            |   2 +
 11 files changed, 461 insertions(+), 27 deletions(-)

--
2.37.1

