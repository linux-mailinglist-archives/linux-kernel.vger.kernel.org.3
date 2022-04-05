Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2B4F4B15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573861AbiDEWxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458142AbiDERKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:10:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB853E0D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:08:10 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F46B3F7F8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649178489;
        bh=5ihDC8svoYNzIK8hMFPyp1shfnbI2+1sTt6+M9occ8s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IUkkLfimBJWf98kUMI2g9SirAuVXQOUPA3bh6YbbqNWxS3lgf7t/5zA6RflitTCXs
         41HLAJtp1A9U4o7JeMLl9l2TJ6P1vjIfMA8NxvppLlEwoz6u633oTtGVUXNp95nemM
         IEzCMIzuFKWRs4Q7DgtXA6JvSSBR7RjD8VHQ0nECVlSAtxWxBGxvhBCIvyeGR4La0o
         ATEwFzYYfPz3ue8rsJfddPbmFOXnsfnKgnuJopniPUIws7tCE0S/2DmJy4EsXEbRD8
         TI78+BnSjHtKOS9CoceoCh+S7CB2IrkUW4/VVyR0PUDHf3A+xNNhvZORbXJZiuJXe8
         ZAea2dKoz/1vQ==
Received: by mail-wr1-f70.google.com with SMTP id e4-20020adfa444000000b002060b7347f8so1774897wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ihDC8svoYNzIK8hMFPyp1shfnbI2+1sTt6+M9occ8s=;
        b=LzdtEnWw6B+LkEinl205j07VAqNbZL90SRMcQM1AaXTamf1AFYNypaR/5CeipNh/rc
         YJcefi0t2ffxYloQADmqz6DNf6pj36ckRQrKZWcVdt/zUaT2f5cmekpFO3WeIZtjJ3me
         DTPUcBlkZOHE1YwZoAIaWyQ3HPFPoF1ODiRBbC5GOD8pzZoEo6yH2HOxfGoNGIdLwhqW
         nKMIQ6Dk03e+acqWqAtRWWYq29ErtjfribZf8XvZ8mGcIa/wxySuqqC70oqejZO2K3Hv
         t1uW9RPwEPfE4ox6Chbo0K0C8aruZCBnul9PV3ZP/wQULMcfrGOgI1AYGzUnC/063xx+
         P5ow==
X-Gm-Message-State: AOAM532NSTiQ3WOfAGk/r19Gm/ZWqa3bz3YkqsWDBm8wvpmXmDo6rPFG
        I2XrhxURBdxND1yJjoqsbuvWlwsON230+r36pGoOVKBQO/1tqVTs8XNNPM4AolZTUamSyf+ALMk
        qWRnr7959fzwG916mteYssIEDgHrj+WoDLiTPgOx6t073izQKfAexhInkog==
X-Received: by 2002:a05:6000:1203:b0:206:1837:b5a8 with SMTP id e3-20020a056000120300b002061837b5a8mr3473856wrx.232.1649178486071;
        Tue, 05 Apr 2022 10:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziuMa66ZbQ9P/QeRUcn9JlFEqtsJOCFfYeHJTQhJe868mBJWdgkEPXXRcbxUGQEfP9hhmpi0r6jO87fnMEX18=
X-Received: by 2002:a05:6000:1203:b0:206:1837:b5a8 with SMTP id
 e3-20020a056000120300b002061837b5a8mr3473845wrx.232.1649178485847; Tue, 05
 Apr 2022 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220405070354.155796697@linuxfoundation.org> <20220405070400.156176848@linuxfoundation.org>
 <YkxjbVp3W2LeVIeL@xps13.dannf> <Ykx1o2PbNzGlp1ds@kroah.com>
In-Reply-To: <Ykx1o2PbNzGlp1ds@kroah.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Tue, 5 Apr 2022 11:07:53 -0600
Message-ID: <CALdTtnv2w5d0N4ez7JTsxaWMa6v2c5j9-guVjkUq33=UDNFMGA@mail.gmail.com>
Subject: Re: [PATCH 5.16 0199/1017] PCI: xgene: Revert "PCI: xgene: Fix IB
 window setup"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 05, 2022 at 09:42:37AM -0600, dann frazier wrote:
> > On Tue, Apr 05, 2022 at 09:18:32AM +0200, Greg Kroah-Hartman wrote:
> > > From: Marc Zyngier <maz@kernel.org>
> > >
> > > commit 825da4e9cec68713fbb02dc6f71fe1bf65fe8050 upstream.
> > >
> > > Commit c7a75d07827a ("PCI: xgene: Fix IB window setup") tried to
> > > fix the damages that 6dce5aa59e0b ("PCI: xgene: Use inbound resources
> > > for setup") caused, but actually didn't improve anything for some
> > > plarforms (at least Mustang and m400 are still broken).
> > >
> > > Given that 6dce5aa59e0b has been reverted, revert this patch as well,
> > > restoring the PCIe support on XGene to its pre-5.5, working state.
> > >
> > > Link: https://lore.kernel.org/r/YjN8pT5e6/8cRohQ@xps13.dannf
> > > Link: https://lore.kernel.org/r/20220321104843.949645-3-maz@kernel.or=
g
> > > Fixes: c7a75d07827a ("PCI: xgene: Fix IB window setup")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: stable@vger.kernel.org
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Toan Le <toan@os.amperecomputing.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: St=C3=A9phane Graber <stgraber@ubuntu.com>
> > > Cc: dann frazier <dann.frazier@canonical.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/pci/controller/pci-xgene.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi Greg,
> >
> >   I don't think it makes sense to apply this to 5.10.y, 5.15.y &
> > 5.16.y w/o also applying a backport of 1874b6d7ab1, because without
> > that we will regress support for St=C3=A9phane's X-Gene2-based systems.=
 The
> > backport of 1874b6d7ab1 was rejected for these trees because it doesn't
> > apply cleanly, but I've just submitted new versions that do.
>
> Where were those patches sent to?  I don't seem to see them on the
> stable list, did I miss them?

These are the message IDs:
<20220405142505.1268999-1-dann.frazier@canonical.com>
<20220405153419.1330755-1-dann.frazier@canonical.com>

I've just bounced them directly to you as well. Thanks Greg!

 -dann
