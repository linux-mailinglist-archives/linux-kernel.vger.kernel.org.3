Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0552E19C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiETBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbiETBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07034135680;
        Thu, 19 May 2022 18:09:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0J7sq005792;
        Fri, 20 May 2022 01:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=CdkcJdR0OlggZFncRV2N7kioLycd3Mu9PDETGZDhfvA=;
 b=QD1DlooC6hjJwYkjA8EqyqjG+DjyL32dcPQqGsuTCuD4LjTt9h2kPOY3b6CY6n9DjBi0
 JTDHESUBZgjT0DXwyFpLM2i/rHijcCJmzqEP4TwWeiOmVKQAk3lx4rdNQ0KG1kha8F5Q
 vAasI2AmBVQ7jf9Tpn95BYrVCjKQn7DGty9q/ITEqAmt6RiOMEoalTWZUzmgJ0tB/Dfm
 wqPvNiyoqcrAmw9vTXlR7KGLZ0aBkf+RJU7/xGhY4OFbNwyHzolznk/PJ9O+4MlRr1WT
 f64wVxJjuwKE0Wq0FEtmMpNNvB03pYzOnDoVZ1SRr/2QQ3VVjCmpjqGTL0fzahSj8pTT Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucddrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15n3W020161;
        Fri, 20 May 2022 01:09:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKT030710;
        Fri, 20 May 2022 01:09:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-13;
        Fri, 20 May 2022 01:09:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        arulponn@cisco.com, linux-scsi@vger.kernel.org, gcboffa@cisco.com,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        djhawar@cisco.com, satishkh@cisco.com, gvaradar@cisco.com
Subject: Re: [PATCH] scsi: fnic: Replace DMA mask of 64 bits with 47 bits
Date:   Thu, 19 May 2022 21:09:12 -0400
Message-Id: <165300891231.11465.3114023089870424603.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220513205605.81788-1-kartilak@cisco.com>
References: <20220513205605.81788-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vuTNoKkLtDstGVvI-f8rxKPwULE8J9OE
X-Proofpoint-ORIG-GUID: vuTNoKkLtDstGVvI-f8rxKPwULE8J9OE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 13:56:05 -0700, Karan Tilak Kumar wrote:

> Cisco VIC supports only 47 bits.
> If the host sends DMA addresses that are greater than 47
> bits, it causes work queue (WQ) errors in the VIC.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: fnic: Replace DMA mask of 64 bits with 47 bits
      https://git.kernel.org/mkp/scsi/c/b559b99a5c08

-- 
Martin K. Petersen	Oracle Linux Engineering
