Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6059C3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiHVQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiHVQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:22:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6893FA0F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:21:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32a09b909f6so308610827b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=haN84sN1RdcncSckg2dQ3RgLJ/cE7ZR6YcXEJeAkpTY=;
        b=pmOOuJBsRUQLDSHE3FVE+d6VG4klW7oHGh5f55Rshh3xjecHv8PQn1xVg21EmgGrym
         DTcvROUy/A2WBHZ84eFf5NsoBwY/ThYaASqz96yvYKu0r/hx40ax0GBxZjkMxdGVT+jG
         D+4pDYeMUixalJTINcUi1dVEMBqOAnLMSNqFOl0AI5XzRLb6fSGYZ09BwJqSz87vAcGG
         zFR+Z+a1u86zJCBUmrGmo6U8AynjTMFI7vmHQRTHILX4Y68VnjIR6Mohyry+Jf1z1sC4
         ZWFkkF2/eswgNK5riySwm7ky5wkJsEdkzQnpw5RRFB1vxUHgECt8Yho3VeJfDrJpe37h
         G/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=haN84sN1RdcncSckg2dQ3RgLJ/cE7ZR6YcXEJeAkpTY=;
        b=fkU/PB9pFbzF36RdwaTh3Qwexg8mxY5Jpa0oCpbvMRrA2/Vyt3iVBl9FGq80Wy4hND
         DQT/3hirYx2ej0K1A6PF4x3tBgQH4fNChdGL0pRdqiE9j/b55283t9oPi6py1WuD48Y8
         fXXLfRB8Cp9jjcys9AAIJMPRcYvlRt/nTyDsmEgbt4jui0bPuAYZzY8R4EJDuSh13buU
         4j7iBMYBEQCdbNCwryJb2UrlLIf7MTw9gYN1ygfYXeqjpbd5ivGJqtfLfWa2pwssAxQu
         WFz36I2YiDaa5hwuIdosbTxEPWpNXCSFruqfDsg0OLGZkpNXgCrAjb6pyOkSusZgrDO2
         UikA==
X-Gm-Message-State: ACgBeo0T6yEN8IGPjQaqR2vrQ1ZgzO1sPYDoo637wrTgdPoKTZaoVVlq
        GzD0cSGctfbHelZgkKKlrRjKNFoyE65jziVd2BMNiw==
X-Google-Smtp-Source: AA6agR59lzOnwIvjU57G5SX6HnX2FwDAfM3O5C43yyHEv+JuVUaLrFyxiAxwa2tdFmdzRLuZw16zKecgK+rlAjMdM8U=
X-Received: by 2002:a25:3b51:0:b0:695:2474:3996 with SMTP id
 i78-20020a253b51000000b0069524743996mr15473174yba.110.1661185318357; Mon, 22
 Aug 2022 09:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
 <Yv27K4+rLfskcQdm@google.com>
In-Reply-To: <Yv27K4+rLfskcQdm@google.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Mon, 22 Aug 2022 10:21:47 -0600
Message-ID: <CANkg5ewGUcWagRNOLfbRx8hLqgX+FfdYGB5Qt7tO5=zicGBVDg@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     rrangel@chromium.org, robbarnes@google.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Tue, Aug 02, 2022 at 11:40:08AM -0600, Tim Van Patten wrote:
> > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > .prepare() and cros_ec_lpc_complete() during .complete(). This allows the
> > EC to log entry/exit of AP's suspend/resume more accurately.
>
> As what I commented on [1], the term "host event" in the commit title is
> confusing.  Also, as this is a cros_ec_lpc specific patch, please change
> the prefix.

I've updated the prefix to "cros_ec_lpc" and the title/description to
indicate that this CL moves when the host event is sent to
.prepare()/.complete().

> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid/#24934911
>
> > -static int cros_ec_lpc_resume(struct device *dev)
> > +static void cros_ec_lpc_complete(struct device *dev)
> >  {
> >       struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = cros_ec_resume(ec_dev);
> >
> > -     return cros_ec_resume(ec_dev);
> > +     dev_info(dev, "EC resume completed: ret = %d\n", ret);
>
> cros_ec_resume() always returns 0.

Yes, it always returns 0 today, but that may not be the case forever.
 While "ret" is not returned by cros_ec_resume() today, it's possible
for it to be non-zero and someone may update cros_ec_resume() to
return that status.

https://github.com/torvalds/linux/blob/1c23f9e627a7b412978b4e852793c5e3c3efc555/drivers/platform/chrome/cros_ec.c#L378

Additionally, everyone passes along the return code of cros_ec_resume():

    drivers/platform/chrome/cros_ec_i2c.c
    331:    return cros_ec_resume(ec_dev);

    drivers/platform/chrome/cros_ec_rpmsg.c
    285:    return cros_ec_resume(ec_dev);

    drivers/platform/chrome/cros_ec_ishtp.c
    766:    return cros_ec_resume(client_data->ec_dev);

    drivers/platform/chrome/cros_ec_spi.c
    808:    return cros_ec_resume(ec_dev);

    drivers/platform/chrome/cros_ec_uart.c
    390:    return cros_ec_resume(ec_dev);

    drivers/platform/chrome/cros_ec_lpc.c
    530:    return cros_ec_resume(ec_dev);

I'm going to leave this as-is, since it's good practice to check
return values (and log bad status) and so we don't need to update this
code in case cros_ec_resume() does return a non-zero value in the
future.

-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
