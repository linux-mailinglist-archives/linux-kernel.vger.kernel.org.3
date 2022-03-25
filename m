Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80EA4E6ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbiCYHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345649AbiCYHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA22A71B;
        Fri, 25 Mar 2022 00:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 744D8B827B7;
        Fri, 25 Mar 2022 07:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26084C340FC;
        Fri, 25 Mar 2022 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648193005;
        bh=npnMOXqhqiiyY8gzvGPB6tzBdGADkYcbd6BnNfDswhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpSJvzwFs/HnOLwqNHoFzG6zl/7hhZmVwrrV0z2V8SdolzdrMmHU2ZAFE2Tq+FMZa
         /u4tAzv0bRpGPk0K1cnJ5tBj0MUs5jcyW2msIo8W5rbGIkoa1FjYiBpJ7XnxyV1zRN
         ElxdVZsBy46mjhGeAkMjs/85WFatACGE1ah6aL8oSUabtENISFwmPnLBiiDurCxj8g
         w6mTkpKiKVKlncj99DyC/WE94tukW+5ijcBElhESeXKgDpaUDnDyRcPFeze1vlgLLN
         1GvRr8pJzXNEXzuFxZo7pXHhM30FKspmB517610AZgeFqIwpUVZvncxb011+RQ4JAj
         Lz/OuQR1eJd2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXeI6-00AYYW-Gi; Fri, 25 Mar 2022 08:23:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        "Mark Gross" <markgross@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] docs: kernel_abi.py: add sphinx build dependencies
Date:   Fri, 25 Mar 2022 08:23:18 +0100
Message-Id: <5d7ea5b7cfbd9300fc6cc75900b1d8839abd4ba9.1648192982.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325071822.42917fcc@coco.lan>
References: <20220325071822.42917fcc@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that Sphinx-build will handle the files parsed by
get_abi.pl as dependencies. This way, if they are touched,
the ABI output will be regenerated.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 4392b3cb4020..efab9b14a9f5 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -128,6 +128,7 @@ class KernelCmd(Directive):
         return out
 
     def nestedParse(self, lines, fname):
+        env = self.state.document.settings.env
         content = ViewList()
         node = nodes.section()
 
@@ -154,6 +155,9 @@ class KernelCmd(Directive):
                     self.do_parse(content, node)
                     content = ViewList()
 
+                    # Add the file to Sphinx build dependencies
+                    env.note_dependency(os.path.abspath(f))
+
                 f = new_f
 
                 # sphinx counts lines from 0
-- 
2.35.1

