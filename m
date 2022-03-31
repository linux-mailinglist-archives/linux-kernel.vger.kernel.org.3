Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D84ED43B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCaG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiCaG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:56:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA7D46670;
        Wed, 30 Mar 2022 23:54:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:6fe0:6d70:c72d:f4de:8728])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CFA811F4610C;
        Thu, 31 Mar 2022 07:54:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648709687;
        bh=xD4boKK9gVCQQWY5steTwuNN1dn/iTguW59Me1H/zwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cn3JpCKuj+8546mjWEIrfVd7/YQqR0Vd1pJjrn134l/UQlsjXZ8DiTFIpIJfaBaiL
         h6MB7Wip/x3ag0BzF5kt1mLmzdGL3kckM/Xk9hfGlI84tn9RCLLyv2aEmcTLqDniFK
         Q7RMQs9kBl6BO1LTRFwdAM66kQGLA5YnKSQwc2AzLv/g0PASfD6EaOGEhXns+T7+Pb
         a118lcY0QiiVx6N+Pj/0YOLTN778obnMoZ+b6L0x1jYVcERv3Ri7hEJIoUH8j0F4to
         qB188rHkYyEG08GdlYLcUKxwhmpCwpwUsbTUcLR4wldgapFhUJYNN+kc4NDEy9DSb9
         RueZw6vAOVdjQ==
Date:   Thu, 31 Mar 2022 08:54:43 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 22/24] media: hantro: h264: Make dpb entry management
 more robust
Message-ID: <20220331065443.ek4p4wqhoaulml2j@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-23-nicolas.dufresne@collabora.com>
 <20220330075913.wfl3prsyw5fvsv4t@basti-XPS-13-9310>
 <4740735d92c0dac3708aa922b3d73db7a61fbdda.camel@collabora.com>
 <CAAEAJfCH+m7mzU2EHkyxdKiNs7p=qfSfnvDzS+hLOftFE=n9CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEAJfCH+m7mzU2EHkyxdKiNs7p=qfSfnvDzS+hLOftFE=n9CA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas & Ezequiel,

On 30.03.2022 20:43, Ezequiel Garcia wrote:
>On Wed, Mar 30, 2022 at 12:16 PM Nicolas Dufresne
><nicolas.dufresne@collabora.com> wrote:
>>
>> Le mercredi 30 mars 2022 à 09:59 +0200, Sebastian Fricke a écrit :
>> > Hey Nicolas,
>> >
>> > On 28.03.2022 15:59, Nicolas Dufresne wrote:
>> > > From: Jonas Karlman <jonas@kwiboo.se>
>> > >
>> > > The driver maintains stable slot location for reference pictures. This
>> >
>> > s/slot location/slot locations/
>> >
>> > > change makes the code more robust by using the reference_ts as key and
>> > > by marking all entries invalid right from the start.
>> > >
>> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> > > ---
>> > > drivers/staging/media/hantro/hantro_h264.c | 10 ++++------
>> > > 1 file changed, 4 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
>> > > index 228629fb3cdf..7377fc26f780 100644
>> > > --- a/drivers/staging/media/hantro/hantro_h264.c
>> > > +++ b/drivers/staging/media/hantro/hantro_h264.c
>> > > @@ -258,8 +258,7 @@ static void prepare_table(struct hantro_ctx *ctx)
>> > > static bool dpb_entry_match(const struct v4l2_h264_dpb_entry *a,
>> > >                         const struct v4l2_h264_dpb_entry *b)
>> > > {
>> > > -   return a->top_field_order_cnt == b->top_field_order_cnt &&
>> > > -          a->bottom_field_order_cnt == b->bottom_field_order_cnt;
>> > > +   return a->reference_ts == b->reference_ts;
>> > > }
>> > >
>> > > static void update_dpb(struct hantro_ctx *ctx)
>> > > @@ -273,13 +272,13 @@ static void update_dpb(struct hantro_ctx *ctx)
>> > >
>> > >     /* Disable all entries by default. */
>> > >     for (i = 0; i < ARRAY_SIZE(ctx->h264_dec.dpb); i++)
>> > > -           ctx->h264_dec.dpb[i].flags &= ~V4L2_H264_DPB_ENTRY_FLAG_ACTIVE;
>> > > +           ctx->h264_dec.dpb[i].flags = 0;
>> >
>> > Ehm ... we just remove all flags? Can't this have any unwanted side
>> > effects like removing a flag that we actually wanted to keep?
>> > (Like long term or the field flags?)
>>
>> This is a local copy of the dpb, the DPB is fully passed for every decode. So
>> these flags will be fully restored lower when we copy the found entry. In fact,
>> holding a state here would not represent well the userland intention and can
>> have negative side effect on the decoding. Flags are not immutable between
>> decode and can change. This simplify the code, and make things less error prone.
>> This part of the code is already a bit complex, no need for an extra layer.
>>
>> > If we just want to set the DPB entry inactive, then removing the ACTIVE
>> > flag seems like the correct approach to me.
>> > If we want to get rid of the VALID flag as well, then we could just do:
>> >               ctx->h264_dec.dpb[i].flags &=
>> >        ~(V4L2_H264_DPB_ENTRY_FLAG_ACTIVE | V4L2_H264_DPB_ENTRY_FLAG_VALID);
>> >
>> > In case we really want to reset all flags, I'd say adjust the comment
>> > above it:
>> > ```
>> > -     /* Disable all entries by default. */
>> > +     /* Reset the flags for all entries by default. */
>> > ```
>>
>> This reads the same to me, but I can do that yes. understand that VALID means
>> the reference exist and the TS should point to some existing past reference
>> (unless there was some decode error, which the userland may not be aware yet as
>> this is asynchronous). While ACTIVE means that it is used as a reference. FFMPEG
>> is known not to filter inactive references. ACTIVE is just a flag without bunch
>> of other flags that can change for every decode. So none of this make sense
>> between 2 decodes.
>>
>
>Please leave the comment as-is, 'Disable all entries' is readable.
>
>As much as I'd love to have very clear comments everywhere,
>we have to accept that only people with insight on codec details
>are expected to make sense of driver details :-)

Fair enough, I just feel like the code should try his best to have as
few hidden details as possible. And in this case our intention is to
disable the entries (removing the active and valid flag) but what we do
is that we remove all flags.

The hidden details at this point are:
- flags will be restored automatically later on and we do not want to
hold the state here
- flags are not immutable between decodes
- this was a decision by the programmer to simplify the code and not a rule in the specification.

All of these things are not obvious from the code (from my POV) and
there are no pointers to the specification, which means the reader is
seemingly expected to know the specification on an expert level. I think
really understanding the H264 specification is hard enough on its own.
And as we do that change right now, I think we might as well take some
time to document as much hidden details as possible and I really think
that it will not lower the code quality when we add another 20-40 lines
of comments.

I might be wrong (as I still learn about H264) but I would love if we
can write code (especially open-source code) in a manner that enables
others to learn quickly.

>
>Thanks,
>Ezequiel

Greetings,
Sebastian
