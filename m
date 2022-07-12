Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0669457262F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiGLToS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiGLTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:43:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6784CDD;
        Tue, 12 Jul 2022 12:28:03 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJPpCY002711;
        Tue, 12 Jul 2022 19:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1HniwvOuytE5H3+nMFD5ZrPlArfFeM40vkuexo78F+M=;
 b=l7xNSmRzHMbWUzVi6k04c4QJBzZ6Oy17M9EpI2U1OS3XAl4Z0gTsG+Ewon/TJ1wBcJsv
 HOd3oUqkS3drangLiAqQyrWaOalEzBRBhggI1Apr5y5hpCE6AlLPv4Lr4p/zCxNgw+Hi
 XqqYBE8cOnbe/krBoo8ptD5VovQAVNbOqa6B9kqBnaiytvK9WebydBNOX1dAsT2L84Qp
 OVEoVc10YorWV35MjgDMO+/x1y375Vq+2XfmtVgb8n3M8MDML+iq/NBIcyD65keywZjl
 WW6E81ObRtgLUG7npISvrDzezTEjl+DI62/YBIiJ60kBhrhWTEgB2jzrUoAW022K6oN0 5Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h964384cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 19:28:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CJLihs018343;
        Tue, 12 Jul 2022 19:27:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn1gxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 19:27:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CJQQ1a22544818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 19:26:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EC9AE053;
        Tue, 12 Jul 2022 19:27:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FC90AE045;
        Tue, 12 Jul 2022 19:27:55 +0000 (GMT)
Received: from osiris (unknown [9.145.52.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jul 2022 19:27:55 +0000 (GMT)
Date:   Tue, 12 Jul 2022 21:27:53 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <Ys3LOT/fGcGo+4Eh@osiris>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com>
 <20220712184619.45edd420@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712184619.45edd420@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: edzKj_LzbgK8bX0Wc0YOlwfKFcO075uU
X-Proofpoint-GUID: edzKj_LzbgK8bX0Wc0YOlwfKFcO075uU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=677 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207120077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:46:19PM +0200, Claudio Imbrenda wrote:
> > +int cpu_have_feature(unsigned int num)
> > +{
> > +	struct s390_cpu_feature *feature;
> > +
> > +	feature = &s390_cpu_features[num];
> 
> I would put some check to make sure you are going past the end of the
> array. 
> 
> Maybe something like
> 
> if (num >= MAX_CPU_FEATURES) {
> 	WARN(1, "Invalid feature %d", num);
> 	return 0;

That makes sense. I would go for a simple

	if (WARN_ON_ONCE(num >= MAX_CPU_FEATURES))
		return 0;
