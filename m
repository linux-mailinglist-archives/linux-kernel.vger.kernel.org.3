Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3EC56B455
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiGHISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiGHIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:17:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8048049E;
        Fri,  8 Jul 2022 01:17:54 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686bfeG002418;
        Fri, 8 Jul 2022 08:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xu4rCDT68mfO5MudmK6UmIYbKX3my2hBQzJ60S+24hQ=;
 b=Lyr920IHY24YJdACfJBEbx+YhwQg2zV536m5TfEzFiLuWb9bM4551+eHtC+62umKXNGh
 v/NFJU2uayTkGICCY7Gq0YzsTSmC1y2BQ2OcFyKQ2V96U2JwVg+MRcHdEMYEURPFEL/k
 M3/qUHQt0o1W/uAFQ5ly8pdHc9TCgK1brmj0gI1oGasaDIZ5Wh0UoNxztKvlghseBMDx
 gDwoVcPSEoUllVK8Ld8r3DUZO9V7lHk9I6/yUCWk4sjmvuhpzdJmb27gTHKB+HrMnh2Q
 9SFGq8Y5D+ntSbxWwQjYJODqmQbKzndjusrSHvJ7Gx7omnj9xIVBtbc0nuSXP/Tl7y96 2A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6e9ymfyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:17:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 268860be014846;
        Fri, 8 Jul 2022 08:17:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4jupng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:17:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2688HVlG24903996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jul 2022 08:17:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B368A4054;
        Fri,  8 Jul 2022 08:17:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC66A405F;
        Fri,  8 Jul 2022 08:17:30 +0000 (GMT)
Received: from sig-9-145-21-70.uk.ibm.com (unknown [9.145.21.70])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jul 2022 08:17:30 +0000 (GMT)
Message-ID: <44c823d7c9ab15579d30734761200c0a6ed44a6f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Jul 2022 10:17:30 +0200
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MWVqaxMEq8CD8_OlP2DoJ9y5jxZ7Sui9
X-Proofpoint-ORIG-GUID: MWVqaxMEq8CD8_OlP2DoJ9y5jxZ7Sui9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=780 clxscore=1015 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207080030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 18:08 +0100, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1650890638.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v3, now with working x86! Having finally made sense of how I
> broke Intel, I've given AMD the same fix by inspection. I'm still not
> 100% sure about s390, but it looks like it should probably be OK since
> it seems to register an IOMMU instance for each PCI device (?!) before
> disappearing into PCI hotplug code, wherein I assume we should never see
> a PCI device appear without its IOMMU already registered.

Yes, this is a bit unusual as our PCI architecture doesn't really have
a notion of an IOMMU device only of I/O translation tables. These are
then registered per PCI function. PCI functions may share I/O
translation tables and thus DMA address spaces but this is not done at
the moment. As Matt already mentioned we do need a small change for
this patch series. Since that was still mangled in his mail for me I
just replied with that using "git send-email". With Matt's patch
applied I can confirm that this works fine for us and does look like a
useful simplification. So feel free to add my

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

