Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FA573C29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiGMRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGMRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:50:26 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3731183B;
        Wed, 13 Jul 2022 10:50:25 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 75so19249330ybf.4;
        Wed, 13 Jul 2022 10:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2ZB0zaBvuSigJ8wTixzYr0WCoqo0gk9Cx66gvFyjbU=;
        b=Ip73G7DEceugIeRWXa5iePF8m8gmVdFo9Rl/Qc8gaIlH+Ju8WtNqC0FDdMn1R2SLaa
         9scw3+semulEbWaUkGS1GZh07K1UW1itTL5pg9MBq/UOKpOYFLBqsAHgpzKnXSVxlyy3
         hV+5t4yIBUIQqIudJA/lL8azQBTKC2ygelDzBhGL7KqNvFY4jF6/bDxGhmQZ7Cxa1km6
         fyjPmRel/xfQqXWVAACC7B/ajznWslcvfqMBu2PiYPVOaebht9IkTfP8UdF08cgBxfsb
         pwQKiDQ232EgtKSbH4Xn1i12R0zhunib/bNcfRbPNGHuYlpt83+8gc16lh7vFf/2846p
         Ej/Q==
X-Gm-Message-State: AJIora9WqU88sdlsRL/MjpLZL6A78CiMsgRN0KsjJ2gXyM9H2LEtxaaB
        pXnj3QTFc2eaoUf3EG/6/4DtqDDjzJdspgd0deU=
X-Google-Smtp-Source: AGRyM1uxYFBPZfrZx33fc81mpTSb3shrL42E4bhwZF0+lp1aDapUWl+W8lD9fdnwjC0wnaBWYIAv/EM/X4mqowxjsDY=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr4629988ybn.622.1657734625055; Wed, 13
 Jul 2022 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
 <CAJZ5v0hX6H1Z-2bAJvV92YO95N_D=uNotVxJRcA9cmGQwsr1fQ@mail.gmail.com> <a4f9eefd-79fc-e9cf-88b8-efef424fb7c9@quicinc.com>
In-Reply-To: <a4f9eefd-79fc-e9cf-88b8-efef424fb7c9@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 19:50:14 +0200
Message-ID: <CAJZ5v0iK5zvyTj4F9cr8jNzpipqvYkYxZGG45u4YMFCQ_OwVTA@mail.gmail.com>
Subject: Re: [PATCH] PM: QoS: Add check to make sure CPU freq is non-negative
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:37 AM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
> Hi Rafael,
>
>
> Thanks for taking the time to review my patch and providing feedback.
>
> Please find answer inline.
>
> Thanks,
>
> Shivnandan
>
> On 7/13/2022 12:07 AM, Rafael J. Wysocki wrote:
> > On Thu, Jun 23, 2022 at 8:47 AM Shivnandan Kumar
> > <quic_kshivnan@quicinc.com> wrote:
> >>          CPU frequency should never be negative.
> > Do you mean "always be non-negative"?
> Yes,corrected subject now.
> >
> >>          If some client driver calls freq_qos_update_request with some
> >>          value greater than INT_MAX, then it will set max CPU freq at
> >>          fmax but it will add plist node with some negative priority.
> >>          plist node has priority from INT_MIN (highest) to INT_MAX
> >>          (lowest). Once priority is set as negative, another client
> >>          will not be able to reduce max CPU frequency. Adding check
> >>          to make sure CPU freq is non-negative will fix this problem.
> >> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> >>
> >> ---
> >>   kernel/power/qos.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> >> index ec7e1e85923e..41e96fe34bfd 100644
> >> --- a/kernel/power/qos.c
> >> +++ b/kernel/power/qos.c
> >> @@ -531,7 +531,8 @@ int freq_qos_add_request(struct freq_constraints *qos,
> >>   {
> >>          int ret;
> >>
> >> -       if (IS_ERR_OR_NULL(qos) || !req)
> >> +       if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE
> >> +               || value > FREQ_QOS_MAX_DEFAULT_VALUE)
> > Why do you check against the defaults?
> Want to make sure to guard against negative value.
> >
> >>                  return -EINVAL;
> >>
> >>          if (WARN(freq_qos_request_active(req),
> >> @@ -563,7 +564,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
> >>    */
> >>   int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
> >>   {
> >> -       if (!req)
> >> +       if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE ||
> >> +               new_value > FREQ_QOS_MAX_DEFAULT_VALUE)
> >>                  return -EINVAL;
> >>
> >>          if (WARN(!freq_qos_request_active(req),
> >> --
> > I agree that it should guard against adding negative values, but I
> > don't see why s32 can be greater than INT_MAX.
> yes, checking against negative values will be sufficient.
> I will share patch v2 with only check against negative values.
> >
> > Also why don't you put the guard into freq_qos_apply() instead of
> > duplicating it in the callers of that function?
> Because function  freq_qos_remove_request calls freq_qos_apply with
> PM_QOS_DEFAULT_VALUE which is actually negative.
> So I do not want to break that.

OK
