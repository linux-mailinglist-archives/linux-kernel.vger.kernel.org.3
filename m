Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA34E7CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiCYUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCYUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:41:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43014171EF9;
        Fri, 25 Mar 2022 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648240810; x=1679776810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/khNg5Ei108i3fhOUlj+7F6wA9Py3hXoiSYOmw59AqM=;
  b=FNec5TaO6SLl4eVHNIIwfTx+JfcfkR1TIn/dHohym0NYHZvnHLtBl3R6
   zoNfQgaRgnBPQkZhuE/KMR+aMEC/zvPGZKSZTjAvEMqwF+sHSvDD4YbWm
   a84V9tFmJaqJNE5+XwUUiiBavD986gufGGWpYH7ysObQ8Ax8MsLE1sDdN
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 13:40:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:40:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 13:40:09 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 13:40:08 -0700
Date:   Fri, 25 Mar 2022 13:39:59 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, <kyletso@google.com>,
        <andy.shevchenko@gmail.com>, <unixbhaskar@gmail.com>,
        <subbaram@codeaurora.org>, <mrana@codeaurora.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
Message-ID: <20220325203959.GA19752@jackp-linux.qualcomm.com>
References: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
 <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Feb 09, 2022 at 04:30:31PM +0200, Heikki Krogerus wrote:
> On Wed, Feb 09, 2022 at 11:50:57AM +0800, Jia-Ju Bai wrote:
> > Hello,
> > 
> > My static analysis tool reports a possible deadlock in the ucsi driver in
> > Linux 5.16:
> > 
> > ucsi_pr_swap()
> >   mutex_lock(&con->lock); --> Line 962 (Lock A)
> >   wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)
> > 
> > ucsi_handle_connector_change()
> >   mutex_lock(&con->lock); --> Line 763 (Lock A)
> >   complete(&con->complete); --> Line 782 (Wake X)
> >   complete(&con->complete); --> Line 807 (Wake X)
> > 
> > When ucsi_pr_swap() is executed, "Wait X" is performed by holding "Lock A".
> > If ucsi_handle_connector_change() is executed at this time, "Wake X" cannot
> > be performed to wake up "Wait X" in ucsi_handle_connector_change(), because
> > "Lock A" has been already held by ucsi_handle_connector_change(), causing a
> > possible deadlock.
> > I find that "Wait X" is performed with a timeout, to relieve the possible
> > deadlock; but I think this timeout can cause inefficient execution.
> > 
> > I am not quite sure whether this possible problem is real.
> > Any feedback would be appreciated, thanks :)
> 
> This is probable a regression from commit ad74b8649bea ("usb: typec:
> ucsi: Preliminary support for alternate modes"). Can you test does
> this patch fix the issue (attached)?

We encountered a slightly different twist to this bug.  Instead of
deadlocking, we see that the dr_swap() / pr_swap() operations actually
jump out of the wait_for_completion_timeout() immediately, even before
any partner change occurs.  This is because the con->complete may
already have its done flag set to true from the first time
ucsi_handle_connector_change() runs, and is never reset after that.

In addition to the unlocking below, I think we need to also add
reinit_completion() calls at the start of ucsi_{pr,dr}_swap().

Thanks,
Jack

> From 2ad06425a3df7be656f8a5b3c202aab45554fd17 Mon Sep 17 00:00:00 2001
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Date: Wed, 9 Feb 2022 17:27:19 +0300
> Subject: [PATCH] usb: typec: ucsi: Test fix
> 
> Interim.
> 
> Not-Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index f0c2fa19f3e0f..225104beda8be 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -956,14 +956,18 @@ static int ucsi_dr_swap(struct typec_port *port, enum typec_data_role role)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> +	mutex_unlock(&con->lock);
> +
>  	if (!wait_for_completion_timeout(&con->complete,
>  					msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
> -		ret = -ETIMEDOUT;
> +		return -ETIMEDOUT;
> +
> +	return 0;
>  
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  
> -	return ret < 0 ? ret : 0;
> +	return ret;
>  }
>  
>  static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
> @@ -992,11 +996,13 @@ static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> +	mutex_unlock(&con->lock);
> +
>  	if (!wait_for_completion_timeout(&con->complete,
> -				msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS))) {
> -		ret = -ETIMEDOUT;
> -		goto out_unlock;
> -	}
> +				msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
> +		return -ETIMEDOUT;
> +
> +	mutex_lock(&con->lock);
>  
>  	/* Something has gone wrong while swapping the role */
>  	if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) !=
> @@ -1372,6 +1378,7 @@ void ucsi_unregister(struct ucsi *ucsi)
>  	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
>  
>  	for (i = 0; i < ucsi->cap.num_connectors; i++) {
> +		complete(&ucsi->connector[i].complete);
>  		cancel_work_sync(&ucsi->connector[i].work);
>  		ucsi_unregister_partner(&ucsi->connector[i]);
>  		ucsi_unregister_altmodes(&ucsi->connector[i],
> -- 
> 2.34.1
> 

