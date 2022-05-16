Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FB5280BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiEPJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiEPJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:21:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A5625EA0;
        Mon, 16 May 2022 02:21:08 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8ShAG001102;
        Mon, 16 May 2022 11:19:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ZkSx5Jhr6ckyxGj+pRYyb9jpx5gL1o2mb7prPSQ2dNM=;
 b=C7hSCTglXqCmazYBepvIQgMmN2svWpJvS1fMMp3gjsCuJ5UmjLQ07Hn2cKzMJFDSwvkN
 IdKG5WvjsS/ncVPzHsZFXAtXgsBRpoPuBG9KtuVJFTCdOoeUCQ1L+UW4b8qN8mBVzf6I
 AXGGO77cTsf1LW6DKp2lr8uVBwKbqRCR/JOAxZYId3lX1fSfODmvieW0vP3bdx/Ul8ZK
 22B6Nqwxg9PxWBXXv9kkM7s7gFxy3z8z7JR1td8VYV/8ODBXLfHLVYiIv+0SXgujzPWk
 +BNvpihloUZs+F281m4J+trEHNsmoSEaIROTFYnAgCG4x+AYFgz9c4d3ino9Hr2fnrTZ gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23ah9k0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:19:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF1E110002A;
        Mon, 16 May 2022 11:19:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5E182171DB;
        Mon, 16 May 2022 11:19:57 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 11:19:57
 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>
Subject: [PATCH 0/3] MIPID02 pixel clk polarity & serial pixel formats
Date:   Mon, 16 May 2022 11:19:31 +0200
Message-ID: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_05,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance MIPID02 CSI-2 to parallel bridge with pixel clock polarity
support and support of 1X16 CSI-2 serial pixel formats.

Alain Volmat (1):
  media: st-mipid02: add support for YVYU and VYUY formats

Hugues Fruchet (2):
  media: st-mipid02: add support of pixel clock polarity
  media: st-mipid02: expose 1X16 serial pixel format

 drivers/media/i2c/st-mipid02.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

-- 
2.25.1

