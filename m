Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8821349E062
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiA0LOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:14:40 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42942
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233389AbiA0LOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:14:39 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 958113F1CD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643282077;
        bh=ei0q12+pTEkVCSC3KLPxXTL3wN1Kz2V2e0OB+SXoUME=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZVHblktjtJb4zmm6qxwYNHV/E7IVKctDR0Xi8qhJjDB9XxuUw2/ozucX3kxsw+ncb
         Y3Xc0KKMAhz22VhYK8dx0SRyyzxfVrErXNb1H/9QWMDfBI1xxUkWFCrZ3DtQU3DdmP
         mLAklBFPcsfBWrffkhFrObBGbJtGYvbWSwjvvB85emFAp/8e9N8tpy8jV/9sJS2nv1
         bU6LBlOPog3l8BC4T0Ws5kkL2idbGUyURXVgFHZ89pUONKQHgpiUuWfcHKZLR6b+tK
         1/+oKNm7LzK8Ftw3lL71MkqcG/Q4o0O5mCp9dJ89Kz3WIXKr5EpehGLeb0LjG/oVWU
         orjXazh0AY2Gw==
Received: by mail-ot1-f70.google.com with SMTP id m23-20020a9d6457000000b0058f6f926cabso1427574otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ei0q12+pTEkVCSC3KLPxXTL3wN1Kz2V2e0OB+SXoUME=;
        b=Hr7RoffzJu8MBCdULEGQes+BpHk87snNXMgXs4W4uFTHHkbEm4hxeSIiUsNREjvj+G
         aWMnf6Id1iv4tr9sClLTEIFFQXpm1oqqctSnERFHYGUaYFkv1Zwh0Q8US7bHOhnm7O9m
         thK/aUCprHvPkNzRvaimxYBP1JE7o/1EXEXOJGix8+9FAk5pyeOZf5iyjWOUD9Ajq271
         BSI/ml6f9+dV3NcGZbswDZ2GC4npluyG5Gfk5fZHn//dvSxfAAVEPxccK0SkyRY8Esed
         9nF+0Z1axT2tkmqxMFqet2NXak7Z+LCABcDtTrGoF/18jJ5wa/AY7CYHEDL94eNA76nG
         SaQw==
X-Gm-Message-State: AOAM533vHl00JpJl041KS0iEsxPbIa1vPza1gA1JV1MUFbVynEFKz+xf
        /4zqlICCkxM0wJ6A49jkqmRlhUFKK/54yyxEYurP9bXNkMtcRTDScigy8XL3v64Vnt0c6foaLZ0
        jdo+AVGzcN9+u5SIV30/3YlmgS2bjTZwM7O+ZirZ5H2d3CWUj617EYE8TzA==
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr1968527oib.57.1643282076598;
        Thu, 27 Jan 2022 03:14:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxEE5Ap4FJ4cUst9yvbfsRQokijydzPA6OcoO6QyYWtnn1PDvaX7TZkZkLGBEICFTLx1JnuD/+0yw+QuDnNaE=
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr1968509oib.57.1643282076282;
 Thu, 27 Jan 2022 03:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com> <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
In-Reply-To: <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 Jan 2022 19:14:25 +0800
Message-ID: <CAAd53p6+KPAJchh9Jx59Fkkj5FidSxsW0yHjLqooFjvu-Y9u7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:01 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/1/27 10:54, Kai-Heng Feng wrote:
> > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > hint") enables ACS, and some platforms lose its NVMe after resume from
> > S3:
> > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >
> > It happens right after ACS gets enabled during resume.
> >
> > There's another case, when Thunderbolt reaches D3cold:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > So disable AER service to avoid the noises from turning power rails
> > on/off when the device is in low power states (D3hot and D3cold), as
> > PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> > transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> > with aux power) and L3 (D3cold).
> >
> > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
>
> I don't know what this fix has to do with the commit 50310600ebda.

Commit 50310600ebda only exposed the underlying issue. Do you think
"Fixes:" tag should change to other commits?

> Commit 50310600ebda only makes sure that PCI ACS is enabled whenever
> Intel IOMMU is on. Before this commit, PCI ACS could also be enabled
> and result in the same problem. Or anything I missed?

The system in question didn't enable ACS before commit 50310600ebda.

Kai-Heng

>
> Best regards,
> baolu
