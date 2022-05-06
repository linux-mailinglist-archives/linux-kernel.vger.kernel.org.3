Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358551DE55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444197AbiEFR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiEFR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:28:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE144FC7E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:25:02 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246H0Bmx023742;
        Fri, 6 May 2022 17:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=745paQssSqo4bmbwBnVPKNVbxW9di2YzRttHYnWhIMk=;
 b=iZwYsARI4lblpiF/QFQnULnhQ2pdvBkDWNUB+V5/ezQ537/3MtxuTexNgjuf9Zhq8QWC
 E9Eb4t5Xs2G19a/PvMGg4Y/FI2akH3g3Y9d4Xt5tI3huBRk9EqLZIpLNh7DmaSChrqm8
 5U8xqLabFkF73abVZZFr+XQsBaN5z+3DpWSRDlmgKrSaaW8zXgoj7WaTV1n8AknLynXn
 jXM7dXQ8saf/GJ+3KMFdsINGRURksMLWwVOP0IB1g9eXh2c07gSsMoUb8Z0kQSrbzbzB
 rcs4A7tnTHSJMBbz3Dj9sOPcwvCKgKFHbJ5UJc49WXvEaNMf2BnpF6CG03QBxR+GkIF1 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw7pp8drn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 17:24:38 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246HMCCu008807;
        Fri, 6 May 2022 17:24:37 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw7pp8drf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 17:24:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246HIlKl019978;
        Fri, 6 May 2022 17:24:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk6j05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 17:24:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246HOXEq24576414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 17:24:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72CA6A405B;
        Fri,  6 May 2022 17:24:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C033A4054;
        Fri,  6 May 2022 17:24:18 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.96.98])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 17:24:17 +0000 (GMT)
Date:   Fri, 6 May 2022 22:54:10 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: Re: [PATCH] kobject: Refactor kobject_set_name_vargs()
Message-ID: <YnVZujpw0RZy3eVT@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
 <5902e26ef400451b966be2dd0fbd1575@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5902e26ef400451b966be2dd0fbd1575@AcuMS.aculab.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qlv8HtQ1R4n87VYj-Kpy7fyBcF6etmcp
X-Proofpoint-ORIG-GUID: VQmocqa5hU9y5EhXK3_OV5RTuwZ7O3eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_06,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 02:46:47PM +0000, David Laight wrote:
> From: Jagdish Gediya
> > Sent: 06 May 2022 14:33
> > 
> > Setting name as per the format is not only useful for kobjects.
> > It can also be used to set name for other things for e.g. setting
> > the name of the struct attribute when multiple same kind of attributes
> > need to be created with some identifier in name, instead of managing
> > memory for names at such places case by case, it would be good if
> > something like current kobject_set_name_vargs() can be utilized.
> > 
> > Refactor kobject_set_name_vargs(), Create a new generic function
> > set_name_vargs() which can be used for kobjects as well as at
> > other places.
> > 
> > This patch doesn't introduce any functionality change.
> > 
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > ---
> >  include/linux/string.h |  1 +
> >  lib/kobject.c          | 30 +-----------------------------
> >  mm/util.c              | 40 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 42 insertions(+), 29 deletions(-)
> > 
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index b6572aeca2f5..f329962e5ae9 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/stdarg.h>
> >  #include <uapi/linux/string.h>
> > 
> > +int set_name_vargs(const char **name, const char *fmt, va_list vargs);
> >  extern char *strndup_user(const char __user *, long);
> >  extern void *memdup_user(const void __user *, size_t);
> >  extern void *vmemdup_user(const void __user *, size_t);
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 5f0e71ab292c..870d05971e3a 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -249,35 +249,7 @@ static int kobject_add_internal(struct kobject *kobj)
> >  int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
> >  				  va_list vargs)
> >  {
> ...
> > +	return set_name_vargs(&kobj->name, fmt, vargs);
> >  }
> > 
> >  /**
> > diff --git a/mm/util.c b/mm/util.c
> > index 54e5e761a9a9..808d29b17ea7 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -112,6 +112,46 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
> >  }
> >  EXPORT_SYMBOL(kstrndup);
> > 
> > +/**
> > + * set_name_vargs() - Set the name as per format
> > + * @name: pointer to point to the name as per format
> > + * @fmt: format string used to build the name
> > + * @vargs: vargs to format the string.
> > + */
> > +int set_name_vargs(const char **name, const char *fmt, va_list vargs)
> > +{
> > +	const char *s;
> > +
> > +	if (*name && !fmt)
> > +		return 0;
> > +
> > +	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
> > +	if (!s)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * ewww... some of these buggers have '/' in the name ... If
> > +	 * that's the case, we need to make sure we have an actual
> > +	 * allocated copy to modify, since kvasprintf_const may have
> > +	 * returned something from .rodata.
> > +	 */
> > +	if (strchr(s, '/')) {
> > +		char *t;
> > +
> > +		t = kstrdup(s, GFP_KERNEL);
> > +		kfree_const(s);
> > +		if (!t)
> > +			return -ENOMEM;
> 
> There is a kstrdup_const() that will DTRT here.
> 
> > +		strreplace(t, '/', '!');
> > +		s = t;
> > +	}
> > +	kfree_const(*name);
> > +	*name = s;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(set_name_vargs);
> 
> Are you sure this can ever work from a module?
> This all relies on:
> 
> static inline bool is_kernel_rodata(unsigned long addr)
> {
> 	return addr >= (unsigned long)__start_rodata &&
> 	       addr < (unsigned long)__end_rodata;
> }
> 
> which isn't going to do anything sane given an "xxx" inside a module.
> 
> Indeed can kobject_set_name_vargs() end up with a constant string
> inside a module?

No, kobject_set_name_vargs() is not exported. I exported
set_name_vargs() because it can have a broader use, but you are right
it shouldn't be exported.

> Seems horribly fragile.
> 
> 	David
> 
> > +
> >  /**
> >   * kmemdup - duplicate region of memory
> >   *
> > --
> > 2.35.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 
