Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632824AD9C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350549AbiBHN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358510AbiBHN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:28:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E602E028D09
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:24:03 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218AFQnH025080;
        Tue, 8 Feb 2022 13:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NFuth8SxiHwdmFbcPnyaVO1InzUXePr0k67t1UmkMEM=;
 b=aTGP0ADJI14AB+qhFWvzuFyeodxrfD04gp+4dgtNwMe3Ej750mbD3v/IAso6I+smpNGl
 Z+yPqXzrR0LANby6wvEt1gpSbI9fh2Ad9nwXiN5fE/IZHCaqeXdzj8DVRaJe6FxT9fRl
 SkfTGtnmc4n4GSko6UKV1Nu+ezFryKAECMmLIAFgTVZyt9ArIRICQvnEhySu7xqGLNFQ
 zBlWoFIafCXCsuQrte/rR05pXWdSOu+3yscjiqazNTUNHBq2hPsVhEhhjXd3SPPdyBxi
 NEIkNAnYmaZoVH30ZoXZf3AMZwBv/V1Sg+FMekt1/8WlTNLEmUA1u7nUmTdSds5BxKcR vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22trhw5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:23:34 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218BvqJw023388;
        Tue, 8 Feb 2022 13:23:34 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22trhw53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:23:34 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218DDqXW007058;
        Tue, 8 Feb 2022 13:23:32 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3e1gvb7tre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 13:23:32 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218DNVwO11338066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 13:23:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F9E3112062;
        Tue,  8 Feb 2022 13:23:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61763112061;
        Tue,  8 Feb 2022 13:23:30 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.65.233.120])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Feb 2022 13:23:30 +0000 (GMT)
Date:   Tue, 8 Feb 2022 07:23:28 -0600
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ppc64le: `NOHZ tick-stop error: Non-RCU local softirq work is
 pending, handler #20!!!` when turning off SMT
Message-ID: <YgJu0DZ6rz4kq9JR@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <0baca95b-771f-2217-1098-2d0eee568ea7@molgen.mpg.de>
 <20220208131703.GA538566@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208131703.GA538566@lothringen>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IchAwxR61oGk0GZE9eikQPycGdF7avgf
X-Proofpoint-GUID: rLUYCc53TXB1MU5eT9jJpepkvxp_L9gc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_04,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=720
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 02:17:03PM +0100, Frederic Weisbecker wrote:
> On Tue, Feb 08, 2022 at 08:32:37AM +0100, Paul Menzel wrote:
> > once warned about a NOHZ tick-stop error, when I executed `sudo
> > /usr/sbin/ppc64_cpu --smt=off` (so that KVM would work).
> 
> I see, so I assume this sets some CPUs offline, right?

ppc64_cpu --smt=off sets all but the first CPU per core offline.

PC
