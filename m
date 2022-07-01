Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C728F562BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiGAGdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiGAGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:33:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767313F10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:33:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2615pHTw024331;
        Fri, 1 Jul 2022 06:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=43E8lWSoKTQumIYPANAN9tbxhnCu/ars1CPwWA8NO1U=;
 b=JOKedKyLCivY7mYGp6FCPDuKCovFSWCAVRjPFXI3fesIQGWMJgvA7YSSjsJzaPt5BvxX
 GKtTEgQ9vHzZM8HoW6mA/B7zjYPAqYHrecJltsVT3PRlxSiDS6H8ZdksNGmGc0rhpeQa
 zfPKQSi36nFnLHhjqSHcMyxgS/XYNwN/jvRWp8wA8HqHlKQnnp8Ny9q/WbRpsO0VhCnj
 /Je01xQghaXKLjsRrLz121EVqY7+tVb5zOiih8hxDKKgaPp52nyPPXfn8rg6nQ8LMYap
 3p/3ClpF3X5Na2AG0X8q3XTFfAEfLCGWRK4npqXxNz5++7mm0gj1ItRK9NK2j4bdNiAb uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1u1c943y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 06:33:02 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2615phKY025370;
        Fri, 1 Jul 2022 06:33:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1u1c9433-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 06:33:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2616LMe9026261;
        Fri, 1 Jul 2022 06:32:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt0918hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 06:32:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2616Wvsv22348128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 06:32:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13857A404D;
        Fri,  1 Jul 2022 06:32:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66371A4051;
        Fri,  1 Jul 2022 06:32:53 +0000 (GMT)
Received: from [9.43.53.136] (unknown [9.43.53.136])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 06:32:53 +0000 (GMT)
Message-ID: <b299ebe2-88e5-c2bd-bad0-bef62d4acdfe@linux.ibm.com>
Date:   Fri, 1 Jul 2022 12:02:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 26/34] tools/testing/nvdimm: Convert to printbuf
Content-Language: en-US
To:     Santosh Sivaraj <santosh@fossix.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, enozhatsky@chromium.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        willy@infradead.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-27-kent.overstreet@gmail.com>
 <62b61165348f4_a7a2f294d0@dwillia2-xfh.notmuch>
 <CA+n8AA-grcDuYWt-TxcttK+2tHpEP4s9ue2uq_0d8=hJpqNh+g@mail.gmail.com>
From:   Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <CA+n8AA-grcDuYWt-TxcttK+2tHpEP4s9ue2uq_0d8=hJpqNh+g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8oemeT4kbVhWz-CORfaTBY1vKeWOi9_V
X-Proofpoint-ORIG-GUID: Qyas4CxWbLYIFtodCSyStsjrbn6FwLO0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/22 05:12, Santosh Sivaraj wrote:
> I don't have setup to test this now. Adding Shiva and Vaibhav who could 
> probably help. Thanks, Santosh On Sat, 25 Jun, 2022, 1:03 am Dan 
> Williams, <dan.j.williams@intel.com> wrote: [ add Santosh ] Kent 
> Overstreet wrote: ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
> ZjQcmQRYFpfptBannerEnd
> I don't have setup to test this now. Adding Shiva and Vaibhav who could 
> probably help.
> 
> Thanks,
> Santosh
> 
> On Sat, 25 Jun, 2022, 1:03 am Dan Williams, <dan.j.williams@intel.com 
> <mailto:dan.j.williams@intel.com>> wrote:
> 
>     [ add Santosh ]
> 
>     Kent Overstreet wrote:
>      > This converts from seq_buf to printbuf. Here we're using printbuf
>     with
>      > an external buffer, meaning it's a direct conversion.
>      >
>      > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com
>     <mailto:kent.overstreet@gmail.com>>
>      > Cc: Dan Williams <dan.j.williams@intel.com
>     <mailto:dan.j.williams@intel.com>>
>      > Cc: Dave Hansen <dave.hansen@linux.intel.com
>     <mailto:dave.hansen@linux.intel.com>>
>      > Cc: nvdimm@lists.linux.dev <mailto:nvdimm@lists.linux.dev>
> 
>     Acked-by: Dan Williams <dan.j.williams@intel.com
>     <mailto:dan.j.williams@intel.com>>
> 

The ndtest build requires [1] as the build is currently broken from 
nd_namespace_blk/blk_region infrastructure removal.

Dan, Could you review [1] and see if it can be included as well ?

With [1], the this patch is tested, and works fine.

Tested-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>

References:
[1] 
https://patchwork.kernel.org/project/linux-nvdimm/patch/165025395730.2821159.14794984437851867426.stgit@lep8c.aus.stglabs.ibm.com/


>     This probably also wants a Tested-by from Santosh, but it looks ok
>     to me.
> 
