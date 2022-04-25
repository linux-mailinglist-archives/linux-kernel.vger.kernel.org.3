Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A350DCD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiDYJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbiDYJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4109027B31
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:32:29 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P87Shb023705;
        Mon, 25 Apr 2022 09:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uOxDMBWeLkg9WNZeIza4Ng+gLhOHcmfsuTeiM+dbGv4=;
 b=QpWuA09OcWwa95NDnpakN3mTdRJq4wCbQlJ8F3MG614EtcvjHYHPJSI+XD+bs0EUS2lv
 nG20LfkUUkljDqwVyqDvEP6FYwUfeO3H94yq5qK1UP1tI+NzzolE1pRbNX+wo5d1rUWY
 WRk4pGZWwEK6/fHnHcdm9UMYawzWvHxm2Sazg/MryeLrhQmYxqCxY9CcQI5qeF7P7KkK
 adGVW3+NvMqdt1+vwRhoCQnmxS7v0ma7yWhZcKjpjWZ/2Sbrk8LEJ99bTWIUSUAb/HYV
 ciNpI6FGTdhVxWZ8GDNrQqvrS+pglMSQEO+2KQGfCtdVx2V1pA0RcdpGGXnRwO/+RxkQ nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh5vv2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:32:24 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23P9WNJT010970;
        Mon, 25 Apr 2022 09:32:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh5vv22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:32:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P9RLTB017445;
        Mon, 25 Apr 2022 09:32:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938t49u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:32:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P9WIHZ58065256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 09:32:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A3A4C040;
        Mon, 25 Apr 2022 09:32:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 104394C044;
        Mon, 25 Apr 2022 09:32:16 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.47.198])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 09:32:15 +0000 (GMT)
Date:   Mon, 25 Apr 2022 15:02:08 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among
 sources
Message-ID: <YmZqmEyEcs3wwu2a@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <20220422195516.10769-2-jvgediya@linux.ibm.com>
 <bb4daddde2df1762dd0d6f2faac1d196a01d50be.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4daddde2df1762dd0d6f2faac1d196a01d50be.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 58Me0xLUKT-80JlZi4j6SGJUVlIKy24Y
X-Proofpoint-GUID: _4klCVE2yRjutZrfd7aIDoXua3OnRyrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 11:25:50AM +0800, ying.huang@intel.com wrote:
> > Subject: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among sources
> 
> IMHO, this patch doesn't fix some bugs in the original code.  Instead,
> it just enhances the original code.  For example, the subject could be,

I think it is fixing a bug, there is a comment in the code which
mentions that 'used_targets will become unavailable in future passes.
This limits some opportunities for multiple source nodes to share a
destination'. As per this comment, it was intended to share a node as
demotion targets with some limits but the code limits not some but all
such opportunities as no common node can be demotion targets for
multiple source node as per current code.

>   mm: demotion: support to share demotion targets among sources
> 
> Best Regards,
> Huang, Ying
> 
> [snip]
> 
> 
> 
