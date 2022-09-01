Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519455A9FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIATXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiIATW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:22:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764B7F0B8;
        Thu,  1 Sep 2022 12:22:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281JHODa007665;
        Thu, 1 Sep 2022 19:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=DWb4uD3u8xuUD0Z0QfUjfyG7JwYuEU9wKlkO5fuZQLo=;
 b=DOL701KOv7vGRmcjcw+OG6dVtjSctUmnWryyEpdz6YHf65Sa+E4v/IzyEFif0Qnth+Va
 nYfxxIllgBQaZXUGdDa9mU/eCKVijhHdx4eQO76rZi4QPI43Gb0Vi08d50bueFUTa97/
 AJ22fnFXEfZHquRoGHiZlkMBU+nUqijxSm7UydbHKNhpmY7tX4DbEnP6Q6CwNoblEDFQ
 JiHQDFG0FwpWxAmycXROe7AFPp4NrEIJteux6vVIqpP/ikj3JWI8XexZgS6+pL/zgB5E
 UZbcO2NW/UtxyRdtbSoAZo9ye6anvOGERFvcloG34RoYyh+TI4AB/HHUhqeFYejP5lNr XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabqk4q02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 19:22:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281JMrqJ028044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 19:22:53 GMT
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 12:22:52 -0700
Date:   Thu, 1 Sep 2022 12:22:47 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] usb: dwc3: Avoid unmapping USB requests if
 endxfer is not complete
Message-ID: <20220901192154.GA19313@jackp-linux.qualcomm.com>
References: <20220901184314.30481-1-quic_wcheng@quicinc.com>
 <20220901184314.30481-2-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901184314.30481-2-quic_wcheng@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gbZ6P6r3HTOkSrZSMDvJglQOO9QjkGDn
X-Proofpoint-ORIG-GUID: gbZ6P6r3HTOkSrZSMDvJglQOO9QjkGDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Thu, Sep 01, 2022 at 11:43:10AM -0700, Wesley Cheng wrote:
> If DWC3_EP_DELAYED_STOP is set during stop active transfers, then do not
> continue attempting to unmap request buffers during dwc3_remove_requests().
> This can lead to SMMU faults, as the controller has not stopped the
> processing of the TRB.  Defer this sequence to the EP0 out start, which
> ensures that there are no pending SETUP transactions before issuing the
> endxfer.
> 
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/core.h   | 3 +++
>  drivers/usb/dwc3/ep0.c    | 5 ++++-
>  drivers/usb/dwc3/gadget.c | 6 +++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4fe4287dc934..7d5d2507244b 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1560,6 +1560,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>  int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
>  		u32 param);
>  void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
> +void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
>  #else
>  static inline int dwc3_gadget_init(struct dwc3 *dwc)
>  { return 0; }
> @@ -1581,6 +1582,8 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
>  { return 0; }
>  static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
>  { }
> +static inline void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)

Oops, you missed updating this with the additional 'status' parameter as
well.

Jack
