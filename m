Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776F4F9721
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiDHNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiDHNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:45:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E946160
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:43:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a6so17565282ejk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZpanQL7fJ5Imrl94t4mOv+0fifiSCixQTFhocGBbW4=;
        b=ocU4WzdvqVtDrF+QNMkeIFKSbQDrw614kxrKDCXUNEPj0TcZTn2VF33O7pzWeuQcUi
         /kpIefrRb+tIPM7KdnbR0CjVrj0C7uFD+iwBJMThlUaqxYgu/HgyrOL3xZXxjwikkwPM
         /w5y4+LqxJFClA/AFhhdE9da2MRmrUgMM0sYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZpanQL7fJ5Imrl94t4mOv+0fifiSCixQTFhocGBbW4=;
        b=jDqp+tqbrOxV1Fu5DVVEzK88aIGbxsSoueU1hJMkSObbiyK0B5AZj38VUmB3Bpdp3i
         /KQocng4p8Ru85MtdtFHtFljyMuFR79TJyBUGgfwfTKf9SpoDlTl3fX9Pi7qhh34cDby
         A/0PAEt5Vba+s5VylF8FItiE3cfZTj3aW0T7oj0rGrIO3IlnRLfCNeuRQVFyjylWUXjO
         4hDnykNyLTj2kXN9JqfKImVDFZ7qOLf9Cu1vfRuyqaKqLvLo/qUVLU7gxwC7WXVl4JU2
         X7DWz5xU1bMvMGSQpbiTyk1dnovxXtmfLj6EeNVMX4sQC0CnnVaVvaDbpmv1iyv2Q6JY
         Uhtw==
X-Gm-Message-State: AOAM531WD89KQ6dqR3toAF/90QWuYYoDYSOIYiMLtwexzsEdMOj4EA0d
        zeIfRURbbiOzl6Z2bQRaupN0ngWYbsRskBRLnzg=
X-Google-Smtp-Source: ABdhPJy0A+UTIJcK1ouJHwj7lq6tJm2V0B+CZ1ZzlNMfxByNgYd0BcilTL+aS5NidWPAFX/G1pjAvQ==
X-Received: by 2002:a17:907:1b08:b0:6da:b62a:762a with SMTP id mp8-20020a1709071b0800b006dab62a762amr17768197ejc.60.1649425426112;
        Fri, 08 Apr 2022 06:43:46 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402280e00b0041957289726sm11508836ede.79.2022.04.08.06.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:43:44 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id w21so12948871wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:43:42 -0700 (PDT)
X-Received: by 2002:adf:e591:0:b0:206:1202:214 with SMTP id
 l17-20020adfe591000000b0020612020214mr14896572wrm.342.1649425421934; Fri, 08
 Apr 2022 06:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
 <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org> <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com> <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
 <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com> <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
 <CAA8EJpqLZ9up4euGEbhf5QyBqm4tJuLcHi7D+0Si7ak9Jej52w@mail.gmail.com>
 <CAD=FV=XwOzsRf7RnvyBjr5TtedMhC0LJFKoK9tp-kw1eEyuJmQ@mail.gmail.com> <CAA8EJprb5UF24WRNvGaY_hSqW--NPd=9=8AaPYWSMbUumNn+dQ@mail.gmail.com>
In-Reply-To: <CAA8EJprb5UF24WRNvGaY_hSqW--NPd=9=8AaPYWSMbUumNn+dQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Apr 2022 06:43:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UG7k4A+hMXxwju-0mLddD1oJdGngXMkMA-dO3AxOx0rQ@mail.gmail.com>
Message-ID: <CAD=FV=UG7k4A+hMXxwju-0mLddD1oJdGngXMkMA-dO3AxOx0rQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 8, 2022 at 5:20 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > I guess my thought was that in DP you could still create the AUX bus
> > at probe time. Then for DP you just return an instant "transfer
> > failed" from the AUX bus if HPD isn't asserted. For eDP (as discussed
> > elsewhere) when we try to do an AUX transfer then we delay until HPD
> > is there.
>
> I think panel-edp would already handle the delay, so we do not need to
> have this logic in the DP driver.

There's a whole discussion about this between Stephen and me in patch
#5 ("drm/msm/dp: wait for hpd high before any sink interaction").
Basically:

* If panel HPD is hooked up to the dedicated HPD pin on the eDP
controller then the panel driver doesn't have a way to read it.

* We can't leverage the existing "HPD" query functions in DRM because
those indicate whether a panel is _physically_ connected. For eDP, it
always is.

For now the rule is that the AUX transfer function is in charge of
waiting for HPD for eDP if the dedicated HPD pin is used. If we want
to re-invent this we could, but that system works, isn't _too_ ugly,
and we're already making big enough changes in this series.


> > So we can still acquire resources (clocks, PHY, io maps, etc) at probe
> > time for DP and create the AUX bus, right? It will just return
> > "-ENODEV" if HPD isn't asserted and you're DP?
>
> Yes, please. I still suppose that we'd need a separate case to
> power_on eDP's PHY during the probe time. Maybe I'm mistaken here.

I think the ideal way is to do it like Kieran's proposal for sn65dsi86:

https://lore.kernel.org/r/20220317131250.1481275-4-kieran.bingham+renesas@ideasonboard.com/

* When enabling HPD (physical hot plug detect) in the hpd_enable()
callback you do a pm_runtime_get(). You do the
pm_runtime_put_autosuspend() when disabling. This is only used for DP
since we only provide DRM_BRIDGE_OP_HPD for DP, not for eDP.

* We do a pm_runtime_get() / pm_runtime_put_autosuspend() in the AUX
transfer routine. While holding the pm_runtime reference we check HPD.
For DP we return immediately if HPD isn't asserted. For eDP, we delay.

* We do the pm_runtime_get() in pre_enable and the pm_runtime_put() in
post_disable. For DP this will add a 2nd refcount (since we probably
were holding the reference for HPD). For eDP this will cause us to
power on.

* If there's any other time we need to read HW registers, and we
aren't guaranteed to already have a pm_runtime reference (like during
probe), we can do a temporary pm_runtime_get() /
pm_runtime_put_autosuspend().
