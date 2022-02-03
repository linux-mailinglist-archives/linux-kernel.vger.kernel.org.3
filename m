Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30604A8B45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353260AbiBCSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:11:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232248AbiBCSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:11:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213GfCvS021697;
        Thu, 3 Feb 2022 18:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QrLTNVShrpy6/lAFMq068G4UwTS0BnpdGIILr+5Fs3Y=;
 b=qupMA6Y+vyvnQ3FaRD54A5BIruwryQUCXUL2Q2bQGpqwGYkQmog0/lLZ3DOFoZS4l/5Y
 Yb2sgbVCg+AtOcdEl/8SEE7VRpXOoRbOPxExoJ6v/dFaDioNocYtiISzZjO6uFVT3QHh
 1UkNtHfk2jPD8tF99ifA6BMedmEa9SXLImsqpkMBwTj35JCD2/sG8zcoRGBa/yDgLsHr
 KkI1NZzSj8O5riqO2jE6v7rCIdC1j2+hCayNnxlcrzEkl9Eh9KbmOdlbVxXmPe8wJ22b
 UWARuPQ6b6DTtpZAf8bywRztSRydIGkIa3E3rPDXjcB6JJIeVFXyVa8FdizxPWenZGI2 TA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvcmx4m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213I38Zf005142;
        Thu, 3 Feb 2022 18:11:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3dvw79xu0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213IBhRZ33030610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 18:11:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78F865204F;
        Thu,  3 Feb 2022 18:11:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3224D52050;
        Thu,  3 Feb 2022 18:11:43 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     scgl@linux.ibm.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        borntraeger@linux.ibm.com, hca@linux.ibm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH 0/2] uaccess: Add mechanism for key checked access to user memory
Date:   Thu,  3 Feb 2022 19:11:39 +0100
Message-Id: <20220203181141.2682997-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220126173358.2951879-1-scgl@linux.ibm.com>
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -h49B-CSwRzWiPWHgGgI0NY10eNw1Duk
X-Proofpoint-ORIG-GUID: -h49B-CSwRzWiPWHgGgI0NY10eNw1Duk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=875
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Considerations:
>  * The key argument is an unsigned long, in order to make the functions
>    less specific to s390, which would only need an u8.
>    This could also be generalized further, i.e. by having the type be
>    defined by the architecture, with the default being a struct without
>    any members.
>    Also the functions could be renamed ..._opaque, ..._arg, or similar.
>  * Which functions do we provide _key variants for? Just defining
>    __copy_from/to_user_key would make it rather specific to our use
>    case.
>  * Should ...copy_from/to_user_key functions be callable from common
>    code? The patch defines the functions to be functionally identical
>    to the normal functions if the architecture does not define
>    raw_copy_from/to_user_key, so that this would be possible, however it
>    is not required for our use case.
> 
After thinking about it some more, this variant seems an attractive
compromise between the different dimensions.
It maximises extensibility by having the additional argument and
semantic completely architecture defined.
At the same time it keeps the changes to the minimum, which reduces the
maintenance cost of keeping the functions in sync.
It is also clear how other use cases can be supported, when they arise.
Calling the functions from common code would be supported by defining
the opaque argument as an empty struct by default, and defaulting to
raw_copy_from/to_user. If other variants of copy to/from user with an
additional argument are required they can be added in the same manner as
is done here for __copy_from/to_user.
> 
> Comments are much appreciated.

Janis Schoetterl-Glausch (2):
  uaccess: Add mechanism for arch specific user access with argument
  s390/uaccess: Provide raw_copy_from/to_user_opaque

 arch/s390/include/asm/uaccess.h | 27 ++++++++++++++--
 arch/s390/lib/uaccess.c         | 56 ++++++++++++++++++++-------------
 include/linux/uaccess.h         | 28 +++++++++++++++++
 3 files changed, 88 insertions(+), 23 deletions(-)

-- 
2.32.0

