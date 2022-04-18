Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B850601F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiDRXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiDRXSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:18:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34314037
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:16:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r12-20020a056830418c00b006054e1142acso2405685otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vGtdbsSp8b8nLU4Y/i6FQSyOLmQMuRTm5ZwD7/D+i1s=;
        b=jgK3NDmxYiGiXrvwIF9JP5KaHQCBLDysQYQyI0VDu1zPG41/TDrZf2azvwl3r8ZnO4
         nc3RuE5w4R5yBC/EOgvpHOYUE9bq3dqqPe57CspsGXhuZJ0t6oDC6JjostCdHR9+VRV8
         3+Nb0wffjdbfQHiWkCAGCdg9g3UXEXwNt7f5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vGtdbsSp8b8nLU4Y/i6FQSyOLmQMuRTm5ZwD7/D+i1s=;
        b=C1WUOe4XZfg3bx6ZECgiMjyAFRRujSDZL3PhtKJt0Z/HH76vxavZPGznjRNmFzil1i
         sFzL9qElfAEYL0g1IFtxihcJxQXBSL1gzv4xzVA0k0RPKosyg3oecnagDVGpoMAmNvCQ
         f4bl+we0wuY40GrwL4BJzOgOfNEKVo43wCBC0u5dUgh/wAPAC30ayj9OvpdH7MxNjVja
         yj+K6It6gcw0/BoH+bvOcPNSGSGXxXUScZ3pYKd7uY9RlyBDyMAmrok0oVLp05gvH+Rp
         M1uR7VoMVtSkSh/+3/RQYvSJhfrZc6TO9sSTuXPDG7IUkhkAAvlHnLK1qo/kTl2gXRn4
         wPWg==
X-Gm-Message-State: AOAM533MkSrh2xDSFCbWc0In2RlVlx+L1lKyQhmatDOFPisCEuTcKvUK
        z/gfnUixJbIBp3Ly8mBNlkAgxC8tSt6lTUxoArKfEg==
X-Google-Smtp-Source: ABdhPJxsGMjYSfJVeUmnawX6RQY6qfIzj5inCYphSGrgNmplvoLLSpR/QIIy2rU3B3oFFZTNwxXUyug6TCFm36/81tU=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr4747770ota.159.1650323772740; Mon, 18
 Apr 2022 16:16:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 16:16:12 -0700
MIME-Version: 1.0
In-Reply-To: <Yl3vd4kfgwJXMs/w@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org> <20220415003253.1973106-2-swboyd@chromium.org>
 <Yl3vd4kfgwJXMs/w@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 16:16:12 -0700
Message-ID: <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-04-18 16:08:39)
> On Apr 14 17:32, Stephen Boyd wrote:
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index c4caf2e2de82..42269703ca6c 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -832,6 +832,37 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >  }
> >  EXPORT_SYMBOL_GPL(cros_ec_check_features);
> >
> > +/**
> > + * cros_ec_pchg_port_count() - Return the number of peripheral charger ports.
> > + * @ec: EC device.
> > + *
> > + * Return: Number of peripheral charger ports, or 0 in case of error.
> > + */
> > +unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec)
> > +{
> > +     struct cros_ec_command *msg;
> > +     const struct ec_response_pchg_count *rsp;
> > +     struct cros_ec_device *ec_dev = ec->ec_dev;
> > +     int ret, count = 0;
> > +
> > +     msg = kzalloc(sizeof(*msg) + sizeof(*rsp), GFP_KERNEL);
> > +     if (!msg)
> > +             return 0;
> > +
> > +     msg->command = EC_CMD_PCHG_COUNT + ec->cmd_offset;
> > +     msg->insize = sizeof(*rsp);
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> > +     if (ret >= 0) {
> > +             rsp = (const struct ec_response_pchg_count *)msg->data;
> > +             count = rsp->port_count;
> > +     }
> > +     kfree(msg);
>
> Can we use the wrapper function cros_ec_command() [1] here, which does
> the kzalloc and msg construction?
>

Sure. I take it that I can drop this function entirely then? BTW, why is
that function name the same as a struct name? It confuses my ctags.
