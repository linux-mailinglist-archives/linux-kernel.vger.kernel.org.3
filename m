Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63465AA490
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiIBAoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiIBAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:44:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2923A1D1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:44:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t5so741516edc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IMQ+BZIR6+h0WYe8X2EFFlmyoPK1mtPErfGaqmTntwQ=;
        b=F0+vYb25Gviz6CRRQK7SorbY/ckL8SrufqNyoh61zl77MW0dtPZOvV6ihZ4IiUHwXp
         lwqPvyJRh2BwWNBPXxi/uN26X4GJfCELYZT+37Qav6trKj+XD4z+m/97EU1zDXqPTdUb
         uxEfoe+gtUc0gXW3gaGFCcZFu2tHbgCPt8AHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IMQ+BZIR6+h0WYe8X2EFFlmyoPK1mtPErfGaqmTntwQ=;
        b=FHwtaQxvRQ8cOdGMifl6gQMeWgT5wsXyPBov2TcEEbDrwtmFyC9xPBJG5TZxeNKo2T
         oqzAAb+NrQLIKc8gfDHKzniSjtXfiIrrCOzI7kwz+iggxHLctUzRIUgFzRph6+BNRfID
         HMtV6VeJOgAwn3iPPcXhXnjQctEgs3BbiCpII4o2kXknCEmWLtkJWzmHSpJ5b1DXTD1b
         StHpRPlxYk7eSOipytTGx1ffShwjqRexNLY/la61HlUtYa6wXZb3MiSmj7vgbibG+8SK
         OzEeWoqOQzZ1hcN6sZjytd0JWSt4MJyNheJEYBp0Iwg3EifR0zr+FN0CaDlobNX67GIa
         o0bQ==
X-Gm-Message-State: ACgBeo3ZjWpqNgZmeroR0EpvbHqmk4nGYZxpRPB5LN9vlJT2ykhggr9N
        90v3TitDCNxL929jrr2b44mFtadtadjFLV3s
X-Google-Smtp-Source: AA6agR77kxC/sIG/YFsBFw7cC7QvOVygLCzsv4ULBVCfkWBhOndlv0R6CAfEFRw6Syb2YFkVjjhb7w==
X-Received: by 2002:a05:6402:5002:b0:444:26fd:d341 with SMTP id p2-20020a056402500200b0044426fdd341mr31437255eda.351.1662079458101;
        Thu, 01 Sep 2022 17:44:18 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id lx12-20020a170906af0c00b0073dc6def190sm381278ejb.158.2022.09.01.17.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 17:44:17 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id m16so396722wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:44:15 -0700 (PDT)
X-Received: by 2002:a05:6000:15c6:b0:226:f246:6e70 with SMTP id
 y6-20020a05600015c600b00226f2466e70mr4192694wry.617.1662079455437; Thu, 01
 Sep 2022 17:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220829164952.2672848-1-dianders@chromium.org>
 <Yw8EE/ESDUnIRf8P@hovoldconsulting.com> <CAD=FV=VJz2hjvsUhsjBPt9nmm3X62oTdAqMeSFABYJietPPzWw@mail.gmail.com>
 <YxDVNW+EQbHRw16s@hovoldconsulting.com>
In-Reply-To: <YxDVNW+EQbHRw16s@hovoldconsulting.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Sep 2022 17:44:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaDNLLjtKswWvhD0JmLpOoVHR05yU8kZESH3yQ0xescA@mail.gmail.com>
Message-ID: <CAD=FV=VaDNLLjtKswWvhD0JmLpOoVHR05yU8kZESH3yQ0xescA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: Fix broken regulator spec on
 RPMH boards
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 1, 2022 at 8:52 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 07:52:52AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 30, 2022 at 11:47 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 09:49:46AM -0700, Douglas Anderson wrote:
> > > > Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > > > get_optimum_mode(), not set_load()") several boards were able to
> > > > change their regulator mode even though they had nothing listed in
> > > > "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> > > > stuck at the initial mode. Discussion of this (again, see [1]) has
> > > > resulted in the decision that the old dts files were wrong and should
> > > > be fixed to fully restore old functionality.
> > > >
> > > > This series attempts to fix everyone. I've kept each board in a
> > > > separate patch to make stable / backports work easier.
> > >
> > > Should you also update the bindings so that this can be caught during
> > > devicetree validation? That is, to always require
> > > "regulator-allowed-modes" when "regulator-allow-set-load" is specified.
> >
> > Yeah, it's probably a good idea. I'm happy to review a patch that does
> > that. I'm already quite a few patches deep of submitting random
> > cleanups because someone mentioned it in a code review. ;-) That's
> > actually how I got in this mess to begin with. The RPMH change was in
> > response to a request in a different code review. ...and that came
> > about in a code review that was posted in response to a comment about
> > how awkward setting regulator loads was... Need to get back to my day
> > job.
>
> Heh.
>
> > In any case, I think these dts patches are ready to land now.
>
> Yeah, as the old dtbs are now broken with newer kernels these are indeed
> needed.

With the latest patches in the regulator tree things shouldn't be
_too_ broken even without the dts files. Essentially things will get
stuck at their initial mode (HPM). So without these patches things
should all still boot but could possibly end up at a higher power
state.

-Doug
