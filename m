Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E3557DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiFWO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:26:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916836B6C;
        Thu, 23 Jun 2022 07:26:14 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NDFmHq006493;
        Thu, 23 Jun 2022 14:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UH/E2Dz3Di0zJG/5hMV/2VU5CDhkghCuUBcdP0NHpi8=;
 b=W2v52cUL38m7HOrqMIAW2zRSlRc1PxdEPhj356a6wQZWInebAd6W7Uxk3SX93YuP4QOo
 cwAEAruz7xqNDCONNX6CycD3Bv5Awf2pTJ+05POfSntsj/Au+hkeaIhO9wAUxdCWNkj+
 5PHY3N5sroMH3GEF6oJHhivngVGj2+zcI2qIvBnSYaLKibRAOeFKmOJn1S367F6uNauG
 H7Y+r78WCtN2AvggxZuLQSneT4K84c2EteXznVSdVTlwj+mfTuzjAAuSSeQ6zmkkTAfL
 XTh1Ztn2FzmHVv6AabPTNtuueQHyE+oEMkBLNNVhl+XG2WW2Cd+aLzgMwxDvg9J3DqVf eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvrwfj4ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 14:25:46 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25NDuJJp028009;
        Thu, 23 Jun 2022 14:25:46 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvrwfj49f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 14:25:45 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25NEKPvj029358;
        Thu, 23 Jun 2022 14:25:44 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3guk92mvax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 14:25:44 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25NEPh6Q32964966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:25:43 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D9646E050;
        Thu, 23 Jun 2022 14:25:43 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70ACB6E04E;
        Thu, 23 Jun 2022 14:25:41 +0000 (GMT)
Received: from li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com (unknown [9.160.24.26])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jun 2022 14:25:41 +0000 (GMT)
Date:   Thu, 23 Jun 2022 09:25:39 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC 00/13] perf: Add perf kwork
Message-ID: <YrR34345A4h/5RfU@li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <YrMuQXIn9DdhZl2w@li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com>
 <3cccc03a-c2bc-91d9-60b9-daf180c6b108@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cccc03a-c2bc-91d9-60b9-daf180c6b108@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yuzybOkGMxq9-YeFQYK1WhuDyDdLflyW
X-Proofpoint-ORIG-GUID: 0BMRZkLs11qURKaveAhmnIukMD_x9TJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_06,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=872
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 09:02:45AM +0800, Yang Jihong wrote:
> On 2022/6/22 22:59, Paul A. Clarke wrote:
> > On Mon, Jun 13, 2022 at 05:45:52PM +0800, Yang Jihong wrote:
> > > Sometimes, we need to analyze time properties of kernel work such as irq,
> > > softirq, and workqueue, such as delay and running time of specific interrupts.
> > > Currently, these events have kernel tracepoints, but perf tool does not
> > > directly analyze the delay of these events
> > > 
> > > The perf-kwork tool is used to trace time properties of kernel work
> > > (such as irq, softirq, and workqueue), including runtime, latency,
> > > and timehist, using the infrastructure in the perf tools to allow
> > > tracing extra targets
> > > 
> > > test case:
> > > 
> > >    # perf kwork report
> > > 
> > >      Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
> > >     ---------------------------------------------------------------------------------------------------------------------------
> > >      (s)RCU:9                  | 0007 |      3.488 ms |      1258 |      0.145 ms |    3398384.220013 s |    3398384.220157 s |
> > >      (s)NET_RX:3               | 0003 |      1.866 ms |       156 |      0.042 ms |    3398385.629764 s |    3398385.629806 s |
> > >      (s)TIMER:1                | 0000 |      1.799 ms |       117 |      0.055 ms |    3398385.568033 s |    3398385.568088 s |
> > >      (w)0xffff9c66e563ee98     | 0006 |      1.561 ms |         5 |      0.351 ms |    3398384.060021 s |    3398384.060371 s |
> > 
> > What units are used for "Frequency"? It would be helpful to include somewhere.

> This refers to the number of event in the trace period.

I see. I suggest changing the column heading to say that.
"Count", "Number of Events", "Occurrences", something like that.

"Frequency" is a count-per-time-unit, like hertz, which doesn't
match well here.

PC
