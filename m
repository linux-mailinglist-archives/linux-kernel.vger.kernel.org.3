Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFB588F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiHCPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiHCPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:30:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777965FAE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:30:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so2147804edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QSNLoRq7qbNX21X/zV/2AlYjV7hEb4BXWVGqbeUJ24g=;
        b=nzI1RPneh/LJJCu1k6xuiZTtzaae82xzjDcJUWtbJsNeS7XJdegrZyHq7NHnqw/K3v
         z5eW0E4AYjhiQE3UwN3v0NPjuunZorY6mJSCV9HwvyMq3kEg6Oek6rOvDV1r5SPQL06U
         pPeZgIcmUj31NF0m2C/T7AnXuxaoNbub9usmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QSNLoRq7qbNX21X/zV/2AlYjV7hEb4BXWVGqbeUJ24g=;
        b=1uewpUry2R0dFmD5vu5uxJoPILzVpgt9NAiZUlVeBv6utfcJ102o1u37TZHupQRcPV
         BoreC8vkduT2+QMCEzG7nOwubUL0p97KAGVT2gUuZCMgN1Ok0tbDS/5U6R8iTdY07FOL
         dMZM3Wq7168VIH0lRyHq9+KovPbnHthHzdhBQ/w7NQT35WByJo3lX5w08Lhqbo7aDSoG
         kEnQMxYtWfK6kPx/h8HoTXPq/qsh4VKEYCP5qmZII/0vSeYcNSTHr0pexxtAwlCpvB+M
         UsNAc8CdzlNBIvfIzBpfyJgkNsDT71haRg+w3Yzv6Bd/G2vq8DVsLRvuurlWsHtv4t0T
         4vBw==
X-Gm-Message-State: AJIora+8qVo30pzJ3/qEoG1yvWMJlvqdtOCZs0DspVN9XNEbGweNxiFo
        8pGC1KlLRkGk/F9tqZox+U6MtS8yhTAJVCJGhqI=
X-Google-Smtp-Source: AGRyM1tbIOponkwZ2E0B6ZiXQCfWRzXiHPyuOGpAqiY8inOsxUcZ8tQ6ZBZAwVLuBlZ4L+GwEE9umA==
X-Received: by 2002:a05:6402:64c:b0:43c:ea8e:85d6 with SMTP id u12-20020a056402064c00b0043cea8e85d6mr26939953edx.269.1659540627870;
        Wed, 03 Aug 2022 08:30:27 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id fv36-20020a17090750a400b0073093eaf53esm2823228ejc.131.2022.08.03.08.30.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 08:30:24 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id l4so22014746wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:30:22 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr16118496wrf.659.1659540622383; Wed, 03
 Aug 2022 08:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220803123332.8138-1-johan+linaro@kernel.org>
In-Reply-To: <20220803123332.8138-1-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Aug 2022 08:30:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoFgMj9iOx1HR72AcnTi9OOSCOFm39kKOGXHkeb2SYBg@mail.gmail.com>
Message-ID: <CAD=FV=VoFgMj9iOx1HR72AcnTi9OOSCOFm39kKOGXHkeb2SYBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] phy: qcom: drop regulator loads
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-phy@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 3, 2022 at 5:34 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Unless a driver implements an idle mode, there's generally no point in
> specifying an active-mode regulator load.
>
> Drop the regulator loads that were recently added to the Qualcomm QMP
> combo and edp PHY drivers.
>
> For a background discussion on this matter, see the following thread:
>
>         https://lore.kernel.org/r/YuPps+cvVAMugWmy@sirena.org.uk
>
> Johan
>
>
> Johan Hovold (2):
>   phy: qcom-qmp-combo: drop regulator loads
>   phy: qcom-edp: drop regulator loads
>
>  drivers/phy/qualcomm/phy-qcom-edp.c       | 12 -------
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++------------------
>  2 files changed, 9 insertions(+), 43 deletions(-)

It's really hard to evaluate this based on the information I have
available to me. :( I'm all for getting rid of all this complexity if
it was added for no reason and I could definitely believe that on most
boards there is no reason for it at all as talked about in other
threads.

I guess I worry that there is some use case where LPM mode is actually
usable to power these devices when they're active. It seems like
_maybe_ it could be but only if nothing else is pulling power from the
same LDO? Some LDOs on the board I have seem to be able to do LPM up
to 30 mA and some of the rails are being specified as ~22mA.

The problem with regulator loads is that using them is kinda an "all
or nothing". Either all the consumers need to specify something or
none of them can. :( This means that once the first user comes in and
is able to run the device in LPM (maybe only if they're the only
consumer?) that everything will break. I honestly have no idea if this
will ever happen, though... Mark said the phrase "actively managing
loads it's probably not doing anything useful" and I think "probably"
is an important word there. If that word was "never" then it would
definitely be OK to remove load management like this, but with
"probably" it becomes a lot harder.

If we needed a hack, I'd somewhat prefer a hack that just bumps the
"mA" value here up to something higher. That would force it to HPM...
...although maybe it still won't work? Then the regulator will still
go down to LPM for other consumers if the PHY ever turns off. In that
case I guess there's no getting around other consumers requesting the
load or finding some way to say that on your board this regulator can
only ever be in HPM mode.


-Doug
