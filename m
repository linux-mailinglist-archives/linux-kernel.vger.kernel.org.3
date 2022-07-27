Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5F58283A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiG0OIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiG0OH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:07:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66243C174
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:07:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v17so1981946edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZJ6Azi8AIlpwcu6fu4nlWUNhFcDU4qihMs8eKUysC1U=;
        b=eKY0mwp9aq52dmD2u/O/c9j4iEkTST15O+BMB8bmNbdLor6rvbEYOSZ9NfGGxPUUFl
         3AkPvuy0QpjESiDFeQeKpry5jHLwvVCF5AKaGNUAXDp37/AqNO7UvvLEc4wddggrxI9O
         INgzOEKZzu4EVZMZLc6i+AaMTw4JVtrMJkZho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZJ6Azi8AIlpwcu6fu4nlWUNhFcDU4qihMs8eKUysC1U=;
        b=bA07sJZ5eDDxuVh7wrViDyvWEJQ3aEZlIMb+OjeHC4LKpDlOx8IKGxEUTopKBQlLGO
         8QUA8mP3dOclonKYvqBC5SfrD3XuCN3lFt037S5Y4SfSo+stwyxFVzouebz4nFC47js/
         wOW18cA17lsjHTDcXbZbPEtnbM64EZyfc7nLbzGwW+DxYZiy3bu3n/HNkBkrZTsuGL0Z
         va9Rb3v+M75wdHthkvYOW2N6yq5O65gtmXcsUlEjHhS6sZsoR9hnOLutfWOwUf5rea+y
         sl9ovNiO31tszyNom5MtUsdZudQUfHycs22FYMkVqddOYHsfLFW+6n18NXWxM+G21MWv
         HCiA==
X-Gm-Message-State: AJIora//WeCdRFBu8vs1moeYMbC1Rv3HkvbgfMFQlCRcIQnxYomfZoJL
        d7asgw0HrJpiaOCLOVWLPE0V/IltbGdRyrzn
X-Google-Smtp-Source: AGRyM1tSP8sIlhWHWPtU8e2elcjezE5EM7qholj8B2+h9V8AtXmEESEkyFwd4NJpJlDpt4//Jizbow==
X-Received: by 2002:aa7:db49:0:b0:43c:d1af:5c76 with SMTP id n9-20020aa7db49000000b0043cd1af5c76mr352661edt.173.1658930874118;
        Wed, 27 Jul 2022 07:07:54 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906538800b0072af930cf97sm7630500ejo.115.2022.07.27.07.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 07:07:52 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h8so24395717wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:07:51 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr14894277wrn.138.1658930870909; Wed, 27
 Jul 2022 07:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org> <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org> <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
 <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org> <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
 <1f3189ef-7d3f-27b3-a691-b9649090b650@linaro.org> <CAODwPW-GDkfyFaNSnEngpSfz8LSXRetu+xwp3QrFHP1rH1O06w@mail.gmail.com>
 <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
In-Reply-To: <86b9c6d6-e8e5-7f6d-0970-460baf9b6fcc@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jul 2022 07:07:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8rgxuymX6hurS96rg1fjDUfh60b0X4UbpPp+TA+ck5g@mail.gmail.com>
Message-ID: <CAD=FV=U8rgxuymX6hurS96rg1fjDUfh60b0X4UbpPp+TA+ck5g@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 1:47 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 01:42, Julius Werner wrote:
> > Sorry, got distracted from this for a bit. Sounds like we were pretty
> > much on the same page about how the updated binding should look like
> > here, the remaining question was just about the compatible string.
> >
> >>>> Yes, we can. You still would need to generate the compatible according
> >>>> to the current bindings. Whether we can change it I am not sure. I think
> >>>> it depends how much customization is possible per vendor, according to
> >>>> JEDEC spec. If we never ever have to identify specific part, because
> >>>> JEDEC spec and registers tell us everything, then we could skip it,
> >>>> similarly to lpddr2 and jedec,spi-nor.
> >>>
> >>> Shouldn't that be decided per use case? In general LPDDR is a pretty
> >>> rigid set of standards and memory controllers are generally compatible
> >>> with any vendor without hardcoding vendor-specific behavior, so I
> >>> don't anticipate that this would be likely (particularly since there
> >>> is no "real" kernel device driver that needs to initialize the full
> >>> memory controller, after all, these bindings are mostly
> >>> informational).
> >>
> >> If decided per use case understood as "decided depending how to use the
> >> bindings" then answer is rather not. For example Linux implementation is
> >> usually not the best argument to shape the bindings and usually to such
> >> arguments answer is: "implementation does not matter".
> >>
> >> If by "use case" you mean actual hardware or specification
> >> characteristics, then yes, of course. This is why I wrote "it depends".
> >
> > By "use case" I mean our particular platform and firmware requirements
> > -- or rather, the realities of building devices with widely
> > multi-sourced LPDDR parts. One cannot efficiently build firmware that
> > can pass an exact vendor-and-part-specific compatible string to Linux
> > for this binding for every single LPDDR part used on such a platform.
>
> Why cannot? You want to pass them as numerical values which directly map
> to vendor ID and some part, don't they?

If you really want this to be in the "compatible" string, maybe the
right answer is to follow the lead of USB which encodes the VID/PID in
the compatible string
(Documentation/devicetree/bindings/usb/usb-device.yaml). It's solving
this exact same problem of avoiding needing a table translating from
an ID provided by a probable device to an human-readable string.


> > And I don't see why that should be needed, either... that's kinda the
> > point of having an interoperability standard, after all, that you can
> > just assume the devices all work according to the same spec and don't
> > need to hardcode details about each specific instance.
>
> If we talk about standard, then DT purpose is not for autodetectable
> pieces. These values are autodetectable, so such properties should not
> be encoded in DT.

In the case of DDR, I think that the firmware can auto-detect them but
not the kernel. So from the kernel's point of view the DDR info should
be in DT, right?

-Doug
