Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF494BD75C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbiBUHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:40:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346381AbiBUHkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:40:08 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7891084;
        Sun, 20 Feb 2022 23:39:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id x3so29956792qvd.8;
        Sun, 20 Feb 2022 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEjwhsOZ6DB3YYZ5JWT5098HH78A0hwKkpXkrefxq0o=;
        b=huEeus9tNqW74TMC/Ls5wM6iHGbX/Xe/UPyF8E1Gbflrifgfo52/H4upyh2gs4CXpI
         XiPu7cxkY9+UMZtau7IB+nX8Yk3FHX0CIvs/Mg543zLTHT7ANhZPPWYolBtVQgSatWFv
         i1r7fU/+g9tbevS1bUCBFXVZedHDnrlbLDwkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEjwhsOZ6DB3YYZ5JWT5098HH78A0hwKkpXkrefxq0o=;
        b=ddrQ/7dtHOWPd1KLDe2DPmzPf/nrimT9ipURd9FxmGXfMANLoX0ALXbrdzUY0uI9y2
         MOwoNTW2vh9tiF6yV40secW694WYZhe7GemIJr9KPNOWeHJP0VhGrG1Jcsp0C/pNxPd9
         cXTPmTaNqu2tWBtengNjkP+Yl62enc/tBu8HbutcEk2n7ocdRQh3I4WwV2UfGes/RlgI
         aqRlWayMLXVYZxilUvo7VLUa2E/VtFqkY05/iGAKVB9xuf79ESHOCqM2Hqwv05R3Dc52
         kWBIzuKds2A/jvZ1nSqKuGQIhOfHKY2FWF91HAWiWDu6APA8SuUOpJrJkQchW932w6zu
         S44g==
X-Gm-Message-State: AOAM5329LeYXUC3fsiuJYc/3sdaETf/OJZbKRNb7Cp23xqwnz8OtNI2G
        aW9cWZs76bZLnPxcOCCVqAl5C/6SJVk0rFlaFYwD3/mH
X-Google-Smtp-Source: ABdhPJxXV5By+0DbrqkBY9Td/eHJYYDuy0aNGv1zFd/VlPw6iQPAzHq1hbFAA3pGBeaCtehWTcHT4nbqwXfI1oXXbRc=
X-Received: by 2002:ad4:456e:0:b0:42c:b084:147f with SMTP id
 o14-20020ad4456e000000b0042cb084147fmr14540604qvu.49.1645429185031; Sun, 20
 Feb 2022 23:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20220215151022.7498-1-eajames@linux.ibm.com> <20220215151022.7498-5-eajames@linux.ibm.com>
 <CACPK8Xe+M97Covu0+Qc9M-8vdCc9pTXfZjJ9y6_Xm-j1E4GUPQ@mail.gmail.com> <19ac1b85-842f-dfcf-93db-489ab6598ff8@linux.ibm.com>
In-Reply-To: <19ac1b85-842f-dfcf-93db-489ab6598ff8@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 07:39:33 +0000
Message-ID: <CACPK8XeNCgkXdds-y1OUAUoioDOYRbATyxHXzVe0iNfDP+DPcg@mail.gmail.com>
Subject: Re: [PATCH 4/4] hwmon: (occ) Add soft minimum power cap attribute
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 20:09, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 2/16/22 00:33, Joel Stanley wrote:
> > On Tue, 15 Feb 2022 at 15:11, Eddie James <eajames@linux.ibm.com> wrote:
> >> Export the power caps data for the soft minimum power cap through hwmon.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/hwmon/occ/common.c | 19 ++++++++++++++++---
> >>   1 file changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> >> index 0cb4a0a6cbc1..f00cd59f1d19 100644
> >> --- a/drivers/hwmon/occ/common.c
> >> +++ b/drivers/hwmon/occ/common.c
> >> @@ -674,6 +674,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
> >>          case 7:
> >>                  val = caps->user_source;
> >>                  break;
> >> +       case 8:
> >> +               val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
> >> +               break;
> >>          default:
> >>                  return -EINVAL;
> >>          }
> >> @@ -835,12 +838,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
> >>          case 1:
> >>                  num_attrs += (sensors->caps.num_sensors * 7);
> >>                  break;
> >> -       case 3:
> >> -               show_caps = occ_show_caps_3;
> >> -               fallthrough;
> >>          case 2:
> >>                  num_attrs += (sensors->caps.num_sensors * 8);
> >>                  break;
> >> +       case 3:
> >> +               show_caps = occ_show_caps_3;
> >> +               num_attrs += (sensors->caps.num_sensors * 9);
> > How do we know this changed from 8 to 9?
>
>
> Well we made the structure change a while back when adding P10 support,
> but didn't bother to export the "soft min" field. Now it's needed.
>
>
> >
> > We should start adding links to the occ source code, or a similar
> > reference, when making these changes so they can be reviewed.
>
>
> I would but it doesn't appear to be public for P10 yet... at least, no
> one has updated the P9 OCC spec hosted in the open-power repo:
> https://github.com/open-power/docs

Ok. Lets follow that up internally. For this patch:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
