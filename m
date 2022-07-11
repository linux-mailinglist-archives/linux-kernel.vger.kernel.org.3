Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435E570D71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiGKWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGKWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:37:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028F3135E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:37:18 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMDoib011729;
        Mon, 11 Jul 2022 22:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Xv634OTH60QX2RztipW8ScWcU8MHAMjaw/sJR/cHONs=;
 b=LjF97rqGnEJJ4CEsrwPTCdmQBuigp9RFJ7wyeoVU+cYNxOo7x2J04b1Wnfz0RZaXUiq7
 7iT6pspY5bZTbGmfxtAWNDNv/unZAX5PbnmIi9Aq47YuOSOmonU0o6i/dfaPLb+4QwZU
 DP2XX6ZUc8zGacolWLcHDyTcUEr+eXZ6KavFbp42HdkGX0wlM+fkQ8MNsd+QDc9ajPM4
 1JCKRwleR/YJ+BqNdPsf3vVdrpHeg1CkhSJAKi/tUg2Fuvf6BWIz+DtmUqVPT5OcDLXp
 7qY3CLJSrdyJrY56MZnBlEaPY3iPNouW7q4h8pBRnqUszMvHSYBXdNK7C/gxTQWS7cWh CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8vfd8bvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:36:34 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26BMXaMA007097;
        Mon, 11 Jul 2022 22:36:33 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8vfd8bv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:36:33 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BMKon8021115;
        Mon, 11 Jul 2022 22:36:32 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3h71a9pkr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 22:36:32 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BMaV5D10158792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 22:36:31 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A449C6072;
        Mon, 11 Jul 2022 22:36:31 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E0EC606C;
        Mon, 11 Jul 2022 22:36:30 +0000 (GMT)
Received: from localhost (unknown [9.163.4.84])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 22:36:30 +0000 (GMT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        mopsfelder@gmail.com
Subject: [PATCH 0/2] KVM: PPC: Book3s HV: Cleanup unused function and declarations
Date:   Mon, 11 Jul 2022 19:36:15 -0300
Message-Id: <20220711223617.63625-1-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BNvzsn6XrWp33fK86lTv5l7gMgFDGNNH
X-Proofpoint-ORIG-GUID: BM2qsaSrrzlvEP4SMh7fhV3CxFTLVyrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=243 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207110091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to remove unused function and declarations.

Murilo Opsfelder Araujo (2):
  KVM: PPC: Book3S HV: Remove kvmhv_p9_[set,restore]_lpcr declarations
  KVM: PPC: Book3s HV: Remove unused function kvmppc_bad_interrupt

 arch/powerpc/include/asm/kvm_book3s.h |  3 ---
 arch/powerpc/kvm/book3s_hv_builtin.c  | 18 ------------------
 2 files changed, 21 deletions(-)

-- 
2.36.1

