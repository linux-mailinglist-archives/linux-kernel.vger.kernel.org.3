Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E8562063
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiF3QhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiF3Qg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:36:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D283B3CC;
        Thu, 30 Jun 2022 09:36:57 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 087564B7;
        Thu, 30 Jun 2022 16:36:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 087564B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656607017; bh=eDHYSyr3kppjt9KjcBoobCi/lAwO48ncPMwYG//WCtM=;
        h=From:To:Cc:Subject:Date:From;
        b=AB/M1tvSP6J+lqHmip0pHHoKx8N6EXRVe1MQ2iNOlCuavQniuWWlkUw1/74p672zR
         YBKIp9+cfBbULtSUCZ5QEwQp6MJ60mmEW82RxiPWCLfrOdhkx+OnlHmpjxyJCeW32G
         QEL+315+V5cQVvhjJM+EycZXp5W8gHajdBlvMADFAJtPj/+ZUxjIK1rZmfns98Uv6v
         tD6bEXHVvemzlv/Jkd2VFqzgYcm1yxDDKii5O58gjKOiKv1T/UVOIo113rEMK4UPqo
         iXoF9SCoSrLrxoDONMjhSkgSnVub2Fyx8RyKbXAa4STVyiDnrcjh0Zh954z3fU9ahl
         ytL0x5StW1mdg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <n@nfraprado.net>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] docs: A couple of automarkup improvements
Date:   Thu, 30 Jun 2022 10:36:28 -0600
Message-Id: <20220630163630.714673-1-corbet@lwn.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the docs takes far too long.  Much of the blame for that lies with
Sphinx, but some of it is under our own control.  These two patches
eliminate a bunch of useless work in the automarkup extension.

Benchmarking Sphinx runs is hard, as the run time can be rather variable.
I have consistently found about a 15% speedup from these patches, though,
with no output changes.

Testing was done with Sphinx 4.4.0 and 5.0.2.  My systems all have Python
3.10 installed, and there does not appear, alas, to be a straightforward
way to get Sphinx 3.x to run on that version.  Versions of Sphinx prior to
3.0 will not be affected by these changes.

Jonathan Corbet (2):
  docs: automarkup: track failed cross-reference attempts
  docs: automarkup: do not look up symbols twice

 Documentation/sphinx/automarkup.py | 56 +++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

-- 
2.36.1

