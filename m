Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F0530B96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiEWIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiEWIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:53:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0531219
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:53:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N8i6U2034362;
        Mon, 23 May 2022 08:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qHEO/P2/97grkhG9Dhe6TgBrYYee1RYDI3UjcZGt/CQ=;
 b=Dc+L1A7H3swP2j42tyEO2xaJNJsTPDclLneXABo5BIaOu+27SO/fw5hR70ZxjIIJsUWk
 WdeyJ/g+Hrr7mjMODvO/hKXTUuvyajYY/kDBQ1/ZwVTGyKElKyoDMH3l2QkRqLUs8RLm
 rMJ+z63lIh7ldB55Qyz7VjAlYG/d4XEXdGdo6Hewm9Pnmw4DeC7oKQE9plMdolC1NqAb
 gmHD+3bI8CkEt5Qbnvjcqrx17c+5LVAfJCraKb957wDGv1NjT2HEP2A32RiD+sHkwk15
 NpE647UV49B/qW21ETZemXirECv0yAPFTN9LB7GVKJZySLMxW6fBBx0NDevb0RjBEg1D mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g7a2dyg8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:53:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24N8m7I5013404;
        Mon, 23 May 2022 08:53:30 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g7a2dyg7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:53:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N8GKi6024021;
        Mon, 23 May 2022 08:53:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3g6qq9a2sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:53:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N8dMTK50790694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 08:39:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7697C11C04C;
        Mon, 23 May 2022 08:53:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3DC611C04A;
        Mon, 23 May 2022 08:53:24 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.152.224.205])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 May 2022 08:53:24 +0000 (GMT)
Date:   Mon, 23 May 2022 10:53:23 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        cohuck@redhat.com, eperezma@redhat.com, lulu@redhat.com,
        sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220523105323.58c28d75.pasic@linux.ibm.com>
In-Reply-To: <20220518035951.94220-1-jasowang@redhat.com>
References: <20220518035951.94220-1-jasowang@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2QDW4SEeX3Ni7NVnpni7rNqwiC6FkjqX
X-Proofpoint-GUID: FG_7jviQorBOfAZ6lw_6pmTTrwR5Haon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=889 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 11:59:42 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Hi All:

Sorry for being slow on this one. I'm pretty much under water. Will try
to get some regression-testing done till tomorrow end of day.

Regards,
Halil
