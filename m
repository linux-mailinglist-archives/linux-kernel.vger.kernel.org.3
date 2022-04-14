Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246C25008B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiDNIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiDNIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:50:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF165D24
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:48:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23E5x8PD001521;
        Thu, 14 Apr 2022 08:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=9KoSwCzdoavRYeHN2J3+5Miyetgwpz0DL+/kJ6CCnWc=;
 b=VhmirNcpoFB6ZJZp9oZtA4QLD3SEi4qrPsePrAT0GEUEPCcfW6y7ukiXV6fUVIjvPSLF
 N/5UQyeH2fU+OieNu3YMjbSdzz9m6K/FhAlgf8ZG/poCeEsXy0eVD8EZv+2Vi/VM7GHC
 dLB+H2Tpdo2PdOLna9joxrfPRYw5edAITqKX3JRFinOH2Aj4PtYS2xZvJBEZr4819U/J
 0K+OPdHXT8gUcBZVgQFAlQrR1l+5n9H84aoRzFcjokVFG+1RYMvcD742+RaDIqFjZC1T
 I2j7Fx65JFNCs9MwANTTAQ/j0VOVJUHpHibgWwRkj+S3KbPIy6jHsnpbcXfHblNGn+sj PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fedxsk09m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 08:48:18 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23E80RtN026020;
        Thu, 14 Apr 2022 08:48:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fedxsk097-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 08:48:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23E8mGlM030389;
        Thu, 14 Apr 2022 08:48:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s900yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 08:48:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23E8mDtr49021202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 08:48:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C42F44C04E;
        Thu, 14 Apr 2022 08:48:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A5D4C044;
        Thu, 14 Apr 2022 08:48:11 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.11.20])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 08:48:10 +0000 (GMT)
Date:   Thu, 14 Apr 2022 14:18:00 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
Message-ID: <YlffwGJg/RWCYja7@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <20220413092206.73974-2-jvgediya@linux.ibm.com>
 <4288cbad49690d7c4eb2b1d705eea01221ab8328.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4288cbad49690d7c4eb2b1d705eea01221ab8328.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qNzJLfL8g_AACqRr0gpvPqBEcVdquWdK
X-Proofpoint-GUID: 818oo_B3BTAKae1XoSZyE31C1hikzShW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_02,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=847 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:09:42PM +0800, ying.huang@intel.com wrote:
> On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > Sharing used_targets between multiple nodes in a single
> > pass limits some of the opportunities for demotion target
> > sharing.
> > 
> > Don't share the used targets between multiple nodes in a
> > single pass, instead accumulate all the used targets in
> > source nodes shared by all pass, and reset 'used_targets'
> > to source nodes while finding demotion targets for any new
> > node.
> > 
> > This results into some more opportunities to share demotion
> > targets between multiple source nodes, e.g. with below NUMA
> > topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
> > are equally slower memory only nodes, and node 4 is slowest
> > memory only node,
> > 
> > available: 5 nodes (0-4)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus: 2 3
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus:
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node 4 cpus:
> > node 4 size: n MB
> > node 4 free: n MB
> > node distances:
> > node   0   1   2   3   4
> >   0:  10  20  40  40  80
> >   1:  20  10  40  40  80
> >   2:  40  40  10  40  80
> >   3:  40  40  40  10  80
> >   4:  80  80  80  80  10
> > 
> > The existing implementation gives below demotion targets,
> > 
> > node    demotion_target
> >  0              3, 2
> >  1              4
> >  2              X
> >  3              X
> >  4              X
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >  0              3, 2
> >  1              3, 2
> >  2              4
> >  3              4
> >  4              X
> > 
> > e.g. with below NUMA topology, where node 0, 1 & 2 are
> > cpu + dram nodes and node 3 is slow memory node,
> > 
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus: 2 3
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 4 5
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  20  20  40
> >   1:  20  10  20  40
> >   2:  20  20  10  40
> >   3:  40  40  40  10
> > 
> > The existing implementation gives below demotion targets,
> > 
> > node    demotion_target
> >  0              3
> >  1              X
> >  2              X
> >  3              X
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >  0              3
> >  1              3
> >  2              3
> >  3              X
> > 
> 
> With the [PATCH v1], you have describe the demotion order changes for
> the following system, I guess there's no change with [PATCH v2]?

Yes, there is no change with v2.

> With below NUMA topology, where node 0 & 2 are cpu + dram
> nodes and node 1 & 3 are slow memory nodes,
> 
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>   0:  10  40  20  80
>   1:  40  10  80  80
>   2:  20  80  10  40
>   3:  80  80  40  10
> 
> And, what is the demotion order for the following system with [PATCH
> v2]?
> 
> Node 0 & 2 are cpu + dram nodes and node 1 are slow
> memory node near node 0,
> 
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node distances:
> node   0   1   2
>   0:  10  40  20
>   1:  40  10  80
>   2:  20  80  10

node 1 is demotion target for both node 0 and node 2 with this patch.
node 1 is demotion target only for node 0 with existing implementation,
however if node 1 is near to node 2 instead of node 0, still existing
implementation will give node 1 as demotion target only for node 0 which
is not the correct behavior.

for both the scenario, with this patch applied, node 1 will be demotion
target for both 0 and 2.

> Best Regards,
> Huang, Ying
> 
> 
> [snip]
> 
> 
> 
Best regards,
Jagdish
