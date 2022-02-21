Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B24BDE37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiBUIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:48:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiBUIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:48:28 -0500
X-Greylist: delayed 77 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 00:48:02 PST
Received: from smtpbg587.qq.com (smtpbg126.qq.com [106.55.201.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E72BB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:48:01 -0800 (PST)
X-QQ-mid: bizesmtp86t1645433192tx52vncf
Received: from localhost.localdomain (unknown [27.210.147.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 16:46:30 +0800 (CST)
X-QQ-SSF: 0120000000000020B000000A0000000
X-QQ-FEAT: 8nRPapzIrE2kEIZ1NApUVHteMTSAz6zr3bHT3f22cRfQ5BwT3cpjDzz0Ep+H5
        gE09+hQ2yVb3x5Mecf+9LAJsebyXVklsLTMNq/eXXsvntUqlVUG47OlLoxSYGgfO14VJTd8
        7JNECtyVVXRWuXSSh1jcO60qacWdpt/f7C2w2AnDSvJXmTImsRvCsVLWqn3AWY9qRMsSzOD
        XaYmwhkLMyAjytFsXcmDq9UJUAGWPxi0SAWmyP/+FBgsWVCMlfC1irhQqs3H7/GAkK0QMKW
        Dt2T3Aq/1a6yZdV27E4wAzN3mZlq0k4Zpk3vxMYYd9HS2TvePgeRNyU82FW/N2jjmPSg==
X-QQ-GoodBg: 0
From:   Jialu Xu <xujialu@vimux.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, rkovhaev@gmail.com,
        Jialu Xu <xujialu@vimux.org>
Subject: [PATCH] scripts/tags.sh: parse *.dts.tmp for compiled sources
Date:   Mon, 21 Feb 2022 16:46:14 +0800
Message-Id: <20220221084614.1682022-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybgspam:qybgspam2
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are files listed in *.dts.tmp, parse them as *.cmd for compiled sources.

Signed-off-by: Jialu Xu <xujialu@vimux.org>
---
 scripts/tags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 16d475b3e203..f64c33f4dabf 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -97,8 +97,8 @@ all_compiled_sources()
 {
 	realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) \
 		include/generated/autoconf.h $(find $ignore -name "*.cmd" -exec \
-		grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
-		awk '!a[$0]++') | sort -u
+		grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ | awk '!a[$0]++') \
+		$(find -name "*.dts.tmp" -exec grep -Poh '(?(?=^# \d+ "\K).*(?="))' {} \+) | sort -u
 }
 
 all_target_sources()
-- 
2.30.2


