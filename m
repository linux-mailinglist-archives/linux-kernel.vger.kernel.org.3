Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BF53B16F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiFBBv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFBBv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:51:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034AC213291
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:51:24 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2520sfv1016485
        for <linux-kernel@vger.kernel.org>; Wed, 1 Jun 2022 18:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YacxzmoePktJOycbEBPjZaVPvCcq4FomTaLS1s9S8oI=;
 b=krFI+/HyTRKxaQ4dQGx8u4vFxjUZ+UBU7TNcuvWAmXkIf8qRv38xQToH9HWDMw80k6rt
 0Bo83V10uqrZjEoCLAZNNNBmAvEVNbgR1dJRwGyoJ0JNYyzWz4ueLdZydGRWYcLu8GR7
 Xmbkx5CtAbnfVkLELdGRePHjweFXwTAHPOs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdbt6e1vj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:51:23 -0700
Received: from twshared6696.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 18:51:21 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 167D749F3A72; Wed,  1 Jun 2022 18:51:03 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: show the install image name and path
Date:   Wed, 1 Jun 2022 18:50:50 -0700
Message-ID: <20220602015050.3185028-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0AjROqC3uagrGaJl0y0P7MTtm70EI_Jo
X-Proofpoint-GUID: 0AjROqC3uagrGaJl0y0P7MTtm70EI_Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_09,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Prior to commit f774f5bb87d13 ("kbuild: factor out the common
installation code into"), a 'make install' would print out the install
command like:

  sh ./arch/x86/boot/install.sh 5.18.0-11935-gbffe08031c89 \
        arch/x86/boot/bzImage System.map "/boot"

This output was very useful for my workflow, so this patch prints it out
again. I'm not sure if there's a better way to do this than what's
implemented here, so any feedback is appreciated.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 scripts/install.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/install.sh b/scripts/install.sh
index 9bb0fb44f04a..2989d25ef069 100755
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -33,6 +33,7 @@ do
 	# installkernel(8) says the parameters are like follows:
 	#
 	#   installkernel version zImage System.map [directory]
+	echo "$0 ${KERNELRELEASE} ${KBUILD_IMAGE} ${INSTALL_PATH}"
 	exec "${file}" "${KERNELRELEASE}" "${KBUILD_IMAGE}" System.map "${INSTA=
LL_PATH}"
 done
=20
--=20
2.30.2

