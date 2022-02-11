Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6DB4B313B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbiBKXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:25:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiBKXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:25:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B691C5F;
        Fri, 11 Feb 2022 15:25:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BN5Z4T015522;
        Fri, 11 Feb 2022 23:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=5eNJBhDGgq1qZSsKV3Wp4fv3E7MvY1SsyGQyWAIjwSA=;
 b=khUN/m6mdpSoOsdNAlyCRxlqfg0jla4eAu/GO2HG3GrWNz7WazBAPzKcbyqEUFyY06MW
 q0AG/K/WEbdvRIDCOdg7H7CT1FO9knawUXJDGJiymOW1WsS8a5bdSgJwp5OZMy3fcQhv
 fnP63UTckuKhzYvcoPVoJdTsLUn3AZ6ny1CCtKRKlT2Gps4lEB3qpF6l/peGBuCOhk44
 nYleX0yilHkdWMyA0/35l2XyLQtsCaPtf6Q0gQyGkt4XBYxw5rDihyXUBO8LslrhiIDx
 +WQagc64Wc8AvFt5Kuga8JbI91YxeyIEGY9wlmcRviXsaGE72awJ6DWDEW/BdYrdIzj8 rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5g98ace3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 23:25:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BNG6uw020666;
        Fri, 11 Feb 2022 23:25:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jpykk2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 23:25:32 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21BNPTtB094578;
        Fri, 11 Feb 2022 23:25:31 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jpykk0v-2;
        Fri, 11 Feb 2022 23:25:31 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH] scsi: mpt3sas: Convert to flexible arrays
Date:   Fri, 11 Feb 2022 18:25:25 -0500
Message-Id: <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201223948.1455637-1-keescook@chromium.org>
References: <20220201223948.1455637-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sGf-vz6rt6-lFfi29dBdIppsmPP0CQdc
X-Proofpoint-ORIG-GUID: sGf-vz6rt6-lFfi29dBdIppsmPP0CQdc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 14:39:48 -0800, Kees Cook wrote:

> This converts to a flexible array instead of the old-style 1-element
> arrays. The existing code already did the correct math for finding the
> size of the resulting flexible array structure, so there is no binary
> difference.
> 
> The other two structures converted to use flexible arrays appear to
> have no users at all.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: mpt3sas: Convert to flexible arrays
      https://git.kernel.org/mkp/scsi/c/d20b3dae630f

-- 
Martin K. Petersen	Oracle Linux Engineering
