Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE165438DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiFHQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiFHQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:26:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C59BF4D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:26:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF591424;
        Wed,  8 Jun 2022 09:26:47 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580E03F73B;
        Wed,  8 Jun 2022 09:26:46 -0700 (PDT)
Date:   Wed, 8 Jun 2022 17:26:40 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET
 behaviour when unsupported
Message-ID: <YqDNsj26zo1NgsUR@e120937-lin>
References: <20220608095530.497879-1-cristian.marussi@arm.com>
 <20220608095530.497879-2-cristian.marussi@arm.com>
 <a349b6be-daa8-e523-6e63-4e9105aa75d9@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a349b6be-daa8-e523-6e63-4e9105aa75d9@opensynergy.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:19:02PM +0200, Peter Hilber wrote:
> Hi Cristian,
> 
> I think I found two missing endianness conversions, see below.
> 
> Best regards,
> 
> Peter

[snip]

> > @@ -393,12 +398,14 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
> >  	u32 attrh, attrl;
> >  	struct scmi_sensor_axis_info *a;
> >  	size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
> > -	struct scmi_sensor_info *s = priv;
> > +	struct scmi_apriv *apriv = priv;
> >  	const struct scmi_axis_descriptor *adesc = st->priv;
> >  
> >  	attrl = le32_to_cpu(adesc->attributes_low);
> > +	if (SUPPORTS_EXTENDED_AXIS_NAMES(attrl))
> > +		apriv->any_axes_support_extended_names = true;
> >  
> > -	a = &s->axis[st->desc_index + st->loop_idx];
> > +	a = &apriv->s->axis[st->desc_index + st->loop_idx];
> >  	a->id = le32_to_cpu(adesc->id);
> >  	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
> >  
> > @@ -444,10 +451,18 @@ iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
> >  					 void *priv)
> >  {
> >  	struct scmi_sensor_axis_info *a;
> > -	const struct scmi_sensor_info *s = priv;
> > +	const struct scmi_apriv *apriv = priv;
> >  	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
> >  
> > -	a = &s->axis[st->desc_index + st->loop_idx];
> > +	if (adesc->axis_id >= st->max_resources)
> 
> I think adesc->axis_id uses in this function need to be wrapped with
> le32_to_cpu() (here and below as well).
> 

...damn, my bad ... I'm posting a V2.

Thanks for the review !

Cristian

