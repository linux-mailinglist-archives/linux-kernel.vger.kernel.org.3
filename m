Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F094B9877
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiBQFzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiBQFzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:55:02 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B152838E6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:54:46 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220217055440epoutp047cb76c795a2327d2eab5e4e63b529b6f~UfRH5wWBy2654026540epoutp048
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:54:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220217055440epoutp047cb76c795a2327d2eab5e4e63b529b6f~UfRH5wWBy2654026540epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645077280;
        bh=fE01e/NtX+AjCnJ40sfy/JMNDKNIr5kI5yo/skDy1Sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=INNWaamUzeQW+8xkk5GRTT3QS4BST+YmG1d7bRkBkfbAff1URLHCHGd+ZX8vd4OH2
         60gddQkLKkCayz2GrIC5Awhdd8YZg+/qHskkxVB1m7/15PVT10/pXNS0PCXzJK2ePh
         UkH3kqxVymoCWAMw7+I5Js48IIwPYSvUEbn3gzuM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220217055439epcas2p1b2a0d0dba45bf0e108a3aa5877e75106~UfRHTxurH2809228092epcas2p1G;
        Thu, 17 Feb 2022 05:54:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JzkYT4V4zz4x9Pq; Thu, 17 Feb
        2022 05:54:37 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.DB.25540.0D0ED026; Thu, 17 Feb 2022 14:44:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220217055434epcas2p3b85d195b91d2bbb4dcfea2787d50039b~UfRDFrghV1402214022epcas2p3S;
        Thu, 17 Feb 2022 05:54:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220217055434epsmtrp1432962b2c003b6df428bf4a23d2f711e~UfRDEqb591385113851epsmtrp1T;
        Thu, 17 Feb 2022 05:54:34 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-85-620de0d03253
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.D3.08738.A13ED026; Thu, 17 Feb 2022 14:54:34 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217055434epsmtip13561f8415a14f506e3e88d704e67e51d~UfRCzxXJ10186201862epsmtip1I;
        Thu, 17 Feb 2022 05:54:34 +0000 (GMT)
Date:   Thu, 17 Feb 2022 14:52:14 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: Re: [RFC PATCH v2 3/3] usb: dwc3: Issue core soft reset before
 enabling run/stop
Message-ID: <20220217055214.GA152781@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20220216000835.25400-4-quic_wcheng@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmue6FB7xJBt/brS2OtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Ixjs76wFzRIVjQvimlgvCrSxcjJISFgIjHjSidzFyMXh5DADkaJD6vPMUI4nxglru/9zA7h
        fGaUWH7pChNMS1/vciaIxC5GiaeXfrNBOE8YJfb9bWAEqWIRUJXYe7gdrINNQEvi3o8TzCC2
        CJB9Z859sB3MAgsYJS5OuMAGkhAWiJZY0nQLrIhXQEfi24EeJghbUOLkzCcsIDangK3Ey/Y/
        QHEODlEBFYlXB+tB5kgIfGWXWHhnMtR5LhL7du+HsoUlXh3fwg5hS0m87G+Dsosldn1qZYJo
        bmCUaHwAcZ2EgLHErGftYB8wC2RIvJ3dxQiyTEJAWeLILRaIMJ9Ex+G/7BBhXomONiGITmWJ
        6ZcnsELYkhIHX5+DmughsejRQ2hoHWaUeLJnO+MERvlZSF6bhWQbhK0jsWD3J7ZZQCuYBaQl
        lv/jgDA1Jdbv0l/AyLqKUSy1oDg3PbXYqMAYHtvJ+bmbGMEpVMt9B+OMtx/0DjEycTAeYpTg
        YFYS4f1wkDdJiDclsbIqtSg/vqg0J7X4EKMpMKImMkuJJucDk3heSbyhiaWBiZmZobmRqYG5
        kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQamTv57XUs3/33VeStnJUvKpA/TLJX3rzZp2X1b
        p7hqvVk10+EPxxfwZyVOSbsj2KSx973UtdW1ajfuJvM8VlnnNK/FdT7r4g0tCumrlvFXrvsX
        ZLPrpafp73e/NhufZ59Uc8Zp86w4l0U8sx263yXNTd68VuHjfzkN7mlWrQ8fzuLp/xUQ8PEj
        S15v6cONOv5+5z+mTrhYVulSuOf2eTcVk+vSQkI2B1b+Ezx92KCKPcGE5c+fJ/o/2RhXv/FN
        DFc+3Sn0vz3glYqYfsKaoO9sm/YpWYuIsXEUHdqyU3txZdjKmvgZyaeOTRPPNp/ybfrjJpMT
        Lo1lMl2Na4szM3Le+69+HO0j8MuA+XvvXaZbSizFGYmGWsxFxYkAltmHfSoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnK7UY94kgyNLtCyOtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        axSXTUpqTmZZapG+XQJXxpZLn9kLDohV7OsQaWBcJ9TFyMkhIWAi0de7nKmLkYtDSGAHo8TK
        le3sEAlJiaVzb0DZwhL3W46wQhQ9YpT4+fQ7M0iCRUBVYu/hdiYQm01AS+LejxNgcREg+86c
        +4wgDcwCCxglLk64wAaSEBaIlljSdAusiFdAR+LbgR6o1YcZJXZsbGGDSAhKnJz5hAXEZgaa
        dOPfS6AiDiBbWmL5Pw6QMKeArcTL9j9gYVEBFYlXB+snMArOQtI8C0nzLITmBYzMqxglUwuK
        c9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNAS2sH455VH/QOMTJxMB5ilOBgVhLh/XCQN0mI
        NyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJocF1z/KimvX
        +fEeWikRn31wGseqCoXH5rI/cmeJ9V0sN2vROOmfYrj4UZtnLX/k9XnSokV/PCRY5lYd/hDe
        w3fiiRjvwlX2ja6x3x7UBQe0sVac+iJ0plMwafax2RdCdqy8/FusQsBfnWPZgeTb/+4t3s7v
        nK2yPfLPzXlyHyO703o3XPhZIe3w6FpEjkCS2BTljX76palBxVrb1YRSBM50imdvF5udH885
        r3TepSMbp8m/kjnGtUrrRhLHuwPGDt8inpVfVbtU16hVP+fR/oKHVXsefz4552zkra7+LQ3f
        t/LWFfWXmjD0n5ANW7ksNESpZZ630p7/JnGBbBkxholKUrcPmp3atC+aw/ebEktxRqKhFnNR
        cSIAAS8eB+8CAAA=
X-CMS-MailID: 20220217055434epcas2p3b85d195b91d2bbb4dcfea2787d50039b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_fe3cf_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220216000912epcas2p419fb5d4f7044389451e28802dd471c5e
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
        <CGME20220216000912epcas2p419fb5d4f7044389451e28802dd471c5e@epcas2p4.samsung.com>
        <20220216000835.25400-4-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_fe3cf_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi wesley,

On Tue, Feb 15, 2022 at 04:08:35PM -0800, Wesley Cheng wrote:
> It is recommended by the Synopsis databook to issue a DCTL.CSftReset
> when reconnecting from a device-initiated disconnect routine.  This
> resolves issues with enumeration during fast composition switching
> cases, which result in an unknown device on the host.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c   |  4 +---
>  drivers/usb/dwc3/core.h   |  2 ++
>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 18adddfba3da..02d10e1cb774 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  	dwc->current_dr_role = mode;
>  }
>  
> -static int dwc3_core_soft_reset(struct dwc3 *dwc);
> -
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc = work_to_dwc(work);
> @@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
>   * dwc3_core_soft_reset - Issues core soft reset and PHY reset
>   * @dwc: pointer to our context structure
>   */
> -static int dwc3_core_soft_reset(struct dwc3 *dwc)
> +int dwc3_core_soft_reset(struct dwc3 *dwc)
>  {
>  	u32		reg;
>  	int		retries = 1000;
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 00348d6d479b..b27ad8dad317 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1532,6 +1532,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
>  int dwc3_event_buffers_setup(struct dwc3 *dwc);
>  void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>  
> +int dwc3_core_soft_reset(struct dwc3 *dwc);
> +
>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>  int dwc3_host_init(struct dwc3 *dwc);
>  void dwc3_host_exit(struct dwc3 *dwc);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 0c89baedf220..788889f924f9 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2585,6 +2585,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  						dwc->ev_buf->length;
>  		}
>  	} else {
> +		/*
> +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 1.90a
> +		 * Section 4.1.9, it specifies that for a reconnect after a
> +		 * device-initiated disconnect requires a core soft reset
> +		 * (DCTL.CSftRst) before enabling the run/stop bit.
> +		 */
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dwc3_core_soft_reset(dwc);
> +		spin_lock_irqsave(&dwc->lock, flags);
> +
> +		dwc3_event_buffers_setup(dwc);

Could you tell me why you add dwc3_event_buffer_setup?

Best Regards,
Jung Daehwan

>  		__dwc3_gadget_start(dwc);
>  	}
>  
> 

------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_fe3cf_
Content-Type: text/plain; charset="utf-8"


------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_fe3cf_--
