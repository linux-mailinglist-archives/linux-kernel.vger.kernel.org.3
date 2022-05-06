Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82951DFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391996AbiEFTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEFTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:53:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F8C6A42A;
        Fri,  6 May 2022 12:49:41 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246JR4Tv013111;
        Fri, 6 May 2022 19:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=d9tDzOxYoFTHwKqeI3nR0c9QSnmMLpO3R25jvjp2BoU=;
 b=oBf02/jq4fdEQVxkleC/MlOIWitIXlmDNmH6iVaz73a4/RTmhqoaHsbr3LmNhQhQcKbq
 SDAuG8CfY0NM448DClIM0MywyPbSyX7qhzdeBcRRbUpkj4cqIboWLXuPQ2jDEZ4eBo1S
 FSlI4aYBhrZrwcGzWHE9z7gdx4kKZyr6RB5eY4Fl1IRPW2aOtXDmu+Z5txJtXKQN5Uae
 ID2WhS+8VmbgKyGO2nuNLtVcvVBEkIp8a5dfix6sTuPQ6b6fvY79JJ5Rm0uJ00rMJCww
 7VAGORGtMzpq93DNidNcxeYmlJtdEKMjZP6xgJpj0h7gInZae6mr9TjEWMPs9yxbcb1J aw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw9ug0anm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:49:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246JnAs3021632;
        Fri, 6 May 2022 19:49:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk6mwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:49:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246JZfNT55247200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 19:35:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E162111C050;
        Fri,  6 May 2022 19:49:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9394F11C04A;
        Fri,  6 May 2022 19:49:06 +0000 (GMT)
Received: from osiris (unknown [9.145.25.133])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 19:49:06 +0000 (GMT)
Date:   Fri, 6 May 2022 21:49:04 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
Message-ID: <YnV7sD3r/PzY+1lA@osiris>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com>
 <87bkwah2p1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkwah2p1.ffs@tglx>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k95cZwgzi8r50lA6U3iXLeytjjD2Udxx
X-Proofpoint-ORIG-GUID: k95cZwgzi8r50lA6U3iXLeytjjD2Udxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=710 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 09:38:02PM +0200, Thomas Gleixner wrote:
> On Wed, May 04 2022 at 08:23, Thomas Richter wrote:
> > From: Sven Schnelle <svens@linux.ibm.com>
> >
> > arch_check_user_regs() is used at the moment to verify that struct pt_regs
> > contains valid values when entering the kernel from userspace. s390 needs
> > a place in the generic entry code to modify a cpu data structure when
> > switching from userspace to kernel mode. As arch_check_user_regs() is
> > exactly this, rename it to arch_enter_from_user_mode().
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Is it ok for you if this gets routed via the s390 tree?
