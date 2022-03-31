Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1964ED70F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiCaJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiCaJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:36:58 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D76AF1F6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:35:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b18so20887304qtk.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsN5p6Zbb92CWY0fCQlSnWVHSmMIpn5JDGM4v10NtKE=;
        b=ZunWdYGe8+BLAfVsPhIKSdgfp/G02w2RPLviviav8MFDJAF80hz+gYJdoOGSo34tqv
         +GOt1h6oPls11MbrXMWncQOXZmfdT+lhqoeeAdjHnzcDo7Y+ls+43qjcKa4FnDUZBr8g
         sfb8w/YhyQ+I+txxTbyARU1xScgG75osTxNrQd/eW37hUwLOqmWqtNTAMgYkd6Ktg+8v
         SISvG4vs6TaDZYpzkTU2u3b1ge4YO9UUK1QU+l3rIQdKqsBt2Cv/PAH7mIcmQDs8WgY7
         CqOd27nG1iOkKCVqS+VcVciIKPjF7ot65oGt3h7/40D3BucYPbivC79Gb3PETsi4mdBl
         9MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsN5p6Zbb92CWY0fCQlSnWVHSmMIpn5JDGM4v10NtKE=;
        b=T31iwqHTrHFzuTsPmq+VuQn4fZpqqE/YPOXmMrNFUoDmv7d92RWMcwfcOzhGLjePd+
         MSN/OjaE01VeATrOfx1YZVDwD1mD7E/7c0l32svYK/ty97gwpbeFbWUJ1NN3s9ejrSXQ
         22bYMn9LE4aii5hosbwd4qwaFfXUK5Q0JOj42PNhwMGdC76hnAaskxAVoTwYijWuDgq9
         jg9eNX2iDDK3dZuC8irJNZ36GliUgtwBnWYEpy6EJcd+oYCYOfGBQ+MlxqZ4XK/mKZhK
         +XynwC7ovj6K8a7lkKnot6bt/eKGbgUZwv8+NXE4X9osyXGB5cyCg/16ekMQj/pmM3WG
         YX8w==
X-Gm-Message-State: AOAM532PflFVBx8ysfov56vxidweg5iBR/8Q1u2pwuDnGShJ+xpnGH7P
        ID3Mx3Fs/+TzpOVSFcuB+Qvu6iie3ytXRvI8YknSwg==
X-Google-Smtp-Source: ABdhPJzGd4rqpbpprVxRT58SQ0mWkivwbwlishXbW/R3KM5sUWLDKwn+nH2fugALpTWwKgteKCnQM+TuY1AtSd9ZY20=
X-Received: by 2002:ac8:5702:0:b0:2e1:ec8a:917a with SMTP id
 2-20020ac85702000000b002e1ec8a917amr3318464qtw.682.1648719309154; Thu, 31 Mar
 2022 02:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya> <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
 <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
 <YkKmPSesQfS6RLCD@matsya> <YkMrPnRbsl3FBig8@robh.at.kernel.org> <YkVEsqiRamfTmNi0@matsya>
In-Reply-To: <YkVEsqiRamfTmNi0@matsya>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Mar 2022 12:34:58 +0300
Message-ID: <CAA8EJpqTqB10JkmK4GfbO6uP4wAUtqPzY+N4f+=Lt6Vy3a+g4Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 09:05, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 29-03-22, 10:52, Rob Herring wrote:
> > On Tue, Mar 29, 2022 at 12:01:52PM +0530, Vinod Koul wrote:
> > > On 28-03-22, 13:21, Rob Herring wrote:
> > > > On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >
> > > > > On 28/03/2022 19:16, Vinod Koul wrote:
> > > > > > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> > > > > >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> > > > > >> <krzysztof.kozlowski@linaro.org> wrote:
> > > > > >>>
> > > > > >>> The DSI node is not a bus and the children do not have unit addresses.
> > > > > >>>
> > > > > >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> > > > > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > >>
> > > > > >> NAK.
> > > > > >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> > > > > >> This is the convention used by other platforms too (see e.g.
> > > > > >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> > > > > >
> > > > > > So we should add reg = 0, i will update my dtsi fix
> > > > > >
> > > > >
> > > > > To "ports" node? No. The reg=0 is for children of the bus, so the
> > > > > panels. How to combine both without warnings - ports and panel@0 - I
> > > > > don't know yet...
> > > >
> > > > I don't think that should case a warning. Or at least it's one we turn off.
> > >
> > > Well in this case I think we might need a fix:
> > > Here is the example quoted in the binding. We have ports{} and then the
> > > two port@0 and port@1 underneath.
> >
> > It's the #address-cells/#size-cells under 'ports' that applies to 'port'
> > nodes. As 'ports' has no address (reg) itself, it doesn't need
> > #address-cells/#size-cells in its parent node.
> >
> > >
> > > So it should be okay to drop #address-cells/#size-cells from dsi node
> > > but keep in ports node...
> >
> > Yes.
> >
> > > Thoughts...?
> >
> > But I thought a panel@0 node was being added? If so then you need to add
> > them back.
>
> I guess we should make this optional, keep it when adding panel@0 node
> and skip for rest where not applicable..? Dmitry is that fine with you?

This sounds like a workaround. When a panel node is added together
with the '#address-cells' / '#size-cells' properties, we will get
warnings for the 'ports' node.
I'd prefer to leave things to pinpoint that the problem is generic
rather than being specific to several device trees with the DSI panel
nodes.
How do other platforms solve the issue?

In fact we can try shifting to the following dts schema:

dsi@ae940000 {
   compatible = "qcom,mdss-dsi-ctrl";

   ports {
      #adress-cells = <1>;
      #size-cells = <0>;
      port@0 {
         reg = <0>;
         dsi0_in: endpoint {};
      };
      port@1 {
         reg = <1>;
         dsi0_out: endpoint {
               remote-endpoint = <&panel_in>;
         };
      };

   /* dsi-bus is a generic part */
   dsi-bus {
      #adress-cells = <1>;
      #size-cells = <0>;
      /* panel@0 goes to the board file */
      panel@0 {
          compatible = "vendor,some-panel";
          ports {
             #adress-cells = <1>;
             #size-cells = <0>;
             port@0 {
               reg = <0>;
                panel_in: endpoint {
                   remote-endpoint = <&dsi0_out>;
                };
             };
        };
   };
};

WDYT?

-- 
With best wishes
Dmitry
