Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D157288F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGLVZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiGLVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:25:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E265CD3F0;
        Tue, 12 Jul 2022 14:25:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k30so11743050edk.8;
        Tue, 12 Jul 2022 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBChpcrNJ7uqMkrlYvpxSCbNo0rDEKF5+LZTTXtJt14=;
        b=Ywi86ClERDeLuKNgFXaQC9C0Am+AWfURZcVsReXCWgtWBy1GfoVl0R6WPPPTlHQErG
         jvoRgofZ0r3jKGOSWj0M8PBwVMxTkkaRoo9gXi9CDdA9GorEEpP7oqu+ssUCkREX1Ovs
         peY1IMAAGlLTZkp+oCV6xVzieZqlH9W3ODaeDlSQZn4/bx/A/Fv291MUyKaxtF+VIsMc
         K+SDlZDCHgMvG4FKXPZPY8CN2X7fsz+eS3QTTKj7DrL5OXrQ6HD0C08KH6DrA5HHQtgU
         53jzf3YbyqCBEx9/MbYCtQmxXiEr6k3msPTAUICZe6d/xtuVMXyaCKrho0FDfkPU2CAv
         DEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBChpcrNJ7uqMkrlYvpxSCbNo0rDEKF5+LZTTXtJt14=;
        b=uUWTgVAyYIFL8rDsPI0gh093U4fDn7yarH8xGf/86FB2zHJkMiruQxU4w9kbeEBDIG
         G8oi46tK940yZQrIeL1D7BAGIIWfAj3zg5EXD90pAg5HYZr1XbRC0eTFBDqJzJzwNku+
         JVo0QtLi1zKHN93Z4vfptw7ZrsUMJDUF60r6nkrzApSFGFsB1ZBeWP6K9ioJaR1tiw/H
         NJpcxCpASeflli6XAQtyCtofQYJr1GNCe1OU5Feb7mR5hX7yKa+rceWfZ13ibcPkBj+Z
         1KmlAbYr4jGdnOndBnatdLKPrC324pJj9HudE7TASze2hEU173T4IauGDYlnqXJedsA7
         r74Q==
X-Gm-Message-State: AJIora+ZeWtaSBmbaHoVSlbr1OFs/pltwtiXezkEKBXNq+ZusxRFQt7E
        TxSMIU0UznWBk8kEC3PmozU=
X-Google-Smtp-Source: AGRyM1s+hQS+QLnU/6lQQ0tzxXZ5MhaAO+TPHGDbqYL360sXVhmOZtETjA1glKjKTh/Rh8MDdn6VUQ==
X-Received: by 2002:a05:6402:4395:b0:43a:c694:907d with SMTP id o21-20020a056402439500b0043ac694907dmr161122edc.310.1657661113418;
        Tue, 12 Jul 2022 14:25:13 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0043a9144d8ecsm6650252edv.71.2022.07.12.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:25:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 5/7] media: cedrus: h265: Add a couple of error checks
Date:   Tue, 12 Jul 2022 23:25:00 +0200
Message-ID: <37675481.J2Yia2DhmK@kista>
In-Reply-To: <YsyWnzdTZ0bC733i@eze-laptop>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com> <20220620175517.648767-6-jernej.skrabec@gmail.com> <YsyWnzdTZ0bC733i@eze-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel.

Dne ponedeljek, 11. julij 2022 ob 23:31:11 CEST je Ezequiel Garcia napisal(a):
> On Mon, Jun 20, 2022 at 07:55:15PM +0200, Jernej Skrabec wrote:
> > Now that we have infrastructure for reporting errors, let's add two
> > checks, which will make sure slice can be actually decoded.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > cfde4ccf6011..99020b9f9ff8 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> 
> Now that you've allowed setup to fail, I would suggest
> to have some documentation/comments on struct cedrus_dec_ops,
> to set the expectation/rules for each ops, including the
> call paths for each operation, which of them are allowed to sleep,
> etc.

Documentation can be always added, but it should be separate patch.

> 
> > @@ -435,9 +435,17 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx,
> > struct cedrus_run *run)> 
> >  	 * instead of start of slice data. Padding is 8 bits at most (one 
bit
> >  	 set to 1 and * at most seven bits set to 0), so we have to 
inspect
> >  	 only one byte before slice data. */
> > 
> > +
> > +	if (slice_params->data_byte_offset == 0)
> > +		return -EOPNOTSUPP;
> > +
> 
> AFAICS, cedrus_h265_setup is called from .device_run.
> We've been discussing control validation before, and I think the
> ideal place to do that is v4l2_ctrl_ops.s_ctrl, if that's
> at all possible.

Yeah, this particular check can be moved to s_ctrl handler.

> 
> Driver's mem2mem device_run are executed in the context
> of a work_struct and the failure won't really get reported
> up the stack.

Well, at least there will be a notice in dmesg. Not ideal, I know.

> 
> >  	padding = (u8 *)vb2_plane_vaddr(&run->src->vb2_buf, 0) +
> >  	
> >  		slice_params->data_byte_offset - 1;
> > 
> > +	/* at least one bit must be set in that byte */
> > +	if (*padding == 0)
> > +		return -EINVAL;
> > +
> 
> Maybe this is something to check at cedrus_buf_prepare(),
> when the buffer is queued?

I don't think so. This check is HEVC specific, but cedrus_buf_prepare() is not 
and we need to have slice control ready, which I'm not sure is the case for 
cedrus_buf_prepare().

Best regards,
Jernej

> 
> Thanks,
> Ezequiel
> 
> >  	for (count = 0; count < 8; count++)
> >  	
> >  		if (*padding & (1 << count))
> >  		
> >  			break;
> > 
> > --
> > 2.36.1


