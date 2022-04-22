Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965E750BA94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448966AbiDVOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiDVOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:53:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2F5675A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:50:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t15so9303581oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGaPIh5SoFzYklaagzQlcJki7oGMS2UI6o+kkUtFny0=;
        b=d3rf+sztCIbv6v0MPOCAFIQHSbhtPuylG1ty60MjzuHPWL3Q5J6hdAbaocHHgSgpeX
         FWTOUbAFtzZs7RKtiUIKKhOR78djDJCLNsqH1y3kJ/TazkmBXaJxv+z0muhXpugCfjyW
         rcEy2xPfafx8bgu95OBiNiuqnpYCb1WSHR93MJnhwN2z5B5+2n74qG2C6DxfFcnT3osx
         YFJE9zLwCFaNqwNsFWkSBtR33NhiifCpWiU1esccbXksvbmy8hds2ppvFVO9Q+5yoWPT
         ai9UgVkhBEYlNC1Hqpex5asq6JECoP8wpGT/rEzcOaSD3sJ8j+GDTeU8fPl3KSikPexl
         1xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGaPIh5SoFzYklaagzQlcJki7oGMS2UI6o+kkUtFny0=;
        b=F3a182kxGTKjFaHSWMjk2IZTwcK/Bh8zekrWlUxym9hkMfwHsbAQyTbK0ncAetdtBc
         01uU6UK0zgHDwd7JlJIcxa8XaGnTbGQQW6+S4m9KhacOi+24C84m8DG4kb5GtdNDhYO+
         +YkX/KVOJVzjlRYr15ZZnefk4Gu5QuMK9R/zb0HadoZ7tiiCuyygPSZwHFKX6bj5myzl
         J3XlMXRf9rl7hwX6oPFVDfur1omCd0FppE7QlO6dkQsnU5H6rkDt2QUl+HIPYPSRrVVo
         nCmvBZl8w2LVWlOylZJhJ5nHxP8tzOLgp5ZQ6lI8kj/blNY+ApKn7X76BKzkRD9zVivr
         3Qog==
X-Gm-Message-State: AOAM531PYNkvy1XBx+Sa+9xMDyLZkrwbsxN+GFAzm9rXVyUZ3b382zB1
        LrFswNH0Rlo6dvKBRi7zwFKytU3ALhRbr4iMcv1eVg==
X-Google-Smtp-Source: ABdhPJzJ8r4MR4LzyD8NYZo/A08ev23krsJl8GsgZXYP/MIkEj1VUKf2DlUR7GsoQ2JKDAbUX5teiIQeiBQwJxf2v50=
X-Received: by 2002:a05:6808:1886:b0:322:f55c:133d with SMTP id
 bi6-20020a056808188600b00322f55c133dmr2388233oib.217.1650639034006; Fri, 22
 Apr 2022 07:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074935.7549-1-etienne.carriere@linaro.org>
 <YmKmFxailmd5AeqF@e120937-lin> <CAN5uoS-kq-UCuPxdrphKd3sMOEQYD7FGMrB-Xo5erXWsxibhxQ@mail.gmail.com>
In-Reply-To: <CAN5uoS-kq-UCuPxdrphKd3sMOEQYD7FGMrB-Xo5erXWsxibhxQ@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 22 Apr 2022 16:50:23 +0200
Message-ID: <CAN5uoS9z4Bo9EXBad70_M6HbrHHXMwMH1X9etpKdK_AS0hF0GQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: support optee shared memory in
 optee transport
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 16:49, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hello Cristian,
>
> On Fri, 22 Apr 2022 at 14:57, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 09:49:35AM +0200, Etienne Carriere wrote:
> > > Adds support for tee shared memory in optee scmi transport. When using
> > > tee shared memory, scmi optee transport manages SCMI messages using
> > > msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
> > > protocol is used with static IOMEM shared buffers.
> > >
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > >
> >
> > Hi Etienne,
> >
> > the bot complaints on linking failure are due to a missing dependency:
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index 7794bd41eaa0..1e7b7fec97d9 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -59,6 +59,7 @@ config ARM_SCMI_TRANSPORT_OPTEE
> >         depends on OPTEE=y || OPTEE=ARM_SCMI_PROTOCOL
> >         select ARM_SCMI_HAVE_TRANSPORT
> >         select ARM_SCMI_HAVE_SHMEM
> > +       select ARM_SCMI_HAVE_MSG
> >         default y
> >         help
> >           This enables the OP-TEE service based transport for SCMI.
> >
> > needed when you compile without any other transport using MSGs.
>
> Thanks! I could not find why the bot failed to build this. I was
> focused on looking at the wrong place.
>
> >
> > One remark down below.
> >
> > >  drivers/firmware/arm_scmi/optee.c | 128 ++++++++++++++++++++++++------
> > >  1 file changed, 104 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > > index 8302a2b4aeeb..6676b17d2587 100644
> > > --- a/drivers/firmware/arm_scmi/optee.c
> > > +++ b/drivers/firmware/arm_scmi/optee.c
> > > @@ -64,6 +64,22 @@ enum scmi_optee_pta_cmd {
> > >        * [in]     value[0].b: Requested capabilities mask (enum pta_scmi_caps)
> > >        */
> > >       PTA_SCMI_CMD_GET_CHANNEL = 3,
> > > +
> > > +     /*
> > > +      * PTA_SCMI_CMD_PROCESS_MSG_CHANNEL - Process SCMI message in a MSG
> > > +      * buffer pointed by memref parameters
> > > +      *
> > > +      * [in]     value[0].a: Channel handle
> > > +      * [in]     memref[1]: Message buffer (MSG and SCMI payload)
> > > +      * [out]    memref[2]: Response buffer (MSG and SCMI payload)
> > > +      *
> > > +      * Shared memories used for SCMI message/response are MSG buffers
> > > +      * referenced by param[1] and param[2]. MSG transport protocol
> > > +      * uses a 32bit header to carry SCMI meta-data (protocol ID and
> > > +      * protocol message ID) followed by the effective SCMI message
> > > +      * payload.
> > > +      */
> > > +     PTA_SCMI_CMD_PROCESS_MSG_CHANNEL = 4,
> > >  };
> > >
> > >  /*
> > > @@ -72,9 +88,17 @@ enum scmi_optee_pta_cmd {
> > >   * PTA_SCMI_CAPS_SMT_HEADER
> > >   * When set, OP-TEE supports command using SMT header protocol (SCMI shmem) in
> > >   * shared memory buffers to carry SCMI protocol synchronisation information.
> > > + *
> > > + * PTA_SCMI_CAPS_MSG_HEADER
> > > + * When set, OP-TEE supports command using MSG header protocol in an OP-TEE
> > > + * shared memory to carry SCMI protocol synchronisation information and SCMI
> > > + * message payload.
> > >   */
> > >  #define PTA_SCMI_CAPS_NONE           0
> > >  #define PTA_SCMI_CAPS_SMT_HEADER     BIT(0)
> > > +#define PTA_SCMI_CAPS_MSG_HEADER     BIT(1)
> > > +#define PTA_SCMI_CAPS_MASK           (PTA_SCMI_CAPS_SMT_HEADER | \
> > > +                                      PTA_SCMI_CAPS_MSG_HEADER)
> > >
> > >  /**
> > >   * struct scmi_optee_channel - Description of an OP-TEE SCMI channel
> > > @@ -85,7 +109,8 @@ enum scmi_optee_pta_cmd {
> > >   * @mu: Mutex protection on channel access
> > >   * @cinfo: SCMI channel information
> > >   * @shmem: Virtual base address of the shared memory
> > > - * @tee_shm: Reference to TEE shared memory or NULL if using static shmem
> > > + * @req: Shared memory protocol handle for SCMI request and synchronous response
> > > + * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
> > >   * @link: Reference in agent's channel list
> > >   */
> > >  struct scmi_optee_channel {
> > > @@ -94,7 +119,10 @@ struct scmi_optee_channel {
> > >       u32 caps;
> > >       struct mutex mu;
> > >       struct scmi_chan_info *cinfo;
> > > -     struct scmi_shared_mem __iomem *shmem;
> > > +     union {
> > > +             struct scmi_shared_mem __iomem *shmem;
> > > +             struct scmi_msg_payld *msg;
> > > +     } req;
> > >       struct tee_shm *tee_shm;
> > >       struct list_head link;
> > >  };
> > > @@ -178,8 +206,8 @@ static int get_capabilities(struct scmi_optee_agent *agent)
> > >
> > >       caps = param[0].u.value.a;
> > >
> > > -     if (!(caps & PTA_SCMI_CAPS_SMT_HEADER)) {
> > > -             dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
> > > +     if (!(caps & (PTA_SCMI_CAPS_SMT_HEADER | PTA_SCMI_CAPS_MSG_HEADER))) {
> > > +             dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT and MSG\n");
> > >               return -EOPNOTSUPP;
> > >       }
> > >
> > > @@ -193,9 +221,14 @@ static int get_channel(struct scmi_optee_channel *channel)
> > >       struct device *dev = scmi_optee_private->dev;
> > >       struct tee_ioctl_invoke_arg arg = { };
> > >       struct tee_param param[1] = { };
> > > -     unsigned int caps = PTA_SCMI_CAPS_SMT_HEADER;
> > > +     unsigned int caps = 0;
> > >       int ret;
> > >
> > > +     if (channel->tee_shm)
> > > +             caps = PTA_SCMI_CAPS_MSG_HEADER;
> > > +     else
> > > +             caps = PTA_SCMI_CAPS_SMT_HEADER;
> > > +
> > >       arg.func = PTA_SCMI_CMD_GET_CHANNEL;
> > >       arg.session = channel->tee_session;
> > >       arg.num_params = 1;
> > > @@ -249,6 +282,37 @@ static int invoke_process_smt_channel(struct scmi_optee_channel *channel)
> > >       return 0;
> > >  }
> > >
> >
> > Looking at the invoke_process_smt_channel() code, I see that it still refers to
> > ->tee_shm in an if condition when you send a PTA_SCMI_CMD_PROCESS_SMT_CHANNEL_MESSAGE
> > but that channel->tee_shm is always NULL when calling invoke_process_smt_channel()
> > since tee_shm is only allocated by non-SMT transport via setup_dynamic_shmem(),
> > so when this if-branch inside invoke_process_smt_channel() is supposed
> > to be used ? or is it a leftover ? (or I am missing something :D)
>
> I caught it right, definitely a leftover. Thanks. I'll clean that.

Typo,
**You** caught it right :)>

br,
etienne

>
> Br,
> Etienne
>
> >
> >
> > > +static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t msg_size)
> > > +{
> > > +     struct tee_ioctl_invoke_arg arg = {
> > > +             .func = PTA_SCMI_CMD_PROCESS_MSG_CHANNEL,
> > > +             .session = channel->tee_session,
> > > +             .num_params = 3,
> > > +     };
> > > +     struct tee_param param[3] = { };
> > > +     int ret;
> > > +
> > > +     param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > > +     param[0].u.value.a = channel->channel_id;
> > > +
> > > +     param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > +     param[1].u.memref.shm = channel->tee_shm;
> > > +     param[1].u.memref.size = msg_size;
> > > +
> > > +     param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > +     param[2].u.memref.shm = channel->tee_shm;
> > > +     param[2].u.memref.size = SCMI_OPTEE_MAX_MSG_SIZE;
> > > +
> > > +     ret = tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg, param);
> > > +     if (ret < 0 || arg.ret) {
> > > +             dev_err(scmi_optee_private->dev, "Can't invoke channel %u: %d / %#x\n",
> > > +                     channel->channel_id, ret, arg.ret);
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > Thanks,
> > Cristian
> >
