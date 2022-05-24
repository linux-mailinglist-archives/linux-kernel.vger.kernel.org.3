Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C328C532EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiEXQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEXQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:28:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E1248C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:28:29 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OFmvBF009858;
        Tue, 24 May 2022 16:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5YR2Ff/r4+h1YOsA/BDq785rx1thurBvne86IGA5dok=;
 b=iMc4vINaSGtL8Ke0RX96cE3S9IXFNNRCxOvcRsppqFmJnPyeAMbtSXu/2TZyG1HOffVE
 WTUXDaQqrsUOTWCyoYCr3bMmAkzGjs/JMHzR1VVp5e0P+dTGtOTKVQN1RbNxJuv6jv0x
 zNxx/se2bO4F1mgmxpr1pdiUPlf/8DoyuZCUzE48MrJIuhaZBxGj9eu92GgLMjwXyW5q
 cYV1NCgac7dVCQfBifz00e8U/uodjOelnopu8MSznjCASo9tIV7nBomTBlGv8nM+uJvd
 i6d/wNwr3eSpocWpKozjHlPOUmNdH36NIZx4rX2/hknFyB3SnjZ7L6obJsCz9J0ghQkf mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g92b9gxd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:28:06 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OFpXD0015823;
        Tue, 24 May 2022 16:28:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g92b9gxcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:28:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OGEYqQ002816;
        Tue, 24 May 2022 16:28:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g6qq94ryf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:28:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OGS2s248169280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 16:28:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F7614C046;
        Tue, 24 May 2022 16:28:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17C974C044;
        Tue, 24 May 2022 16:28:01 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.31.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 24 May 2022 16:28:01 +0000 (GMT)
Date:   Tue, 24 May 2022 18:27:51 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        cohuck@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220524182751.1d4bf02f.pasic@linux.ibm.com>
In-Reply-To: <20220523105323.58c28d75.pasic@linux.ibm.com>
References: <20220518035951.94220-1-jasowang@redhat.com>
        <20220523105323.58c28d75.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zBHVL5g6ebnXQ_PtXF-ggneJ4xe4nz8E
X-Proofpoint-ORIG-GUID: 9ZptdZSi-2FDlM9dOcSbceyOpiliPn-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_08,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 10:53:23 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 18 May 2022 11:59:42 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > Hi All:  
> 
> Sorry for being slow on this one. I'm pretty much under water. Will try
> to get some regression-testing done till tomorrow end of day.
> 

Did some testing with the two stage indicators disabled. Didn't see any
significant difference in performance, and with that also no performance
regression. IMHO we are good to go ahead!

Sorry it took so long.

Regards,
Halil

