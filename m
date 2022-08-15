Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8359288B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiHOEQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiHOEQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:16:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90960C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:16:20 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F3vsG8007100;
        Mon, 15 Aug 2022 04:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=1TNmFe+z/ueah8s5FCf/AALM0joYNBnIp0kYzEHh/PY=;
 b=m7Wq/jNdwV/Yo6feaJwPCVZ1HGFeL/cjHbqFH3Ww0qjvN9bDkTwDvPFb7CnJg6yGkJnt
 KW9povVagJgR5SjgfomKhp5UxlboYZlBhioM6YSQAQfvMl057QTg8ivMmC+HxdD6pIbk
 kmB1zW1DAYeq4Cy/Dfok2dJdKjwJ37T9Zv/8DJY8D0EqKPKi/2K/pqp4UMDxUelD+QjC
 oWH/QCsJCQ4wIS0Z0ve7L06g1e0Pl5TR3aRG9guLBicj6R3k4fBb1Qe1d4OKRBbaIFFN
 d7NdF3f/1OiI1vtgiWZQ/zDbso+MRVaylJaVcfWWjnWubT7euOTD6KWZ8WJybZZQFD22 Lg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyept09rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 04:16:16 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 48EA0D294;
        Mon, 15 Aug 2022 04:16:15 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B4C858048EE;
        Mon, 15 Aug 2022 04:16:14 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 0/3] checkpatch: enhance Kconfig parsing
Date:   Sun, 14 Aug 2022 23:15:45 -0500
Message-Id: <20220815041548.43744-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rAe4Cu0wy1wfFh9xYkA05vZBx0KRFxBv
X-Proofpoint-ORIG-GUID: rAe4Cu0wy1wfFh9xYkA05vZBx0KRFxBv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=521 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150016
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance parsing for Kconfig patches and files.

Robert Elliott (3):
  checkpatch: improve Kconfig help text patch parsing
  checkpatch: don't sanitise quotes in Kconfig files
  checkpatch: check line length in Kconfig help text

 scripts/checkpatch.pl | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.37.1

