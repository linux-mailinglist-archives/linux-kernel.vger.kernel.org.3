Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC813528288
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiEPKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiEPKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:49:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB842717E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:49:14 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G908mU028661;
        Mon, 16 May 2022 10:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=w1Yi0lAOLDTe0MuIeEWGBvPWxIA9sOQQKTPvE4SB9KQ=;
 b=BzkfOnYhLAQha0V3+DVmSZlqJVoNecJv9btVL+HnHToiI5oVpidyEncoDG2dKFQWwBGM
 6M5vCOISAzD8lTWLwM3gAmdESLMdZix3es+sI6UK8u0M5gURqq3CqpIlUP4EkCf85WGl
 IFtvprP9DNaoe2AItnj9JJnOdatHOxX2OJUCoUiYgs2/ypY7zRs5PNi5ZENn2FFr9boy
 CvUScbgYp1Pk0+5Uy9UTsxepATPHyCMxcj6b9DZwz8ISIsTJGIvbuRkrqx4xKcF5MOKt
 sU2rWiJ2f1dYT1qWsaLsWlCipGcy170gvdSeief6q4YmNFgR14jbARotWZrP2glg6+7u LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3kkn9xqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:57 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GAjUcu032615;
        Mon, 16 May 2022 10:48:56 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3kkn9xpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:56 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GAldmV010447;
        Mon, 16 May 2022 10:48:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3g23pj1xn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GAZ4oA50594218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:35:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E9434C050;
        Mon, 16 May 2022 10:48:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFFF04C058;
        Mon, 16 May 2022 10:48:48 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.73.52])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 10:48:48 +0000 (GMT)
Date:   Mon, 16 May 2022 16:18:43 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Message-ID: <YoIsC8Ay+Th0n4bA@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
 <20220426170040.65487-2-jvgediya@linux.ibm.com>
 <YmleidxlL2/d859f@smile.fi.intel.com>
 <20220512180537.5296f39b27c3488080ff67cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512180537.5296f39b27c3488080ff67cf@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Um10J9AKc1vuy5fVC3MO6TKkXzgwYUMM
X-Proofpoint-GUID: RTeW_obQAle-XtUwNg9JuqQdj4_nm2Eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 06:05:37PM -0700, Andrew Morton wrote:
> On Wed, 27 Apr 2022 18:17:29 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> > > Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> > > to false, "true" or "1" to true are currently handled through strncmp
> > > at multiple places. Use kstrtobool() to convert sysfs input to bool
> > > value.
> > 
> > ...
> > 
> > > +	if (kstrtobool(buf, &numa_demotion_enabled))
> > >  		return -EINVAL;
> > 
> > Hmm... The commit message doesn't explain what's wrong with the error codes
> > returned by kstrtobool(). Can't it be
> > 
> > 	ret = kstrtobool();
> > 	if (ret)
> > 		return ret;
> > 
> > ?
> 
> Jagdish fell asleep.
Sorry, I was away from work for few days.
> Yes, I agree.  It has no practical difference at present because
> kstrtobool() can only return 0 or -EINVAL.  I did this:
> 
> --- a/mm/migrate.c~mm-convert-sysfs-input-to-bool-using-kstrtobool-fix
> +++ a/mm/migrate.c
> @@ -2523,8 +2523,10 @@ static ssize_t numa_demotion_enabled_sto
>  					   struct kobj_attribute *attr,
>  					   const char *buf, size_t count)
>  {
> -	if (kstrtobool(buf, &numa_demotion_enabled))
> -		return -EINVAL;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &numa_demotion_enabled);
> +		return ret;
>  
>  	return count;
>  }
> --- a/mm/swap_state.c~mm-convert-sysfs-input-to-bool-using-kstrtobool-fix
> +++ a/mm/swap_state.c
> @@ -874,8 +874,11 @@ static ssize_t vma_ra_enabled_store(stru
>  				      struct kobj_attribute *attr,
>  				      const char *buf, size_t count)
>  {
> -	if (kstrtobool(buf, &enable_vma_readahead))
> -		return -EINVAL;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &enable_vma_readahead);
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> _
> 
