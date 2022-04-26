Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFD50F148
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiDZGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbiDZGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:45:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954C11A07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:42:03 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q6Jns3030019;
        Tue, 26 Apr 2022 06:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CdxO9k+K2Z3VdCfoUGvq9FT5yhNnrm3bVlXSkf9eM/8=;
 b=YLlUiQum92F1671/tem474cxYakdOptJBURq37hazB6C8ljX3iwIQTF2oKAvabnT5VRS
 TlW+f2sq441dbHOfGl0DaP3YUlyjx4qYX5id8ygc/ocyFw1AIVVgkzy8sekVib/F8Cjc
 5oQwoOC/DFc9FhaqFA+AjjhFxOWtJQY/ZIxGOYMhl3l270hK10xvuY4ODGdhS2pBAZpc
 s7WiE/hjIDzNZ1LuhUPNhy5BPHm7Kqmo2Yb8dC5xBx32Y1zThNR5l2wNcukeZq7AKaXR
 9h1HvrcWxkgQA1QdE6AJAjDEWgYoad/BLxVDoUDoIU2rH0bMPdjjy+xaoa8aqSZuUnir Zw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbcerbpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:41:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q6abl3005102;
        Tue, 26 Apr 2022 06:41:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhjxnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:41:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q6fseK39256400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 06:41:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F69FA405F;
        Tue, 26 Apr 2022 06:41:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14ED4A4062;
        Tue, 26 Apr 2022 06:41:52 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.82.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 06:41:51 +0000 (GMT)
Date:   Tue, 26 Apr 2022 12:11:46 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andy@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        minchan@kernel.org, ying.huang@intel.com, dave.hansen@intel.com
Subject: Re: [RESEND PATCH] string_helpers: sysfs: Add helper to get bool
 from string
Message-ID: <YmeUKg9s5AZUKXj8@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220425085233.82576-1-jvgediya@linux.ibm.com>
 <20220425150046.e23a0198e0076221549eb7cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425150046.e23a0198e0076221549eb7cf@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qUmtZk5Kj0EMTaM7g0W9Wr6IsEkS7pCi
X-Proofpoint-ORIG-GUID: qUmtZk5Kj0EMTaM7g0W9Wr6IsEkS7pCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204260042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:00:46PM -0700, Andrew Morton wrote:
> On Mon, 25 Apr 2022 14:22:33 +0530 Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> 
> > At many places in kernel, It is necessary to convert sysfs input
> > to corrosponding bool value e.g. "false" or "0" need to be converted
> > to bool false, "true" or "1" need to be converted to bool true,
> > places where such conversion is needed currently check the input
> > string manually. Also, such conversions compare sysfs input using
> > strncmp functions so even if certain number of character match in the
> > beginning, they assume the string as valid bool, which is not the
> > right semantic e.g. false is bool but falseX is not.
> > 
> > Introduce new string helper function to convert sysfs input to
> > corrosponding bool value. Modify existing such conversions to use
> > this new function.
> > 
> > logs,
> > $ cat /sys/kernel/mm/numa/demotion_enabled
> > false
> > $ echo true > /sys/kernel/mm/numa/demotion_enabled
> > $ cat demotion_enabled
> > true
> > $ echo truex > /sys/kernel/mm/numa/demotion_enabled
> > -bash: echo: write error: Invalid argument
> > $ echo 10 > /sys/kernel/mm/numa/demotion_enabled
> > -bash: echo: write error: Invalid argument
> > $ echo false > /sys/kernel/mm/numa/demotion_enabled
> > $ cat demotion_enabled
> > false
> > $ echo falseabc > /sys/kernel/mm/numa/demotion_enabled
> > -bash: echo: write error: Invalid argument
> > $ echo 1 > /sys/kernel/mm/numa/demotion_enabled
> > $ cat demotion_enabled
> > true
> > $ echo 0 > /sys/kernel/mm/numa/demotion_enabled
> > $ cat demotion_enabled
> > false
> > 
> > This patch doesn't have any functionality change.
> > 
> > ...
> >
> > --- a/lib/string_helpers.c
> > +++ b/lib/string_helpers.c
> > @@ -967,6 +967,26 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >  }
> >  EXPORT_SYMBOL(memcpy_and_pad);
> >  
> > +/**
> > + * sysfs_strbool - Get bool value corrosponding to string
> > + * @s: The string to operate on.
> > + * @output: Pointer to fill resulting bool value
> > + *
> > + * Returns 1 if string represents bool value, 0 otherwise
> > + */
> > +int sysfs_strbool(const char *s, bool *output)
> > +{
> > +	if (sysfs_streq(s, "1") || sysfs_streq(s, "true"))
> > +		*output = true;
> > +	else if (sysfs_streq(s, "0") || sysfs_streq(s, "false"))
> > +		*output = false;
> > +	else
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +EXPORT_SYMBOL(sysfs_strbool);
> > +
> 
> Can we teach kstrtobool() about "true" and "false" then use that?

I think we can do that, I have sent v2. Thanks
