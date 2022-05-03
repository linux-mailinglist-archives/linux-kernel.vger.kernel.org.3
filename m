Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7451C53A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382086AbiEEQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243243AbiEEQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:38:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79254D4C;
        Thu,  5 May 2022 09:35:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MuHJu018680;
        Tue, 3 May 2022 00:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=YDpybZyMtUto8vzB7am4iv3VtisKb3L6fXgrRs5sN9s=;
 b=xxIyeuW5EZadlLJb3Kn928Omyai87Hz6btNX6PGK9Ya5irtQo6toZxvB5IH58cg5gPX4
 5sB+duHYXCJvGyUBSwCcesmTF/wpLCGWCwd0jgPxwrktRxPZbyg0ZS0CDahAO8Ta9jOO
 x1A7/EXyAqIokZ+PoL7zRg7Xl625MHGPlC5LJx+/MkrVvqcEgyUH8KuSYPb3rovdmzg+
 9Fef3o0M3FimBH1g1TbKg/ZnY0AvIAFttHDFq4Eah9B2Pl4fiVTEFWpw4tiwbK6gmkmQ
 ojbW/Ep3+cUc6IsItoRpJIUjbxSMG5FnYGp2/41KhpTXrlrmzoyxfI6dUF8Ov/7eqE8U 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430orCC009030;
        Tue, 3 May 2022 00:52:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plju010389;
        Tue, 3 May 2022 00:52:03 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-30;
        Tue, 03 May 2022 00:52:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Enze Li <lienze@kylinos.cn>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sr: add handling of memory allocation failures when calling get_capabilities
Date:   Mon,  2 May 2022 20:51:40 -0400
Message-Id: <165153836364.24053.1228657933500703944.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220427025647.298358-1-lienze@kylinos.cn>
References: <20220413100008.522912-1-lienze@kylinos.cn> <20220427025647.298358-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DFm3DGdgo6sAmZIKJAHLWD1d82YL0M0b
X-Proofpoint-GUID: DFm3DGdgo6sAmZIKJAHLWD1d82YL0M0b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 10:56:47 +0800, Enze Li wrote:

> The function get_capabilities() has the possibility of failing to
> allocate transfer buffer, but it does not currently handle this, which
> may lead to exceptions when accessing the buffer.
> 
> This patch adds handling when memory allocation fails.
> 
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: sr: add handling of memory allocation failures when calling get_capabilities
      https://git.kernel.org/mkp/scsi/c/ebc95c790653

-- 
Martin K. Petersen	Oracle Linux Engineering
