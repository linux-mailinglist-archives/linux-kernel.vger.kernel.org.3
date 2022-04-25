Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC10E50DDCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiDYKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiDYKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:25:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143935D187;
        Mon, 25 Apr 2022 03:21:57 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P8MpI7023893;
        Mon, 25 Apr 2022 10:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Au4JzryWRBYgy4L1Xbqp/CvWbSnc2mAQbKPn+mwsVH0=;
 b=DgoOhFsX4udMT/K6Kx6FVRwcQGIpR2htQo3Bt4+5upakDxiQ4d9CkTflaZJBvPd/JRnz
 VNHCTsf2mbuooCU6nPiENk3rHgZgr5JMrP8hUxyn5cSALo3HO66P6Sv++Tp/wV04BB+2
 iG4oGUXqHS+bSrbHW1RHdCJc3IlGNxluXLErKPP5zwGu5iXWLaVp51N7x5swU2Twcvx7
 K6KGD4Eor6M9iPMYL8ouMk9mZX7+07J2XLHOxQEdGjgRWJQo3x5Cldyd+O/x+ul2l4Z5
 HkVQHnFKStFdbbK2TxtHCO+QbngL7Mcu4WPs7PY/AHrQie8Ep/Pua9zRovkfFiU8JhmH Nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmuh5wydy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:21:44 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PADNWg029499;
        Mon, 25 Apr 2022 10:21:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhhtdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 10:21:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PALp3856164610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 10:21:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0FE2A4054;
        Mon, 25 Apr 2022 10:21:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E186A405B;
        Mon, 25 Apr 2022 10:21:38 +0000 (GMT)
Received: from osiris (unknown [9.145.60.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 10:21:38 +0000 (GMT)
Date:   Mon, 25 Apr 2022 12:21:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v6 02/17] s390: define get_cycles macro for arch-override
Message-ID: <YmZ2MSQssUNwoprd@osiris>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-3-Jason@zx2c4.com>
 <YmZtJz4tsP6hr2H5@osiris>
 <CAHmME9r84RAvALEA91b+uRaRfhM1VJn=bQkPWQ=n+_ZWpnPb5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r84RAvALEA91b+uRaRfhM1VJn=bQkPWQ=n+_ZWpnPb5w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dLjpCHMTCJRAW-5iEGbUuGwEdFn7OJKS
X-Proofpoint-GUID: dLjpCHMTCJRAW-5iEGbUuGwEdFn7OJKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=626
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:48:34AM +0200, Jason A. Donenfeld wrote:
> On 4/25/22, Heiko Carstens <hca@linux.ibm.com> wrote:
> > Is any of your subsequent patches making sure that the asm generic
> > header file gets included everywhere? Otherwise I don't see the point
> > of this patch.
> 
> Yes; patch 6 requires this as a prereq. I'm not doing this arbitrarily.

Ok, that was not obvious to me, especially since I was only cc'ed for
this patch and assumed this was actually a bug fix.
Thanks for clarifying.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
