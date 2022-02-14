Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7404B5585
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356075AbiBNQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:03:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356076AbiBNQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:03:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5749F9C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:03:31 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EDusYB022765
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=52NasPmj6mRet15SXSw7TYN5QFC61p18hQLhwPXITgQ=;
 b=IXiUOcLk05JofpR6ySdGqv/gRVJZUAHE4Sif1bLFRMWhaslfx+W1cSsZVgTHhU0eeHfV
 iTLqGzP1JJ1AYUeOulxTs9QH2Cj1DCipx5mcVVRlLkmBdXp4YTUVVOxBwOEB8no7xCNS
 r9jN+9COy4SSE7exs5jBdwQcP5odZztC+dI1c4wkG4CLltaBN2P+uOJcdxRyZcKJ+Hj4
 Q249Q7rbHEHY+BMCjniE15nEgu/KilTtaWvO2N+ohe2oPqft2t4jEJYMWITvJB4ktRLw
 FE5poDcPdLVXEwbmysDgJMV3ph1Ot2T2lPeIXkLtfxXeZZao7708SzOXxAdzAnUD2tZ7 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6ycqwqwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:03:29 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EDlfEN002590
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:03:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6ycqwqvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 16:03:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EFvsHf015314;
        Mon, 14 Feb 2022 16:03:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3e64h9p5xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 16:03:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EG3P0a44695962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 16:03:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB4BA4053;
        Mon, 14 Feb 2022 16:03:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A645A4051;
        Mon, 14 Feb 2022 16:03:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Feb 2022 16:03:24 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: circular locking splat in fs/proc/vmcore.c
References: <yt9dee4579sc.fsf@linux.ibm.com>
        <0a85d63e-8f51-4aaf-1b8e-c323f496cba7@redhat.com>
Date:   Mon, 14 Feb 2022 17:03:24 +0100
In-Reply-To: <0a85d63e-8f51-4aaf-1b8e-c323f496cba7@redhat.com> (David
        Hildenbrand's message of "Mon, 14 Feb 2022 16:58:27 +0100")
Message-ID: <yt9da6et77w3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c27dwlktdBQpBn6wvr3xwSwFUtM4Mho3
X-Proofpoint-GUID: 8yg2acYL8jddokAjjEqE1u06H5B0pLEg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=810 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Hildenbrand <david@redhat.com> writes:
> On 14.02.22 16:22, Sven Schnelle wrote:
>> I think we could also switch the list to an rcu protected list, but i
>> don't know the code really. Any opinions how to fix this?
>> 
> did you stumble over
>
> https://lkml.kernel.org/r/20220119193417.100385-1-david@redhat.com
>
> yet?
>
> It should be fixing the (mostly impossible to trigger) splat you've seen
> --  via sleepable rcu :)
>
> The fix is scheduled for v5.18.

No, i missed that. Thank you very much!

/Sven
