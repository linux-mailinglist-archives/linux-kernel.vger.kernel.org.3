Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB88538ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiEaF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiEaF1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:27:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AACB562EB;
        Mon, 30 May 2022 22:27:40 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V2K0RK024723;
        Tue, 31 May 2022 05:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=PT5JtTPRZQDI4w0OM0wq5EeAWJPlSipYKeQ/cQVBe84=;
 b=Y8hsD7BmBM418ki+GIUIpbJ+9kIJ8ByUyQr93TN43l3rXIxX0GjoTGEK5UyS0UZHQv5H
 Kn6vsm6ydAFasl9FlE1xZU5MNdeFv19jZyzKkwSkTY1vpGcH31RzDLZtLOf6HIodNMz5
 KTKrz4qDYkLjBFyVO5jTdkO5JOqALbxnmJSVVpSnTMP+R1vIoUtkYFOTB2FftViN2o7k
 +JSh+iNBXYQKWxyrhooocbc6+ULkJbH+GQgPCudZanlKi0YI3FWJekS/0HOAmwQQzzfq
 9ctXcF7SCEIA6BTXc0p6/GxHelKhipZz5EXS3Ppq1MUCNY1Vgau9+pI+PqgQDq0eO2DE Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gda53ac6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 05:27:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24V5FVfc019175;
        Tue, 31 May 2022 05:27:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gda53ac6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 05:27:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V57DJX015405;
        Tue, 31 May 2022 05:27:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae3j1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 05:27:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V5REi916843150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 05:27:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A88D211C04C;
        Tue, 31 May 2022 05:27:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D0A11C04A;
        Tue, 31 May 2022 05:27:10 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.34.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 31 May 2022 05:27:10 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Tue, 31 May 2022 10:57:09 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] of: check previous kernel's ima-kexec-buffer against
 memory bounds
In-Reply-To: <20220526015240.GA2884362-robh@kernel.org>
References: <20220524055042.1527968-1-vaibhav@linux.ibm.com>
 <20220526015240.GA2884362-robh@kernel.org>
Date:   Tue, 31 May 2022 10:57:09 +0530
Message-ID: <87h756ff0y.fsf@vajain21.in.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R2s4D36h56biMphvC_rMY7PtyfsreFsy
X-Proofpoint-ORIG-GUID: 4m1hsAWBxReN2px9sIiPiHsphA8vz2zn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_01,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=682 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking into this patch Rob,

I have addressed your review comment in v3 of the patch posted at
https://lore.kernel.org/all/20220531041446.3334259-1-vaibhav@linux.ibm.com/

<snip>

-- 
Cheers
~ Vaibhav
