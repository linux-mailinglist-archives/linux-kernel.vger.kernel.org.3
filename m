Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20237575CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiGOIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGOID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4C7E01D;
        Fri, 15 Jul 2022 01:03:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F7MnnW027336;
        Fri, 15 Jul 2022 08:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NBUwyhowEQys1JjcN3CXThBF5Vo7fLtS996n4hCauS0=;
 b=MhWfDJCyvHcSth21Rn7xjUnahD+hrqLjCqxKUGMYRlxoVU50vVWC41nAX8pCblOkmw5q
 Hdpu972eNHmoPK0J+gEmnI+XIYTLjsV4mxanurxtyteik8h7BbVrWbG9/cqDsUOu5i//
 80xYZJvCAgzm4xBrRJ7hZ8aG2S89qAq4AxvffxrMXvO65pDpGdqEUycRYvYwkgRMyaIx
 9+Xvwkt8h6h3q7Fg7V1hozIDDsoyUPSlEnkc0Pj0ESmL/4PgvfWDv21MOykm/vJP3kIN
 Jm8OXzTOPjhR2uw3fwkO+Qt3gsb5E0uhwG3Mz7HT+Lx56GX2s15i0K+iE4UHidQdBMEH qA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb3t1gtnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:03:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F7wVKS017500;
        Fri, 15 Jul 2022 08:03:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a903yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:03:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F83Jxo13500694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:03:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B10A404D;
        Fri, 15 Jul 2022 08:03:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1E3A4040;
        Fri, 15 Jul 2022 08:03:19 +0000 (GMT)
Received: from vela (unknown [9.145.26.36])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 08:03:19 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.94.2)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1oCGI9-0002ga-SE; Fri, 15 Jul 2022 10:03:17 +0200
Date:   Fri, 15 Jul 2022 10:03:17 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <YtEfReThyg0/jyK+@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com>
 <Ys3Kt7nG2jtE8H3H@osiris>
 <4132ba2a-f5ad-25ba-7f74-72369b8a140b@linux.ibm.com>
 <Ys/1ab1BXPw1RWuy@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/1ab1BXPw1RWuy@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OIzIy2TV7U-wGyj2fSInnTs3SmfU5BgO
X-Proofpoint-ORIG-GUID: OIzIy2TV7U-wGyj2fSInnTs3SmfU5BgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:52:25PM +0200, Heiko Carstens wrote:
> > > > +static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
> > > > +	[S390_CPU_FEATURE_ESAN3]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ESAN3},
> > > > +	[S390_CPU_FEATURE_ZARCH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ZARCH},
> ...
> > > I only realized now that you added all HWCAP bits here. It was
> > > intentional that I added only the two bits which are currently used
> > > for several reasons:
> > > 
> > > - Keep the array as small as possible.
> > > - No need to keep this array in sync with HWCAPs, if new ones are added.
> > > - There is a for loop in print_cpu_modalias() which iterates over all
> > >    MAX_CPU_FEATURES entries; this should be as fast as possible. Adding
> > >    extra entries burns cycles for no added value.
> > The loop in print_cpu_modalias() was the reason why I added all
> > current HWCAPs. The current implementation runs through all HWCAPs
> > using cpu_have_feature() and I feared that reducing to just MSA and
> > VXRS has effects in the reporting of CPU-features to userspace.
> > 
> > I double checked the output of 'grep features /proc/cpuinfo' and it
> > stays the same, for 5.19-rc6, 5.19-rc6+this series, 5.19-rc6+this series
> > with just the two S390_CPU_FEATUREs. I might have misunderstood what happens
> > in that loop in print_cpu_modalias().
> 
> It is used on cpu hotplug to generate a MODALIAS environment
> variable. You can check that by running "udevadm monitor -p"
> and then switching a cpu off/on.
> 
> This environment variable is then used by systemd/udev to load
> feature matching modules via kmod.

See also some notes on the cpu feature in KRN1305 spec (introduced w/ VX
support).
