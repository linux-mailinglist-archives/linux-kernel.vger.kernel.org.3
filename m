Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626774ABE56
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391688AbiBGMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387859AbiBGLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:41:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33114C0401C1;
        Mon,  7 Feb 2022 03:41:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217Apeok012378;
        Mon, 7 Feb 2022 11:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=l4GRQfS6dt8KbwsIfRAoCLiv5GnoaDEu32gKAeieLAs=;
 b=tMYBZbQ5uoALXShCqp6HByVPllh1Kvsr1LGK1z8CCnCMSqYqiXQWgp/XBppYyBXcDAv0
 lCiUGYobeF8LUROFa5mplfD2sbiqwHKtzsXBLlD7mRtdHMay4lKJSBfWCQuQ6YfuqQxw
 8/D5M9EP9z0a02ib9a1CHpC2cWhHvxUwS2xlyQ0arWWoaA3UzTh9Zw69ngsQFZwXhy9E
 lUVbTGFsYCzyiIqy2vpW0yIhicNq2e+WaQOKRfjfekQWjJ4doMN+P4g/F1YtKBz74J2P
 PsZ7j2fIHL7bkYg5Hltfxy5ZwNwrzgrvun+xNqvkIleR/xvYPFFSOZ1cDrhywbIVtJzN Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22nk1vhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:40:59 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217BUMdN010053;
        Mon, 7 Feb 2022 11:40:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22nk1v8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:40:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217BYQpC008045;
        Mon, 7 Feb 2022 11:40:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv93kdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:40:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217BeXt442467668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 11:40:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C8354C050;
        Mon,  7 Feb 2022 11:40:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABBCD4C04A;
        Mon,  7 Feb 2022 11:40:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Feb 2022 11:40:32 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        linux-s390@vger.kernel.org
Subject: Re: [patch v11 01/13] s390: add support for TIF_TASK_ISOL
References: <20220204173537.429902988@fedora.localdomain>
        <20220204173554.491925589@fedora.localdomain>
Date:   Mon, 07 Feb 2022 12:40:32 +0100
In-Reply-To: <20220204173554.491925589@fedora.localdomain> (Marcelo Tosatti's
        message of "Fri, 04 Feb 2022 14:35:38 -0300")
Message-ID: <yt9dr18ec3bj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cdSfjdKU77sRKrlYxT3oyA8rYXlmk4TE
X-Proofpoint-ORIG-GUID: bTTjUIYd2LzLfoOoHH7-L9S_VOucRtDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_04,2022-02-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=883 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <mtosatti@redhat.com> writes:

> Add TIF_TASK_ISOL handling for s390.
>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Acked-by: Sven Schnelle <svens@linux.ibm.com>

> Index: linux-2.6/arch/s390/include/asm/thread_info.h
> ===================================================================
> --- linux-2.6.orig/arch/s390/include/asm/thread_info.h
> +++ linux-2.6/arch/s390/include/asm/thread_info.h
> @@ -73,6 +73,7 @@ void arch_setup_new_exec(void);
>  #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
>  #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
>  #define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
> +#define TIF_TASK_ISOL		11	/* task isolation work pending */
>  
>  #define TIF_31BIT		16	/* 32bit process */
>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
> @@ -97,6 +98,7 @@ void arch_setup_new_exec(void);
>  #define _TIF_ISOLATE_BP		BIT(TIF_ISOLATE_BP)
>  #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
>  #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
> +#define _TIF_TASK_ISOL		BIT(TIF_TASK_ISOL)
>  
>  #define _TIF_31BIT		BIT(TIF_31BIT)
>  #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
