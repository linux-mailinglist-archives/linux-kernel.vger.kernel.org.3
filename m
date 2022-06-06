Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F553E221
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiFFISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiFFISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:18:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7155663387
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:18:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0917711FB;
        Mon,  6 Jun 2022 01:18:41 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2383F66F;
        Mon,  6 Jun 2022 01:18:39 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:18:33 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH 15/22] firmware: arm_scmi: Add SCMIv3.1
 SENSOR_AXIS_NAME_GET support
Message-ID: <Yp24WY3xlQuUa59A@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-16-cristian.marussi@arm.com>
 <d523569d-2470-3e01-c407-d6e723c7d0c1@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d523569d-2470-3e01-c407-d6e723c7d0c1@opensynergy.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:25:45PM +0200, Peter Hilber wrote:
> On 30.03.22 17:05, Cristian Marussi wrote:
> > Add support for SCMIv3.1 SENSOR_AXIS_NAME_GET multi-part command using the
> > common iterator protocol helpers.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/sensors.c | 82 ++++++++++++++++++++++++++---
> >  1 file changed, 76 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index e1a94463d7d8..21e0ce89b153 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -28,6 +28,7 @@ enum scmi_sensor_protocol_cmd {
> >  	SENSOR_CONFIG_SET = 0xA,
> >  	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
> >  	SENSOR_NAME_GET = 0xC,
> > +	SENSOR_AXIS_NAME_GET = 0xD,
> >  };
> >  
> >  struct scmi_msg_resp_sensor_attributes {
> > @@ -117,13 +118,22 @@ struct scmi_msg_resp_sensor_axis_description {
> >  	struct scmi_axis_descriptor {
> >  		__le32 id;
> >  		__le32 attributes_low;
> > +#define SUPPORTS_EXTENDED_AXIS_NAMES(x)	FIELD_GET(BIT(9), (x))
> 
> Hi Cristian,
> 
> I saw this patch is probably going into v5.19 already, so I'm a bit late, but I
> wanted to point out a compatibility issue, and a small error handling issue.
> 
> Please see below.
> 

Hi Peter,

thanks for having a look, your feedback is always appreciated.

Plese see my answers inline.

> Best regards,
> 
> Peter
> 
> >  		__le32 attributes_high;
> > -		u8 name[SCMI_MAX_STR_SIZE];
> > +		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> >  		__le32 resolution;
> >  		struct scmi_msg_resp_attrs attrs;
> >  	} desc[];
> >  };
> >  
> > +struct scmi_msg_resp_sensor_axis_names_description {
> > +	__le32 num_axis_flags;
> > +	struct scmi_sensor_axis_name_descriptor {
> > +		__le32 axis_id;
> > +		u8 name[SCMI_MAX_STR_SIZE];
> > +	} desc[];
> > +};
> > +
> >  /* Base scmi_axis_descriptor size excluding extended attrs after name */
> >  #define SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ	28
> >  
> > @@ -393,7 +403,6 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
> >  	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
> >  
> >  	attrh = le32_to_cpu(adesc->attributes_high);
> > -
> >  	a->scale = S32_EXT(SENSOR_SCALE(attrh));
> >  	a->type = SENSOR_TYPE(attrh);
> >  	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
> 
> The strscpy() call should probably change the size parameter to
> SCMI_SHORT_NAME_MAX_SIZE.
> 

I disagree on this, the strscpy size param is meant to represent the max
size of the dest buffer and here the destination buffer 'a->name' is the
string buffer publicly exposed by include/linux/scmi_protocol.h:scmi_sensor_axis_info
whose size is SCMI_MAX_STR_SIZE.

> > @@ -408,15 +417,69 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
> >  		scmi_parse_range_attrs(&a->attrs, &adesc->attrs);
> >  		dsize += sizeof(adesc->attrs);
> >  	}
> > -
> >  	st->priv = ((u8 *)adesc + dsize);
> >  
> >  	return 0;
> >  }
> >  
> > +static int
> > +iter_axes_extended_name_update_state(struct scmi_iterator_state *st,
> > +				     const void *response, void *priv)
> > +{
> > +	u32 flags;
> > +	const struct scmi_msg_resp_sensor_axis_names_description *r = response;
> > +
> > +	flags = le32_to_cpu(r->num_axis_flags);
> > +	st->num_returned = NUM_AXIS_RETURNED(flags);
> > +	st->num_remaining = NUM_AXIS_REMAINING(flags);
> > +	st->priv = (void *)&r->desc[0];
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
> > +					 const void *response,
> > +					 struct scmi_iterator_state *st,
> > +					 void *priv)
> > +{
> > +	struct scmi_sensor_axis_info *a;
> > +	const struct scmi_sensor_info *s = priv;
> > +	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
> > +
> > +	a = &s->axis[st->desc_index + st->loop_idx];
> > +	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
> > +	st->priv = ++adesc;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
> > +				    struct scmi_sensor_info *s)
> > +{
> > +	void *iter;
> > +	struct scmi_msg_sensor_axis_description_get *msg;
> > +	struct scmi_iterator_ops ops = {
> > +		.prepare_message = iter_axes_desc_prepare_message,
> > +		.update_state = iter_axes_extended_name_update_state,
> > +		.process_response = iter_axes_extended_name_process_response,
> > +	};
> > +
> > +	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
> > +					    SENSOR_AXIS_NAME_GET,
> > +					    sizeof(*msg), s);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> >  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> > -					struct scmi_sensor_info *s)
> > +					struct scmi_sensor_info *s,
> > +					u32 version)
> >  {
> > +	int ret;
> >  	void *iter;
> >  	struct scmi_msg_sensor_axis_description_get *msg;
> >  	struct scmi_iterator_ops ops = {
> > @@ -436,7 +499,14 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> >  	if (IS_ERR(iter))
> >  		return PTR_ERR(iter);
> >  
> > -	return ph->hops->iter_response_run(iter);
> > +	ret = ph->hops->iter_response_run(iter);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
> > +		ret = scmi_sensor_axis_extended_names_get(ph, s);
> 
> From the SCMI v3.1 spec, I understood that the reading of the extended axis
> name should be conditional on the bit checked by SUPPORTS_EXTENDED_AXIS_NAMES()
> (the `Extended axis name' bit). Yet, the implementation doesn't use the macro,
> and instead decides whether to issue SENSOR_AXIS_NAME_GET depending on the
> (sensor management) protocol version being at least v3.0. But, per the spec, it
> would be permissible for a v3.0 protocol to not support SENSOR_AXIS_NAME_GET at
> all. Is my understanding correct?
> 

Yes, indeed this behaviour was deliberate so as to keep this code
simpler while addressing some tricky definitions in the spec.
(not so short explanation follows :P)

SENSOR_AXIS_DESCRIPTION_GET is a command that, issued against a specific
sensor, return a list of axes descriptors for that sensor and such
descriptors in turn also include the flag you're mentioning that states
if a specific ax does support an extended name or not that will have to
be fetched with SENSOR_AXIS_GET_NAME.

BUT the SENSOR_AXIS_GET_NAME command is a multi-part command issued
against a specific sensor to retrieve the list of all the axes extended
names for that sensor, NOT to retrieve a single ax extended name, so I
cannot really check each ax extended name support before issuing the
commmand and, even though weird, the axes could have different support
with some of them supporting the extended name while some other don't:
as a consequence my take about this was that the platform would reply
anyway but only with the list of axes having an extended name (possibly
a subset of all the axes).

What could be missing in this context it's the handling of the case in
which all axes does NOT support extended names where probably the platform
won't even answer my request. (unsupported even if PROTO > 3.0)

Moreover even tracking this per-ax support while iterating the replies
would have made more complex some of the logic with anyway at the same
time hitting all the limitations explained above.

In this context, it seemed to me simpler (and a good trade-off) to issue
anyway the command while checking only for the protocol version and
accepting thatSENSOR_AXIS_GET_NAME could fail because unsupported
by all the axes, with the result of leaving the ax->name string content
filled with the short name previously retrieved.

Assuming that my blabbing above is acceptable, what IS indeed wrong
(reviewig this patch) is that the any 'acceptable' failure as depicted
above is not properly ignored in fact. I'll post a fix on top like:

--->8----
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 50502c530b2f..788b566f634b 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -472,7 +472,9 @@ scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
        if (IS_ERR(iter))
                return PTR_ERR(iter);
 
-       return ph->hops->iter_response_run(iter);
+       ph->hops->iter_response_run(iter);
+
+       return 0;
 }
 
 static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
----

Moreover even the parsing logic for the SENSOR_AXIS_GET_NAME command has to
be sligthly reviewed to address the fact that the list of returned axes
extended names is incomplete so the returned axes won't necessarily be
returned in order (i.e. I'll have to check 'axis_d' in the SENSOR_AXIS_NAME_GET
replies to look up the proper ax descriptor.).
I'll post this as a distinct fix.

Does all of this make sense/seems reasonable ?

Thanks for the review again,
Cristian

