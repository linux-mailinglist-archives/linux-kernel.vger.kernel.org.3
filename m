Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE57464ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349577AbhLANfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349540AbhLANfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:35:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C86C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04E7FCE1759
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB03C53FAD;
        Wed,  1 Dec 2021 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638365537;
        bh=Ugji584zVJ/I3sWBpg/k0K1Uufu688Ld13ZODd6Twvo=;
        h=From:To:Cc:Subject:Date:From;
        b=HXYyeT4VaRqzW0K4XaxiYsbgTAD67rC7w66hRVaqUvSTEhUDjZqqmBRDix0PDPml4
         swMU/FGvtJtR0q4vNCYVvkpddRiQR3ySgzjH3/owwqyAiCb/RlUWak2xx95TGBJFmW
         VaXZfn/iAhDNFR07wOVQAQ2c0yPyFvsDVf/NgCv1+Zq7ROxpDjn4+HYdtF5gr8Izno
         RT2nboUwpi3M2ZnEMeENBXUx20djfOgbEFDNaGSVXG233JIngJcpUTGROMBINFfE0K
         SlfoIn2FOjstwytHPwpTQfRfYyxe7/cTHE9wojyGZwzNE+aBBDOcWN5nyXKgWV2lxd
         ZjEB5bT0n4mbA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1msPiH-0007rs-3l; Wed, 01 Dec 2021 14:31:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] firmware: qemu_fw_cfg: misc bug fixes
Date:   Wed,  1 Dec 2021 14:25:24 +0100
Message-Id: <20211201132528.30025-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for the latest umn.edu patches I stumbled upon a recently
submitted fix for a bug purportedly introduced by umn.edu:

	https://lore.kernel.org/r/YaZc4LbX5hrJDnec@hovoldconsulting.com

The patch in question is obviously bogus, but a closer look at the
function in question revealed a number of other bugs, including one that
was indeed introduced by umn.edu but that was missed during the
(re-)review.

Included is also a related clean up.

Johan


Johan Hovold (4):
  firmware: qemu_fw_cfg: fix NULL-pointer deref on duplicate entries
  firmware: qemu_fw_cfg: fix kobject leak in probe error path
  firmware: qemu_fw_cfg: fix sysfs information leak
  firmware: qemu_fw_cfg: remove sysfs entries explicitly

 drivers/firmware/qemu_fw_cfg.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.32.0

