Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFD4EDB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiCaOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiCaOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706A1BFDF7;
        Thu, 31 Mar 2022 07:20:20 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VDP8Ip010210;
        Thu, 31 Mar 2022 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=kRBcowtAIg+U1BYIxVvx2TwDQmBLa27VX92AbZvvO4I=;
 b=WgiKreRg6xVX1G7roLx5WLkwcIvedfV5EQ5WbLgZW8tvtGFvlAvjj2ctlWp5/sEfIQ0s
 vg5HXC/7R0LXUNJPEx4lg5qGGPCx4ZUFlQbKTRBk7ojKyV5PKNo/jj31JZlhDi3aZYLG
 7PKsBqhA8p4gtItYzGsUl6SV8xQS1ELgLsfU6tBrBjcoIAT4cSLa0cBWktIX/DSPyCG8
 C/rW2BJY/HfVwnFhGXivvIZcqOhBkq3ZLp1TNi6TsH5E1/1RZlcVAyRxOrXJdPQYgdCn
 Hr/tyBflBcIL6uXMmk9ZoIynMEMgVZqigzYhy/YCKc1UYYNMSfVBFoCvSZz3jiXN9bSW Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f58a401cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 14:20:03 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22VEK20k024987;
        Thu, 31 Mar 2022 14:20:02 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f58a401c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 14:20:02 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22VEDZ8E001147;
        Thu, 31 Mar 2022 14:20:01 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3f1tfae6nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 14:20:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22VEK0GZ14156216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:20:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BAA27806B;
        Thu, 31 Mar 2022 14:20:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0C8C78063;
        Thu, 31 Mar 2022 14:19:58 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551::c14] (unknown [9.163.9.79])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 14:19:58 +0000 (GMT)
Message-ID: <574d33978be5eb4732cd3bf61727e6b509a7e484.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com
Cc:     fmdefrancesco@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        linfeilong@huawei.com
Date:   Thu, 31 Mar 2022 10:19:57 -0400
In-Reply-To: <20220331134210.GF12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
         <20220331152622.616534-1-haowenchao@huawei.com>
         <20220331054156.GI3293@kadam>
         <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com>
         <20220331134210.GF12805@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zKmGDzLpzzB_S1JDhPOk3DeX7A3LagNa
X-Proofpoint-GUID: e9DkUTvMMIgF-uLZnCkqQYobHaGnPue4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=580
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-31 at 16:42 +0300, Dan Carpenter wrote:
[...]
> Also, I don't really understand why we don't have to call
> put_device(&sdkp->disk_dev) at the end of sd_remove().

That's because the final put is done by the gendisk ->free_disk()
function which is scsi_disk_free_disk().  Most of the gendisk functions
we provide convert a gendisk to a scsi_disk (via the gendisk
private_data), so the sdkp has to live as long as the gendisk.

James


