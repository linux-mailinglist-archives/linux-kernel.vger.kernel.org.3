Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422E56D740
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGKIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:00:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A31CB26;
        Mon, 11 Jul 2022 01:00:30 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B7dMnF013422;
        Mon, 11 Jul 2022 08:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xGRh9784j+XL7fT3gPOzqy0OXO59e948uj3leVo7td4=;
 b=JaQvACYNvfKpXTOmQyVwXHDmWQ59LUww8dcubPGvGa3aD0sFh04ROpO05t1Ti/bn3U1F
 44sDCy8c6ooquxMofN2BeHEEn5JVn1nGLQpsy8CtsARDhWN3bJpN2whAPbihHUkfxsYL
 6dLrvlQmH+MtQiTn8B/ePXBKesrdbWl82KQsU0D1X3WhQGJLCfsb2L5Z2KSmxNP343ef
 7ZZGEl2CXovzYSINaHlDvTBQ+yfLmohHUzUP5ppJzj9lsEgSzROXKGMSjTV08fZceVnJ
 gL9RX6IWadLCwskqAA4Q2IdHwOZTP077LlJ0UL7HaliyTUpp1dG/UdMA0UsV+4P7nbsD rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h82jx4uv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:00:27 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B73m9G005350;
        Mon, 11 Jul 2022 08:00:27 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h82jx4utw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:00:27 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B7p9jH010360;
        Mon, 11 Jul 2022 08:00:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3h71a8ht97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:00:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B80LYH19661142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 08:00:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805614C04A;
        Mon, 11 Jul 2022 08:00:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35AA84C040;
        Mon, 11 Jul 2022 08:00:21 +0000 (GMT)
Received: from [9.171.15.135] (unknown [9.171.15.135])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 08:00:21 +0000 (GMT)
Message-ID: <0f498561-4bd3-3247-4ef4-796dc15cdaf3@de.ibm.com>
Date:   Mon, 11 Jul 2022 10:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the vfio tree with the kvms390 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20220711171353.2b8eb09a@canb.auug.org.au>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20220711171353.2b8eb09a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rhy5Yv5kkC8Q2_CF2lQJZvV1QA16GxZu
X-Proofpoint-ORIG-GUID: RVYl-DW9PBJRTD6KsXDTkxUgDCrkZ94c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_13,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.07.22 um 09:13 schrieb Stephen Rothwell:
> Betreff:
> linux-next: manual merge of the vfio tree with the kvms390 tree
> Von:
> Stephen Rothwell <sfr@canb.auug.org.au>
> Datum:
> 11.07.22, 09:13
> 
> An:
> Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
> Kopie (CC):
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Matthew Rosato <mjrosato@linux.ibm.com>
> 
> 
> Hi all,
> 
> Today's linux-next merge of the vfio tree got a conflict in:
> 
>    include/linux/vfio_pci_core.h
> 
> between commits:
> 
>    b6a7066f4e9b ("vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM")
>    6518ebc68c72 ("vfio-pci/zdev: add open/close device hooks")
> 
> from the kvms390 tree and commit:
> 
>    d1877e639bc6 ("vfio: de-extern-ify function prototypes")
> 
> from the vfio tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Alex, Paolo,

I do have a topic branch that we could merge, but I think the conflict is trivial enough for the time being.
