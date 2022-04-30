Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D82515958
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381907AbiD3AiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiD3AiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 20:38:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC4659F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:34:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7c57ee6feso101170587b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZdhfgXcYyzwQ2Qbee46+dN9XPUR+TwA/X5/pzXcNMQ=;
        b=hgzCI1pU/Sf5CSopWVg8mrZsOmGMyK2uQJMYiDRakeWgP4rQDVr0OzsKoAEyGr7G7s
         MU+79meZgzN6dY170248qXerXKjAawlPA19wuoLRK/EygBn9OHvDdRtX0lbr9w7DQoui
         hfTr9X8yvB9ngRQbxXadIp1y44r+xsjCSF1xEHfnfinzDrgU+rI+X5yn/1DnXl7K1l0a
         cZ5s/ZQ/AUftZhpQsp/2QzwGb/Bk9fRDN3JveXlfvHHOCThdPTL5/81aJZ99DxZLXxPV
         DhCH/1bmQre/0VOtJ0nG1s0AfmL/NoD0LKEt+YbcvF+A1YyzK0AvQXPj8RrPnm6/XHM3
         EXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZdhfgXcYyzwQ2Qbee46+dN9XPUR+TwA/X5/pzXcNMQ=;
        b=3388REfG4kIPBOCNRryHkbvYPL5S2W0SgorS4z8Lj2o2diXvaZX3DfkXrr5jcm8Xas
         s8m121kt6dzMZ8lOhK1+xLq5S87XgV8kgvOVmNbhd6eAcijVltg07tUrhEwVLP4QgeN8
         dRoFOoTmFUiGx56YU/t7BsyigqTWSwcO8FtELkVYbIf63SkDihtJHg9AiAIm+aqXIdIo
         d/vPqBAWWbrgrW20mKL+gYwtaZYAbe3d80dFJje3tv8NjzDWWCNB8vMOPfFlEbwogj1Z
         mVqbUqfJcVsieFMzsJPfDYXTLogYM7nW82k8maYpw9F1LIBDComqoDSVcX87dF2NSFXM
         BvPg==
X-Gm-Message-State: AOAM532pF/IcaXwa5rroAepHdhfUtiqmmkEuwFdTm98a8cVM+iEmsFVT
        wVRn4e61zyfj0ku8LuXQJiE8rxJWRCxtlO+Eiw3Xzg==
X-Google-Smtp-Source: ABdhPJwgD+XnOBNx8doAXxOKJPMj70f1B+iF247gtD9LkvbzcVOtpMrSGBmJinpKgpBS3LvBxStkWw7WXaDVdB1d6H0=
X-Received: by 2002:a05:690c:293:b0:2f8:d994:b750 with SMTP id
 bf19-20020a05690c029300b002f8d994b750mr1878320ywb.459.1651278880449; Fri, 29
 Apr 2022 17:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
In-Reply-To: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 29 Apr 2022 17:34:04 -0700
Message-ID: <CAGETcx-i0giDksG7ARfT0E6gakdYuh6OO9g1Vmeu6S3PH1qGUQ@mail.gmail.com>
Subject: Re: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        swboyd@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:43 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Due to a subtle typo, instead of commit 87ffea09470d ("device
> property: Introduce fwnode_for_each_parent_node()") being a no-op
> change, it ended up causing the display on my sc7180-trogdor-lazor
> device from coming up unless I added "fw_devlink=off" to my kernel
> command line. Fix the typo.

Thank you for the fix!

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..52e85dcb20b5 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>         struct device *dev;
>
>         fwnode_for_each_parent_node(fwnode, parent) {
> -               dev = get_dev_from_fwnode(fwnode);
> +               dev = get_dev_from_fwnode(parent);
>                 if (dev) {
>                         fwnode_handle_put(parent);
>                         return dev;
> --
> 2.36.0.464.gb9c8b46e94-goog
>
