Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E387529F87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiEQKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbiEQKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:34:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4E629CA3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:33:09 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAT5KK025732;
        Tue, 17 May 2022 10:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PcjdGuEDm0Uy4HFqQ0oqMFsTEP1sBNNpNA4Jw/4K3jU=;
 b=fTpv0TYcDKvlTsPgq1SqVjMEYam0Ij4F3ZMWc/qsCapdaNP+QZm5HKxOl5nGFvL50AvY
 zyCIp/DzWjcT97aih2gLMGE30/PoP3qYO115LWXgGijt1PJGPSwsA4yEGHTcmgUEy+Ge
 MRtzpuOCqaX2I72/Y5PwkHXp8XJusKy6BjmhHUy6k4l78EXK7HVu15iyN3EDmGBUD+V4
 S8X/4QvH7Ll1YnHsqNR70qfb9rpalGRBmXI3nhgOytMz7NP7sjBGU+8UpdB1CbmbxktT
 GTr0RjsbpcrUWeq5Erb38Pe7eoXhx035Vc8oTSz/JCNLFnbsjJyyKTbsbWPxyFY61UIv uQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g49yy02c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:32:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HANhIs002035;
        Tue, 17 May 2022 10:32:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429c1yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:32:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HAVw7W33292600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 10:31:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51B99A4062;
        Tue, 17 May 2022 10:32:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FBA4A4060;
        Tue, 17 May 2022 10:32:31 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 10:32:31 +0000 (GMT)
Message-ID: <8183a172d9e13d5b69f00ce4382dcaeb5ecdb4f7.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Date:   Tue, 17 May 2022 12:32:30 +0200
In-Reply-To: <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
         <20220517083657.GA16377@lst.de>
         <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
         <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cF-ugdLpC8p-7Qri5jsKNfrToZVf2fJL
X-Proofpoint-ORIG-GUID: cF-ugdLpC8p-7Qri5jsKNfrToZVf2fJL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=815 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 11:18 +0100, Robin Murphy wrote:
> On 2022-05-17 11:17, Niklas Schnelle wrote:
> > On Tue, 2022-05-17 at 10:36 +0200, Christoph Hellwig wrote:
> > > On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
> > > > In __iommu_dma_alloc_noncontiguous() the value returned by
> > > > iommu_map_sg_atomic() is checked for being smaller than size. Before
> > > > commit ad8f36e4b6b1 ("iommu: return full error code from
> > > > iommu_map_sg[_atomic]()") this simply checked if the requested size was
> > > > successfully mapped.
> > > > 
> > > > After that commit iommu_map_sg_atomic() may also return a negative
> > > > error value. In principle this too would be covered by the existing
> > > > check. There is one problem however, as size is of type size_t while the
> > > > return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
> > > > converted to size_t and negative error values end up as very large
> > > > positive values making the check succeed. Fix this by making the return
> > > > type visible with a local variable and add an explicit cast to ssize_t.
> > > > 
> > > > Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > 
> > > I don't see what the point of the newly added local variable is here.
> > > Just casting size should be all that is needed as far as I can tell.
> > 
> > No technical reason just found it easier to read and more descriptive.
> > I'll sent a v2 with just the cast, it does simplify the commit message.
> 
> Note that this is already fixed upstream, though:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core&id=a3884774d731f03d3a3dd4fb70ec2d9341ceb39d
> 
> Robin.

Ah oh well then nevermind and you can of course also ignore the v2 I
sent out a minute ago.

