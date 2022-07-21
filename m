Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0257C191
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiGUA1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiGUA1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:27:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55CB643F4;
        Wed, 20 Jul 2022 17:27:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L0RJk0028070;
        Thu, 21 Jul 2022 00:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NmhwEse6cUBIX/nZxf7Dn/Ybq+gGxUUVPu1x3YVEeV0=;
 b=KkIvZQExgPuV9weaFFr16OGUOcSfQrB8MkhkyMCXo5CUmihN3FzKB+UyddJDJ4lEERMt
 yP6gnhy67sZWx6mNAnvpbe08Lols3o9G2D246YDehGGiRlei24rNqNuZudGmTz+WZcLv
 Yn3Nj2Awx7nJ5skYmngz1e75dvFlF2MANlyOP+a+Ac6HlhrIE/Bkq5xpz27YP349RKA3
 1P+w5lEhDSdLT78tWIhb9gE3PkzfBJJpqNcQ0GJif7GJ94uKEZzR5LmqjlEt4EsVxt0E
 KGERcbuneiHOU0NfPgEEc6JAIvSlhjBtn7oKYNfB+3x31FBwDtYOoSDXhNRUHKD2lO90 Aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3he90k2s4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 00:27:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26L0RIoU015444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 00:27:18 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 17:27:18 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 17:27:17 -0700
Date:   Wed, 20 Jul 2022 17:26:59 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     <3090101217@zju.edu.cn>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <colin.king@intel.com>, <jbrunet@baylibre.com>,
        <jleng@ambarella.com>, <pavel.hofman@ivitera.com>,
        <pawell@cadence.com>, <ruslan.bilovol@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: gadget: f_uac2: fix superspeed transfer
Message-ID: <20220720230425.GA8843@jackp-linux.qualcomm.com>
References: <Yg5onoldRY3ygW7v@kroah.com>
 <20220218095948.4077-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218095948.4077-1-3090101217@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GkSVQ6mjgG-VMeCZ2ao9rJdUW8JJw3UY
X-Proofpoint-GUID: GkSVQ6mjgG-VMeCZ2ao9rJdUW8JJw3UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=498
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Feb 18, 2022 at 05:59:48PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> On page 362 of the USB3.2 specification (
> https://usb.org/sites/default/files/usb_32_20210125.zip),
> The 'SuperSpeed Endpoint Companion Descriptor' shall only be returned
> by Enhanced SuperSpeed devices that are operating at Gen X speed.
> Each endpoint described in an interface is followed by a 'SuperSpeed
> Endpoint Companion Descriptor'.
> 
> If users use SuperSpeed UDC, host can't recognize the device if endpoint
> doesn't have 'SuperSpeed Endpoint Companion Descriptor' followed.
> 
> Currently in the uac2 driver code:
> 1. ss_epout_desc_comp follows ss_epout_desc;
> 2. ss_epin_fback_desc_comp follows ss_epin_fback_desc;
> 3. ss_epin_desc_comp follows ss_epin_desc;
> 4. Only ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
> Companion Descriptor' followed, so we should add it.
> 
> Fixes: eaf6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
> ChangeLog v3->v4:
> - Add "Fixes:" tag in the changelog area
> ChangeLog v2->v3:
> - Remove static variables which are explicitly initialized to 0
> - Remove redundant modification "case USB_SPEED_SUPER_PLUS:"
> ChangeLog v1->v2:
> - Update more detailed description of the PATCH

I don't see this patch in any of your trees, so I'm assuming it must not
have made it into your inbox.  If that's the case I would like to
resubmit on Jing's behalf as it does fix a legitimate issue with
enabling the UAC2 gadget in SuperSpeed.

Jack
