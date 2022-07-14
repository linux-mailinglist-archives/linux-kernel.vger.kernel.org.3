Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA00574B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiGNKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGNKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:53:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA233B2;
        Thu, 14 Jul 2022 03:53:34 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EAjuQH008236;
        Thu, 14 Jul 2022 10:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GcThNGg2Yr2aKFd8MolPLAVThyf+NGmaQQcFslu0LEQ=;
 b=jgCrSLf0TtQvBXRXEoYnF8ny05AluKlyNMeumQrRh798sRWLMRbbmlxmFlqvwRY+J8YN
 5buiGt+AA3IezNmaLPoE4mPVT2eIK3LOuEqwQe2kG5tkUtfUmyUe487p0pyLkOpmGRi9
 WNHhkPqYaW/v8s2/K7x6BNSBRhpAobHf+xIEPAE5seNbNkrCffitgohr6t/qBCHWMlmy
 mxB0wDOouwhQnrQYPIfRopoeWzS0kL3Q1lLC/gcDiE0oEkoPkz7VARKaUL1u6vXPvfdH
 g+/MS4jeiU7ziRXB+y5lCCPEyxIEjS1YRbYIXe05k/2IKPKUUMJdEDoaSNgH0QSKiMLC Pw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hahp7r55k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:53:32 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26EAorS8018567;
        Thu, 14 Jul 2022 10:53:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3h71a8x949-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:53:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26EArQur12648880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:53:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2BE04203F;
        Thu, 14 Jul 2022 10:53:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C80342042;
        Thu, 14 Jul 2022 10:53:26 +0000 (GMT)
Received: from osiris (unknown [9.152.212.242])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Jul 2022 10:53:26 +0000 (GMT)
Date:   Thu, 14 Jul 2022 12:53:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH v2 0/3] s390/cpufeature: rework to allow different types
 of cpufeatures
Message-ID: <Ys/1pZ5Z4GlC7YEe@osiris>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713125644.16121-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GznMXaIexpPSwtwtUOuc_x96QF1jYkAs
X-Proofpoint-GUID: GznMXaIexpPSwtwtUOuc_x96QF1jYkAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_08,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=767 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:56:41PM +0200, Steffen Eiden wrote:
> Currently the s390 implementaion of cpufeature is limited to elf_hwcap
> bits. Using these to automatically load modules also exposes this
> cpufeature to userspace which, sometimes is not intended.
> 
> Therefore, rework the s390-cpufeature implementation to allow for
> various cpu feature indications, which is not only limited to hwcap bits.
> 
> Add a new type to allow facilities to be a cpufeature without using
> hwcap bits that expose this feature to userspace.
> 
> Load uvdevice when facility 158 is present.
> 
> since v1:
> 	* add r-bs from Claudio
> 	* worked in comments
> 
> Heiko Carstens (2):
>   s390/cpufeature: rework to allow more than only hwcap bits
>   s390/cpufeature: allow for facility bits
> 
> Steffen Eiden (1):
>   s390/uvdevice: autoload module based on CPU facility

Series applied, thanks!
