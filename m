Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8347574B36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiGNKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiGNKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:52:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC68558CF;
        Thu, 14 Jul 2022 03:52:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EAEiLs022351;
        Thu, 14 Jul 2022 10:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=C2anyf1yrzZL+ykuU7hePx5FGIyAtJfSq27x8aEWYlQ=;
 b=P+ZYnhyBkj4uD5ekcbvFSTTxYGHuN861MbkdF2iduFHrivA4mhzRkaDIhRbmN8LomR3/
 vzh8H/p3tEzY4RQKMkmiTAaAfCiocBLx8xoPRii8CKHC+p2L51th1PkmwfoT2svS5tB/
 ivz7c3n6LCsJu+MnYXF4ds0XSDvcb7Gygm8UkGCXztzbsZK4ms/9slyi81eqBF3OAf/j
 cVU95fXN6fRzbcoNu2AFz3PijP7TBwRLW/uZyH+l116v5/x2aWjeJXjk3bAHg3GLalk9
 dvpGbHYJDRGri/FkUGMzCrDEIwyMAtw5cpL6wsQIlThdmc45wYSISf8mbkoqu+OUiufK xw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hah7g8tks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:52:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26EAotOF013987;
        Thu, 14 Jul 2022 10:52:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhxytf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:52:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26EAqQuc23986492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:52:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3326D42041;
        Thu, 14 Jul 2022 10:52:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A634203F;
        Thu, 14 Jul 2022 10:52:25 +0000 (GMT)
Received: from osiris (unknown [9.152.212.242])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Jul 2022 10:52:25 +0000 (GMT)
Date:   Thu, 14 Jul 2022 12:52:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <Ys/1ab1BXPw1RWuy@osiris>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com>
 <Ys3Kt7nG2jtE8H3H@osiris>
 <4132ba2a-f5ad-25ba-7f74-72369b8a140b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4132ba2a-f5ad-25ba-7f74-72369b8a140b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yRg23_3jnu08hiJYNPJsp6LzK6eLTS1l
X-Proofpoint-ORIG-GUID: yRg23_3jnu08hiJYNPJsp6LzK6eLTS1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_08,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=990 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
> > > +	[S390_CPU_FEATURE_ESAN3]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ESAN3},
> > > +	[S390_CPU_FEATURE_ZARCH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ZARCH},
...
> > I only realized now that you added all HWCAP bits here. It was
> > intentional that I added only the two bits which are currently used
> > for several reasons:
> > 
> > - Keep the array as small as possible.
> > - No need to keep this array in sync with HWCAPs, if new ones are added.
> > - There is a for loop in print_cpu_modalias() which iterates over all
> >    MAX_CPU_FEATURES entries; this should be as fast as possible. Adding
> >    extra entries burns cycles for no added value.
> The loop in print_cpu_modalias() was the reason why I added all
> current HWCAPs. The current implementation runs through all HWCAPs
> using cpu_have_feature() and I feared that reducing to just MSA and
> VXRS has effects in the reporting of CPU-features to userspace.
> 
> I double checked the output of 'grep features /proc/cpuinfo' and it
> stays the same, for 5.19-rc6, 5.19-rc6+this series, 5.19-rc6+this series
> with just the two S390_CPU_FEATUREs. I might have misunderstood what happens
> in that loop in print_cpu_modalias().

It is used on cpu hotplug to generate a MODALIAS environment
variable. You can check that by running "udevadm monitor -p"
and then switching a cpu off/on.

This environment variable is then used by systemd/udev to load
feature matching modules via kmod.
