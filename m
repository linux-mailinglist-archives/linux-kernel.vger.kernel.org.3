Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10F51DA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442210AbiEFOeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbiEFOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:34:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D03522A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:30:18 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246ERf8s027434;
        Fri, 6 May 2022 14:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ksAZ8ap0QGJQ4onjEIn74AoQRbvMpZEApzQTCpHDhUA=;
 b=o+jz0yW63c9nKJZokaGCFKkYDN9b4ujULESM+iclUgfeYZD3yfuyL4bwwcKKBQ75FWit
 kXXeaQR8tT25PtlAbpCSc0bUNkRzZLwxCOz7kkwt0GLh3sgQ+Z2FhoKdqhIk4ukjPAAn
 c2ANMSqQrEbe2DRQBO94Q0vatGB2Oj4ts1S5+0oOUk5WJ4qDnlvrhLLBNM2prSdrqAgD
 6o4rqPn6ZJNR+utXQjWO7Pj6fk77ndN4dmaqhPYnmCloj16pNzl4ZTFdyRt5GLYN3E9W
 nmk8X2rUDzW5L93T4G5cWQNi3CilF66lwJNUn4G1MGdZXk/h5W/9+VlZV63UW7uciQCA NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw5f6g18u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 14:29:57 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246ESjn0030115;
        Fri, 6 May 2022 14:29:57 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw5f6g18e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 14:29:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246ERe0H031273;
        Fri, 6 May 2022 14:29:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3fuyn7a4hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 14:29:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246ETqcl48628034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 14:29:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE996A4060;
        Fri,  6 May 2022 14:29:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23953A405C;
        Fri,  6 May 2022 14:29:49 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.96.98])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 14:29:48 +0000 (GMT)
Date:   Fri, 6 May 2022 19:59:42 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, linux@roeck-us.net, adobriyan@gmail.com
Subject: Re: [PATCH] kobject: Refactor kobject_set_name_vargs()
Message-ID: <YnUw1pRzusU8j0A7@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
 <YnUqdBuxy7MofDoR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnUqdBuxy7MofDoR@kroah.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6gpsC7kr0Uz7cwXWtN-yr0nMJNKeqV98
X-Proofpoint-GUID: xLrIWm4HIA5Knwl-6HcRmnW5l2zH3is1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:02:28PM +0200, Greg KH wrote:
> On Fri, May 06, 2022 at 07:03:09PM +0530, Jagdish Gediya wrote:
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
> > -	const char *s;
> > -
> > -	if (kobj->name && !fmt)
> > -		return 0;
> > -
> > -	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
> > -	if (!s)
> > -		return -ENOMEM;
> > -
> > -	/*
> > -	 * ewww... some of these buggers have '/' in the name ... If
> > -	 * that's the case, we need to make sure we have an actual
> > -	 * allocated copy to modify, since kvasprintf_const may have
> > -	 * returned something from .rodata.
> > -	 */
> > -	if (strchr(s, '/')) {
> > -		char *t;
> > -
> > -		t = kstrdup(s, GFP_KERNEL);
> > -		kfree_const(s);
> > -		if (!t)
> > -			return -ENOMEM;
> > -		strreplace(t, '/', '!');
> > -		s = t;
> > -	}
> > -	kfree_const(kobj->name);
> > -	kobj->name = s;
> > -
> > -	return 0;
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
> 
> Why is this a mm/ thing and not a lib/ thing?

I think it can be moved to lib/, Will correct it in next version.

> And who else will be needing to use this?  Why the churn for no
> actual users?

I am working on a sepatare series for memory tiers where this kind
of functionality is needed, Based on numa topology of the system,
We can build the memory tiers nodemasks based on numa distances,
such masks need to be viewed/stored from sysfs using interfaces
/sys/*/memory_tier0, /sys/*/memory_tier1 etc. there can be upto
MAX_TIERS of memory tiers in the system, so we can define struct
device_attribute array statically but their names need to be set
as per tier number where this function is useful.

Also I think this requirement is generic although there are no
current users, It would be useful to not just restrict it to
kobjects.

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
> No need to export this as there are no users in modules.

Will remove in next version.

> And if there was, shouldn't it be EXPORT_SYMBOL_GPL() as that's what the
> kobject functions are exported as (most of them at least.)
> 
> But again, why is this needed at all?
> 
> thanks,
> 
> greg k-h
> 
