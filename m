Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D435115EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiD0Kv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiD0KvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBB48DEC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:22:31 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RA81ma025510;
        Wed, 27 Apr 2022 10:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mSV32sp7cJhcsos5Ovf87FuQrg2T/M26sICQvRjZKQM=;
 b=dyF6dMnew8xgXK6WOquOzkbH5YRxeipcqw23pz+DVZA8KMN3A/GaQUCqTwJaK6jzcUEO
 KGsPCX7zY2TjVV11EK+eW+UsK7Uiuwduv2z/zUYDMYkYt9+NcXKVTCu+ZWDhgs7QyyUL
 vcbT/kNDPtsgg297B79YrfRGrHIoqkvl717rYWS1Y5OFA7jRaYlWgi6zGCrZL5jUtEq9
 sW3gcIhbyi54yMjJGO9OJ9jZdQu67B+VZ1YHbjwy0GL1O7JzoLFftVuJRf/8mbHbLzCC
 kzB3BGRnM5UXT8HjRBD1o5cW7vUsh7Q9StPyibWps7iYCbvD7ozCdCahEuGC1IRa0Jpr +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpsdpjw02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 10:22:04 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23RALYge032105;
        Wed, 27 Apr 2022 10:22:04 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpsdpjvys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 10:22:04 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23RAIcpY015710;
        Wed, 27 Apr 2022 10:22:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhmhq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 10:22:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23RALxDl49938876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 10:21:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A3FA4054;
        Wed, 27 Apr 2022 10:21:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64AE6A405F;
        Wed, 27 Apr 2022 10:21:56 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.114.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Apr 2022 10:21:56 +0000 (GMT)
Date:   Wed, 27 Apr 2022 15:51:49 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <YmkZPYqIpIOfu8Ce@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <YmhEqCCfUvYYPmci@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhEqCCfUvYYPmci@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eYYxBJq2nS7cbuxCNHN0-PCJsqsMqnuR
X-Proofpoint-GUID: _uy774HE_0Tj2AqL0lnTKdlHrLbqCDZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_03,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=689
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:14:48PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> HEY!  You still have the buggy IFF -> IF change.  FIX IT.
> My R-b was very clearly conditional on you fixing it.

My bad, I forgot to correct it. Andrew has corrected it.

> > - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> > + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
