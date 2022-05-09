Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14051F485
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiEIGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiEIGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:24:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C8245AE;
        Sun,  8 May 2022 23:20:58 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2496KaRY016784;
        Mon, 9 May 2022 06:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=XGsTLEwOaQIfxo397XNIDIaNBSvxTkajB9Ez6aSnGFM=;
 b=iWNQjqRXd7YPdLGKpwm2G6ul0y3DZKRElQq2TOWzsPtmxRCuHvjNsdNABJQtm0y7Jn1G
 ncAf08kdZylF36ugDa65vMDyg7X3PAixWLA49PhQlAnpxWklP1OD2gO2Pres91Fv6o0V
 0HYrvRWsrpff1O1Pq6zZDZzDNGJDEEkHXJSPo5NvhEMolhpe9L7gpN15OjrvnYuRBrcg
 f4eoNKoONPoKtwAQJWNzxZKlGrJZztpp2JefBXdye0wpWAJHzm/Q4Usu2HvFz/IJbjY0
 isFgdpPvahYYpfaZmM+/tlG4LxuAaXwIwDf4rGYPu1blj+sHqDRtpeiaVAHhcvfnRQQj iQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fx2jrb4pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:20:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2495ww6i012343;
        Mon, 9 May 2022 06:20:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3fwg1j20ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:20:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24967AEP49414612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 May 2022 06:07:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE4F4C040;
        Mon,  9 May 2022 06:20:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615F64C044;
        Mon,  9 May 2022 06:20:41 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 May 2022 06:20:41 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
        <20220504062351.2954280-2-tmricht@linux.ibm.com>
        <YnV3iljKUM0Fqw/F@hirez.programming.kicks-ass.net>
Date:   Mon, 09 May 2022 08:20:41 +0200
In-Reply-To: <YnV3iljKUM0Fqw/F@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 6 May 2022 21:31:22 +0200")
Message-ID: <yt9dsfpjgrba.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YhL3zwoMZ-Ah8l3NxD6xTzZWCviAR9gZ
X-Proofpoint-GUID: YhL3zwoMZ-Ah8l3NxD6xTzZWCviAR9gZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_01,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=892 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, May 04, 2022 at 08:23:50AM +0200, Thomas Richter wrote:
>> From: Sven Schnelle <svens@linux.ibm.com>
>> 
>> arch_check_user_regs() is used at the moment to verify that struct pt_regs
>> contains valid values when entering the kernel from userspace. s390 needs
>> a place in the generic entry code to modify a cpu data structure when
>> switching from userspace to kernel mode. As arch_check_user_regs() is
>> exactly this, rename it to arch_enter_from_user_mode().
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>
> With the note that NMI doesn't (necessarily) call this..
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How about:

"When entering the kernel from userspace, arch_check_user_regs() is
 used to verify that struct pt_regs contains valid values. Note that
 the NMI codepath doesn't call this function. s390 needs a place in the
 generic entry code to modify a cpu data structure when switching from
 userspace to kernel mode. As arch_check_user_regs() is exactly this,
 rename it to arch_enter_from_user_mode()."
