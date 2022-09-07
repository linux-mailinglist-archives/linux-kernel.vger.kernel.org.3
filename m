Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322555AF9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIGCTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIGCTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:19:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD61D33D;
        Tue,  6 Sep 2022 19:19:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Ldpow002735;
        Wed, 7 Sep 2022 02:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=tiMuMtloEl6dF3vltfvZce+MAf2KzlQANPJ0FBStzsM=;
 b=1bNSHOwdR80AkUx6fNFz1np2wyvC0xh5rO+JxmBOfH26CNJjtjN0pHKjvYJdzh3xTLwP
 QIh7H+Tr4SYFWvES9ccN2Vs8jomhkWpczyh/988luPMGlw0X03/SgTN4z4ffR3dhqLda
 hSeASxjaIYS1sLUseSe/L1kDliJK1QUxurgKsbbGF+Y4pDYBgajVUd3HqfqSvdPPUUqM
 K7b2vajHMVZDtwOiSH/J8LzJHaBIw+hdEMF7HNkCUhGa8nJSdJJ2zy09YSFz4YmL7f5U
 rjli+hmD0lnFaS6yXgRKLkLHq3c2yLC9vW4orUIPgWBiXJdz8sgtJvL363asu7DOUy6b +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtafeeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:19:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286NTfkl024586;
        Wed, 7 Sep 2022 02:19:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9yave-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:19:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872JClc006033;
        Wed, 7 Sep 2022 02:19:12 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc9yav6-1;
        Wed, 07 Sep 2022 02:19:12 +0000
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v8] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qsogc4w.fsf@ca-mkp.ca.oracle.com>
References: <20220829081845.v8.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
Date:   Tue, 06 Sep 2022 22:19:11 -0400
In-Reply-To: <20220829081845.v8.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
        (Daniil Lunev's message of "Mon, 29 Aug 2022 08:18:58 +1000")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=934 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070008
X-Proofpoint-ORIG-GUID: tEkZaeEK-d1SCqXFkqVz26S2tsypn8pO
X-Proofpoint-GUID: tEkZaeEK-d1SCqXFkqVz26S2tsypn8pO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniil,

> Userspace may want to manually control when the data should go into
> WriteBooster buffer. The control happens via "wb_on" node, but
> presently, there is no simple way to check if WriteBooster is
> supported and enabled. This change exposes the Write Booster and Clock
> Scaling capabilities to be able to determin if the Write Booster is
> available and if its manual control is blocked by Clock Scaling
> mechanism.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
