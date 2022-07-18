Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6C5785D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiGROwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiGROwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:52:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD2E17595;
        Mon, 18 Jul 2022 07:52:17 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IEWIP6028685;
        Mon, 18 Jul 2022 14:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Oy7HgKyIBC9fQtCF4y4wlZCKdBYNiQh14flahJi/ENA=;
 b=Hj8l/AE1AjLVSLh3N+l9LqJzj0yJlawdr0ig3krWzAOz9a0ZSC89fOJKXCqp6Yi/LiCZ
 cS1CjMmkAGMeyz9iuInTZd23Q8sEm9CxagbFdw7wMiOx99YLR/F+Ikw+0+8x2u6Weqdb
 WbfInoOPrIsAhbprzyoBMEQp8cgW3mjr0lcCDPULbLj/fqWMNTXbyuuCuMu1+Rm8l/F+
 y6xCFiZLFWVi/RKU6PlGlTyV92/ZSlQ1UCH7QFL9W9MoqXfC4lhPkq5afgyVPJOhG2s3
 kvg2oBBG/pJQgq4jSkbr0kp28gCpA4x+fOUNXijztAnPol/7W4/RS5vtuopVFUfc5WdD jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd9c90kgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 14:52:09 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26IEX9Ln031800;
        Mon, 18 Jul 2022 14:52:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd9c90kfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 14:52:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26IEomY9014924;
        Mon, 18 Jul 2022 14:52:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj2r8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 14:52:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26IEq2j921234166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 14:52:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90231A405B;
        Mon, 18 Jul 2022 14:52:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B46A4054;
        Mon, 18 Jul 2022 14:52:01 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jul 2022 14:52:01 +0000 (GMT)
Date:   Mon, 18 Jul 2022 16:51:59 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/3] s390/crash: use static swap buffer for
 copy_to_user_real()
Message-ID: <YtVzj5W5xr/UwjLT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
 <77d50b4a2359d1791835b6111edaa155eb11c5ea.1658148067.git.agordeev@linux.ibm.com>
 <YtVkpRJ7jvLFuKs4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVkpRJ7jvLFuKs4@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8KvRGPC9cWT1vITsR6w2_OsAqRSmMJye
X-Proofpoint-ORIG-GUID: u86h4odW8QlgwCkqmNH70KHhiK_ZnRK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_13,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=814 lowpriorityscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207180061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:48:21PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 18, 2022 at 03:32:40PM +0200, Alexander Gordeev wrote:
> > +++ b/arch/s390/kernel/crash_dump.c
> > @@ -53,6 +53,7 @@ struct save_area {
> >  };
> >  
> >  static LIST_HEAD(dump_save_areas);
> 
> I'd suggest you need a mutex here so that simultaneous calls to
> copy_to_user_real() don't corrupt each others data.

We stop all (but one) CPUs before calling into the capture kernel -
one that calls these functions. Similarily to racy hsa_buf[] access
from memcpy_hsa_iter() this should not hit.

As you noticed last time, it is a pre-existing race and I was
actually going to address it in a separate fix - if the problem
really exists.

> > +static char memcpy_real_buf[PAGE_SIZE];
> >  
> >  /*
> >   * Allocate a save area
> > @@ -179,23 +180,18 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
> >  static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
> >  {
> >  	int offs = 0, size, rc;
> > -	char *buf;
> >  
> > -	buf = (char *)__get_free_page(GFP_KERNEL);
> > -	if (!buf)
> > -		return -ENOMEM;
> >  	rc = -EFAULT;
> >  	while (offs < count) {
> >  		size = min(PAGE_SIZE, count - offs);
> > -		if (memcpy_real(buf, src + offs, size))
> > +		if (memcpy_real(memcpy_real_buf, src + offs, size))
> >  			goto out;
> > -		if (copy_to_user(dest + offs, buf, size))
> > +		if (copy_to_user(dest + offs, memcpy_real_buf, size))
> >  			goto out;
> >  		offs += size;
> >  	}
> >  	rc = 0;
> >  out:
> > -	free_page((unsigned long)buf);
> >  	return rc;
> >  }

Thanks!
