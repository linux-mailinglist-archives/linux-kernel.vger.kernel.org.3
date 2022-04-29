Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6187A514889
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358249AbiD2Lxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiD2Lxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB25595;
        Fri, 29 Apr 2022 04:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F014F62002;
        Fri, 29 Apr 2022 11:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB19C385A4;
        Fri, 29 Apr 2022 11:50:10 +0000 (UTC)
Message-ID: <6b2ff63b-7fa6-935b-002a-3ecd46273877@xs4all.nl>
Date:   Fri, 29 Apr 2022 13:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V0 1/1] media: v4l2-core: Enable reserved field of
 v4l2_event
Content-Language: en-US
To:     Naina Vaskenly <quic_nvaskenl@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        lijian <lijian@yulong.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Anshuman <quic_anshuk@quicinc.com>
References: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
 <a24b19a835430064a0677e04d746f72ae7987a3c.1651223992.git.quic_nvaskenl@quicinc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <a24b19a835430064a0677e04d746f72ae7987a3c.1651223992.git.quic_nvaskenl@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 13:45, Naina Vaskenly wrote:
> 'reserved' member of struct v4l2_event is currently not enabled.
> This field can be used to transfer data, if >64 bytes of data
> has to be sent. Hence, added this change to copy the reserved field in
> __v4l2_event_queue_fh.
> 
> Signed-off-by: Naina Vaskenly <quic_nvaskenl@quicinc.com>
> ---
>  drivers/media/v4l2-core/v4l2-event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
> index c5ce9f1..3d741cb 100644
> --- a/drivers/media/v4l2-core/v4l2-event.c
> +++ b/drivers/media/v4l2-core/v4l2-event.c
> @@ -137,8 +137,10 @@ static void __v4l2_event_queue_fh(struct v4l2_fh *fh,
>  	/* Take one and fill it. */
>  	kev = sev->events + sev_pos(sev, sev->in_use);
>  	kev->event.type = ev->type;
> -	if (copy_payload)
> +	if (copy_payload) {
>  		kev->event.u = ev->u;
> +		memcpy(kev->event.reserved, ev->reserved, sizeof(ev->reserved));
> +	}
>  	kev->event.id = ev->id;
>  	kev->ts = ts;
>  	kev->event.sequence = fh->sequence;

What's the point of this? It's a reserved field, it must be 0. If you want to use
it for something else, then make a proposal to repurpose some of the reserved
fields.

This looks like you are trying to copy reserved data for some driver-specific hack.

That's not going to be accepted.

For the record:

Nacked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans
