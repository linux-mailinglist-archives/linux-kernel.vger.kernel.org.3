Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34E5A1564
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiHYPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbiHYPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990F558D8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661440516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gVvHoDnKDdIYQv1Tk0myCNHOeNmZIUPmw6v6LQZ79ZU=;
        b=Icx+QiX2tgUhmmaaiL+c9FQLF9d0DPilK3Mltk73KcAH6zSen7v3XVzxnx8otfz1CsCNmM
        Bf0YKi/SlwV8qVUq4gHozQNqShiqQwQLNR9zfWuOyqQyifNQYAHk/QrJp/yyNguusecPdp
        evNGcf7cSDLxHjw3OKD77TbktWNJ7TE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-paa1RsL7OpyduPe3lS03zw-1; Thu, 25 Aug 2022 11:15:14 -0400
X-MC-Unique: paa1RsL7OpyduPe3lS03zw-1
Received: by mail-qt1-f199.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so15237280qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gVvHoDnKDdIYQv1Tk0myCNHOeNmZIUPmw6v6LQZ79ZU=;
        b=6SFNGIwODHIosCJDBUPNRZ7lb8kfb4fIIqTRc4LIluGHd2d/ZL5u33RWl0ijzMDGnC
         Uck/mawNw1b9hD7gxXfAVlV4/QLt5+9JbMjYF5mEAvLxjqhuyLECFkN3mTnLxzsEshIo
         y8/If59Exl2GIjqaPBLUooTVe7Spb1RvH7S6l5mOdlMkm2AUtV2baVRREV0T53trtHCk
         jSkHTcu2W4Zy7zXv1IFD3WewP234cmEO0wDLTav4eXabnK5g/OOAXkoh+0W3pg3PyhLc
         GJp0+HZvrT0IPaXI6nr3UBnxStFhpmsagFR715leI+2I2zcoVnii+l0LPSalyAnsc4FC
         bNoA==
X-Gm-Message-State: ACgBeo1ZZpjt2ow34xMsR5TWAYipXUKMwHUhi4ki4lg8ofXMMU+HkpHE
        AmlyoblQYWd7p0Tza+peDOddassy93wX5RMGFazAhT8NOJsF3pLtKmChD0b1qUiF+LXJmLMvyJi
        0a3sR5RP0NGaOkI6GqQiwzmqU
X-Received: by 2002:ac8:5d92:0:b0:344:6f74:4d17 with SMTP id d18-20020ac85d92000000b003446f744d17mr3971755qtx.227.1661440514316;
        Thu, 25 Aug 2022 08:15:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6wIxKi2ag6eKK2FoQEFD6XKL8J9kIp/IY8vCMrH41X/QcaR95W90qq/dNi32PFVaknpb06TA==
X-Received: by 2002:ac8:5d92:0:b0:344:6f74:4d17 with SMTP id d18-20020ac85d92000000b003446f744d17mr3971731qtx.227.1661440514106;
        Thu, 25 Aug 2022 08:15:14 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id bk26-20020a05620a1a1a00b006bb29d932e1sm16831654qkb.105.2022.08.25.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:15:13 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:15:11 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 1/2] regulator: core: Require regulator drivers to
 check uV for get_optimum_mode()
Message-ID: <20220825151511.6nihkswhqz2ei6dc@halaneylaptop>
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:22:56PM -0700, Douglas Anderson wrote:
> The get_optimum_mode() for regulator drivers is passed the input
> voltage and output voltage as well as the current. This is because, in
> theory, the optimum mode can depend on all three things.
> 
> It turns out that for all regulator drivers in mainline only the
> current is looked at when implementing get_optimum_mode(). None of the
> drivers take the input or output voltage into account. Despite the
> fact that none of the drivers take the input or output voltage into
> account, though, the regulator framework will error out before calling
> into get_optimum_mode() if it doesn't know the input or output
> voltage.
> 
> The above behavior turned out to be a probelm for some boards when we
> landed commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()"). Before that change we'd have no
> problems running drms_uA_update() for RPMH regulators even if a
> regulator's input or output voltage was unknown. After that change
> drms_uA_update() started to fail. This is because typically boards
> using RPMH regulators don't model the input supplies of RPMH
> regulators. Input supplies for RPMH regulators nearly always come from
> the output of other RPMH regulators (or always-on regulators) and RPMH
> firmware is initialized with this knowledge and handles enabling (and
> adjusting the voltage of) input supplies. While we could model the
> parent/child relationship of the regulators in Linux, many boards
> don't bother since it adds extra overhead.
> 
> Let's change the regulator core to make things work again. Now if we
> fail to get the input or output voltage we'll still call into
> get_optimum_mode() and we'll just pass error codes in for input_uV
> and/or output_uV parameters.
> 
> Since no existing regulator drivers even look at input_uV and
> output_uV we don't need to add this error handling anywhere right
> now. We'll add some comments in the core so that it's obvious that (if
> regulator drivers care) it's up to them to add the checks.
> 
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

Thanks again for the quick patches!
 - Andrew

