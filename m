Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940724E4653
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiCVS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCVS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:56:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785ED9136F;
        Tue, 22 Mar 2022 11:55:31 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MHlugE020616;
        Tue, 22 Mar 2022 18:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CyagAI7Zeq7tiV8uo9vkWbzE0a4UJj2OZAp99hJ/Uo0=;
 b=DlC/03RXOAjbnQA8qtGw1egsSBbM8TvHQv/kd6wjVR+M3/ot9T/Z9LAtAdmDMyS4S4l/
 Is0RAEtK1Zu/THkoaPC1dMLhAiRReZ+HVc06OIiKUCZyyFFawRzaEfXcuwsiA1wTCk4b
 Mxp1JIflBpNEFa0+JdUQXoEV2CtWRJJH7ihcA2zG10k926cmQkO/IpZBvOxhugdLVcLu
 WQSxGgdex81IVijRKa2/IFJRRdsfGJuSczDRrLpCn+Z/Qy+b6nPIe9WK9+A8/9I+uW1Z
 bHGk5v3/rIpTAnpx2upjmy1pX7B2PchBRk/f7pJpyWQbs2m/SYUz8FDMrd9JQzssweQy kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyautx52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:55:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22MIXAuE003774;
        Tue, 22 Mar 2022 18:55:16 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyautx524-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:55:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22MIdJOB021971;
        Tue, 22 Mar 2022 18:55:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ehxvuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:55:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22MItAbX36569586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 18:55:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C899E11C050;
        Tue, 22 Mar 2022 18:55:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0F7A11C04A;
        Tue, 22 Mar 2022 18:55:07 +0000 (GMT)
Received: from sig-9-65-81-246.ibm.com (unknown [9.65.81.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Mar 2022 18:55:07 +0000 (GMT)
Message-ID: <c312556db3fa746c9c4004ffb6e77f23b2a4a609.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>
Date:   Tue, 22 Mar 2022 14:55:07 -0400
In-Reply-To: <YjoJVnTuaw/3l7Xp@bombadil.infradead.org>
References: <cover.1644953683.git.msuchanek@suse.de>
         <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
         <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
         <20220215204730.GQ3113@kunlun.suse.cz>
         <c3f6f6c8a9db34cc1cdc1000f9272c2b36445e15.camel@linux.ibm.com>
         <20220216105645.GS3113@kunlun.suse.cz>
         <edb305079c28e49021166423af0378f8d218f269.camel@linux.ibm.com>
         <20220216120911.GT3113@kunlun.suse.cz>
         <YjoJVnTuaw/3l7Xp@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p6SNgQMqO9RT46ITjBOQlaacCXIHYzcx
X-Proofpoint-ORIG-GUID: kCkFNlABDSGHz-qoPS75B2zZp6A0kgS0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Tue, 2022-03-22 at 10:37 -0700, Luis Chamberlain wrote:
> How's this series going? Did you and Mimi sort things out? Either way,
> just wanted to let you kow you can base your changes on modules-testing
> [0] if you want to resubmit for v5.19 (v5.18 will be too late already).
> Once testing is done what is on modules-testing will go to modules-next
> for testing for v5.19. There are no changes planned for v5.18 other than
> fixes and so far there are none.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing

The "platform" keyring was upstreamed specifically to verify the kexec
kernel image. Orginally it contained only the UEFI db keys, but the MOK
keys were later added as well.  Any other usage of the "platform" is
not planned.

To allow end users to sign their own kernel modules, executables, or
any other file, Eric Snowberg is working on a patch set to only load
the MOK CA keys onto the ".machine" keyring, which is linked to the
"secondary" keyring[1].  Verifying kernel modules based on certificates
signed by a MOK CA will then be possible.

thanks,

Mimi

[1] 
https://lore.kernel.org/all/20220301173651.3435350-1-eric.snowberg@oracle.com/

