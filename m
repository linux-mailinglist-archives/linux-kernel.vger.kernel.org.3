Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C8557E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiFWPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiFWPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEB19FAD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:13:18 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NEvnlL022324;
        Thu, 23 Jun 2022 15:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sBtAlbehnBC5gvwLF+7/KNPN9s0TH5AndEXoR2BLKoU=;
 b=cksxygNUmwI/kly6jWbUrueB7cM1R179fi02xLH0f/d5PUTk+YyNraxqL4iQCpl6K5Rp
 YVzxHsYbYj6+6LWsj/UxnruabV9NWaqVY4YvNaaUeGd3+2wPukoujky1WbQfDIB1sc/L
 f7Acm5AyyENAwNyMPyiMloI8dcu8//gusx/bRTnWL5Ss5CvMDY1nFTAeqTCJNHUv3SjN
 h+N0dN0iZXgjSbJgl5dE9zHoYlItM0mj51WbPHQC9KtDehyPbFcrL3MiNWrP21XsLfHc
 bA3fNesXYIR1oHcjm2mOo+zB8URt4dFkURZBu8ebnLEc5b5DvFBjZwxWDZCUEMrr41Gl Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvhnh0hwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 15:12:57 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25NEw3SO022880;
        Thu, 23 Jun 2022 15:12:56 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvhnh0hv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 15:12:56 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NF61ET019943;
        Thu, 23 Jun 2022 15:12:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3gv3mb9cvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 15:12:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NFComo20709692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 15:12:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2425A4040;
        Thu, 23 Jun 2022 15:12:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4620AA404D;
        Thu, 23 Jun 2022 15:12:50 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jun 2022 15:12:50 +0000 (GMT)
Date:   Thu, 23 Jun 2022 17:12:48 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Robert O'Callahan" <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
Message-ID: <YrSC8AxEV24IgSbm@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f_L7GjTrz00iN_91kYw0jfjRp7Sr5ALC
X-Proofpoint-GUID: DBpZlsdBY4ZFujTVTCVePkxZblVMjAlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_06,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 mlxlogscore=745
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:43:37AM -0500, Eric W. Biederman wrote:
> Recently I had a conversation where it was pointed out to me that
> SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
> difficult for a tracer to handle.
> 
> Keeping SIGKILL working for anything after the process has been killed
> is also a real pain from an implementation point of view.
> 
> So I am attempting to remove this wart in the userspace API and see
> if anyone cares.

Hi Eric,

With this series s390 hits the warning exactly same way. Is that expected?

Thanks!
