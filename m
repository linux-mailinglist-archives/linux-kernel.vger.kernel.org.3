Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B324528284
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiEPKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiEPKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:48:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C252559C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:48:17 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GA1nsx009291;
        Mon, 16 May 2022 10:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=b2j/XibOv+PC8mmhgOSjQNz5DFoBtyw+2PfLVJK9vKU=;
 b=P1d+yl9WYm/3Eq3K/ZMNpzT+cgfPiSykMKR38IWmAXf5YAaTlyn1B8jGRVSuczhD7MDj
 Zh35US7UYTygfkg5dx+l4Q9S6ADsstJC28iroQHcz20z2nD2M1ewGrHg1KE2PQ2+Uwvp
 2vRTIGdRS+J9Zy0ZbqZl3l9HxRMuUZHRXG0SHv8DIaAxCuqunBB35thxaETy3l16L923
 W0KLSVYWvCTVIGnysivfATBwDxsH86Vqg/hx7N+s7rblgAIVyOegH+fIf+ZSBo8VhxVv
 xPNBc0IvyPXJ+/rglODhzoFqtmPBDj2zQtDobeTp8jVGXOvrgl3TEwDIOBhRAvtQni5L uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgj8s8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:04 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GAZwXZ007380;
        Mon, 16 May 2022 10:48:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mgj8s8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GAm0Ff007036;
        Mon, 16 May 2022 10:48:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429aghh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:48:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GAlT8o26411324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:47:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4F76A405B;
        Mon, 16 May 2022 10:47:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39372A4054;
        Mon, 16 May 2022 10:47:57 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.73.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 10:47:56 +0000 (GMT)
Date:   Mon, 16 May 2022 16:17:50 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com,
        pmladek@suse.com, ying.huang@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Message-ID: <YoIr1j7JHKxA9i1V@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
 <20220426170040.65487-2-jvgediya@linux.ibm.com>
 <YmleidxlL2/d859f@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmleidxlL2/d859f@smile.fi.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j1m6khRs7I50RBEokCFWH_uE7QIvUFmm
X-Proofpoint-ORIG-GUID: 4ZtA1uUBA_i0x73H_lm1vPd3YhyGGdhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=941 lowpriorityscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:17:29PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> > Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> > to false, "true" or "1" to true are currently handled through strncmp
> > at multiple places. Use kstrtobool() to convert sysfs input to bool
> > value.
> 
> ...
> 
> > +	if (kstrtobool(buf, &numa_demotion_enabled))
> >  		return -EINVAL;
> 
> Hmm... The commit message doesn't explain what's wrong with the error codes
> returned by kstrtobool(). Can't it be
> 
> 	ret = kstrtobool();
> 	if (ret)
> 		return ret;
> 
> ?
Sorry for the late reply, I was away from work for few days. Yes, It can
be like what you mentioned.
> ...
> 
> > +	if (kstrtobool(buf, &enable_vma_readahead))
> >  		return -EINVAL;
> 
> Ditto.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
