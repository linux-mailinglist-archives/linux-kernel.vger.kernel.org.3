Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416E14B9C59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiBQJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:46:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiBQJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:46:32 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFC1705F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:46:17 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220217094614epoutp03faffe20f9477998150e7f835dac9fabd~UibUGjxJY0327503275epoutp03T
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:46:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220217094614epoutp03faffe20f9477998150e7f835dac9fabd~UibUGjxJY0327503275epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645091174;
        bh=YtIs6HfKgm2suQmqonwEnnMUyJ6x6ufYGCqDDJ4lONs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NC/ghVqyClo0RFx4GhzkD7drcdLLp0eaINnDdJmSOcqGybgUWvGLjQA1+IvNPqc5I
         3f5sEmVUjpZkisf80TnvwVFy8/BAt0zIbNbZJgoH2nU5RdSFdavBnfp3py5ETyihta
         OH1N+BOFsxUXZTQNjV8m0dwK0pUP07LmCpsHv/wk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220217094613epcas2p1a31e86bb83f74b755bd23c393a6245d0~UibTaWa_q1972619726epcas2p1t;
        Thu, 17 Feb 2022 09:46:13 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jzqhh0V7Jz4x9Q7; Thu, 17 Feb
        2022 09:46:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.B0.12141.1F81E026; Thu, 17 Feb 2022 18:44:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220217094611epcas2p135157769acb0262a71533bad35abebc1~UibRblKun0379003790epcas2p1J;
        Thu, 17 Feb 2022 09:46:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217094611epsmtrp2dcacb285fae860020f4d262f791b99d2~UibRa19lR1108811088epsmtrp2G;
        Thu, 17 Feb 2022 09:46:11 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-2d-620e18f122bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.E5.08738.3691E026; Thu, 17 Feb 2022 18:46:11 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217094611epsmtip26ec2678ee27e63d0f6fc877c3a1bce91~UibRSPVLU2129621296epsmtip2Q;
        Thu, 17 Feb 2022 09:46:11 +0000 (GMT)
Date:   Thu, 17 Feb 2022 18:43:54 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: Re: [RFC PATCH v2 3/3] usb: dwc3: Issue core soft reset before
 enabling run/stop
Message-ID: <20220217094354.GB152781@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20220217055214.GA152781@ubuntu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmme5HCb4kg2fXFC2OtT1ht2hevJ7N
        4vKuOWwWi5a1Mlvs+reIyWLT7j5Wi1ULDrA7sHtsWtXJ5rF/7hp2j4l76jy27P/M6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7IwVCx4yFpyUrvizdxNrA+NysS5GTg4JAROJJ4+es3UxcnEICexglOj4+ZcNJCEk8IlR4shH
        c4jEZ0aJrd8XMsJ0fGpewQSR2MUo8e/EFRYI5wmjxPmHb1hBqlgEVCUmtu8DG8UmoCVx78cJ
        ZhBbBMi+M+c+I0gDs8ACRomLEy6AFQkLREssaboFVsQroCOx8t1NRghbUOLkzCcsIDangK7E
        jd9NQDYHh6iAisSrg/UgcyQEfrJL3PkPc56LxKOvXewQtrDEq+NboGwpic/v9rJB2MUSuz61
        MkE0NzBKND6AuE5CwFhi1rN2sEHMApkSXyftZAVZJiGgLHHkFgtEmE+i4/Bfdogwr0RHmxBE
        p7LE9MsTWCFsSYmDr89BTfSQWPToIRMkSJ8xSpz7kTyBUX4Wks9mIVkGYetILNj9iW0W0AZm
        AWmJ5f84IExNifW79Bcwsq5iFEstKM5NTy02KjCBR3Zyfu4mRnAC1fLYwTj77Qe9Q4xMHIyH
        GCU4mJVEeD8c5E0S4k1JrKxKLcqPLyrNSS0+xGgKjKeJzFKiyfnAFJ5XEm9oYmlgYmZmaG5k
        amCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoGp+EzFJ03m6A8z4o5JOPjorZIou/sorKhi
        zSJrvwiv7SobfVcy/P7+vMDC/RCbxMmAKUZpMpW+EnbnY8snz8tapWasvsO4wjVoltiS5c3b
        v3p/5b/nHHar3Ng9wjvBuuB3n7rMGv+U6yUJXzI2XNqzOudf55IUp2kqy1J+iBpofNL9YPP6
        3mXW2Ltr0791Tmxh+yvqpPbKzlDggrD/nca3jnPSnn/e+FPMUip5Sve2Eta5y47/c9eq/O09
        /8h23aibFqH/5qRIW2U92vGn5Yu6zKffB48dipitppx4X6BH92Lb7/IuThGOY7ft5of+j1Mu
        mH5/R/VvX8WDOp5iU3f9efn2xH4Bd/ePh+pvbZqvxFKckWioxVxUnAgAxppbeykEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvG6yJF+SwcZ7ihbH2p6wWzQvXs9m
        cXnXHDaLRctamS12/VvEZLFpdx+rxaoFB9gd2D02repk89g/dw27x8Q9dR5b9n9m9Pi8SS6A
        NYrLJiU1J7MstUjfLoEr4/PLJ8wFbZIVE/+FNDD+Fe5i5OSQEDCR+NS8gqmLkYtDSGAHo8Tl
        HfvZIRKSEkvn3oCyhSXutxxhhSh6xCjx/vRPVpAEi4CqxMT2fWwgNpuAlsS9HyeYQWwRIPvO
        nPuMIA3MAgsYJS5OuABWJCwQLbGk6RZYEa+AjsTKdzcZIaY+Y5SYs3w3C0RCUOLkzCdgNjPQ
        pBv/XgLdxwFkS0ss/8cBEuYU0JW48buJBSQsKqAi8epg/QRGwVlImmchaZ6F0LyAkXkVo2Rq
        QXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwBGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrwfDvIm
        CfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCUOsUpe8PG
        3yf3zT18+uWcmDmHpN35Z7Y0GMQVxorWvqnov+kzW3JdBq+c8oOQD4v+nJhlFfp1lWHDx/mX
        BeSKz108/JJdJHH38WiHY7bnctyUG/ySJE7eksiuf5G613T31+Wla+c/fb/suOytA0JzT0Rp
        VHHmte3LXXQ8xW+BsbTP1+gZb732/n6wVLjj778jJhO9lX4453Brr1jgO7M8Wd8vSmlq7BoX
        IVm5kP1nlycu4udQS9sZN6+icer5yvNflmi9VxYynPTTZ0fNIol36zdG8rwIO7nvjdfxUzor
        jVxuLfsoL3x/14LezvX6smKlyZ6e3G9nilZ+59r5cLtIxtt13Z25627KFbmIZEo0K7EUZyQa
        ajEXFScCAKabbuzvAgAA
X-CMS-MailID: 20220217094611epcas2p135157769acb0262a71533bad35abebc1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_100ab0_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220216000912epcas2p419fb5d4f7044389451e28802dd471c5e
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
        <CGME20220216000912epcas2p419fb5d4f7044389451e28802dd471c5e@epcas2p4.samsung.com>
        <20220216000835.25400-4-quic_wcheng@quicinc.com>
        <20220217055214.GA152781@ubuntu>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_100ab0_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Feb 17, 2022 at 02:52:14PM +0900, Jung Daehwan wrote:
> Hi wesley,
> 
> On Tue, Feb 15, 2022 at 04:08:35PM -0800, Wesley Cheng wrote:
> > It is recommended by the Synopsis databook to issue a DCTL.CSftReset
> > when reconnecting from a device-initiated disconnect routine.  This
> > resolves issues with enumeration during fast composition switching
> > cases, which result in an unknown device on the host.
> > 
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> >  drivers/usb/dwc3/core.c   |  4 +---
> >  drivers/usb/dwc3/core.h   |  2 ++
> >  drivers/usb/dwc3/gadget.c | 11 +++++++++++
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 18adddfba3da..02d10e1cb774 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> >  	dwc->current_dr_role = mode;
> >  }
> >  
> > -static int dwc3_core_soft_reset(struct dwc3 *dwc);
> > -
> >  static void __dwc3_set_mode(struct work_struct *work)
> >  {
> >  	struct dwc3 *dwc = work_to_dwc(work);
> > @@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
> >   * dwc3_core_soft_reset - Issues core soft reset and PHY reset
> >   * @dwc: pointer to our context structure
> >   */
> > -static int dwc3_core_soft_reset(struct dwc3 *dwc)
> > +int dwc3_core_soft_reset(struct dwc3 *dwc)
> >  {
> >  	u32		reg;
> >  	int		retries = 1000;
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 00348d6d479b..b27ad8dad317 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1532,6 +1532,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
> >  int dwc3_event_buffers_setup(struct dwc3 *dwc);
> >  void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
> >  
> > +int dwc3_core_soft_reset(struct dwc3 *dwc);
> > +
> >  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
> >  int dwc3_host_init(struct dwc3 *dwc);
> >  void dwc3_host_exit(struct dwc3 *dwc);
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 0c89baedf220..788889f924f9 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2585,6 +2585,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  						dwc->ev_buf->length;
> >  		}
> >  	} else {
> > +		/*
> > +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 1.90a
> > +		 * Section 4.1.9, it specifies that for a reconnect after a
> > +		 * device-initiated disconnect requires a core soft reset
> > +		 * (DCTL.CSftRst) before enabling the run/stop bit.
> > +		 */
> > +		spin_unlock_irqrestore(&dwc->lock, flags);
> > +		dwc3_core_soft_reset(dwc);
> > +		spin_lock_irqsave(&dwc->lock, flags);
> > +
> > +		dwc3_event_buffers_setup(dwc);
> 
> Could you tell me why you add dwc3_event_buffer_setup?
> 
> Best Regards,
> Jung Daehwan
> 

I'm sorry I misunderstood databook then. It seems to be needed.

Best Regrards,
Jung Daehwan

> >  		__dwc3_gadget_start(dwc);
> >  	}
> >  
> > 



------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_100ab0_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_100ab0_--
