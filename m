Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247DF55CC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiF0Krg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiF0Krf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:47:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B97642B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:47:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u9so12210796oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmZKb1z18EDVwc67jEwsvqQ2o+cNJLYi4tj3i//9p34=;
        b=GHPKRSKrUAHBUwVDZE3XUgMpB/fT11Y1/6i9ub8wLkh7bteMlcs2VuSKn7E3ub+zad
         /N+i0Ro5cItgL8qQuegPDkAuzDbeoYeP09clLXn9rT5WZQnSGhgujfMGcYoaniIBKTua
         alv415OSebEWYA/d+ZtMCoQTiS8f4c6iYHQgySNFkjE5IrZ73AolYW/g7OCzas2WwDW8
         k9MtlRZn2MLllCNX71SeBB38vPzlY12FuhCFrfyDK4TVnYZoV/NEEzd0XrOxIlObkMah
         4/pyJ/t1NryP0XH2nhcuFsL+5lxk/hB5rfZvjju1vpHd1axAx9Td0mMJRQTpQirY09PP
         7gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmZKb1z18EDVwc67jEwsvqQ2o+cNJLYi4tj3i//9p34=;
        b=zsj795bGmh1dozhoWCtk97KAz2VMNLr89Sk8pwUodcFVbYaLOLD9dwifhCZ8eEYWcH
         3l7ldXTYSxSUFync8OpVuaOXPHg2qaz3v0jYLLY3uDfe/drYmvKCUcueibLY59syHM33
         mg/P5yc7KrxSFazLXZN1KOX5CeAF2lUnoaLlt4yZeubaJjMq5zX/g08AiKPq8vbLI0l4
         kjQAgC9U1GsECZnwpJOyrsEtWhqgDFFRJhMF3uIcEmaWYjboMZV5vvwffe4POTBnvgRR
         40Zy32Ym2NKHhZ8yLZfwafxKajkvGUbWjnf8ACTDT3VEBXgnl9mm8t8V343hXxZ0WrT1
         8M8g==
X-Gm-Message-State: AJIora+j4eA12JgiWvZUkWSRFgnwJPKKDUyZR2bfwH4hOJfIKedP9u9U
        B8bMfBaycYxO1Q4k5+haNU0HUhZjC+E1xvjUuYxOnQ==
X-Google-Smtp-Source: AGRyM1tZY52KkyYiJLHfNgYn+Ap7cZZWiTpq03zyjLMuN3cwjCqQKIaqOzOSH5cLn23NDCmR5KfEeCsgnonH/c7xVZQ=
X-Received: by 2002:a05:6808:ed0:b0:331:4811:737f with SMTP id
 q16-20020a0568080ed000b003314811737fmr7451560oiv.104.1656326853588; Mon, 27
 Jun 2022 03:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220624074549.3298-1-vincent.guittot@linaro.org> <YrWCctNSyKcqSHE9@e120937-lin>
In-Reply-To: <YrWCctNSyKcqSHE9@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 27 Jun 2022 12:47:22 +0200
Message-ID: <CAN5uoS_v+WBRJjNkOnDDjtavQAnyPVMHEOrYx6GPo0HJ8a2Z_w@mail.gmail.com>
Subject: Re: [PATCH] scmi/optee: fix response size warning
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

On Fri, 24 Jun 2022 at 11:23, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Fri, Jun 24, 2022 at 09:45:49AM +0200, Vincent Guittot wrote:
> > Some protocols check the response size with the expected value but optee
> > shared memory doesn't return such size whereas it is available in the
> > optee output buffer.
> >
> > As an example, the base protocol compares the response size with the
> > expected result when requesting the list of protocol which triggers a
> > warning with optee shared memory:
> >
> > [    1.260306] arm-scmi firmware:scmi0: Malformed reply - real_sz:116  calc_sz:4  (loop_num_ret:4)
> >
> > Save the output buffer length and use it when fetching the answer.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Hi Vincent,
>
> > ---
> >
> > Tested on sudeep's for-next/scmi branch
> >
> >  drivers/firmware/arm_scmi/optee.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > index b503c22cfd32..8abace56b958 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -117,6 +117,7 @@ struct scmi_optee_channel {
> >       u32 channel_id;
> >       u32 tee_session;
> >       u32 caps;
> > +     u32 rx_len;
> >       struct mutex mu;
> >       struct scmi_chan_info *cinfo;
> >       union {
> > @@ -302,6 +303,9 @@ static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t
> >               return -EIO;
> >       }
> >
> > +     /* Save response size */
> > +     channel->rx_len = param[2].u.memref.size;
> > +
> >       return 0;
> >  }
> >
> > @@ -353,6 +357,7 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
> >       shbuf = tee_shm_get_va(channel->tee_shm, 0);
> >       memset(shbuf, 0, msg_size);
> >       channel->req.msg = shbuf;
> > +     channel->rx_len = msg_size;
> >
> >       return 0;
> >  }
> > @@ -508,7 +513,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
> >       struct scmi_optee_channel *channel = cinfo->transport_info;
> >
> >       if (channel->tee_shm)
> > -             msg_fetch_response(channel->req.msg, SCMI_OPTEE_MAX_MSG_SIZE, xfer);
> > +             msg_fetch_response(channel->req.msg, channel->rx_len, xfer);
> >       else
> >               shmem_fetch_response(channel->req.shmem, xfer);
> >  }

Thanks for the fix.
Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>


>
> Looks good to me.
>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>
> Thanks,
> Cristian
>
