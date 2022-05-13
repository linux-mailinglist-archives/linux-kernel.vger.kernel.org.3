Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263AF52653E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbiEMOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiEMOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:52:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83367A19C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:52:06 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEg7LT030310;
        Fri, 13 May 2022 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=LFBzXhvAWhuWz6P/ROhSXAvK1PWLgXpG04D7AZagkOs=;
 b=F09gWwxMGFq1d+3UghvZ1k0QcZ6bHOldrUOL+0EbAHbzcYMrzJA5/HtI5MGJSvxEgpn/
 9Lilx9S5xwEr0F+zzQalcFGFNF8ZCl0OeW7oYMtXMPOr6qqzk15mEZjY+ngFNDP1UXlI
 ylhIt3/iBqiTGkY90VAlqYR6HemHv6fxoutPlT5mY0AdKV4talv7BrO6W38sxUUFm8k+
 O3ETPIdf1wWqvtI8H3BJr3xQxDuQk398oEaTMKAe5SoEhfZGmR9lsBR1cnQH1LMLS7vL
 fKow/mOuhuEteks8ziLt3GM1+VMeWA/BS9b2TXUdkC1mjwDB4dtIfBRZ74asNh3icRa2 pw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1ra81vfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:51:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DEhSXL016396;
        Fri, 13 May 2022 14:51:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3fwgd90tnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:51:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DEpknH51839480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:51:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94C0BAE045;
        Fri, 13 May 2022 14:51:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD8CAE04D;
        Fri, 13 May 2022 14:51:46 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 13 May 2022 14:51:46 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mapletree-vs-khugepaged
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
        <yt9dk0apbicu.fsf@linux.ibm.com>
Date:   Fri, 13 May 2022 16:51:46 +0200
In-Reply-To: <yt9dk0apbicu.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Fri, 13 May 2022 16:46:41 +0200")
Message-ID: <yt9d4k1ta3jx.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6stgYCUvJ81iOzJjJ31f4oAGsqhd4kUM
X-Proofpoint-GUID: 6stgYCUvJ81iOzJjJ31f4oAGsqhd4kUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=588 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sven Schnelle <svens@linux.ibm.com> writes:

> Starting today we're still seeing the same crash with linux-next from
> (next-20220513):

Small correction: This also happened the last two days, so it started
with next-20220511.
