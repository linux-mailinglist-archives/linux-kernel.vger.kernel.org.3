Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27DD4A7F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348164AbiBCHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:02:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229550AbiBCHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:02:02 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2136OSWL027310;
        Thu, 3 Feb 2022 07:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=fuwdlhtK3yRJD6X/BS3CQjG2oeXrgsNiAMMXe2n2B4w=;
 b=L9T2uuIIv1U+gOTg3zN+LZMnfuj1VmcKipYFK2rIfwqPxkHvFXqgtnGS8LQqkxe5iCTu
 upEVwNppj7NuMwQHSxIJLnTwLYAULVneMS+sCQlQpTIZpXZdkkY1MxjAIxuU2wTL04Gw
 BkLUYipN87BwyVFnwwTui8iT4ohmI/E5RZqEBl6a78ZNIU6rUzVXNQhN1KwvA+lnjp1P
 6ykNqd2GHFn6JIH5XERPsm0dukyeRzF9TULilYawNIeDtqPl4V0eka+tjZDLA4CHDjXF
 Jb+ahpWOseoSZpZaWFZBngmS8c/CqrzhbYPXMJZC/59OgQoJnTqLTBKWlpd5Cx0548Zi Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e03uqebjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 07:01:53 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2136vBS3021161;
        Thu, 3 Feb 2022 07:01:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e03uqebht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 07:01:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2136whT2032075;
        Thu, 3 Feb 2022 07:01:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvujtx8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 07:01:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21371mx738994376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 07:01:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4320A4051;
        Thu,  3 Feb 2022 07:01:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CEA7A405B;
        Thu,  3 Feb 2022 07:01:47 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.11.85])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Feb 2022 07:01:47 +0000 (GMT)
Date:   Thu, 3 Feb 2022 09:01:45 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Berger <opendmb@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Updated git tree for MM patches??
Message-ID: <Yft92aSYi9QIfKNf@linux.ibm.com>
References: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XynTtDatfQvbBPY7PiTloOB0mxo2LpIi
X-Proofpoint-GUID: 8ls657mRn2XvOqtbddWJOBnNk3dQzSsj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_01,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=772
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 04:21:38PM -0800, Florian Fainelli wrote:
> Hi Andrew, Johannes,
> 
> The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:
> 
> git://github.com/hnaz/linux-mm.git
> 
> however it does not look like it has been updated in the past 5 months or so
> as master still points to 5.17-rc7-mm1
> 
> Is there another git tree that other memory management related subsystems
> use for development?

AFAIK, hnaz/linux-mm was the only git mirror of mmotm series.

I keep a tree for memblock, but it follows Linus' tree rather than mmotm.
I think Vlastimil's slab tree does the same.

-- 
Sincerely yours,
Mike.
