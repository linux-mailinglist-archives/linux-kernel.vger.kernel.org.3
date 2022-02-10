Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A8B4B079A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiBJH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:56:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8BBAE;
        Wed,  9 Feb 2022 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644479774; x=1676015774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8UgR787ewrZS9tOQpQFXRDaJVesqcuVUgUYSZ5cedQ=;
  b=qJBi7hHsQkaMz6umMjIaWSYzs690HqNVplGCvGbMIupT75iG49bWOx5x
   CZz6iTnPTB7ELOqS+DGy1lsocwE5/o+4SFj0JlhImvT1nIAOoQyF2/5r3
   cbkRPzFz68jHDnmT2gtylsc9q588+4S0+Q4Aq+H+fqgNNsfVEi40a6Abw
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2022 23:56:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:56:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 23:56:13 -0800
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 23:56:13 -0800
Date:   Wed, 9 Feb 2022 23:56:11 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] usb: typec: ucsi: Register USB Power Delivery
 Capabilities
Message-ID: <20220210075611.GC13801@jackp-linux.qualcomm.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
 <20220203144657.16527-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220203144657.16527-4-heikki.krogerus@linux.intel.com>
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

On Thu, Feb 03, 2022 at 05:46:57PM +0300, Heikki Krogerus wrote:
> UCSI allows the USB PD capabilities to be read with the
> GET_PDO command. This will register those capabilities, and
> that way make them visible to the user space.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 128 +++++++++++++++++++++++++++++++---
>  drivers/usb/typec/ucsi/ucsi.h |   8 +++
>  2 files changed, 125 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index f0c2fa19f3e0f..5149001093c7f 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -568,8 +568,8 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
>  	}
>  }
>  
> -static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
> -			 u32 *pdos, int offset, int num_pdos)
> +static int ucsi_read_pdos(struct ucsi_connector *con, enum typec_role role, int is_partner,
> +			  u32 *pdos, int offset, int num_pdos)
>  {
>  	struct ucsi *ucsi = con->ucsi;
>  	u64 command;
> @@ -579,7 +579,7 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
>  	command |= UCSI_GET_PDOS_PARTNER_PDO(is_partner);
>  	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
>  	command |= UCSI_GET_PDOS_NUM_PDOS(num_pdos - 1);
> -	command |= UCSI_GET_PDOS_SRC_PDOS;
> +	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
>  	ret = ucsi_send_command(ucsi, command, pdos + offset,
>  				num_pdos * sizeof(u32));
>  	if (ret < 0 && ret != -ETIMEDOUT)
> @@ -590,26 +590,39 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
>  	return ret;
>  }
>  
> -static int ucsi_get_src_pdos(struct ucsi_connector *con)
> +static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
> +			 int is_partner, u32 *pdos)
>  {
> +	u8 num_pdos;
>  	int ret;
>  
>  	/* UCSI max payload means only getting at most 4 PDOs at a time */
> -	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
> +	ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
>  	if (ret < 0)
>  		return ret;
>  
> -	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> -	if (con->num_pdos < UCSI_MAX_PDOS)
> -		return 0;
> +	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> +	if (num_pdos < UCSI_MAX_PDOS)
> +		return num_pdos;
>  
>  	/* get the remaining PDOs, if any */
> -	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
> -			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
> +	ret = ucsi_read_pdos(con, role, is_partner, pdos, UCSI_MAX_PDOS,
> +			     PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret / sizeof(u32) + num_pdos;
> +}
> +
> +static int ucsi_get_src_pdos(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 1, con->src_pdos);

This issues the GET_PDOS command to PPM to get the source PDOs of the
partner...

>  	if (ret < 0)
>  		return ret;
>  
> -	con->num_pdos += ret / sizeof(u32);
> +	con->num_pdos += ret;
>  
>  	ucsi_port_psy_changed(con);
>  
> @@ -638,6 +651,60 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
>  	return ret;
>  }
>  
> +static int ucsi_register_partner_pdos(struct ucsi_connector *con)
> +{
> +	struct pd_desc desc = { con->ucsi->cap.pd_version };
> +	struct pd_capabilities *cap;
> +	struct pd_caps_desc caps;
> +	int ret;
> +
> +	con->partner_pd = typec_partner_register_pd(con->partner, &desc);
> +	if (IS_ERR(con->partner_pd))
> +		return PTR_ERR(con->partner_pd);
> +
> +	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 1, caps.pdo);

... and also here.

> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret < PDO_MAX_OBJECTS)
> +		caps.pdo[ret] = 0;
> +	caps.role = TYPEC_SOURCE;
> +
> +	cap = pd_register_capabilities(con->partner_pd, &caps);
> +	if (IS_ERR(cap))
> +		return PTR_ERR(cap);
> +
> +	ret = typec_partner_set_pd_capabilities(con->partner, cap);
> +	if (ret) {
> +		pd_unregister_capabilities(cap);
> +		return ret;
> +	}
> +
> +	con->partner_source_caps = cap;
> +
> +	ret = ucsi_get_pdos(con, TYPEC_SINK, 1, caps.pdo);
> +	if (ret <= 0)
> +		return ret;
> +
> +	if (ret < PDO_MAX_OBJECTS)
> +		caps.pdo[ret] = 0;
> +	caps.role = TYPEC_SINK;
> +
> +	cap = pd_register_capabilities(con->partner_pd, &caps);
> +	if (IS_ERR(cap))
> +		return PTR_ERR(cap);
> +
> +	ret = typec_partner_set_pd_capabilities(con->partner, cap);
> +	if (ret) {
> +		pd_unregister_capabilities(cap);
> +		return ret;
> +	}
> +
> +	con->partner_sink_caps = cap;
> +
> +	return 0;
> +}
> +
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  {
>  	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
> @@ -646,6 +713,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
>  		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
>  		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
> +		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);

And, both ucsi_get_src_pdos() and ucsi_register_partner_pdos() are
scheduled to run here...

>  		break;
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
>  		con->rdo = 0;
> @@ -704,6 +772,17 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>  	if (!con->partner)
>  		return;
>  
> +	typec_partner_unset_pd_capabilities(con->partner, TYPEC_SINK);
> +	pd_unregister_capabilities(con->partner_sink_caps);
> +	con->partner_sink_caps = NULL;
> +
> +	typec_partner_unset_pd_capabilities(con->partner, TYPEC_SOURCE);
> +	pd_unregister_capabilities(con->partner_source_caps);
> +	con->partner_source_caps = NULL;
> +
> +	typec_partner_unregister_pd(con->partner);
> +	con->partner_pd = NULL;
> +
>  	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
>  	typec_unregister_partner(con->partner);
>  	con->partner = NULL;
> @@ -1037,6 +1116,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  	u64 command;
>  	char *name;
>  	int ret;
> +	struct pd_desc desc = { ucsi->cap.pd_version };
> +	struct pd_caps_desc caps;
>  
>  	name = kasprintf(GFP_KERNEL, "%s-con%d", dev_name(ucsi->dev), con->num);
>  	if (!name)
> @@ -1103,6 +1184,24 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  		goto out;
>  	}
>  
> +	con->pd = typec_port_register_pd(con->port, &desc);
> +
> +	ret = ucsi_get_pdos(con, TYPEC_SOURCE, 0, caps.pdo);
> +	if (ret > 0) {
> +		caps.pdo[ret] = 0;
> +		caps.role = TYPEC_SOURCE;
> +		con->source_caps = pd_register_capabilities(con->pd, &caps);
> +		typec_port_set_pd_capabilities(con->port, con->source_caps);
> +	}
> +
> +	ret = ucsi_get_pdos(con, TYPEC_SINK, 0, caps.pdo);
> +	if (ret > 0) {
> +		caps.pdo[ret] = 0;
> +		caps.role = TYPEC_SINK;
> +		con->sink_caps = pd_register_capabilities(con->pd, &caps);
> +		typec_port_set_pd_capabilities(con->port, con->sink_caps);
> +	}
> +
>  	/* Alternate modes */
>  	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_CON);
>  	if (ret) {
> @@ -1169,6 +1268,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  	    UCSI_CONSTAT_PWR_OPMODE_PD) {
>  		ucsi_get_src_pdos(con);
>  		ucsi_check_altmodes(con);
> +		ucsi_register_partner_pdos(con);

... as well as here.

So wouldn't this result in the PPM issuing the same PD Get_Source_Cap
message twice to the port partner (in either case of initial port
registration or op mode change)?  Could we just consolidate them to just
issue GET_PDOS only once and take care of populating the partner's
Source Caps for both the pd_capabilties as well as power_supply purposes
from a single helper?

Another aside, thinking back to a previous patch [1] I had proposed a
few months ago, another question I had is whether it is proper to even
issue a Get_Source_Cap message to sink-only devices, as we did encounter
certain DisplayPort adapters that don't like when that happens.
Wondering if it could be possible to limit calling the GET_PDOS command
unless we know the partner is capable of operating in that particular
power role.  e.g. don't call get_src_pdos() if partner is sink-only.
Or is this the kind of thing that the PPM is supposed to be able to
figure out and allow OPM to naively issue the command regardless, and
just get an error/empty return?

[1] https://lore.kernel.org/all/20211027064842.6901-1-quic_jackp@quicinc.com/

Thanks,
Jack
