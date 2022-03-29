Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255F4EB225
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiC2Qt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiC2QtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:49:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF206211F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:47:41 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TFsrMr003612;
        Tue, 29 Mar 2022 16:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GGKNeV/gY92UXzgFNtB6asnSVh287RpznEXVzvvgBFk=;
 b=AF4URul67qeOefpDxVANug9r+TNMEK44sxYcen5D+rSAqlOAkvlaPJCub17GpEVK5Qyj
 hOlE33T1COdoBe9bqFC9BpKcyvYr9lKD+Mf9LOfMpQFU7V/qMZQ3OESnkJhh4ycL5IJT
 w2ZFH/Mk6Gh7hebeYEjNum9NU3VE+19nJ9RjhMJq8xbuZWDLeaAFCO9mZM5seFyMyuxl
 fMnm0W+MHyysNVcWnDHdszFgyTUY5qjyvevOoglCvxysqABG/Z/LjlF95k1T5QrIZQv/
 dcsFW0whYB/axkeGeT4bGX31lireYuzSgSl9LAfsQcPDeOuZDl3UGaXw5FnF8edGtICc kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40t885n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 16:47:35 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22TGgvuM016680;
        Tue, 29 Mar 2022 16:47:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40t885mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 16:47:34 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22TGlCdW027362;
        Tue, 29 Mar 2022 16:47:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3f1tf8wng0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 16:47:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22TGlTck30474540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 16:47:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9701A4057;
        Tue, 29 Mar 2022 16:47:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE01A4055;
        Tue, 29 Mar 2022 16:47:10 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.18.42])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Mar 2022 16:47:08 +0000 (GMT)
Date:   Tue, 29 Mar 2022 22:16:54 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
Message-ID: <YkM3/vKRoy8/fnvD@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <55161160-1084-c81d-d116-00f5bcaa1268@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55161160-1084-c81d-d116-00f5bcaa1268@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkFLX3C5bmzK9TV7PYHEGpA4HH6tJK2R
X-Proofpoint-GUID: 8G7qoZUOfJiNX9tvu8Kl53pBaSM1mHST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_06,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=530 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:31:12AM -0700, Dave Hansen wrote:
> On 3/29/22 04:52, Jagdish Gediya wrote:
> > The current implementation to identify the demotion
> > targets limits some of the opportunities to share
> > the demotion targets between multiple source nodes.
> 
> This changelog is a bit unsatisfying.  It basically says: the current
> code isn't working, throw some more code at the problem.

The current code works but it doesn't utilize all the possibilities
for the demotion. One of the comment in the current code says that
'used_targets will become unavailable in future passes. This limits
some opportunities for multiple source nodes to share a destination.'
This patch removes those limitation. The current limitation is single
used_target nodemask sharing between all the nodes, This patch prepares
the used_targets from scratch for each individual node and then tries
to avoid the looping based on what demotion targets are not possible
for that particular node based on the data we accumulate in newly
defined src_nodes array.

For example, with below numa topology where node 0,1 & 2 are cpu + dram
node and node 3 is slow memory node,
node   0   1   2   3
  0:  10  20  20  40
  1:  20  10  20  40
  2:  20  20  10  40
  3:  40  40  40  10

once node 3 is utilized for node 0, it can not be shared for node 1 & 2
because in current code, used_targets will have that set even when we
find demotion targets for  1 & 2.

> I'd love to see some more information about *why* the current code
> doesn't work.  Is it purely a bug or was it mis-designed?

I think the design seems to be intended because as per the comment
in the current code, it was known that there are limits to the node
sharing as a demotion target.

> I actually wrote it intending for it to handle cases like you describe
> while not leaving lots of nodes without demotion targets.

if you see the examples I have given in the commit message, the current
code misses many opportunities for the demotion, so current
implementation to avoid the looping is not the best as I have explained
above, that is where this patch is required.
