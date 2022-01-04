Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E7484AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiADXCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiADXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:02:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48692C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 15:02:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso2258938wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 15:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9Q464dJsA61ztzMVCDLwkiyBO0cxsblJDFVUHC/myM=;
        b=NAAwFH8/U25c7BJFYgmYRIpaZ4gFJpSOe2SqImBb3Z0x2XXoAfkwkaA/pwZ0kBuRrL
         W8x7T9+co0K4pCUm2OeiLCuC66lhYKf7f8QNd8M8ynBu42WDbGzH3CrBM2uF+LNjMsjl
         4m6CpySGR0Ngq+KfAGH88U7PygI867vf5/7xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9Q464dJsA61ztzMVCDLwkiyBO0cxsblJDFVUHC/myM=;
        b=CzQ5jCXrBmYQdMXz8R19KxDgAYqziDOkgwbPwELTyNbDgPgULiydY7uNfxyYF4+Cn4
         Sht7PvPgkpMEo8MxFbX+XgfoY3X2x94Q05hPnia0Li9lwJ41dR1nnG0Hc1eEr+gvTO5E
         UzZfjTnGHyXimVK7hjktVQyQOzaNR5VOTV6GyaUeY7RBdSce5PPOCLRFc/YOamueagAR
         3RoEyyrVvbtyVpxsMbPyhUXTkQ8Xzz885M+/fF1Wzp9Eyh38RG58vc/E+SvLL3Rq1XjV
         Ed6w3XMygunHQO2Ler3/1cEW7RbcmtYfeQI7sx/wv729/CdOzcsLTZZqqRleTw/mmYPR
         xgKA==
X-Gm-Message-State: AOAM530D+sc4dvCShgTB7MEyFZ/aClHLuOTuEux5QLO3pR+N7U+kqv5x
        JXl2EzaqKRsbqOfnpZWBpU5vt02jI/zGK6vkO5Kiow==
X-Google-Smtp-Source: ABdhPJyJH85XC/G1cTAoBYYB7LWI76pa1knx86tv/aOG37udJswLbCCRbFe2P2vgYilaSxoIbfA6OuCI+vbLeUUJx88=
X-Received: by 2002:a05:600c:1d08:: with SMTP id l8mr462879wms.44.1641337327740;
 Tue, 04 Jan 2022 15:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20211209211407.8102-1-jim2101024@gmail.com> <YbOf836C58fUSmCO@robh.at.kernel.org>
 <d659ec6c-ddf8-87b9-ebf1-b32c3730d038@gmail.com> <20220104141742.GA27804@lpieralisi>
In-Reply-To: <20220104141742.GA27804@lpieralisi>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 4 Jan 2022 18:01:05 -0500
Message-ID: <CA+-6iNxiRqYNbBYcZqg13K4RExrVZfbJjUDH3x9Rh7E_dQ7JGg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 9:18 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 10, 2021 at 12:31:10PM -0800, Florian Fainelli wrote:
> > On 12/10/21 10:44 AM, Rob Herring wrote:
> > > On Thu, Dec 09, 2021 at 04:13:58PM -0500, Jim Quinlan wrote:
> > >> v10 -- Bindings commit example: in comment, refer to bridge under
> > >>        controller node as a root port. (Pali)
> > >>     -- Bindings commit example: remove three properties that are not
> > >>        appropriate for a PCIe endpoint node. (Rob)
> > >>
> > >> v9  -- Simplify where this mechanism works: instead of looking for
> > >>        regulators below every bridge, just look for them at the
> > >>        bridge under the root bus (root port).  Now there is no
> > >>        modification of portdrv_{pci,core}.c in this submission.
> > >>     -- Although Pali is working on support for probing native
> > >>        PCIe controller drivers, this work may take some time to
> > >>        implement and it still might not be able to accomodate
> > >>        our driver's requirements (e.g. vreg suspend/resume control).
> > >>     -- Move regulator suspend/resume control to Brcm RC driver.  It
> > >>        must reside there because (a) in order to know when to
> > >>        initiate linkup during resume and (b) to turn on the
> > >>        regulators before any config-space accesses occur.
> > >
> > > You now have a mixture of 'generic' add/remove_bus hooks and the host
> > > controller suspend/resume managing the regulators. I think long term,
> > > the portdrv is going to be the right place for all of this with some
> > > interface defined for link control. So I think this solution moves
> > > sideways rather than towards anything common.
> > >
> > > Unfortunately, the only leverage maintainers have to get folks to care
> > > about any refactoring is to reject features. We're lucky to find anyone
> > > to test refactoring when posted if done independently. There's a long
> > > list of commits of PCI hosts that I've broken to prove that. So it's
> > > up to Lorenzo and Bjorn on what they want to do here.
> >
> > After version 10, it would seem pretty clear that we are still very much
> > committed to and interested in getting that set merged and do it the
> > most acceptable way possible. Common code with a single user is always a
> > little bit of a grey area to me as it tends to be developed to cater for
> > the specific needs of that single user, so the entire common aspect is
> > debatable. I suppose as long as we have the binding right, the code can
> > change at will.
> >
> > Not trying to coerce Bjorn and Lorenzo into accepting these patches if
> > they don't feel comfortable, but what about getting it included so we
> > can sort of move on from that topic for a little bit (as we have other
> > PCIe changes coming in, supporting additional chips etc.) and we work
> > with Pali on a common solution and ensure it works on our pcie-brcmstb.c
> > based devices? We are not going to vanish and not come back looking at this.
>
> Sorry for being late on reviewing this set. I agree with both of you.
>
> I don't think Bjorn had a chance to have a look at patch (4) now I am
> delegating it to him; I am not very keen on adding functionality to PCI
> core where it is still a question whether it can be reused by other
> drivers (forgive me if I missed some details on previous review
> versions).
>
> Is it possible to keep patch (4) brcmstb specific (ie keep the code
> out of PCI core for now), we then merge this series and help Pali
> implement a generic version based on Rob's suggestion ?
>
> Just let me know please, thanks.
Hi Lorenzo,

That sounds good to me.  Pullreq coming tomorrow.

Thanks,
Jim Quinlan
Broadcom STB
>
> Lorenzo
