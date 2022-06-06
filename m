Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF553F292
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiFFXbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFFXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:31:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD2248CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:31:05 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h188so21810569oia.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+R99sP1E+YJ8V/C7V8qm0/rICq7UmmvLlPBjsI3F3Ow=;
        b=dKhMQYmUnygXdMLeEuMU0xGiJl9UgJwKjf8/RsmACBEtpyzET5tJxD7FaR+jKvOhYS
         7GtNAnbdGyp6gzpJL9zuR8BnALu2GLbWpgz2wfzN3xXiKQ3a6cpenvYeusZyhAW3BN+R
         HOBsN1VxX7pjzhyn70e7HrXjDp8GIPE1qQrlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+R99sP1E+YJ8V/C7V8qm0/rICq7UmmvLlPBjsI3F3Ow=;
        b=FfjHIUlDToMvFpVWUTiwFik8eZ7TvSyaEUTtCWHD0cdeDzzNkl+21FReG1xAvfBr3Q
         5wdoxespBo2uhwrdcDeksSscoKVRuXooRuWqLJ+qzzmslBQOivK1e8DXZYmPBqVJtAt4
         ug/880dqLtv4K/sPZa6SlnnhH36LAelvSzG3udsuJn1ZjEb3bXkwVhChOpLg/pNioFg6
         R3JpOcHpTko9Hqg3xU85U8HvqUcMSRB+TTwazuTj24VdbX1HxxCN2tCidx9holk4Y5sP
         Qt8GGdiZX8Xq/IxDXSVlcVsRieiL+QUaVRhL42ErpZUUaXKQlJeaMprKskoOHTZO70um
         HHIQ==
X-Gm-Message-State: AOAM531lBTWsdwFLSUJjZG0mYDUiXx/h3B9Q3/rizzkXiY0TcjvtGKZk
        +0lNEORwlcCMu3iAU5Td9NGFm7lElFgPRd50L41YTw==
X-Google-Smtp-Source: ABdhPJzR5c8nv8+vHF7bA0iF44Ouo2hgGfY/3Fma+5GyZJXfDl7OqD4sgsm3BVVkVxAJA1OcF9ciIXiKVwihGwfaTyY=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr12356912oil.193.1654558264904; Mon, 06
 Jun 2022 16:31:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 16:31:04 -0700
MIME-Version: 1.0
In-Reply-To: <20220606201825.763788-2-pmalani@chromium.org>
References: <20220606201825.763788-1-pmalani@chromium.org> <20220606201825.763788-2-pmalani@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 16:31:04 -0700
Message-ID: <CAE-0n52hKCPwitrZNesh=NZKbXb76yR5xhAbyxh+5JaQAD3xZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: cros-ec: Use common cros_ec_command()
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, chrome-platform@lists.linux.dev,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-06-06 13:18:01)
> Reduce code duplication by using the common cros_ec_command() function
> instead of the locally defined variant.
>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
