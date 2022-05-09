Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F151F93F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiEIKDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiEIKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:00:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9B179F17;
        Mon,  9 May 2022 02:56:46 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2499pIYY027995;
        Mon, 9 May 2022 09:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ecbswQepaBbmZmYaheJEFCLm/1V+YM5cliMGmxJLUqE=;
 b=ff/dkOuh5G8ZE0XW8fMPvkm5L8VE1m7lxK2JXTS7s4td+TfapnRIVh2IM8ZgqxYc0Lu2
 fj4xbyPwdaDCoksn00iPO3xNrRs7WjWYOX6IPKlWrm9XLEaH1cS/YigBPkb7VNzrFL3O
 R0S8ZQXLbNvA8ITwWuDY2MlarbS7rjk+to23isBPT+QmuW9MqehShPOD2F1VLAvWQ7zC
 P5dGrIyTJlNIWCzi+WFaC1Iq7tpG93bSdyngTn3FnmzhgvXaN7YYbHxHjWBfkmHYLFdP
 UyGT9maS2lVHLJUz6XJpn4aGVxyO3ekiYF8zsmyApyIwc7Dy/jDtbLDlzuiwdtjX938c YA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fy0pk82gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 09:55:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2499qSDx007521;
        Mon, 9 May 2022 09:55:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8tanm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 09:55:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2499tbCA44761580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 May 2022 09:55:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FC3DA4051;
        Mon,  9 May 2022 09:55:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24999A4055;
        Mon,  9 May 2022 09:55:37 +0000 (GMT)
Received: from osiris (unknown [9.145.14.3])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 May 2022 09:55:37 +0000 (GMT)
Date:   Mon, 9 May 2022 11:55:35 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
Message-ID: <YnjlF8tTWt0yA5xm@osiris>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com>
 <YnV3iljKUM0Fqw/F@hirez.programming.kicks-ass.net>
 <yt9dsfpjgrba.fsf@linux.ibm.com>
 <20220509070831.GD76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509070831.GD76023@worktop.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JM9ILrzA7QLMYMp9JogK1Js5HVVfpunW
X-Proofpoint-GUID: JM9ILrzA7QLMYMp9JogK1Js5HVVfpunW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_03,2022-05-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=888
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:08:31AM +0200, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 08:20:41AM +0200, Sven Schnelle wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > On Wed, May 04, 2022 at 08:23:50AM +0200, Thomas Richter wrote:
> > >> From: Sven Schnelle <svens@linux.ibm.com>
> > >> 
> > >> arch_check_user_regs() is used at the moment to verify that struct pt_regs
> > >> contains valid values when entering the kernel from userspace. s390 needs
> > >> a place in the generic entry code to modify a cpu data structure when
> > >> switching from userspace to kernel mode. As arch_check_user_regs() is
> > >> exactly this, rename it to arch_enter_from_user_mode().
> > >> 
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: Andy Lutomirski <luto@kernel.org>
> > >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > >> ---
> > >
> > > With the note that NMI doesn't (necessarily) call this..
> > >
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > How about:
> > 
> > "When entering the kernel from userspace, arch_check_user_regs() is
> >  used to verify that struct pt_regs contains valid values. Note that
> >  the NMI codepath doesn't call this function. s390 needs a place in the
> >  generic entry code to modify a cpu data structure when switching from
> >  userspace to kernel mode. As arch_check_user_regs() is exactly this,
> >  rename it to arch_enter_from_user_mode()."
> 
> Sure, thanks!

Merged into commit message, and applied both patches to s390 tree.

Thanks!
