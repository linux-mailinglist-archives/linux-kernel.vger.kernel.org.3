Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21F51004B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351556AbiDZOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346521AbiDZOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:24:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECD315714
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:21:27 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCLlM0023199;
        Tue, 26 Apr 2022 14:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nxJrjASpdOp6LZ/qybVuOqh2psHVAGqnrBLl9aVXjKA=;
 b=HYSjWqbO/0ZpplQhU+nBGOKMKnFGRxFRVfTcMgCO8ZPDmQ2QfTL18AbnG6cds+IDp5Wp
 JDnu5pJb9kg99vmPP3tzex6fo8PBNby+pMI7Xw1A8QOSRjNJOKmuooDE9BQ6V73vx0qb
 CFH2Bg+8u+l+4w68OmFza5d0I4xUfUy6OJFB9slM39zNj0E8MgSLuxJwSv15siF579v0
 IdilRLo2gWqS/1+hBD0Hlf8pP1LHdET5JAwi9vpQJmql6qMGEaXdrEh0Z27yOM5PAWUq
 kZr5oAK6ChH3Rn1k5VqU+x79tuowNuyTsrU4Tg4rGw6L0pQs1KbZ9DC/CtaYcWC+V4JJ Qw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpgn7tsnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 14:21:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QE8QdI003317;
        Tue, 26 Apr 2022 14:21:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj4jms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 14:21:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QEL9ev39191026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 14:21:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60CE5A4057;
        Tue, 26 Apr 2022 14:21:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB0BA4040;
        Tue, 26 Apr 2022 14:21:07 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.82.112])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 14:21:06 +0000 (GMT)
Date:   Tue, 26 Apr 2022 19:50:59 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool
Message-ID: <Ymf/yyPLGErQji06@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
 <YmfzJVPng1U8X+jV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfzJVPng1U8X+jV@smile.fi.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gwNlRMVl6-xaTSMX2znSEiv-oui1UpIa
X-Proofpoint-ORIG-GUID: gwNlRMVl6-xaTSMX2znSEiv-oui1UpIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=902 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:27:01PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 26, 2022 at 12:10:01PM +0530, Jagdish Gediya wrote:
> > At many places in kernel, It is necessary to convert sysfs input
> > to corrosponding bool value e.g. "false" or "0" need to be converted
> > to bool false, "true" or "1" need to be converted to bool true,
> > places where such conversion is needed currently check the input
> > string manually, kstrtobool can be utilized at such places but
> 
> kstrtobool()
> 
> > currently kstrtobool doesn't have support to "false"/"true".
> 
> 
> Ditto.
> 
> > Add "false"/"true" support to kstrtobool while string conversion
> 
> Ditto.
> 
> > to bool. Modify existing manual sysfs conversions to use kstrtobool().
> 
> > This patch doesn't have any functionality change.
> 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> 
> You may use --cc parameter to `git send-email`.
Sure, Will remove these from here.
> ...
> 
> >  lib/kstrtox.c   | 7 +++++++
> >  mm/migrate.c    | 6 +-----
> >  mm/swap_state.c | 6 +-----
> 
> Please, split to two.
Sure
> Also Documentation update is missed.
I am not finding any related documentation. I can update
the comment on the function for true/false change.

--Jagdish
> 
> 
> 
