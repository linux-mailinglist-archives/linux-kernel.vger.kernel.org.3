Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4025196E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiEDF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiEDF0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:26:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCA1A3BC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:23:01 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2444olut031528;
        Wed, 4 May 2022 05:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=24RB/HLOYtZvIrRuVGwSYwsoXcOHWsgOEhJJ2V5mDm8=;
 b=AQ9q00LTEL/ZNyqO8pjh4Y5PTfB2QFwHfsc8DXRd9VXQ9c2Oqo3r30WRkX8OovocQtOD
 GGk9bxKSEFHFb1bc8LgNMaE5IjIIULkaG7+LsUlZo/tX3ey95zp6wvt2ppndG9KpdW5Y
 iYkeBYUooh9tDdBvpz2t7nZSsFAJoAwjfT8XcWrp4ZwKFRk0jAKGCgqlrWIcJM6oOlGL
 tE8Qd0OM/WsBWoAizdHwN1L+PRyGIm67nMPiUcUVdQnF4eOBZM7/bYeAG/y8yCfZREZS
 pRrsyBnmNrclOztm/XcQ/s5tCIz5IlXW/+8D4rqf/bjUnYmvR5Fpzo8qBYfUsz9NkOrD 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fujtqrej1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 05:22:59 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2445JRsu011121;
        Wed, 4 May 2022 05:22:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fujtqrehh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 05:22:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2445I2b3003780;
        Wed, 4 May 2022 05:22:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3fttcj1b33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 05:22:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2445MsBc7209338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 05:22:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC027AE045;
        Wed,  4 May 2022 05:22:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CF35AE051;
        Wed,  4 May 2022 05:22:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 May 2022 05:22:54 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] audit: add filterkey to special audit messages
References: <20220503090212.1322050-1-svens@linux.ibm.com>
        <20220503090212.1322050-2-svens@linux.ibm.com>
        <CAHC9VhQ44G1oXLHTf7FmqwzYBRNW=5EPHod1uMTLhaY3sK_Qeg@mail.gmail.com>
Date:   Wed, 04 May 2022 07:22:54 +0200
In-Reply-To: <CAHC9VhQ44G1oXLHTf7FmqwzYBRNW=5EPHod1uMTLhaY3sK_Qeg@mail.gmail.com>
        (Paul Moore's message of "Tue, 3 May 2022 12:57:21 -0400")
Message-ID: <yt9dbkwddg7l.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wCKP6VK8w9RMpIrahzofXVjWTNsQjINg
X-Proofpoint-GUID: 33MC8WjOjA4nFURHawwlqYaTy2EuVfH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_01,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Tue, May 3, 2022 at 5:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>> For automated filtering/testing it is useful to have the
>> filter key logged in the message.
>>
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  kernel/auditsc.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> The SOCKETCALL record, along with all of the others generated inside
> show_special(), are associated with a SYSCALL record which carries the
> "key=" field.  As a general rule we try very hard not to duplicate
> fields across records in a single audit event.

Ok, thanks. Guess you can ignore both patches than.

Thanks!
