Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4A5129B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiD1C6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiD1C6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:58:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED413701F;
        Wed, 27 Apr 2022 19:55:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S2hZxm015405;
        Thu, 28 Apr 2022 02:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qRh+kCkgOa9dV3TWrbuX8juS99jukR8jTYOkR3GxzOw=;
 b=uWeEfg9Pk2BpfMhvGMlV3g0LD03f02a0uMumsHasNEMNMLuFCWqHqI9uvX0cVZafQbIk
 YUz+AL0AqxmoGfcWekcvCqqv5vzqApVsVAKELJoWfvmQL8dFAV1MilJ2mHIHMqkC2YuR
 jg8JfPkJ2j/OGD2jyCUNTw5zh7OQeieBgKeVPv1K29KxpdRLf22fPMY73/mqzWGt1bv7
 Q4Pf9ur0HDS9XKPcTNB7V7myxAVNAS11SK/a2anYjppubfHU8XkTqyCmrVsgjm3w6oSl
 B+lTgVir4iW3Uj+Uk0PrqMqCYs9q4HreJazOTKsCVzdbKk27YK+IHCJZzLYts7vnIn8C XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9atpab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:55:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S2k8Tg019742;
        Thu, 28 Apr 2022 02:55:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5u4yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:55:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23S2tKis039391;
        Thu, 28 Apr 2022 02:55:20 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5u4y0-1;
        Thu, 28 Apr 2022 02:55:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     David Jeffery <djeffery@redhat.com>, target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] target: pscsi: set SCF_TREAT_READ_AS_NORMAL flag only if there is valid data
Date:   Wed, 27 Apr 2022 22:55:19 -0400
Message-Id: <165111450538.20789.16658928197210500441.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220427183250.291881-1-djeffery@redhat.com>
References: <20220427183250.291881-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p4tgCAzGMfiIHnyhWKFXOQwwadPaaaM8
X-Proofpoint-GUID: p4tgCAzGMfiIHnyhWKFXOQwwadPaaaM8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 14:32:50 -0400, David Jeffery wrote:

> With tape devices, the SCF_TREAT_READ_AS_NORMAL flag is used by the target
> subsystem to mark commands which have both data to return as well as
> sense data. But with pscsi, SCF_TREAT_READ_AS_NORMAL can be set even if
> there is no data to return. The SCF_TREAT_READ_AS_NORMAL flag causes the
> target core to call iscsit datain callbacks even if there is no data, which
> iscsit does not support. This results in iscsit going into an error state
> requiring recovery and being unable to complete the command to the
> initiator.
> 
> [...]

Applied to 5.18/scsi-fixes, thanks!

[1/1] target: pscsi: set SCF_TREAT_READ_AS_NORMAL flag only if there is valid data
      https://git.kernel.org/mkp/scsi/c/8be70a842f70

-- 
Martin K. Petersen	Oracle Linux Engineering
