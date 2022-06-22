Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216B7554E27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358797AbiFVPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbiFVPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B387B3E0F7;
        Wed, 22 Jun 2022 08:00:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEQdr5015397;
        Wed, 22 Jun 2022 15:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KA1JdRgtOjD40XyEB3YqySk4ezHovydA8xxcytIvEYQ=;
 b=NSBfEbpYDxi2EtzNLiGVV4uw1tjgyyVZdTF3fBoUUnpPsANoCAlYlzWhxtg5Oq+P4sTu
 5m4PFGlO2NcWLddzGRSFyXitMpxqzZvNKN52q2zc0lm/jJ7/E151gitnra9uYlBlNnUQ
 fmJJ3y1HQJqtMnufByjLitBTsSjQ1Eg7aM0yngk2TnxOqtHpBKxM5s5555U5j65TPnJY
 1O+GOj7sL7iVvrrW9itY1Qj5FWzEcYv28Cr776eCSkjsFf2LnsienjEtaIdhWVMRe+I9
 Ho6do+V7MIb2OjAj+THetnBcswJVH1ihve2C4/dumParYTlWwj1ccA9v9AXLjuoQroqg Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4uqh36s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 15:00:32 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25MER0wW016225;
        Wed, 22 Jun 2022 15:00:32 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv4uqh35a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 15:00:32 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MEZV2m007182;
        Wed, 22 Jun 2022 15:00:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3gs6babcy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 15:00:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MExFXV6489080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 14:59:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E46AC05B;
        Wed, 22 Jun 2022 14:59:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC5DDAC05F;
        Wed, 22 Jun 2022 14:59:14 +0000 (GMT)
Received: from li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com (unknown [9.160.24.26])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 14:59:14 +0000 (GMT)
Date:   Wed, 22 Jun 2022 09:59:13 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC 00/13] perf: Add perf kwork
Message-ID: <YrMuQXIn9DdhZl2w@li-be644d4c-2c59-11b2-a85c-bc3dba3ed00b.ibm.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AvCbPAo-d3UsCRqJ_ADSkvTZyHdcA9f6
X-Proofpoint-GUID: aGQ6kEiRha3BkJ7E2zLkTpSiFgYZfmCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=799
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206220074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:45:52PM +0800, Yang Jihong wrote:
> Sometimes, we need to analyze time properties of kernel work such as irq,
> softirq, and workqueue, such as delay and running time of specific interrupts.
> Currently, these events have kernel tracepoints, but perf tool does not
> directly analyze the delay of these events
> 
> The perf-kwork tool is used to trace time properties of kernel work
> (such as irq, softirq, and workqueue), including runtime, latency,
> and timehist, using the infrastructure in the perf tools to allow
> tracing extra targets
> 
> test case:
> 
>   # perf kwork report
> 
>     Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
>    ---------------------------------------------------------------------------------------------------------------------------
>     (s)RCU:9                  | 0007 |      3.488 ms |      1258 |      0.145 ms |    3398384.220013 s |    3398384.220157 s |
>     (s)NET_RX:3               | 0003 |      1.866 ms |       156 |      0.042 ms |    3398385.629764 s |    3398385.629806 s |
>     (s)TIMER:1                | 0000 |      1.799 ms |       117 |      0.055 ms |    3398385.568033 s |    3398385.568088 s |
>     (w)0xffff9c66e563ee98     | 0006 |      1.561 ms |         5 |      0.351 ms |    3398384.060021 s |    3398384.060371 s |

What units are used for "Frequency"? It would be helpful to include somewhere.

PC
