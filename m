Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F54960B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381047AbiAUO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:26:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381028AbiAUO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:26:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LDZxnN030038;
        Fri, 21 Jan 2022 14:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lsebu3yywD9GXAKMlk2Xl0HzAG5hoaXOsUFjDfEzK3Q=;
 b=a0mT4g4u4SjEAKHSRhxwyGiN5wWO427PD+MgDaGy0yDlacNTWLQMJxswnSJJ8jpwNGbM
 RkTgUtMQWlkC5b4ijEM8ypE/sIesKXCxhniGjtGhFg7DUeiQueEjhtvsAQgZIQRGYT/r
 0rVjiT65w3awX/C+YVXDAGgTFyJ8oCkrQUya9+Hhek/nYGTRx2hhzA77SlMTznARptN5
 E7J1nF8dCGzY+VkQ+xwEMxNfWGZIxsnT4Qp3XaaTAOm9y4yJIn/rmjrd5czwC8uwPu9F
 7pp+KWt90wDaB4YL1o2GKr2FqVMfuI5VgcP33bFG5EucyFceqvnFDg6fdbjMbo6gZ115 aw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqt27wuqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 14:26:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LE8ZDm001893;
        Fri, 21 Jan 2022 14:26:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3dqjepn9pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 14:26:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LEQ6lJ32833992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 14:26:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF80DAE055;
        Fri, 21 Jan 2022 14:26:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0DEAAE04D;
        Fri, 21 Jan 2022 14:26:05 +0000 (GMT)
Received: from osiris (unknown [9.145.74.142])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jan 2022 14:26:05 +0000 (GMT)
Date:   Fri, 21 Jan 2022 15:26:04 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YerCfDceDszqbdHU@osiris>
References: <20220118095210.1651483-2-scgl@linux.ibm.com>
 <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
 <YelcCEuVbIg9ND90@osiris>
 <YemnprCIEjjGFeTn@osiris>
 <b6896b1a-d529-1504-091c-d41287c01dc8@linux.ibm.com>
 <YeqTP6WDbZzEJUbJ@osiris>
 <13a03972-0020-b8e7-2fc0-def8a164eb10@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a03972-0020-b8e7-2fc0-def8a164eb10@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F8E0q23zV84nP37URidlBGxChnAmGMRc
X-Proofpoint-GUID: F8E0q23zV84nP37URidlBGxChnAmGMRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=815
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 02:46:02PM +0100, Janis Schoetterl-Glausch wrote:
> >> +static inline __must_check unsigned long
> >> +_copy_from_user_key(void *to, const void __user *from, unsigned long n, u8 key)
> > 
> > Make key unsigned long, add support for INLINE_COPY_TO_USER, and maybe
> > add a wrapper, so this works on all architectures, e.g. if
> > raw_copy_to_user_key() is not defined, then fall back to
> > raw_copy_to_user() and ignore the key parameter.
> > 
> 
> Since we only need the double underscore variants, even if we're going to be more
> general than we need to be, we can restrict ourselves to those, can't we?

I don't think that works with INLINE_COPY_TO_USER. The reason for the
single underline variants is being able to have an out-line-implementation
in lib/usercopy.c, isn't it?

> I don't understand your comment about the wrapper. You'd want an error on misuse,
> that is, if you try to use a _with_key function if the functionality is not defined, no?

No. My intention was that it should simply work/compile by default for
architectures which do not support a key mechanism:

something like

#ifndef raw_copy_to_user_key
static inline unsigned long raw_copy_to_user_key(..., unsigned long key)
{
	return raw_copy_to_user(...);
}
#endif

Again, this is just a proposal and might be turned down by common code
guys. Just trying to come up with something which could also work on other
architectures, and which does not cause pain because architectures don't
really need it.
