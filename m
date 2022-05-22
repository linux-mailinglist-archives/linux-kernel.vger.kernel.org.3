Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9994530635
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiEVVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiEVVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:31:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB31EAFF;
        Sun, 22 May 2022 14:31:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w3so4861955plp.13;
        Sun, 22 May 2022 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=04+dzA0nLZrbapXkAJwbNYGP/eoDQEsbfnqc85YkYrU=;
        b=B9ojAkF7Mt2/AyWp0t2VXzTdbbsucofNlcphrA8SKQEYjk9MWw3enaGlL0ipn36khG
         FQIhfmQIquZKwjVZI0ivsVcYPxGT1t3MPqbmL6V2Lq6rxso9fPNn4exE6CRrpkymnewO
         Kqyhad0/+z+FeIqiHRx91lcSBup4k7J0DsG1GwmfKikJor4d4lJ9Fi7m7pt4xOo/WU3k
         GRjM5M82qCI1tH/c4apQSNTD7dL4f2uZs2cFB609Bop1zF/miUTnq7NeSWSAH1+8uzGP
         Apj+7hTBD/xBb0Mvctn9G3ucH0B1lQ2qMJt/u/HbXiKJTiFN/zKAATd/DiIbK1Dl0axc
         DoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04+dzA0nLZrbapXkAJwbNYGP/eoDQEsbfnqc85YkYrU=;
        b=GWcEgtVO1+0vnlNOu1WS5G/LJopFu6fgDW9x5RmP51SJ7Px2OCngU3c1kNfPd1Sdtb
         +cSrreTQOxaKPinzkuklrJqaYkdjNvN2CxlImKqbCMDPY8ZtMPtZwuJjka0V7dAGZ4Jd
         pIN+QtJV11msXFbwYuwloA3TPlupuiu3JYBaaxl9f0K+M7J6gpFuRQua92NYZUDJfR1b
         y9ap7i3NWR2QY59q1KJrijRk9FUXCXqGklmNSdlnpDFuF1qJaM+9Z/4rg5B0InecBw9T
         V0OIVCe/FrYIicIH+spNieIucrfN/a1CwrlTs64zCDV5gV6w03JiRFXWPPSq+GiZduap
         pwfA==
X-Gm-Message-State: AOAM532Lb31MM05O2vknjyyGs8/xEF+R3i2z2IaX8XunaYX3UOiSHuLo
        u2J8C3U91YYOPjCz26+5Ww6lViPly7Y=
X-Google-Smtp-Source: ABdhPJytm2YIWC9JmvtJcUU8BGBupHRbaJF+VJZu5sQb5Vjs5ewVOOobRyjcLkJiL2Ep8+gVjW3Ayw==
X-Received: by 2002:a17:90a:6c64:b0:1df:8451:d197 with SMTP id x91-20020a17090a6c6400b001df8451d197mr23125936pjj.175.1653255100648;
        Sun, 22 May 2022 14:31:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id e8-20020a056a001a8800b0050dc762819dsm5593928pfv.119.2022.05.22.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 14:31:39 -0700 (PDT)
Date:   Sun, 22 May 2022 14:31:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        swboyd@chromium.org, linux-input@vger.kernel.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: i2c-hid: elan: Add support for Elan eKTH6915
 i2c-hid touchscreens
Message-ID: <YoqrudJZneAZ010D@google.com>
References: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
 <20220519155925.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519155925.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:00:03PM -0700, Douglas Anderson wrote:
> Like many i2c-hid touchscreen controllers, the Elan eKTH6915 has a
> reset GPIO hooked up to it. According to the datasheet, the way we're
> supposed to turn the touchscreen on is:
> 
> 1. Turn on the 3.3V supply.
> 2. Turn on the IO supply. It's OK if this is hardwired to the 3.3V
>    supply, but if it's not then it must be turned on _after_ the 3.3V
>    supply.
> 3. Wait >= 1 ms.
> 4. Deassert the reset GPIO (reset GPIO is active low, so there would
>    be a leakage path if this was deasserted _before_ the IO supply).
> 5. Wait 300 ms.
> 
> Much of the above can be handled by the generic i2c-hid-of driver, but
> the "reset" GPIO is not supported by that driver. Thus we'll do the
> same as we did for Goodix and add a new tiny driver that uses the
> i2c-hid core.
> 
> NOTE: support for this new touchscreen could theorically fit into the
> Goodix driver. I've made it a separate driver because the Elan driver
> supports _two_ regulators and it's unclear exactly how that would fit
> in with commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line
> to true state of the regulator").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> +
> +	return i2c_hid_core_probe(client, &ihid_elan->ops, 0x0001, 0);

Maybe #define for the descriptor address, or rename
elan_i2c_hid_timing_data into elan_i2c_hid_chip_data and put it there?

Thanks.

-- 
Dmitry
