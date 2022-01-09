Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428F3488A95
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiAIQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:33:14 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39485 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiAIQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:33:13 -0500
Received: by mail-ot1-f48.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso3261828otr.6;
        Sun, 09 Jan 2022 08:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6aQP76L17zZIifS48mJSyI2JpkFOM8CJyj+hC/CiesE=;
        b=SAeXACI8IJbntaLQmRUSoStSnUl/wC0E5rKRw8V7FyhpCMdoSN2YrXGMJ5qHo0IkR7
         mKIeihpeZBWazgUDY2/rkc6iVzUXvoo0fxHQUnwvRAgDQcTK/N94wH8BcFBjjkpU9wQK
         kC+idPSRnDonJd3uAmdQSu0KVXOlBFngBZwmUqGc9Qo2ZINAykRoW+dFuKiBzG0YQABK
         umL9xf9LedepjkKHArrqTArfWC3RRmkXI6hRZp9G/T/bgDz58BE4t1DPVFguLtndUqxR
         zhaol/uDtxxsEwGJI9mqcDOgX73SiYbO7n1Wa0FiqxHiDdx8hSshUQM8G606ZBqV84tK
         FyIw==
X-Gm-Message-State: AOAM532r/d0+6YWwI7+2o9bJSqPxkm9OFxXkQcalH3spV0sJ66A4zG2Y
        U7oCo6UA+wcwv2MakCclS9WLoqoC3A==
X-Google-Smtp-Source: ABdhPJyjNrFptPbU7HtswyOghK5ZNW41xftu9unOvQFYSHzdWpB2VWJ/iT1O1WH3Rms7hoEFc6T7aQ==
X-Received: by 2002:a9d:4d8d:: with SMTP id u13mr14022539otk.246.1641745993000;
        Sun, 09 Jan 2022 08:33:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q65sm759252oih.45.2022.01.09.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 08:33:12 -0800 (PST)
Received: (nullmailer pid 3263068 invoked by uid 1000);
        Sun, 09 Jan 2022 16:33:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>
In-Reply-To: <20220107155215.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
References: <20220107235320.965497-1-briannorris@chromium.org> <20220107155215.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
Subject: Re: [PATCH 01/10] dt-bindings: devfreq: rk3399_dmc: Convert to YAML
Date:   Sun, 09 Jan 2022 10:33:11 -0600
Message-Id: <1641745991.444665.3263067.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 15:53:11 -0800, Brian Norris wrote:
> I want to add, deprecate, and bugfix some properties, as well as add the
> first users. This is easier with a proper schema.
> 
> The transformation is mostly straightforward, plus a few notable tweaks:
> 
>  * Renamed rockchip,dram_speed_bin to rockchip,ddr3_speed_bin. The
>    driver code and the example matched, but the description was
>    different. I went with the implementation.
> 
>  * Drop upthreshold and downdifferential properties from the example.
>    These were undocumented (so, wouldn't pass validation), but were
>    representing software properties (governor tweaks). I drop them from
>    the driver in subsequent patches.
> 
>  * Rename clock from pclk_ddr_mon to dmc_clk. The driver, DT example,
>    and all downstream users matched -- the binding definition was the
>    exception. Anyway, "dmc_clk" is a more appropriately generic name.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 212 -------------
>  .../bindings/devfreq/rk3399_dmc.yaml          | 297 ++++++++++++++++++
>  2 files changed, 297 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml:37:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1577007

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

