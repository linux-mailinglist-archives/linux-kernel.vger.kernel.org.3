Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC704D85EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiCNNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiCNNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:32:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE913D73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:31:16 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EDDHa5016652;
        Mon, 14 Mar 2022 13:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=NgDfcMbBGd3DW5fIpR/Qs+Z/HcDTzQJQcY7VH4+xRlQ=;
 b=l7u+H6NDYrHrNDmmNzJ4WbiSV1eb92bPL7qD1dxIebKEG8qaHzkhxM6FnKR7UrxQPgWI
 NMnV5L07zF9JuaA9WT1/3P41XAhSu3MBfFrwPPiqphUfcYiifgx8psDe5RwBbYx3isuP
 EprYLgAhChrKr3xcx8j4syqs0i1J3ZiY1ZIT+Sc29DjAa+712E3ImXUi47gobsyc5aJg
 7pcnol+JDRdCf3XGgu2W9IkG87SA78gfm+sdf7+ScPhcLm5q32p5+pG91UaJwZpkdDYM
 mIq4MvuBfUb2ALYFtWIn+5Wvn68/4BADN3S4hhTpFTcPBaYKGt7H0IbHLodprhqi1UlA aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d98rvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:30:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EDDV8l018765;
        Mon, 14 Mar 2022 13:30:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d98ndc-106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:30:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EAxHSn010595;
        Mon, 14 Mar 2022 11:09:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshkysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 11:09:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EB91Tv28967192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 11:09:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0D64A42D9;
        Mon, 14 Mar 2022 11:07:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E269A422D;
        Mon, 14 Mar 2022 11:06:54 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Mar 2022 11:06:54 +0000 (GMT)
Date:   Mon, 14 Mar 2022 16:36:53 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220314110653.GM618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
 <20220308092944.GJ618915@linux.vnet.ibm.com>
 <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
 <20220309052554.GK618915@linux.vnet.ibm.com>
 <bb443650-868a-49b7-e41e-c2a788781df5@amd.com>
 <20220309094320.GL618915@linux.vnet.ibm.com>
 <9effd823-5375-fce0-cb92-6630e82d8b04@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9effd823-5375-fce0-cb92-6630e82d8b04@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1TuZbGqvSJ_qoQVJnbLUZPvGHZME_YkZ
X-Proofpoint-ORIG-GUID: Zmvb6ER6ezzHHQOszOXQqS7iTY-epXpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_08,2022-03-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-09 17:00:33]:

> Hello Srikar,
> 
> On 3/9/2022 3:13 PM, Srikar Dronamraju wrote:
> > [..snip..]
> > I completely understand your problem. The only missing piece is why is this
> > initial placement *not a problem for the unpinned case*. If we are able to
> > articulate how the current code works well for the unpinned case, I would
> > be fine.
> From what I understand, the initial task placement happens as follows:
> 
> When a new task is created via fork or exec, for the initial wakeup
> it takes the slow path in select_task_rq_fair() and goes to
> find_idlest_cpu(). find_idlest_cpu() will explore the sched domain
> hierarchy in a top-down fashion to find the idlest cpu for task to
> run on.
> 
> During this, it'll call find_idlest_group() to get the idlest group
> within a particular domain to search for the target cpu. In our case,
> the local group will have spare capacity to accommodate tasks.
> We only do a cpumask_test_cpu(this_cpu, sched_group_span(group))
> to check is the task can run on a particular group.
> 

[snip]

Ok, Prateek, I do understand the intent here.
Thanks for spending the time to explain the same.

> Ah! I see. But I do believe this problem of initial
> placement lies along the wakeup path.
> --
> Thanks and Regards,
> Prateek

-- 
Thanks and Regards
Srikar Dronamraju
