Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194150EF78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiDZEEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiDZED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:03:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50E12633;
        Mon, 25 Apr 2022 21:00:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q3rX19022277;
        Tue, 26 Apr 2022 04:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=YtF2I6bZ2CqMK9GSqQlDwN70ct9X7AOPMuRUyJ5XD34=;
 b=sYbDhuD06ibuX53ceYl1TpdxTecDYDAYljQAxG0tA/9dVQsSgEyQ3w/3sLBjHGiQ1nIG
 m/Q+dwEe4+zZgeS1A8FhtsaJ1z7doEqLU0t8o26SoycRjkqhiQFRbfgcDCvsTb8YJyGH
 SK74kkz32doy/CsgfQX0qn7qJsTWHW4WnyCWn3cmpFW/OQhOhw7BXdnTk3eWq9cHfAa9
 xbrrBFni07XURnU48NQ3jfrudz9xavw0A6b67dlbjI4ie5q91Q14fG/qlmK/tcacisJn
 cSNRkzITq2AQou9N3SDDLBTAJ0q64HgAgW8NWd/CaJuOzB09pprq3BmwZSeqqUgNrQt5 tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4d0br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q40RBG029582;
        Tue, 26 Apr 2022 04:00:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23Q40juP030030;
        Tue, 26 Apr 2022 04:00:45 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v10-1;
        Tue, 26 Apr 2022 04:00:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Yihao Han <hanyihao@vivo.com>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>, kernel@vivo.com
Subject: Re: [PATCH] scsi: fcoe: simplify if-if to if-else
Date:   Tue, 26 Apr 2022 00:00:40 -0400
Message-Id: <165094528687.21993.818175220673009011.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220408081237.14037-1-hanyihao@vivo.com>
References: <20220408081237.14037-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0wzTlgmboAoNDySwbRc0ekE62d_lRvHP
X-Proofpoint-ORIG-GUID: 0wzTlgmboAoNDySwbRc0ekE62d_lRvHP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 01:12:37 -0700, Yihao Han wrote:

> Replace `if (!is_zero_ether_addr(mac))` with `else` for simplification
> and add curly brackets according to the kernel coding style:
> 
> "Do not unnecessarily use braces where a single statement will do."
> 
> ...
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: fcoe: simplify if-if to if-else
      https://git.kernel.org/mkp/scsi/c/65db22e505c4

-- 
Martin K. Petersen	Oracle Linux Engineering
