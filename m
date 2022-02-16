Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C404B9132
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiBPTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:32:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBPTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:32:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6067CDFC;
        Wed, 16 Feb 2022 11:31:59 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GJHekl025850;
        Wed, 16 Feb 2022 19:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=7eSi80sucexNTq5VTd+FJqwj5S44r/5XDWArAHdBcgE=;
 b=Lp9CbHCT2JEEKJS6guX1c8c+bem6OCUGFxBBdSwH5xDMSUkH97kqjEQeLHlIyqB+82nM
 mTgkfDMw6nOMVxfywDQRMudEstBdPujfJPM2h6UTb3WbKLiw9Y0m6MUNUzFFC5o8MI7u
 rzVC+LrK8NUOIvxhZIZfSE2d4m4dmgp8q8Lc+EkbSiPtPbyXKLZGSgRKM+91885HBOn7
 zn4X8cd+SmaKiSPM0HXBFUkiQzr62Sx3GcDyMQoOZNHeLILcVJb9/5Q247dz7geGj2ur
 JrRU7Z4BNxF1OOG/jM5fgrRpgtUjcKv6Y/73VPolRELQgYZaLE1ikX7EynctvxC9zJyS yQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e950tuukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 19:31:43 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GJS8FV029970;
        Wed, 16 Feb 2022 19:31:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e645k2319-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 19:31:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GJVcKN40763862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 19:31:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D6FD11C052;
        Wed, 16 Feb 2022 19:31:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 291E311C05E;
        Wed, 16 Feb 2022 19:31:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Feb 2022 19:31:38 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: ftrace startup tests crashing due to missing rcu_synchronize()
References: <yt9dilte4px4.fsf@linux.ibm.com>
        <20220216135419.01d96fe1@gandalf.local.home>
        <20220216135821.67a22c52@gandalf.local.home>
Date:   Wed, 16 Feb 2022 20:31:37 +0100
In-Reply-To: <20220216135821.67a22c52@gandalf.local.home> (Steven Rostedt's
        message of "Wed, 16 Feb 2022 13:58:21 -0500")
Message-ID: <yt9da6eq4nhi.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VVYir-Eh-pwmDtOVaJejuq5TvIGaxO8Z
X-Proofpoint-ORIG-GUID: VVYir-Eh-pwmDtOVaJejuq5TvIGaxO8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=615
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 16 Feb 2022 13:54:19 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> That is, shutdown is called, the item is removed from the list and freed,
>> but something got preempted while on the ftrace trampoline, with a
>> reference to the item, and then woke up and executed the item that was
>> freed.
>> 
>> I'll look into it. Thanks for the report.
>
> OK, I wonder if something changed with "is_kernel_core_date()"?
>
> Because on registering, we have:
>
> 	if (!is_kernel_core_data((unsigned long)ops))
> 		ops->flags |= FTRACE_OPS_FL_DYNAMIC;

I checked, and the flag gets set here. I cannot say whether it
is also set when the system crashes, but i would expect it.
