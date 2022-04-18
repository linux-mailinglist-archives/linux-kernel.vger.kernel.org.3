Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0B506031
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiDRXYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiDRXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:24:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9525EB6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:21:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx5so14233869pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wj9ktjp8539IBcyT0vIYeLD+G78WHjtfzUpEOICZKzM=;
        b=dffHjgxqGjuBcBO3tjLfh+jbi/wrxy4PJEkFZyRUNauUWHiW4oCvPHwvZYjl5cDvqb
         M60Qp7Zrk834tyQAN8D4tDhmCpEH/bIQSIpflT0jPvP4SHHpkUgnVZo8NNsD5XZjeigY
         huIWvCJI4M2w4cfIWpJT7Zb7BA2h4XtJuVXwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wj9ktjp8539IBcyT0vIYeLD+G78WHjtfzUpEOICZKzM=;
        b=TLHjsp1hI24+4jCHOd3MRaNSimKfYyrOq/FicKpLyY0CJhi5AXQA/UAkj3lGFmU/1V
         hquIGA6XS0aOuGkWalMxz1O/wDWsRGbJeKek3DTCQMNTK74gSSUdYShf2UrpMDVz0Nsg
         3CRixLlJbgEEp3pQ+04AbHS0+sL/ZIoJjfZ8ouy9MSGsQ5V7u+1K4UH1TXNiqKu867VQ
         z/97jhLCllb/bNRHh3AGNgK9BWqqxJCNw5eHrAOAdAvP17EB7Aw6xx2zVGFvLijqQoo2
         tdQN/BTj8u1y5Fen0ecm3VE5iJySmL4g9CekVXQIJb2bjP2vjZYliaVqzHQ0/x+k7EHT
         p+gw==
X-Gm-Message-State: AOAM531NRFE//rnVZvCWw7FjFRQ5khRN3S2KB3mW/kRUQ5JiA41K29L0
        4sW/AGWIkcJNNe5v4exUlKcFRQ==
X-Google-Smtp-Source: ABdhPJzaZrHgZTRHQG9sU6PlJdSAjTGDIdi3eePNzKrdaL7pcgeYSIq0gxEeiiBpn09uDMbASCKt5Q==
X-Received: by 2002:a17:903:110c:b0:14a:f110:84e1 with SMTP id n12-20020a170903110c00b0014af11084e1mr13111551plh.7.1650324113692;
        Mon, 18 Apr 2022 16:21:53 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b005061dd378a1sm13457579pfi.35.2022.04.18.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:21:53 -0700 (PDT)
Date:   Mon, 18 Apr 2022 23:21:52 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
Message-ID: <Yl3ykMvfCaQlQ7t9@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-2-swboyd@chromium.org>
 <Yl3vd4kfgwJXMs/w@chromium.org>
 <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18 16:16, Stephen Boyd wrote:
> Quoting Prashant Malani (2022-04-18 16:08:39)
> > On Apr 14 17:32, Stephen Boyd wrote:
> > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > index c4caf2e2de82..42269703ca6c 100644
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -832,6 +832,37 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> > >  }
> > >  EXPORT_SYMBOL_GPL(cros_ec_check_features);
> > >
> > > +/**
> > > + * cros_ec_pchg_port_count() - Return the number of peripheral charger ports.
> > > + * @ec: EC device.
> > > + *
> > > + * Return: Number of peripheral charger ports, or 0 in case of error.
> > > + */
> > > +unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec)
> > > +{
> > > +     struct cros_ec_command *msg;
> > > +     const struct ec_response_pchg_count *rsp;
> > > +     struct cros_ec_device *ec_dev = ec->ec_dev;
> > > +     int ret, count = 0;
> > > +
> > > +     msg = kzalloc(sizeof(*msg) + sizeof(*rsp), GFP_KERNEL);
> > > +     if (!msg)
> > > +             return 0;
> > > +
> > > +     msg->command = EC_CMD_PCHG_COUNT + ec->cmd_offset;
> > > +     msg->insize = sizeof(*rsp);
> > > +
> > > +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> > > +     if (ret >= 0) {
> > > +             rsp = (const struct ec_response_pchg_count *)msg->data;
> > > +             count = rsp->port_count;
> > > +     }
> > > +     kfree(msg);
> >
> > Can we use the wrapper function cros_ec_command() [1] here, which does
> > the kzalloc and msg construction?
> >
> 
> Sure. I take it that I can drop this function entirely then?

Yeah, if it's a simple response, should be fine.

> BTW, why is
> that function name the same as a struct name? It confuses my ctags.

Yeahhh, didn't think about ctags... :/
Topic for another series: probably can be renamed to cros_ec_cmd() (just to keep ctags happy) ?

Best regards,

-Prashant
